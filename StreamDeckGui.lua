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
    local function createCrescendo(staff, measure_start, measure_end, leftpos, rightpos)    
        local smartshape = finale.FCSmartShape()
        smartshape.ShapeType = finale.SMARTSHAPE_CRESCENDO
        smartshape.EntryBased = false
        smartshape.MakeHorizontal = true
        smartshape.BeatAttached= true
        smartshape.PresetShape = true
        smartshape.Visible = true
        smartshape.LineID = 3
    
        if rightpos > 1000000 then
            local get_time = finale.FCMeasure()
            get_time:Load(measure_end)
            local new_right_end = get_time:GetTimeSignature()
            local beat = new_right_end:GetBeats()
            local duration = new_right_end:GetBeatDuration()
            rightpos = beat * duration
        end
    
        local staff_pos = {}
    
        local music_reg = finenv.Region()
        music_reg:SetStartStaff(staff)
        music_reg:SetEndStaff(staff)
    
        for noteentry in eachentrysaved(music_reg) do
            if noteentry:IsNote() then
                for note in each(noteentry) do
                    table.insert(staff_pos, note:CalcStaffPosition())
                end
            end
        end
    
        local has_left_dyn = 0
        local left_x_value = 0
        music_reg:SetStartMeasure(measure_start)
        music_reg:SetEndMeasure(measure_start)
        music_reg:SetStartMeasurePos(leftpos)
        music_reg:SetEndMeasurePos(leftpos)
    
        local left_expressions = finale.FCExpressions()
        left_expressions:LoadAllForRegion(music_reg)
    
        local left_add_offset = 0
    
        for le in each(left_expressions) do
            local create_def = le:CreateTextExpressionDef()
            local cd = finale.FCCategoryDef()
            if cd:Load(create_def:GetCategoryID()) then
                if string.find(cd:CreateName().LuaString, "Dynamic") then
                    has_left_dyn = 1
                    if string.find(create_def:CreateTextString().LuaString, ")ë") then
                        left_x_value = 68 + (le:GetHorizontalPos())
                        left_add_offset = le:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")ì") then
                        left_x_value = 54 + (le:GetHorizontalPos())
                        left_add_offset = le:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")Ä") then
                        left_x_value = 45 + (le:GetHorizontalPos())
                        left_add_offset = le:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")f") then
                        left_x_value = 36 + (le:GetHorizontalPos())
                        left_add_offset = le:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")F") then
                        left_x_value = 54 + (le:GetHorizontalPos())
                        left_add_offset = le:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")P") then
                        left_x_value = 54 + (le:GetHorizontalPos())
                        left_add_offset = le:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")p") then
                        left_x_value = 36 + (le:GetHorizontalPos())
                        left_add_offset = le:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")¹") then
                        left_x_value = 54 + (le:GetHorizontalPos())
                        left_add_offset = le:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")¸") then
                        left_x_value = 68 + (le:GetHorizontalPos())
                        left_add_offset = le:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")¯") then
                        left_x_value = 86 + (le:GetHorizontalPos())
                        left_add_offset = le:GetVerticalPos()
                    end
                end
            end
        end
         
        local has_right_dyn = 0
        music_reg:SetStartMeasure(measure_end)
        music_reg:SetEndMeasure(measure_end)
        music_reg:SetStartMeasurePos(rightpos)
        music_reg:SetEndMeasurePos(rightpos)
    
        local right_expressions = finale.FCExpressions()
        right_expressions:LoadAllForRegion(music_reg)
        
        local right_add_offset = 0
    
        for re in each(right_expressions) do
            local create_def = re:CreateTextExpressionDef()
            local cd = finale.FCCategoryDef()
            if cd:Load(create_def:GetCategoryID()) then
                if string.find(cd:CreateName().LuaString, "Dynamic") then
                    has_right_dyn = 1
                    if string.find(create_def:CreateTextString().LuaString, ")ë") then
                        right_x_value = -76 + (re:GetHorizontalPos())
                        right_add_offset = re:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")ì") then
                        right_x_value = -63 + (re:GetHorizontalPos())
                        right_add_offset = re:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")Ä") then
                        right_x_value = -52 + (re:GetHorizontalPos())
                        right_add_offset = re:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")f") then
                        right_x_value = -40 + (re:GetHorizontalPos())
                        right_add_offset = re:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")F") then
                        right_x_value = -50 + (re:GetHorizontalPos())
                        right_add_offset = re:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")P") then
                        right_x_value = -54 + (re:GetHorizontalPos())
                        right_add_offset = re:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")p") then
                        right_x_value = -40 + (re:GetHorizontalPos())
                        right_add_offset = re:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")¹") then
                        right_x_value = -60 + (re:GetHorizontalPos())
                        right_add_offset = re:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")¸") then
                        right_x_value = -80 + (re:GetHorizontalPos())
                        right_add_offset = re:GetVerticalPos()
                    end
                    if string.find(create_def:CreateTextString().LuaString, ")¯") then
                        right_x_value = -98 + (re:GetHorizontalPos())
                        right_add_offset = re:GetVerticalPos()
                    end
                end
            end
        end
    
        local additional_offset = 0
        local base_line_offset = 16
        local entry_offset  = -72
    
        local get_offsets = finale.FCExpressions()
        get_offsets:LoadAllForRegion(music_reg)
    
        for offset in each(get_offsets) do
            local create_def = offset:CreateTextExpressionDef()
            local cd = finale.FCCategoryDef()
            if cd:Load(create_def:GetCategoryID()) then
                if string.find(cd:CreateName().LuaString, "Dynamic") then
                    base_line_offset =  create_def:GetVerticalBaselineOffset()
                    entry_offset = create_def:GetVerticalEntryOffset()
                end
            end
        end
    
        if left_add_offset <= right_add_offset then
            additional_offset = left_add_offset
        else
            additional_offset = right_add_offset
        end
    
        table.sort(staff_pos)
    
        if staff_pos[1] <= -11 then
            y_value = ((staff_pos[1] * 12) + entry_offset) + additional_offset
        else
            y_value = (base_line_offset * -12) + additional_offset
        end
    
        if has_left_dyn == 0 then
            left_x_value = 0
        end
    
        local leftseg = smartshape:GetTerminateSegmentLeft()
        leftseg:SetMeasure(measure_start)
        leftseg.Staff = staff
        leftseg:SetCustomOffset(false)
        leftseg:SetEndpointOffsetY(y_value)
        leftseg:SetEndpointOffsetX(left_x_value)
        leftseg:SetMeasurePos(leftpos)
    
    
        if has_right_dyn == 0 then
            right_x_value = 0
        end
    
        local rightseg = smartshape:GetTerminateSegmentRight()
        rightseg:SetMeasure(measure_end)
        rightseg.Staff = staff
        rightseg:SetCustomOffset(false)
        if right_x_value == 0 then
            rightseg:SetEndpointOffsetX(0)
        else
            rightseg:SetEndpointOffsetX(right_x_value)
        end
        rightseg:SetEndpointOffsetY(y_value)
        rightseg:SetMeasurePos(rightpos)
        smartshape:SaveNewEverything(nil, nil)
    end
    
    local function setRange()
        local music_region = finenv.Region()
        local start_meas = music_region.StartMeasure
        local end_meas = music_region.EndMeasure
        local measure_pos_table = {}
    
        local count = 0
        
        for noteentry in eachentry(music_region) do
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
    
        for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
            createCrescendo(addstaff, start_meas, end_meas, start_pos, end_pos)
        end
    end
    
    setRange()
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