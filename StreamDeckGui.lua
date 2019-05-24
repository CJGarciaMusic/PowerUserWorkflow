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

str.LuaString = "Add ffff"
listbox:AddString(str)
local function func_3()
    local first_expression = {}

    local function addExpression(staff_num, measure_num, measure_pos)
        add_expression=finale.FCExpression()
        add_expression:SetStaff(staff_num)
        add_expression:SetVisible(true)
        add_expression:SetMeasurePos(measure_pos)
        add_expression:SetScaleWithEntry(false)
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(true)
        add_expression:SetID(first_expression[1])
        local and_cell = finale.FCCell(measure_num, staff_num)
        add_expression:SaveNewToCell(and_cell)
    end
    
    local function getFirstNote()
        for staff_range = finenv.Region():GetStartStaff(), finenv.Region():GetEndStaff() do
            local first_note = {}
            local music_range = finenv.Region()
            music_range:SetStartStaff(staff_range)
            music_range:SetEndStaff(staff_range)
            local measures = finale.FCMeasures()
            measures:LoadRegion(music_range)
            
            for m in each(measures) do
                for noteentry in eachentrysaved(finenv.Region()) do
                    if noteentry:IsNote() then
                        table.insert(first_note, {noteentry:GetStaff(), noteentry:GetMeasure(), noteentry:GetMeasurePos()})
                    end
                end
            end
            addExpression(first_note[1][1], first_note[1][2], first_note[1][3])
        end
    end
    
    local function CreateExpression(glyph, table_name)
        local ex_ted = finale.FCTextExpressionDef()
        local ex_textstr = finale.FCString()
        ex_textstr.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"..glyph
        ex_ted:SaveNewTextBlock(ex_textstr)
        
        local and_descriptionstr = finale.FCString()
        and_descriptionstr.LuaString="fortissississimo (velocity = 127)"
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
    
    findExpression("^^fontMus", ")ë", first_expression)
    getFirstNote()
end

str.LuaString = "Add fff"
listbox:AddString(str)
local function func_4()
    local first_expression = {}

    local function addExpression(staff_num, measure_num, measure_pos)
        add_expression=finale.FCExpression()
        add_expression:SetStaff(staff_num)
        add_expression:SetVisible(true)
        add_expression:SetMeasurePos(measure_pos)
        add_expression:SetScaleWithEntry(false)
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(true)
        add_expression:SetID(first_expression[1])
        local and_cell = finale.FCCell(measure_num, staff_num)
        add_expression:SaveNewToCell(and_cell)
    end
    
    local function getFirstNote()
        for staff_range = finenv.Region():GetStartStaff(), finenv.Region():GetEndStaff() do
            local first_note = {}
            local music_range = finenv.Region()
            music_range:SetStartStaff(staff_range)
            music_range:SetEndStaff(staff_range)
            local measures = finale.FCMeasures()
            measures:LoadRegion(music_range)
            
            for m in each(measures) do
                for noteentry in eachentrysaved(finenv.Region()) do
                    if noteentry:IsNote() then
                        table.insert(first_note, {noteentry:GetStaff(), noteentry:GetMeasure(), noteentry:GetMeasurePos()})
                    end
                end
            end
            addExpression(first_note[1][1], first_note[1][2], first_note[1][3])
        end
    end
    
    local function CreateExpression(glyph, table_name)
        local ex_ted = finale.FCTextExpressionDef()
        local ex_textstr = finale.FCString()
        ex_textstr.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"..glyph
        ex_ted:SaveNewTextBlock(ex_textstr)
        
        local and_descriptionstr = finale.FCString()
        and_descriptionstr.LuaString="fortississimo (velocity = 114)"
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
    
    findExpression("^^fontMus", ")ì", first_expression)
    getFirstNote()
end

