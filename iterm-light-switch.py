#!/usr/bin/env python3

import asyncio
import iterm2

LIGHT_THEME = "papercolor-light"
DARK_THEME = "papercolor-dark"


async def main(connection):
    async with iterm2.VariableMonitor(
        connection, iterm2.VariableScopes.APP, "effectiveTheme", None
    ) as mon:
        while True:
            # Block until theme changes
            theme = await mon.async_get()


            preset = await iterm2.ColorPreset.async_get(
                connection,
                DARK_THEME if "dark" in theme.split(" ") else LIGHT_THEME,
            )

            # Update the list of all profiles and iterate over them.
            profiles = await iterm2.PartialProfile.async_query(connection)
            for partial in profiles:
                profile = await partial.async_get_full_profile()
                await profile.async_set_color_preset(preset)


iterm2.run_forever(main)
