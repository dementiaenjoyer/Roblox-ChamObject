-- Services
local RunService = game : GetService( "RunService" );
local Workspace = game : GetService( "Workspace" );

-- Variables
local CurrentCamera = Workspace.CurrentCamera;

-- Cache
local SetMetatable = setmetatable;
local InstanceNew = Instance.new;

local TableInsert = table.insert;
local TableRemove = table.remove;

local TableClone = table.clone;
local Vector3New = Vector3.new;

local CFrameNew = CFrame.new;
local MathMin = math.min;

local RawSet = rawset;
local RawGet = rawget;

-- Main
do
	local ChamObject = { }; do
		ChamObject.Size = Vector3New( 1, 1, 1 );
		ChamObject.ZIndex = 0;

		function ChamObject : Stepper( )
			local Adornee = self.Adornee;
			local Part = self.Part;

			local CameraCFrame = CurrentCamera.CFrame;
			local AdorneeCFrame = Adornee.CFrame;
			
			local AdorneePosition = AdorneeCFrame.Position;
			local CameraPosition = CameraCFrame.Position;
	
			local Delta = ( AdorneePosition - CameraPosition );
			local Scale = .07;

			Part.CFrame = CFrameNew( CameraPosition + ( Delta.Unit * ( ( Delta.Magnitude * Scale ) - self.ZIndex ) ) ) * ( AdorneeCFrame - AdorneePosition );
			Part.Size = self.Size * Scale;
		end

		function ChamObject : Destroy( )
			self.Part : Destroy( );
		end

		ChamObject = SetMetatable( ChamObject, { __call = function( Self, Adornee, Parent )
			local Part = InstanceNew( "Part" ); do
				Part.Parent = ( Parent or CurrentCamera );

				Part.CanCollide = false;
				Part.Anchored = true;
			end

			local Object = SetMetatable( TableClone( Self ), {
				__newindex = function( _, Index, Value )
					Part[ Index ] = Value;
				end, 
				
				__index = Self,
			} );

			RawSet( Object, "Adornee", Adornee );
			RawSet( Object, "Part", Part );

			return Object;
		end } );
	end

	return ChamObject;
end
