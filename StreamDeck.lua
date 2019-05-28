function plugindef()
    finaleplugin.RequireSelection = true
    finaleplugin.Author = "CJ Garcia"
    finaleplugin.Copyright = "© 2019 CJ Garcia Music"
    finaleplugin.Version = "0.3"
    finaleplugin.Date = "5/27/2019"
    return "Stream Deck", "Stream Deck", "A selectable list of all Lua functions related to Stream Deck"
end

local dialog = finenv.UserValueInput()
dialog.Title = "Stream Deck for Finale"

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

local function createHairpin(staff, measure_start, measure_end, leftpos, rightpos, shape, gap_num)    
    local smartshape = finale.FCSmartShape()
    smartshape.ShapeType = shape
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

    if staff_pos[1] == nil then
        y_value = (base_line_offset * -12) + additional_offset
    else
        if staff_pos[1] <= -11 then
            y_value = ((staff_pos[1] * 12) + entry_offset) + additional_offset
        else
            y_value = (base_line_offset * -12) + additional_offset
        end
    end

    if has_left_dyn == 0 then
        if (shape == finale.SMARTSHAPE_CRESCENDO) and (gap_num == 0) then
            left_x_value = 0
        else
            left_x_value = gap_num
        end
    end

    local leftseg = smartshape:GetTerminateSegmentLeft()
    leftseg:SetMeasure(measure_start)
    leftseg.Staff = staff
    leftseg:SetCustomOffset(false)
    leftseg:SetEndpointOffsetY(y_value)
    leftseg:SetEndpointOffsetX(left_x_value)
    leftseg:SetMeasurePos(leftpos)


    if has_right_dyn == 0 then
        if (shape == finale.SMARTSHAPE_DIMINUENDO) and (gap_num == 0) then
            right_x_value = 0
        else
            right_x_value = gap_num
        end
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

local function setHairpinRange(smart_shape)
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
        createHairpin(addstaff, start_meas, end_meas, start_pos, end_pos, smart_shape, 0)
    end
end

local function setSwellRange(smart_shape1, smart_shape2)
    local music_region = finenv.Region()
    local measure_pos_table = {}
    local measure_table = {}

    local count = 0
    
    for noteentry in eachentry(music_region) do
        if noteentry:IsNote() then
            table.insert(measure_pos_table, noteentry:GetMeasurePos())
            table.insert(measure_table, noteentry:GetMeasure())
            count = count + 1
        end
    end
    local start_meas = measure_table[1]
    local end_meas = measure_table[count]
    local start_pos = measure_pos_table[1]
    local end_pos = measure_pos_table[count]

    local half_way_meas = finenv.Region()
    half_way_meas:SetStartMeasure(start_meas)
    half_way_meas:SetEndMeasure(end_meas)

    local half_way_region = finenv.Region()
    half_way_region:SetStartMeasurePos(start_pos)
    half_way_region:SetEndMeasurePos(end_pos)

    local half_way_pos = half_way_region:CalcDuration()

    local get_time = finale.FCMeasure()
    get_time:Load(start_meas)
    local signature = get_time:GetTimeSignature()
    local beat = signature:GetBeats()
    local duration = signature:GetBeatDuration()
    local one_measure = beat * duration
    local half_measure = math.floor((half_way_meas:CalcMeasureSpan() / 2) + 0.5)
    local half_point = math.floor((((half_measure * one_measure) + 0.5) - math.floor(half_way_pos:CalcDuration() / 2) - 0.5)) - duration

    if count < 2 then
        end_pos = music_region:GetEndMeasurePos() 
    end

    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        createHairpin(addstaff, start_meas, half_measure, start_pos, half_point, smart_shape1, -12)
        createHairpin(addstaff, half_measure, end_meas, half_point, end_pos, smart_shape2, 12)
    end
end

local first_expression = {}

