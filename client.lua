-------------------------------------------------------------------------------
------------------------------- CONFIGURATION ---------------------------------
-------------------------------------------------------------------------------

local debugMode = true -- Enables a command " /testdialog " to test the script

-------------------------------------------------------------------------------
-------------------------------- DO NOT TOUCH ---------------------------------
-------------------------------------------------------------------------------

local dialogOpen = false
local currDialog = nil
local currFS = {}
local currFC = {}

function viewInput(name, label, input, help, submitFunc, cancelFunc, textarea)
	if not dialogOpen then
		currDialog = name
		currFS = submitFunc
		currFC = cancelFunc
		SetNuiFocus(true,true)
		if textarea == nil then
			textarea = false
		end
		SendNUIMessage({
			action = "showDialog",
			menuAction = name,
			label = label,
			defaultInput = input,
			helpText = help,
			textarea = textarea,
		})
		dialogOpen = true
	else
		print('^1dialog box already open!')
	end
end

RegisterNUICallback('exit', function(data)
    SetNuiFocus(false,false)
	if currFC ~= nil then
		currFC()
	end
	currDialog = nil
	currFS = nil
	currFC = nil
	dialogOpen = false
end)

RegisterNUICallback('submit', function(data)
	SetNuiFocus(false,false)
	dialogOpen = false
	if data.currMA == currDialog then -- This is to avoid the script being triggered by someone using FiveM's NUI Dev Tools
		local doSubmitFunction = currFS
		currDialog = nil
		currFS = nil
		currFC = nil
		doSubmitFunction(data.text)
	else
		-- 
	end
end)

-------------------------------------------------------------------------------
------------------------------ DEBUG AND TESTING ------------------------------
-------------------------------------------------------------------------------

if debugMode then
	RegisterCommand('testdialog', function(src, args)
		viewInput('unique_dialog_name', 'Présentation NSX INPUT', nil, 'Rework du An-DialogBox', testFuncSubmit, testFuncCancel, false)
	end)
	function testFuncSubmit(data)
		print('Vous avez entré le texte suivant ^1'..data)
	end
	function testFuncCancel()
		print('Action Annulée')
	end
end