str.LuaString = "Add ff"
listbox:AddString(str)
local function func_5()
    local first_expression = {}

    local function addExpression(staff_num, measure_num, measure_pos)
        add_expression=finale.FCExpression()
        add_expression:SetStaff(staff_num)
        add_expression:SetVisible(true)
        add_expression:SetMeasurePos(measure_pos)
        add_expression:SetScaleWithEntry(false)
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(true)
        add_expression:SetID(first_expression[1])
        local and_cell = finale.FCCell(measure_num, staff_num)
        add_expression:SaveNewToCell(and_cell)
    end
    
    local function getFirstNote()
        for staff_range = finenv.Region():GetStartStaff(), finenv.Region():GetEndStaff() do
            local first_note = {}
            local music_range = finenv.Region()
            music_range:SetStartStaff(staff_range)
            music_range:SetEndStaff(staff_range)
            local measures = finale.FCMeasures()
            measures:LoadRegion(music_range)
            
            for m in each(measures) do
                for noteentry in eachentrysaved(finenv.Region()) do
                    if noteentry:IsNote() then
                        table.insert(first_note, {noteentry:GetStaff(), noteentry:GetMeasure(), noteentry:GetMeasurePos()})
                    end
                end
            end
            addExpression(first_note[1][1], first_note[1][2], first_note[1][3])
        end
    end
    
    local function CreateExpression(glyph, table_name)
        local ex_ted = finale.FCTextExpressionDef()
        local ex_textstr = finale.FCString()
        ex_textstr.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"..glyph
        ex_ted:SaveNewTextBlock(ex_textstr)
        
        local and_descriptionstr = finale.FCString()
        and_descriptionstr.LuaString="fortissimo (velocity = 101)"
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
    
    findExpression("^^fontMus", ")Ä", first_expression)
    getFirstNote()
end

str.LuaString = "Add f"
listbox:AddString(str)
local function func_6()
    local first_expression = {}

    local function addExpression(staff_num, measure_num, measure_pos)
        add_expression=finale.FCExpression()
        add_expression:SetStaff(staff_num)
        add_expression:SetVisible(true)
        add_expression:SetMeasurePos(measure_pos)
        add_expression:SetScaleWithEntry(false)
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(true)
        add_expression:SetID(first_expression[1])
        local and_cell = finale.FCCell(measure_num, staff_num)
        add_expression:SaveNewToCell(and_cell)
    end

    local function getFirstNote()
        for staff_range = finenv.Region():GetStartStaff(), finenv.Region():GetEndStaff() do
            local first_note = {}
            local music_range = finenv.Region()
            music_range:SetStartStaff(staff_range)
            music_range:SetEndStaff(staff_range)
            local measures = finale.FCMeasures()
            measures:LoadRegion(music_range)
            
            for m in each(measures) do
                for noteentry in eachentrysaved(finenv.Region()) do
                    if noteentry:IsNote() then
                        table.insert(first_note, {noteentry:GetStaff(), noteentry:GetMeasure(), noteentry:GetMeasurePos()})
                    end
                end
            end
            addExpression(first_note[1][1], first_note[1][2], first_note[1][3])
        end
    end

    local function CreateExpression(glyph, table_name)
        local ex_ted = finale.FCTextExpressionDef()
        local ex_textstr = finale.FCString()
        ex_textstr.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"..glyph
        ex_ted:SaveNewTextBlock(ex_textstr)
        
        local and_descriptionstr = finale.FCString()
        and_descriptionstr.LuaString="forte (velocity = 88)"
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
    getFirstNote()
end

str.LuaString = "Add mf"
listbox:AddString(str)
local function func_7()    
    local first_expression = {}

    local function addExpression(staff_num, measure_num, measure_pos)
        add_expression=finale.FCExpression()
        add_expression:SetStaff(staff_num)
        add_expression:SetVisible(true)
        add_expression:SetMeasurePos(measure_pos)
        add_expression:SetScaleWithEntry(false)
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(true)
        add_expression:SetID(first_expression[1])
        local and_cell = finale.FCCell(measure_num, staff_num)
        add_expression:SaveNewToCell(and_cell)
    end
    
    local function getFirstNote()
        for staff_range = finenv.Region():GetStartStaff(), finenv.Region():GetEndStaff() do
            local first_note = {}
            local music_range = finenv.Region()
            music_range:SetStartStaff(staff_range)
            music_range:SetEndStaff(staff_range)
            local measures = finale.FCMeasures()
            measures:LoadRegion(music_range)
            
            for m in each(measures) do
                for noteentry in eachentrysaved(finenv.Region()) do
                    if noteentry:IsNote() then
                        table.insert(first_note, {noteentry:GetStaff(), noteentry:GetMeasure(), noteentry:GetMeasurePos()})
                    end
                end
            end
            addExpression(first_note[1][1], first_note[1][2], first_note[1][3])
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
    getFirstNote()