local function addExpression(staff_num, measure_num, measure_pos)
    local del_region = finenv.Region()
    del_region:SetStartStaff(staff_num)
    del_region:SetEndStaff(staff_num)
    del_region:SetStartMeasure(measure_num)
    del_region:SetEndMeasure(measure_num)
    del_region:SetStartMeasurePos(measure_pos)
    del_region:SetEndMeasurePos(measure_pos)
    local expressions = finale.FCExpressions()
    expressions:LoadAllForRegion(del_region)
    for e in each(expressions) do
        local ex_def = finale.FCTextExpressionDef()
        ex_def:Load(e.ID)
        if ex_def:GetCategoryID() == 1 then
            e:DeleteData()
        end
    end
    add_expression=finale.FCExpression()
    add_expression:SetStaff(staff_num)
    add_expression:SetVisible(true)
    add_expression:SetMeasurePos(measure_pos)
    add_expression:SetScaleWithEntry(true)
    add_expression:SetPartAssignment(true)
    add_expression:SetScoreAssignment(true)
    add_expression:SetID(first_expression[1])
    local and_cell = finale.FCCell(measure_num, staff_num)
    add_expression:SaveNewToCell(and_cell)
end

local function getFirstNoteInRegion()
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
        if first_note[1] == nil then
            return
        else
            addExpression(first_note[1][1], first_note[1][2], first_note[1][3])
        end
    end
end

local function CreateExpression(glyph_list, table_name, exp_description)
    local ex_ted = finale.FCTextExpressionDef()
    local ex_textstr = finale.FCString()
    ex_textstr.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"
    for key, value in pairs(glyph_list) do
        ex_textstr:AppendCharacter(value)
    end
    ex_ted:SaveNewTextBlock(ex_textstr)
    
    local and_descriptionstr = finale.FCString()
    and_descriptionstr.LuaString=exp_description
    ex_ted:SetDescription(and_descriptionstr)
    local cat_def = finale.FCCategoryDef()
    cat_def:Load(1)
    ex_ted:AssignToCategory(cat_def)
    ex_ted:SetUseCategoryPos(true)
    ex_ted:SetUseCategoryFont(true)
    ex_ted:SaveNew()
    table.insert(table_name, ex_ted:GetItemNo())  
end

local function findExpression(font, glyph_nums, table_name, description_text)
    local matching_glyphs = {}
    local exp_defs = finale.FCTextExpressionDefs()
    local exp_def = finale.FCTextExpressionDef()
    exp_defs:LoadAll()
    local already_exists = 0
    for exp in each(exp_defs) do
        local glyph_length = 0
        local exp_string = finale.FCString()
        exp_string.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"
        for key, value in pairs(glyph_nums) do
            exp_string:AppendCharacter(value)
            glyph_length = glyph_length + 1
        end
        if (string.find(exp:CreateTextString().LuaString, font) ~=nil) then
            if glyph_length > 1 then
                if ((exp:CreateTextString():GetCharacterAt(-1) == glyph_nums[2]) and (exp:CreateTextString():GetCharacterAt(33) == glyph_nums[1])) then
                    already_exists = exp:GetItemNo()
                    table.insert(matching_glyphs, already_exists)
                end
            else
                if exp:CreateTextString():GetCharacterAt(-1) == glyph_nums[1] then
                    already_exists = exp:GetItemNo()
                    table.insert(matching_glyphs, already_exists) 
                end
            end
        end
    end
    if matching_glyphs[1] == nil then
        CreateExpression(glyph_nums, table_name, description_text)
    else
        exp_def:Load(matching_glyphs[1])
        table.insert(table_name, exp_def:GetItemNo())  
    end
end

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

local function func_3()
    findExpression("^^fontMus", {235}, first_expression, "fortissississimo (velocity = 127)")
    getFirstNoteInRegion()
end

local function func_4()    
    findExpression("^^fontMus", {236}, first_expression, "fortississimo (velocity = 114)")
    getFirstNoteInRegion()
end

local function func_5()    
    findExpression("^^fontMus", {196}, first_expression, "fortissimo (velocity = 101)")
    getFirstNoteInRegion()
end

local function func_6()
    findExpression("^^fontMus", {102}, first_expression, "forte (velocity = 88)")
    getFirstNoteInRegion()
end

local function func_7()    
    findExpression("^^fontMus", {70}, first_expression, "mezzo forte (velocity = 75)")
    getFirstNoteInRegion()
end

local function func_8()    
    findExpression("^^fontMus", {80}, first_expression, "mezzo piano (velocity = 62)")
    getFirstNoteInRegion()
end

local function func_9()    
    findExpression("^^fontMus", {112}, first_expression, "piano (velocity = 49)")
    getFirstNoteInRegion()
end

local function func_10()
    findExpression("^^fontMus", {185}, first_expression, "pianissimo (velocity = 36)")
    getFirstNoteInRegion()
