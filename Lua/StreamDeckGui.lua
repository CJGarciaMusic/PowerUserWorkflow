function plugindef()
    finaleplugin.RequireSelection = false
    finaleplugin.Author = "CJ Garcia"
    finaleplugin.Copyright = "© 2019 CJ Garcia Music"
    finaleplugin.Version = "0.1"
    finaleplugin.Date = "5/14/2019"
    return "Stream Deck", "Stream Deck", "Stream Deck commands and gui"
end

local str = finale.FCString()
str.LuaString = "Stream Deck for Finale"
local dialog = finale.FCCustomLuaWindow()
dialog:SetTitle(str)

local button_width = 90

local button_1 = dialog:CreateButton(0, 0)
str.LuaString = "Function 1"
button_1:SetText(str)
button_1:SetWidth(button_width)

local button_2 = dialog:CreateButton(100, 0)
str.LuaString = "Function 2"
button_2:SetText(str)
button_2:SetWidth(button_width)

local button_3 = dialog:CreateButton(200, 0)
str.LuaString = "Function 3"
button_3:SetText(str)
button_3:SetWidth(button_width)

local button_4 = dialog:CreateButton(300, 0)
str.LuaString = "Function 4"
button_4:SetText(str)
button_4:SetWidth(button_width)

local button_5 = dialog:CreateButton(400, 0)
str.LuaString = "Function 5"
button_5:SetText(str)
button_5:SetWidth(button_width)

local button_6 = dialog:CreateButton(0, 50)
str.LuaString = "Function 6"
button_6:SetText(str)
button_6:SetWidth(button_width)

local button_7 = dialog:CreateButton(100, 50)
str.LuaString = "Function 7"
button_7:SetText(str)
button_7:SetWidth(button_width)

local button_8 = dialog:CreateButton(200, 50)
str.LuaString = "Function 8"
button_8:SetText(str)
button_8:SetWidth(button_width)

local button_9 = dialog:CreateButton(300, 50)
str.LuaString = "Function 9"
button_9:SetText(str)
button_9:SetWidth(button_width)

local button_10 = dialog:CreateButton(400, 50)
str.LuaString = "Function 10"
button_10:SetText(str)
button_10:SetWidth(button_width)

local button_11 = dialog:CreateButton(0, 100)
str.LuaString = "Function 11"
button_11:SetText(str)
button_11:SetWidth(button_width)


local button_12 = dialog:CreateButton(100, 100)
str.LuaString = "Function 12"
button_12:SetText(str)
button_12:SetWidth(button_width)

local button_13 = dialog:CreateButton(200, 100)
str.LuaString = "Function 13"
button_13:SetText(str)
button_13:SetWidth(button_width)

local button_14 = dialog:CreateButton(300, 100)
str.LuaString = "Function 14"
button_14:SetText(str)
button_14:SetWidth(button_width)

local button_15 = dialog:CreateButton(400, 100)
str.LuaString = "Function 15"
button_15:SetText(str)
button_15:SetWidth(button_width)

dialog:CreateOkButton()
dialog:CreateCancelButton()

local function mycommandhandler(thecontrol)
    if thecontrol:GetControlID() == button_1:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 1, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
    if thecontrol:GetControlID() == button_2:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 2, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
    if thecontrol:GetControlID() == button_3:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 3, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
    if thecontrol:GetControlID() == button_4:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 4, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
    if thecontrol:GetControlID() == button_5:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 5, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
    if thecontrol:GetControlID() == button_6:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 6, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
    if thecontrol:GetControlID() == button_7:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 7, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
    if thecontrol:GetControlID() == button_8:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 8, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
    if thecontrol:GetControlID() == button_9:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 9, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
    if thecontrol:GetControlID() == button_10:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 10, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
    if thecontrol:GetControlID() == button_11:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 11, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
    if thecontrol:GetControlID() == button_12:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 12, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
    if thecontrol:GetControlID() == button_13:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 13, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
    if thecontrol:GetControlID() == button_14:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 14, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
    if thecontrol:GetControlID() == button_15:GetControlID() then
        finenv.UI():AlertInfo("you pressed button 15, nothing is going to happen though #DealWithIt",  "Sucks to suck.")
    end
end

dialog:RegisterHandleCommand(mycommandhandler)
if (dialog:ExecuteModal(nil) == 1) then
end