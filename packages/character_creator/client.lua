local webview = nil
local isCreating = false
function ShowPanel(creating)
	if (webview ~= nil) then
		return
	end
	webview = CreateWebUI(0.0, 0.0, 0.0, 0.0)
	LoadWebFile(webview, "http://asset/"..GetPackageName().."/ui/index.html")
	SetWebAlignment(webview, 0.0, 0.0)
	SetWebAnchors(webview, 0, 0, 1, 1)		
	SetWebVisibility(webview, WEB_HIDDEN)
	isCreating = creating
end
AddRemoteEvent("characterize:ShowPanel", ShowPanel)

function OnWebLoadComplete(webid)
	if webview == webid then
		CallRemoteEvent("characterize:GetOptions")
	end
end
AddEvent("OnWebLoadComplete", OnWebLoadComplete)

function SetOptions(bodyOptions, shirtOptions, pantOptions, shoeOptions, hairOptions)
	ExecuteWebJS(webview, "SetCharacterOptions('body', '".. bodyOptions .."')")
	ExecuteWebJS(webview, "SetCharacterOptions('hair', '".. hairOptions .."')")
	ExecuteWebJS(webview, "SetCharacterOptions('shirt', '".. shirtOptions .."')")
	ExecuteWebJS(webview, "SetCharacterOptions('pants', '".. pantOptions .."')")
	ExecuteWebJS(webview, "SetCharacterOptions('shoes', '".. shoeOptions .."')")
	ExecuteWebJS(webview, "ShowOrHideCreationElements('".. tostring(isCreating) .. "')")
	if isCreating then
		SetDefaultCothing()
	end
	ShowMouseCursor(true)
	SetIgnoreMoveInput(true);
	SetInputMode(INPUT_UI)
	SetWebVisibility(webview, WEB_VISIBLE)
end
AddRemoteEvent("characterize:SetOptions", SetOptions)

function HidePanel()
	SetWebVisibility(webview, WEB_HIDDEN)
	DestroyWebUI(webview)
	webview = nil
	ShowMouseCursor(false)
	SetIgnoreMoveInput(false);
	SetInputMode(INPUT_GAME)
end
AddEvent("characterize:HidePanel", HidePanel)

function SetDefaultCothing()
	Change("body", "/Game/CharacterModels/SkeletalMesh/BodyMerged/HZN_CH3D_Normal01_LPR")
	Change("hair", "/Game/CharacterModels/SkeletalMesh/HZN_CH3D_Normal_Hair_01_LPR")
	Change("shirt", "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_TShirt_LPR")
	Change("pants", "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_CargoPants_LPR")
	Change("shoes", "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_NormalShoes_LPR")
	Change("hair_color", "000000")
	Change("shirt_color", "000000")
	Change("pants_color", "000000")
end

function Change(type, value)
	CreateSound("click.wav")
	local player = GetPlayerId()
	if (type == 'preset') then
		RemoveAllClothes(player)
		SetPlayerClothingPreset(player, value)
	elseif (type == 'body') then
		local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Body")
		SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(value))
		SkeletalMeshComponent:SetFloatParameterOnMaterials("PupilScale", 1.5)
		CallRemoteEvent("CharacterChangeClothingItem", "body", value)
	elseif (type == 'hair') then
		local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing0")
    	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(value))
		CallRemoteEvent("CharacterChangeClothingItem", "hair", value)
	elseif (type == 'shirt') then
		local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing1")
		if (value == -1) then
			SkeletalMeshComponent:SetSkeletalMesh(nil)
		else
			SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(value))
		end
		CallRemoteEvent("CharacterChangeClothingItem", "shirt", value)
	elseif (type == 'pants') then
		local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing4")
    	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(value))
		CallRemoteEvent("CharacterChangeClothingItem", "pants", value)
	elseif (type == 'shoes') then
		local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing5")
		if (value == -1) then
			SkeletalMeshComponent:SetSkeletalMesh(nil)
		else
			SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(value))
		end		
		CallRemoteEvent("CharacterChangeClothingItem", "shoes", value)
	elseif (type == 'hair_color') then
		local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing0")
		local r, g, b, a = HexToRGBAFloat("0x"..value)
		SkeletalMeshComponent:SetColorParameterOnMaterials("Hair Color", FLinearColor(r, g, b, a))
		CallRemoteEvent("CharacterChangeClothingItem", "hair_color", {r, g, b, a})
	elseif (type == 'shirt_color') then
        SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Clothing2")
        SkeletalMeshComponent:SetSkeletalMesh(nil)

		local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing1")
		local r, g, b, a = HexToRGBAFloat("0x"..value)
		SkeletalMeshComponent:SetColorParameterOnMaterials("Clothing Color", FLinearColor(r, g, b, a))
		CallRemoteEvent("CharacterChangeClothingItem", "shirt_color", {r, g, b, a})
	elseif (type == 'pants_color') then
		local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing4")
		local r, g, b, a = HexToRGBAFloat("0x"..value)
		SkeletalMeshComponent:SetColorParameterOnMaterials("Clothing Color", FLinearColor(r, g, b, a))
		CallRemoteEvent("CharacterChangeClothingItem", "pants_color", {r, g, b, a})
	end
end
AddEvent("characterize:Change", Change)

function Submit(params)
	CallRemoteEvent('characterize:Submit', params, isCreating);
end
AddEvent("characterize:Submit", Submit)

AddRemoteEvent("characterize:HidePanel", function()
	CallEvent("characterize:HidePanel")
end)

function RemoveAllClothes(player)
	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Body")
	SkeletalMeshComponent:SetSkeletalMesh(nil)
	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing0")
	SkeletalMeshComponent:SetSkeletalMesh(nil)
	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing1")
	SkeletalMeshComponent:SetSkeletalMesh(nil)
	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing2")
	SkeletalMeshComponent:SetSkeletalMesh(nil)
	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing3")
	SkeletalMeshComponent:SetSkeletalMesh(nil)
	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing4")
	SkeletalMeshComponent:SetSkeletalMesh(nil)
	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing5")
	SkeletalMeshComponent:SetSkeletalMesh(nil)
end