end

str.LuaString = "Add mp"
listbox:AddString(str)
local function func_8()
    local first_expression = {}

    local function addExpression(staff_num, measure_num, measure_pos)
        add_expression=finale.FCExpression()
        add_expression:SetStaff(staff_num)
        add_expression:SetVisible(true)
        add_expression:SetMeasurePos(measure_pos)
        add_expression:SetScaleWithEntry(false)
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(true)
        add_expression:SetID(first_expression[1])
        local and_cell = finale.FCCell(measure_num, staff_num)
        add_expression:SaveNewToCell(and_cell)
    end
    
    local function getFirstNote()
        for staff_range = finenv.Region():GetStartStaff(), finenv.Region():GetEndStaff() do
            local first_note = {}
            local music_range = finenv.Region()
            music_range:SetStartStaff(staff_range)
            music_range:SetEndStaff(staff_range)
            local measures = finale.FCMeasures()
            measures:LoadRegion(music_range)
            
            for m in each(measures) do
                for noteentry in eachentrysaved(finenv.Region()) do
                    if noteentry:IsNote() then
                        table.insert(first_note, {noteentry:GetStaff(), noteentry:GetMeasure(), noteentry:GetMeasurePos()})
                    end
                end
            end
            addExpression(first_note[1][1], first_note[1][2], first_note[1][3])
        end
    end
    
    local function CreateExpression(glyph, table_name)
        local ex_ted = finale.FCTextExpressionDef()
        local ex_textstr = finale.FCString()
        ex_textstr.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"..glyph
        ex_ted:SaveNewTextBlock(ex_textstr)
        
        local and_descriptionstr = finale.FCString()
        and_descriptionstr.LuaString="mezzo piano (velocity = 62)"
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
    
    findExpression("^^fontMus", ")P", first_expression)
    getFirstNote()
end

str.LuaString = "Add p"
listbox:AddString(str)
local function func_9()
    local first_expression = {}

    local function addExpression(staff_num, measure_num, measure_pos)
        add_expression=finale.FCExpression()
        add_expression:SetStaff(staff_num)
        add_expression:SetVisible(true)
        add_expression:SetMeasurePos(measure_pos)
        add_expression:SetScaleWithEntry(false)
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(true)
        add_expression:SetID(first_expression[1])
        local and_cell = finale.FCCell(measure_num, staff_num)
        add_expression:SaveNewToCell(and_cell)
    end
    
    local function getFirstNote()
        for staff_range = finenv.Region():GetStartStaff(), finenv.Region():GetEndStaff() do
            local first_note = {}
            local music_range = finenv.Region()
            music_range:SetStartStaff(staff_range)
            music_range:SetEndStaff(staff_range)
            local measures = finale.FCMeasures()
            measures:LoadRegion(music_range)
            
            for m in each(measures) do
                for noteentry in eachentrysaved(finenv.Region()) do
                    if noteentry:IsNote() then
                        table.insert(first_note, {noteentry:GetStaff(), noteentry:GetMeasure(), noteentry:GetMeasurePos()})
                    end
                end
            end
            addExpression(first_note[1][1], first_note[1][2], first_note[1][3])
        end
    end
    
    local function CreateExpression(glyph, table_name)
        local ex_ted = finale.FCTextExpressionDef()
        local ex_textstr = finale.FCString()
        ex_textstr.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"..glyph
        ex_ted:SaveNewTextBlock(ex_textstr)
        
        local and_descriptionstr = finale.FCString()
        and_descriptionstr.LuaString="piano (velocity = 49)"
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
    
    findExpression("^^fontMus", ")p", first_expression)
    getFirstNote()
end