end


local function func_11()    
    findExpression("^^fontMus", {184}, first_expression, "pianississimo (velocity = 23)")
    getFirstNoteInRegion()
end


local function func_12()    
    findExpression("^^fontMus", {175}, first_expression, "pianissississimo (velocity = 10)")
    getFirstNoteInRegion()
end


local function func_13()
    findExpression("^^fontMus", {150}, first_expression, "niente (velocity = 0)")
    getFirstNoteInRegion()
end

local function func_14()
    findExpression("^^fontMus", {234}, first_expression, "forte piano")
    getFirstNoteInRegion()
end

local function func_15()
    findExpression("^^fontMus", {90}, first_expression, "forzando")
    getFirstNoteInRegion()
end

local function func_16()
    findExpression("^^fontMus", {83}, first_expression, "sforzando")
    getFirstNoteInRegion()
end


local function func_17()
    findExpression("^^fontMus", {167}, first_expression, "sforzato")
    getFirstNoteInRegion()
end


local function func_18()
    findExpression("^^fontMus", {141}, first_expression, "sforzato")
    getFirstNoteInRegion()
end

local function func_19()
    findExpression("^^fontMus", {167, 112}, first_expression, "sforzando piano")
    getFirstNoteInRegion()
end

local function func_20()
    findExpression("^^fontMus", {182}, first_expression, "sforzato pianissimo")
    getFirstNoteInRegion()
end

local function func_21()
    findExpression("^^fontMus", {130}, first_expression, "sforzato piano")
    getFirstNoteInRegion()
end


local function func_22()
    findExpression("^^fontMus", {142, 90}, first_expression, "rinforzando")
    getFirstNoteInRegion()
end


local function func_23()
    findExpression("^^fontMus", {142, 102}, first_expression, "rinforte")
    getFirstNoteInRegion()
end


local function func_24()
    setHairpinRange(finale.SMARTSHAPE_CRESCENDO)
end

local function func_25()
    setHairpinRange(finale.SMARTSHAPE_DIMINUENDO)
end

local function func_26()
    setSwellRange(finale.SMARTSHAPE_CRESCENDO, finale.SMARTSHAPE_DIMINUENDO)
end

local function func_27()
    setSwellRange(finale.SMARTSHAPE_DIMINUENDO, finale.SMARTSHAPE_CRESCENDO)
end

dialog:SetTypes("String")
dialog:SetDescriptions("Function Number")

local returnvalues = dialog:Execute() 

if returnvalues ~= nil then
    if returnvalues[1] == "0001" then
        func_1()
    end
    if returnvalues[1] == "0002" then
        func_2()
    end
    if returnvalues[1] == "0003" then
        func_3()
    end
    if returnvalues[1] == "0004" then
        func_4()
    end
    if returnvalues[1] == "0005" then
        func_5()
    end
    if returnvalues[1] == "0006" then
        func_6()
    end
    if returnvalues[1] == "0007" then
        func_7()
    end
    if returnvalues[1] == "0008" then
        func_8()
    end
    if returnvalues[1] == "0009" then
        func_9()
    end
    if returnvalues[1] == "0010" then
        func_10()
    end
    if returnvalues[1] == "0011" then
        func_11()
    end
    if returnvalues[1] == "0012" then
        func_12()
    end
    if returnvalues[1] == "0013" then
        func_13()
    end
    if returnvalues[1] == "0014" then
        func_14()
    end
    if returnvalues[1] == "0015" then
        func_15()
    end
    if returnvalues[1] == "0016" then
        func_16()
    end
    if returnvalues[1] == "0017" then
        func_17()
    end
    if returnvalues[1] == "0018" then
        func_18()
    end
    if returnvalues[1] == "0019" then
        func_19()
    end
    if returnvalues[1] == "0020" then
        func_20()
    end
    if returnvalues[1] == "0021" then
        func_21()
    end
    if returnvalues[1] == "0022" then
        func_22()
    end
    if returnvalues[1] == "0023" then
        func_23()
    end
    if returnvalues[1] == "0024" then
        func_24()
    end
    if returnvalues[1] == "0025" then
        func_25()
    end
    if returnvalues[1] == "0026" then
        func_26()
    end
    if returnvalues[1] == "0027" then
        func_27()
    end
end