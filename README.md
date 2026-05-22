# Roblox-ChamObject
roblox cham object which calculates custom depth for an "AlwaysOnTop" look

```lua
local RunService = game : GetService( "RunService" );
local Players = game : GetService( "Players" );

local LocalPlayer = Players.LocalPlayer;
local Character = LocalPlayer.Character;

local Module = require( script.Chams );
local Color = Color3.new( 1, 1, 1 );

local ChamObjects = { };

for _, Part in Character : GetChildren( ) do
	if ( not Part : IsA( "BasePart" ) ) or ( Part.Transparency > .1 ) then
		continue;
	end
	
	local ChamObject = Module( Part ); do
		ChamObject.Material = Enum.Material.ForceField;

		ChamObject.Size = Part.Size * 1.05;
		ChamObject.Transparency = 0;

		ChamObject.Color = Color;
	end
	
	table.insert( ChamObjects, ChamObject );
end

RunService.PreRender : Connect( function( )
	for _, Object in ChamObjects do
		Object : Stepper( );
	end
end )
```