str.LuaString = "Add pp"
listbox:AddString(str)
local function func_10()
    local first_expression = {}

    local function addExpression(staff_num, measure_num, measure_pos)
        add_expression=finale.FCExpression()
        add_expression:SetStaff(staff_num)
        add_expression:SetVisible(true)
        add_expression:SetMeasurePos(measure_pos)
        add_expression:SetScaleWithEntry(false)
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(true)
        add_expression:SetID(first_expression[1])
        local and_cell = finale.FCCell(measure_num, staff_num)
        add_expression:SaveNewToCell(and_cell)
    end
    
    local function getFirstNote()
        for staff_range = finenv.Region():GetStartStaff(), finenv.Region():GetEndStaff() do
            local first_note = {}
            local music_range = finenv.Region()
            music_range:SetStartStaff(staff_range)
            music_range:SetEndStaff(staff_range)
            local measures = finale.FCMeasures()
            measures:LoadRegion(music_range)
            
            for m in each(measures) do
                for noteentry in eachentrysaved(finenv.Region()) do
                    if noteentry:IsNote() then
                        table.insert(first_note, {noteentry:GetStaff(), noteentry:GetMeasure(), noteentry:GetMeasurePos()})
                    end
                end
            end
            addExpression(first_note[1][1], first_note[1][2], first_note[1][3])
        end
    end
    
    local function CreateExpression(glyph, table_name)
        local ex_ted = finale.FCTextExpressionDef()
        local ex_textstr = finale.FCString()
        ex_textstr.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"..glyph
        ex_ted:SaveNewTextBlock(ex_textstr)
        
        local and_descriptionstr = finale.FCString()
        and_descriptionstr.LuaString="pianissimo (velocity = 36)"
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
    
    findExpression("^^fontMus", ")¹", first_expression)
    getFirstNote()
end

str.LuaString = "Add ppp"
listbox:AddString(str)
local function func_11()
    local first_expression = {}

    local function addExpression(staff_num, measure_num, measure_pos)
        add_expression=finale.FCExpression()
        add_expression:SetStaff(staff_num)
        add_expression:SetVisible(true)
        add_expression:SetMeasurePos(measure_pos)
        add_expression:SetScaleWithEntry(false)
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(true)
        add_expression:SetID(first_expression[1])
        local and_cell = finale.FCCell(measure_num, staff_num)
        add_expression:SaveNewToCell(and_cell)
    end
    
    local function getFirstNote()
        for staff_range = finenv.Region():GetStartStaff(), finenv.Region():GetEndStaff() do
            local first_note = {}
            local music_range = finenv.Region()
            music_range:SetStartStaff(staff_range)
            music_range:SetEndStaff(staff_range)
            local measures = finale.FCMeasures()
            measures:LoadRegion(music_range)
            
            for m in each(measures) do
                for noteentry in eachentrysaved(finenv.Region()) do
                    if noteentry:IsNote() then
                        table.insert(first_note, {noteentry:GetStaff(), noteentry:GetMeasure(), noteentry:GetMeasurePos()})
                    end
                end
            end
            addExpression(first_note[1][1], first_note[1][2], first_note[1][3])
        end
    end
    
    local function CreateExpression(glyph, table_name)
        local ex_ted = finale.FCTextExpressionDef()
        local ex_textstr = finale.FCString()
        ex_textstr.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"..glyph
        ex_ted:SaveNewTextBlock(ex_textstr)
        
        local and_descriptionstr = finale.FCString()
        and_descriptionstr.LuaString="pianississimo (velocity = 23)"
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
    
    findExpression("^^fontMus", ")¸", first_expression)
    getFirstNote()
end

