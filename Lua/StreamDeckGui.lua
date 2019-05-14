function plugindef()
    finaleplugin.RequireSelection = false
    finaleplugin.Author = "CJ Garcia"
    finaleplugin.Copyright = "© 2019 CJ Garcia Music"
    finaleplugin.Version = "0.1"
    finaleplugin.Date = "5/14/2019"
    return "Stream Deck", "Stream Deck", "A selectable list of all Lua functions related to Stream Deck"
end

local str = finale.FCString()
str.LuaString = "Stream Deck for Finale"
local dialog = finale.FCCustomLuaWindow()
dialog:SetTitle(str)

local static_text = dialog:CreateStatic(0, 0)
str.LuaString = "Select Your Action"
static_text:SetWidth(200)
static_text:SetText(str)

local listbox = dialog:CreateListBox(0, 20)
listbox:SetWidth(200)
str.LuaString = "Function 1"
listbox:AddString(str)
local function func_1()
    finenv.UI():AlertInfo("you pressed button 1, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

str.LuaString = "Function 2"
listbox:AddString(str)
local function func_2()
    finenv.UI():AlertInfo("you pressed button 2, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

str.LuaString = "Function 3"
listbox:AddString(str)
local function func_3()
    finenv.UI():AlertInfo("you pressed button 3, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

str.LuaString = "Function 4"
listbox:AddString(str)
local function func_4()
    finenv.UI():AlertInfo("you pressed button 4, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

str.LuaString = "Function 5"
listbox:AddString(str)
local function func_5()
    finenv.UI():AlertInfo("you pressed button 5, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

str.LuaString = "Function 6"
listbox:AddString(str)
local function func_6()
    finenv.UI():AlertInfo("you pressed button 6, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

str.LuaString = "Function 7"
listbox:AddString(str)
local function func_7()
    finenv.UI():AlertInfo("you pressed button 7, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

str.LuaString = "Function 8"
listbox:AddString(str)
local function func_8()
    finenv.UI():AlertInfo("you pressed button 8, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

str.LuaString = "Function 9"
listbox:AddString(str)
local function func_9()
    finenv.UI():AlertInfo("you pressed button 9, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

str.LuaString = "Function 10"
listbox:AddString(str)
local function func_10()
    finenv.UI():AlertInfo("you pressed button 10, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

str.LuaString = "Function 11"
listbox:AddString(str)
local function func_11()
    finenv.UI():AlertInfo("you pressed button 11, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

str.LuaString = "Function 12"
listbox:AddString(str)
local function func_12()
    finenv.UI():AlertInfo("you pressed button 12, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

str.LuaString = "Function 13"
listbox:AddString(str)
local function func_13()
    finenv.UI():AlertInfo("you pressed button 13, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

str.LuaString = "Function 14"
listbox:AddString(str)
local function func_14()
    finenv.UI():AlertInfo("you pressed button 14, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

str.LuaString = "Function 15"
listbox:AddString(str)
local function func_15()
    finenv.UI():AlertInfo("you pressed button 15, nothing is going to happen though #DealWithIt",  "Sucks to suck.") 
end

dialog:CreateOkButton()
dialog:CreateCancelButton()

if (dialog:ExecuteModal(nil) == 1) then
    if listbox:GetSelectedItem() == 0 then
        func_1()
    end
    if listbox:GetSelectedItem() == 1 then
        func_2()
    end
    if listbox:GetSelectedItem() == 2 then
        func_3()
    end
    if listbox:GetSelectedItem() == 3 then
        func_4()
    end
    if listbox:GetSelectedItem() == 4 then
        func_5()
    end
    if listbox:GetSelectedItem() == 5 then
        func_6()
    end
    if listbox:GetSelectedItem() == 6 then
        func_7()
    end
    if listbox:GetSelectedItem() == 7 then
        func_8()
    end
    if listbox:GetSelectedItem() == 8 then
        func_9()
    end
    if listbox:GetSelectedItem() == 9 then
        func_10()
    end
    if listbox:GetSelectedItem() == 10 then
        func_11()
    end
    if listbox:GetSelectedItem() == 11 then
        func_12()
    end
    if listbox:GetSelectedItem() == 12 then
        func_13()
    end
    if listbox:GetSelectedItem() == 13 then
        func_14()
    end
    if listbox:GetSelectedItem() == 14 then
        func_15()
    end
end