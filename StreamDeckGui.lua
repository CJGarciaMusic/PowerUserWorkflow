function plugindef()
    finaleplugin.RequireSelection = false
    finaleplugin.Author = "CJ Garcia"
    finaleplugin.Copyright = "© 2019 CJ Garcia Music"
    finaleplugin.Version = "0.2"
    finaleplugin.Date = "5/22/2019"
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
str.LuaString = "Clear Lyrics"
listbox:AddString(str)
local function func_1()
    for noteentry in eachentry(finenv.Region()) do
        local cs = finale.FCChorusSyllable()
        cs:SetNoteEntry(noteentry)
        if cs:LoadFirst() then
            cs:DeleteData()
        end
        local vs = finale.FCVerseSyllable()
        vs:SetNoteEntry(noteentry)
        if vs:LoadFirst() then
            vs:DeleteData()
        end
        local ss = finale.FCSectionSyllable()
        ss:SetNoteEntry(noteentry)
        if ss:LoadFirst() then
            ss:DeleteData()
        end
    end
end

str.LuaString = "Split Articulations"
listbox:AddString(str)
local function func_2()
    art_table = {0, 0, 0, 0}
    local articulationdefs = finale.FCArticulationDefs()
    articulationdefs:LoadAll()

    for ad in each(articulationdefs) do
        if (ad:GetAboveSymbolChar() == 46) and (ad:GetFlippedSymbolChar() > 0)then
            art_table[1] = ad.ItemNo
        end
        if (ad:GetAboveSymbolChar() == 62) and (ad:GetFlippedSymbolChar() > 0) then
            art_table[2] = ad.ItemNo
        end
        if (ad:GetAboveSymbolChar() == 45) and (ad:GetFlippedSymbolChar() > 0) then
            art_table[3] = ad.ItemNo
        end
        if (ad:GetAboveSymbolChar() == 94) and (ad:GetFlippedSymbolChar() > 0) then
            art_table[4] = ad.ItemNo
        end
    end

    for noteentry in eachentry(finenv.Region()) do
        local a = finale.FCArticulation()
        a:SetNoteEntry(noteentry)
        if a:LoadFirst() then
            local ad = finale.FCArticulationDef()
            if ad:Load(a:GetID()) then
                if ad:GetAboveSymbolChar() == 249 then
                    a:SetID(art_table[2])
                    a:Save()
                    a:SetID(art_table[1])
                    a:SaveNew()
                elseif (ad:GetAboveSymbolChar() == 138) or (ad:GetAboveSymbolChar() == 251) then
                    a:SetID(art_table[2])
                    a:Save()
                    a:SetID(art_table[3])
                    a:SaveNew()
                elseif ad:GetAboveSymbolChar() == 248 then
                    a:SetID(art_table[3])
                    a:Save()
                    a:SetID(art_table[1])
                    a:SaveNew()
                elseif ad:GetAboveSymbolChar() == 172 then
                    a:SetID(art_table[4])
                    a:Save()
                    a:SetID(art_table[1])
                    a:SaveNew()
                end
            end
        end 
    end
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