str.LuaString = "Add pppp"
listbox:AddString(str)
local function func_12()
    local first_expression = {}

    local function addExpression(staff_num, measure_num, measure_pos)
        add_expression=finale.FCExpression()
        add_expression:SetStaff(staff_num)
        add_expression:SetVisible(true)
        add_expression:SetMeasurePos(measure_pos)
        add_expression:SetScaleWithEntry(false)
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(true)
        add_expression:SetID(first_expression[1])
        local and_cell = finale.FCCell(measure_num, staff_num)
        add_expression:SaveNewToCell(and_cell)
    end
    
    local function getFirstNote()
        for staff_range = finenv.Region():GetStartStaff(), finenv.Region():GetEndStaff() do
            local first_note = {}
            local music_range = finenv.Region()
            music_range:SetStartStaff(staff_range)
            music_range:SetEndStaff(staff_range)
            local measures = finale.FCMeasures()
            measures:LoadRegion(music_range)
            
            for m in each(measures) do
                for noteentry in eachentrysaved(finenv.Region()) do
                    if noteentry:IsNote() then
                        table.insert(first_note, {noteentry:GetStaff(), noteentry:GetMeasure(), noteentry:GetMeasurePos()})
                    end
                end
            end
            addExpression(first_note[1][1], first_note[1][2], first_note[1][3])
        end
    end
    
    local function CreateExpression(glyph, table_name)
        local ex_ted = finale.FCTextExpressionDef()
        local ex_textstr = finale.FCString()
        ex_textstr.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"..glyph
        ex_ted:SaveNewTextBlock(ex_textstr)
        
        local and_descriptionstr = finale.FCString()
        and_descriptionstr.LuaString="pianissississimo (velocity = 10)"
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
    
    findExpression("^^fontMus", ")¯", first_expression)
    getFirstNote()
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
                    local text_met = finale.FCTextMetrics()
                    text_met:LoadString(create_def:CreateTextString(), create_def:CreateTextString():CreateLastFontInfo(), 100)
                    left_x_value = ((text_met:CalcWidthEVPUs() - 1027) / 2) + (le:GetHorizontalPos())
                    left_add_offset = le:GetVerticalPos()
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
                    local text_met = finale.FCTextMetrics()
                    text_met:LoadString(create_def:CreateTextString(), create_def:CreateTextString():CreateLastFontInfo(), 100)
                    right_x_value = (0 - (text_met:CalcWidthEVPUs() - 1000) / 2) + (re:GetHorizontalPos())
                    right_add_offset = re:GetVerticalPos()
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
        print(left_x_value)
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

str.LuaString = "Add Decrescendo"
listbox:AddString(str)
local function func_14()
    local function createDecrescendo(staff, measure_start, measure_end, leftpos, rightpos)    
        local smartshape = finale.FCSmartShape()
        smartshape.ShapeType = finale.SMARTSHAPE_DIMINUENDO
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
                    local text_met = finale.FCTextMetrics()
                    text_met:LoadString(create_def:CreateTextString(), create_def:CreateTextString():CreateLastFontInfo(), 100)
                    left_x_value = ((text_met:CalcWidthEVPUs() - 1027) / 2) + (le:GetHorizontalPos())
                    left_add_offset = le:GetVerticalPos()
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
                    local text_met = finale.FCTextMetrics()
                    text_met:LoadString(create_def:CreateTextString(), create_def:CreateTextString():CreateLastFontInfo(), 100)
                    right_x_value = (0 - (text_met:CalcWidthEVPUs() - 1000) / 2) + (re:GetHorizontalPos())
                    right_add_offset = re:GetVerticalPos()
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
        print(left_x_value)
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
            createDecrescendo(addstaff, start_meas, end_meas, start_pos, end_pos)
        end
    end
    setRange()
end

str.LuaString = "Add n"
listbox:AddString(str)
local function func_15()
    local first_expression = {}

    local function addExpression(staff_num, measure_num, measure_pos)
        add_expression=finale.FCExpression()
        add_expression:SetStaff(staff_num)
        add_expression:SetVisible(true)
        add_expression:SetMeasurePos(measure_pos)
        add_expression:SetScaleWithEntry(false)
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(true)
        add_expression:SetID(first_expression[1])
        local and_cell = finale.FCCell(measure_num, staff_num)
        add_expression:SaveNewToCell(and_cell)
    end
    
    local function getFirstNote()
        for staff_range = finenv.Region():GetStartStaff(), finenv.Region():GetEndStaff() do
            local first_note = {}
            local music_range = finenv.Region()
            music_range:SetStartStaff(staff_range)
            music_range:SetEndStaff(staff_range)
            local measures = finale.FCMeasures()
            measures:LoadRegion(music_range)
            
            for m in each(measures) do
                for noteentry in eachentrysaved(finenv.Region()) do
                    if noteentry:IsNote() then
                        table.insert(first_note, {noteentry:GetStaff(), noteentry:GetMeasure(), noteentry:GetMeasurePos()})
                    end
                end
            end
            addExpression(first_note[1][1], first_note[1][2], first_note[1][3])
        end
    end
    
    local function CreateExpression(glyph, table_name)
        local ex_ted = finale.FCTextExpressionDef()
        local ex_textstr = finale.FCString()
        ex_textstr.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"..glyph
        ex_ted:SaveNewTextBlock(ex_textstr)
        
        local and_descriptionstr = finale.FCString()
        and_descriptionstr.LuaString="niente (velocity = 0)"
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
    
    findExpression("^^fontMus", ")ñ", first_expression)
    getFirstNote()
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