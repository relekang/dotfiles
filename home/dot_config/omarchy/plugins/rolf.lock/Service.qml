import QtQuick
import Quickshell.Io
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import "file:/usr/share/omarchy/shell/plugins/lock" as Builtin

Builtin.Service {
  id: root

  readonly property var defaultSink: Pipewire.defaultAudioSink
  property var lockedAudioStates: []

  function syncLockAudio() {
    if (root.currentlyLocked()) {
      var sink = root.defaultSink
      if (!sink || !sink.ready || !sink.audio) return
      if (!root.lockedAudioStates.some(state => state.node === sink)) {
        root.lockedAudioStates = root.lockedAudioStates.concat([{
          node: sink, volume: sink.audio.volume, muted: sink.audio.muted
        }])
      }
      sink.audio.muted = true
    } else {
      for (var state of root.lockedAudioStates) {
        if (!state.node || !state.node.ready || !state.node.audio) continue
        state.node.audio.volume = state.volume
        state.node.audio.muted = state.muted
      }
      root.lockedAudioStates = []
    }
  }

  onLockRequestedChanged: root.syncLockAudio()
  onDefaultSinkChanged: {
    if (root.currentlyLocked()) root.syncLockAudio()
  }

  Timer {
    interval: 100
    repeat: true
    running: root.lockRequested || root.lockedAudioStates.length > 0
    onTriggered: root.syncLockAudio()
  }

  PwObjectTracker {
    objects: (root.defaultSink ? [root.defaultSink] : []).concat(root.lockedAudioStates.map(state => state.node).filter(node => node !== null))
  }

  Connections {
    target: root.defaultSink
    function onReadyChanged() {
      if (root.currentlyLocked()) root.syncLockAudio()
    }
  }

  Connections {
    target: root.defaultSink ? root.defaultSink.audio : null
    function onMutedChanged() {
      if (root.currentlyLocked() && !root.defaultSink.audio.muted) root.syncLockAudio()
    }
  }

  function runBlank() {
    if (!UPower.onBattery) return
    root.displaysBlank = true
    root.monitorDpmsKnown = false
    root.pauseFingerprint()
    if (!batteryBlankProcess.running) batteryBlankProcess.running = true
  }

  function updatePower() {
    if (powerProcess.running) return
    powerProcess.command = ["systemctl", "--user", UPower.onBattery ? "stop" : "start", "keep-awake-on-ac.service"]
    powerProcess.running = true
    if (root.lockRequested) root.runWake()
  }

  Process {
    id: batteryBlankProcess
    command: ["bash", "-c", "omarchy-brightness-keyboard off; omarchy-brightness-display off"]
  }

  Process {
    id: powerProcess
    onExited: {
      if ((command[2] === "stop") !== UPower.onBattery) root.updatePower()
    }
  }

  Connections {
    target: UPower
    function onOnBatteryChanged() { root.updatePower() }
  }

  Component.onCompleted: root.updatePower()
}