str.LuaString = "Add f"
listbox:AddString(str)
local function func_6()
    local first_expression = {}
    
    local function addExpression()
        local measures = finale.FCMeasures()
        measures:LoadRegion(finenv.Region())
        
        for m in each(measures) do
            for noteentry in eachentrysaved(finenv.Region()) do
                add_expression=finale.FCExpression()
                add_expression:SetStaff(noteentry:GetStaff())
                add_expression:SetVisible(true)
                add_expression:SetMeasurePos(noteentry:GetMeasurePos())
                add_expression:SetScaleWithEntry(false)
                add_expression:SetPartAssignment(true)
                add_expression:SetScoreAssignment(true)
                add_expression:SetID(first_expression[1])
                local and_cell = finale.FCCell(noteentry:GetMeasure(), noteentry:GetStaff())
                add_expression:SaveNewToCell(and_cell)
            end
        end 
    end
    
    local function CreateExpression(glyph, table_name)
        local ex_ted = finale.FCTextExpressionDef()
        local ex_textstr = finale.FCString()
        ex_textstr.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"..glyph
        ex_ted:SaveNewTextBlock(ex_textstr)
        
        local and_descriptionstr = finale.FCString()
        and_descriptionstr.LuaString="mezzo forte (velocity = 75)"
        ex_ted:SetDescription(and_descriptionstr)
        local cat_def = finale.FCCategoryDef()
        cat_def:Load(1)
        ex_ted:AssignToCategory(cat_def)
        ex_ted:SetUseCategoryPos(true)
        ex_ted:SetUseCategoryFont(true)
        ex_ted:SaveNew()
        table.insert(table_name, ex_ted:GetItemNo())  
    end
    
    local function findExpression(font, glyph, table_name)
        local matching_glyphs = {}
        local exp_defs = finale.FCTextExpressionDefs()
        local exp_def = finale.FCTextExpressionDef()
        exp_defs:LoadAll()
        local already_exists = 0
        for exp in each(exp_defs) do
            if (string.find(exp:CreateTextString().LuaString, font) ~=nil) and (string.find(exp:CreateTextString().LuaString, glyph) ~= nil) then
                already_exists = exp:GetItemNo()
                table.insert(matching_glyphs, already_exists)
            end
        end
        if matching_glyphs[1] == nil then
            CreateExpression(string.sub(glyph, 2), table_name)
        else
            exp_def:Load(matching_glyphs[1])
            table.insert(table_name, exp_def:GetItemNo())  
        end
    end
    
    findExpression("^^fontMus", ")f", first_expression)
    addExpression()
end

str.LuaString = "Add mf"
listbox:AddString(str)
local function func_7()    
    local first_expression = {}
    
    local function addExpression()
        local measures = finale.FCMeasures()
        measures:LoadRegion(finenv.Region())
        
        for m in each(measures) do
            for noteentry in eachentrysaved(finenv.Region()) do
                add_expression=finale.FCExpression()
                add_expression:SetStaff(noteentry:GetStaff())
                add_expression:SetVisible(true)
                add_expression:SetMeasurePos(noteentry:GetMeasurePos())
                add_expression:SetScaleWithEntry(false)
                add_expression:SetPartAssignment(true)
                add_expression:SetScoreAssignment(true)
                add_expression:SetID(first_expression[1])
                local and_cell = finale.FCCell(noteentry:GetMeasure(), noteentry:GetStaff())
                add_expression:SaveNewToCell(and_cell)
            end
        end 
    end
    
    local function CreateExpression(glyph, table_name)
        local ex_ted = finale.FCTextExpressionDef()
        local ex_textstr = finale.FCString()
        ex_textstr.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"..glyph
        ex_ted:SaveNewTextBlock(ex_textstr)
        
        local and_descriptionstr = finale.FCString()
        and_descriptionstr.LuaString="mezzo forte (velocity = 75)"
        ex_ted:SetDescription(and_descriptionstr)
        local cat_def = finale.FCCategoryDef()
        cat_def:Load(1)
        ex_ted:AssignToCategory(cat_def)
        ex_ted:SetUseCategoryPos(true)
        ex_ted:SetUseCategoryFont(true)
        ex_ted:SaveNew()
        table.insert(table_name, ex_ted:GetItemNo())  
    end
    
    local function findExpression(font, glyph, table_name)
        local matching_glyphs = {}
        local exp_defs = finale.FCTextExpressionDefs()
        local exp_def = finale.FCTextExpressionDef()
        exp_defs:LoadAll()
        local already_exists = 0
        for exp in each(exp_defs) do
            if (string.find(exp:CreateTextString().LuaString, font) ~=nil) and (string.find(exp:CreateTextString().LuaString, glyph) ~= nil) then
                already_exists = exp:GetItemNo()
                table.insert(matching_glyphs, already_exists)
            end
        end
        if matching_glyphs[1] == nil then
            CreateExpression(string.sub(glyph, 2), table_name)
        else
            exp_def:Load(matching_glyphs[1])
            table.insert(table_name, exp_def:GetItemNo())  
        end
    end
    
    findExpression("^^fontMus", ")F", first_expression)
    addExpression()
