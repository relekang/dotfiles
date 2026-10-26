import QtQuick
import Quickshell.Io
import Quickshell.Services.UPower
import "file:/usr/share/omarchy/shell/plugins/lock" as Builtin

Builtin.Service {
  id: root

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
