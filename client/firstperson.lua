class 'FirstPerson'

function FirstPerson:__init()
	self.enabled = false

	Events:Subscribe( "CalcView", self, self.CalcView )
	Events:Subscribe( "LocalPlayerChat", self, self.LocalPlayerChat )

    Events:Subscribe( "ModuleLoad", self, self.ModuleLoad )
    Events:Subscribe( "ModuleUnload", self, self.ModuleUnload )
end

function FirstPerson:CalcView()
	if not self.enabled then return end

	local position = LocalPlayer:GetBonePosition( "ragdoll_Head" )

	if not LocalPlayer:InVehicle() then
		position = position + (Camera:GetAngle() * Vector3( 0, 0.25, 0.2 ))
	end

	Camera:SetPosition( position )
end

function FirstPerson:LocalPlayerChat( args )
	if args.text == "/fp" then
		self.enabled = not self.enabled
		return false
	end
end

function FirstPerson:ModuleLoad()
	Events:Fire( "HelpAddItem",
        {
            name = "First-Person View",
            text = 
                "The first-person script lets you play JC2 in first-person mode.\n\n" ..
                "To toggle it, type /fp in chat."
        } )
end

function FirstPerson:ModuleUnload()
    Events:Fire( "HelpRemoveItem",
        {
            name = "First-Person View"
        } )
end

firstperson = FirstPerson()