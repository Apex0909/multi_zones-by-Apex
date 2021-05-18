Hi there!

I would like to start off by saying this is my 3rd script and it is not really optimized. I have been learning how to code recently and am enjoying it loads. Maybe this script is useful for someone :smiley: 

So what does this script do?

It adds the following things:

* It adds redzones which are visible on the (mini)map and ingame with a red sphere around the configured coordinates. 

* It adds greenzones which make it so anyone inside is immune to damage from other players, other players vehicles, etc. This is set back to normal once said person leaves the greenzone. (Basically means you cannot be shot nor VDM'd in a greenzone)

* It adds a speed limiter for greenzones. So the moment someone enters a greenzone with a vehicle, you can set the maximum speed for inside the greenzone

* It adds a "global" speed limiter which allows you to set the maximum speed of someone outside any greenzone.

Now this script is almost standalone, you do not require any frameworks for it to work, however we have decided we want to include the mythic notifications possibility. If you do not wish to use mythic notifications please do the following:

Navigate to the 2 client files.

For "cl_m-gz.lua" (greenzones) comment out line 59 & 75.
For "cl_m-rz.lua" (redzones) comment out line 43 & 53.

If you wish to use mythic notifications but not text do the following: (note: the "You entered a redzone" text will stay on the players screen as long as the player is inside the redzone. This is intended)

For "cl_m-gz.lua" (greenzones) comment out line 35 & 44.
For "cl_m-rz.lua" (redzones) comment out line 21 & 29.

By default the greenzones have no sphere around them ingame, only on the (mini)map, the redzones by default have both "ingame" and on the (mini)map a sphere. If you wish to change either do the following:

* Add "ingame" sphere to greenzone: Go to cl_m-gz.lua, uncomment line 30

* Remove "ingame" sphere from redzone: Go to cl_m-rz.lua and comment out line 19

You are allowed to edit my scripts to your liking, however if you wish to publish it please link this release in your post! :smiley: 

I will try to provide "support" to the best of my abilities, however please understand I have only been into coding for 2 weeks! Any tips therefore are more than welcome seeing I would like to improve my "coding" skills.

Also make sure to read the README file.

If you wish to use mythic_notify please download it here: [https://github.com/JayMontana36/mythic_notify]

Download the multi_zones resource here: 
[https://github.com/Apex0909/multi_zones-by-Apex]

Thank you!
Apex
(Please let me know if I missed anything!)

Discord: DuhItzRik#0909
Discord Server: [https://discord.gg/nemQUPnC3U]