end

str.LuaString = "Function 8"
listbox:AddString(str)
local function func_8()

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

str.LuaString = "Add Crescendo"
listbox:AddString(str)
local function func_13()
    local function createCrescendo(staff, measure_start, measure_end, leftpos, rightpos, endstem)
    
        if rightpos > 1000000 then
            local get_time = finale.FCMeasure()
            get_time:Load(measure_end)
            local new_right_end = get_time:GetTimeSignature()
            local beat = new_right_end:GetBeats()
            local duration = new_right_end:GetBeatDuration()
            rightpos = beat * duration
        end
    
        local staff_pos = {}
    
        for noteentry in eachentrysaved(finenv.Region()) do
            if noteentry:IsNote() then
                for note in each(noteentry) do
                    table.insert(staff_pos, note:CalcStaffPosition())
                end
            end
        end
        
        table.sort(staff_pos)
        
        if staff_pos[1] <= -11 then
            y_value = (staff_pos[1] * 12) - 54
        else
            y_value = -180
        end
    
        local smartshape = finale.FCSmartShape()
        smartshape.ShapeType = finale.SMARTSHAPE_CRESCENDO
        smartshape.EntryBased = false
        smartshape.MakeHorizontal = true
        smartshape.BeatAttached= true
        smartshape.PresetShape = true
        smartshape.Visible = true
        smartshape.LineID = 3
    
        local leftseg = smartshape:GetTerminateSegmentLeft()
        leftseg:SetMeasure(measure_start)
        leftseg.Staff = staff
        leftseg:SetCustomOffset(false)
        leftseg:SetEndpointOffsetY(y_value)
        leftseg:SetMeasurePos(leftpos)
    
        local rightseg = smartshape:GetTerminateSegmentRight()
        rightseg:SetMeasure(measure_end)
        rightseg.Staff = staff
        rightseg:SetCustomOffset(false)
        if endstem == true then
            rightseg:SetEndpointOffsetX(27)
        else
            rightseg:SetEndpointOffsetX(0)
        end
        rightseg:SetEndpointOffsetY(y_value)
        rightseg:SetMeasurePos(rightpos)
        smartshape:SaveNewEverything(NULL, NULL)
    end
    
    local music_region = finenv.Region()

    for addstaff=1, music_region:CalcStaffSpan() do
        music_region:SetStartStaff(addstaff)
        music_region:SetEndStaff(addstaff)
        local measure_pos_table = {}
    
        local count = 0
        
        for noteentry in eachentrysaved(music_region) do
            if noteentry:IsNote() then
                table.insert(measure_pos_table, noteentry:GetMeasurePos())
                count = count + 1
            end
        end
        
        local start_pos = measure_pos_table[1]
        
        local end_pos = measure_pos_table[count]
        
        if count < 2 then
            end_pos = music_region:GetEndMeasurePos() 
        end
            
        local entry_table = {}
        
        local right_note_count = 0
        
        for noteentry in eachentrysaved(music_region) do
            if noteentry:IsNote() then
                table.insert(entry_table, noteentry:GetMeasurePos())
                right_note_count = right_note_count + 1
            end
        end

        local right_noteentry_cell = finale.FCNoteEntryCell(music_region.EndMeasure, addstaff)
        right_noteentry_cell:Load()
        
        local rightnoteentry = right_noteentry_cell:FindEntryStartPosition(entry_table[right_note_count], 1)
        
        local stem_up = rightnoteentry:CalcStemUp()
        createCrescendo(addstaff, music_region.StartMeasure, music_region.EndMeasure, start_pos, end_pos, stem_up)
    end
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