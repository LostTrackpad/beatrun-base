# beatrun-base

Parkour gamemode for _Garry's Mod_, modified for use as a gamemode base.

_Wanna **play** Beatrun? Check [this](https://github.com/JonnyBro/beatrun) version of Beatrun out instead._

**CURRENTLY NOT SUPPORTED.**

## Changes

> [!IMPORTANT]
> There are many undocumented changes in this version. Checking the commit history of [this](https://github.com/JonnyBro/beatrun) repository and this (the one you're in right now) is recommended.

* Implemented "Proper" Kick Glitch just like in [original ME](https://www.youtube.com/watch?v=zK5y3NBUStc).
* Added an in-game config menu - you can find it in the tool menu, in the *Beatrun* Category.\
**All** of the Beatrun settings can be changed in the configuration menu.
* Localization support.
* Added the ability to get off of ladders.
* Added a ConVar to allow Overdrive usage on the server - `Beatrun_AllowOverdriveInMultiplayer`.
* Added a ConVar to toggle between old and new Kick Glitch - `Beatrun_OldKickGlitch`.
* Added some ConVars to change HUD colors - `Beatrun_HUDTextColor`, `Beatrun_HUDCornerColor`, `Beatrun_HUDFloatingXPColor`.
* Added a ConVar to allow players to spawn props and weapons without admin rights - `Beatrun_AllowPropSpawn`.
* Added a ConVar to toggle the grapple ability - `Beatrun_DisableGrapple`.
* Added a ConVar to allow QuickTurn with any weapon or only with *Runner Hands* - `Beatrun_QuickturnHandsOnly`.
* Added a ConVar to toggle the health regeneration - `Beatrun_HealthRegen`.
* Added small camera punch when diving.
* Added the ability to remove ziplines that created with *Zipline Gun* - `RMB`.

## Fixes

* Your SteamID in the right corner is no longer present.
* Fixed some playermodels show up as ERROR.
* Allowed jumping while walking (🤷).
* Fixed collisions issues. (PvP damage not going through in gamemodes other than Data Theft)
* Tweaked safety roll, now you can roll under things.
* Tweaked some grapple related stuff. Now it moves with the entity it was attached to and other players can see the rope.
* Made it possible to dive to your death =).

## Credits

* [All contributors](https://github.com/JonnyBro/beatrun/graphs/contributors) - <3.
* [EarthyKiller127](https://www.youtube.com/channel/UCiFqPwGo4x0J65xafIaECDQ) - Making the original obfuscated mod.
* [relaxtakenotes](https://github.com/relaxtakenotes) - Made all of this possible.
