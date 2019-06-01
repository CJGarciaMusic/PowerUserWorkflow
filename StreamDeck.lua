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

local full_art_table = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

local function assignArticulation(art_id)
    for noteentry in eachentrysaved(finenv.Region()) do
        local a = finale.FCArticulation()
        a:SetNoteEntry(noteentry)
        local ad = finale.FCArticulationDef()        
        if (noteentry:IsNote()) and (noteentry:IsTiedBackwards() == false) then
            a:SetID(art_id)
            a:SaveNew()
        else
            if ad:GetAboveSymbolChar() == 85 then
                a:SetID(art_id)
                a:SaveNew()
            end
        end 
    end
end

local function createArticulation(table_placement, MainSymbolChar, MainSymbolFont, AboveSymbolChar, AboveUsesMain, AlwaysPlaceOutsideStaff, AttachToTopNote, AttackIsPercent, AutoPosSide, AvoidStaffLines, BelowSymbolChar, BelowUsesMain, BottomAttack, BottomDuration, BottomVelocity, CenterHorizontally, CopyMainSymbol, CopyMainSymbolHorizontally, DefaultVerticalPos, DurationIsPercent, MainHandleHorizontalOffset, MainHandleVerticalOffset, FlippedHandleHorizontalOffset, FlippedHandleVerticalOffset, FlippedSymbolChar, FlippedSymbolFont, InsideSlurs, OnScreenOnly, Playback, TopAttack, TopDuration, TopVelocity, VelocityIsPercent, fm_Absolute, fm_Bold, fm_EnigmaStyles, fm_Hidden, fm_Italic, fm_Name, fm_Size, fm_SizeFloat, fm_StrikeOut, fm_Underline, ff_Absolute, ff_Bold, ff_EnigmaStyles, ff_Hidden, ff_Italic, ff_Name, ff_Size, ff_SizeFloat, ff_StrikeOut, ff_Underline)
    local ad = finale.FCArticulationDef()
    ad:SetMainSymbolChar(MainSymbolChar)
    ad:SetMainSymbolFont(MainSymbolFont)
    ad:SetAboveSymbolChar(AboveSymbolChar)
    ad:SetAboveUsesMain(AboveUsesMain)
    ad:SetAlwaysPlaceOutsideStaff(AlwaysPlaceOutsideStaff)
    ad:SetAttachToTopNote(AttachToTopNote)
    ad:SetAttackIsPercent(AttackIsPercent)
    ad:SetAutoPosSide(AutoPosSide)
    ad:SetAvoidStaffLines(AvoidStaffLines)
    ad:SetBelowSymbolChar(BelowSymbolChar)
    ad:SetBelowUsesMain(BelowUsesMain)
    ad:SetBottomAttack(BottomAttack)
    ad:SetBottomDuration(BottomDuration)
    ad:SetBottomVelocity(BottomVelocity)
    ad:SetCenterHorizontally(CenterHorizontally)
    ad:SetCopyMainSymbol(CopyMainSymbol)
    ad:SetCopyMainSymbolHorizontally(CopyMainSymbolHorizontally)
    ad:SetDefaultVerticalPos(DefaultVerticalPos)
    ad:SetDurationIsPercent(DurationIsPercent)
    ad:SetMainHandleHorizontalOffset(MainHandleHorizontalOffset)
    ad:SetMainHandleVerticalOffset(MainHandleVerticalOffset)
    ad:SetFlippedHandleHorizontalOffset(FlippedHandleHorizontalOffset)
    ad:SetFlippedHandleVerticalOffset(FlippedHandleVerticalOffset)
    ad:SetFlippedSymbolChar(FlippedSymbolChar)
    ad:SetFlippedSymbolFont(FlippedSymbolFont)
    ad:SetInsideSlurs(InsideSlurs)
    ad:SetOnScreenOnly(OnScreenOnly)
    ad:SetPlayback(Playback)
    ad:SetTopAttack(TopAttack)
    ad:SetTopDuration(TopDuration)
    ad:SetTopVelocity(TopVelocity)
    ad:SetVelocityIsPercent(VelocityIsPercent)
    local fonti = ad:CreateMainSymbolFontInfo()
    fonti:SetAbsolute(fm_Absolute)
    fonti:SetBold(fm_Bold)
    fonti:SetEnigmaStyles(fm_EnigmaStyles)
    fonti:SetHidden(fm_Hidden)
    fonti:SetItalic(fm_Italic)
    fonti:SetName(fm_Name)
    fonti:SetSize(fm_Size)
    fonti:SetSizeFloat(fm_SizeFloat)
    fonti:SetStrikeOut(fm_StrikeOut)
    fonti:SetUnderline(fm_Underline)
    ad:SetMainSymbolFontInfo(fonti)
    local fontif = ad:CreateFlippedSymbolFontInfo()
    fontif:SetAbsolute(ff_Absolute)
    fontif:SetBold(ff_Bold)
    fontif:SetEnigmaStyles(ff_EnigmaStyles)
    fontif:SetHidden(ff_Hidden)
    fontif:SetItalic(ff_Italic)
    fontif:SetName(ff_Name)
    fontif:SetSize(ff_Size)
    fontif:SetSizeFloat(ff_SizeFloat)
    fontif:SetStrikeOut(ff_StrikeOut)
    fontif:SetUnderline(ff_Underline)
    ad:SetFlippedSymbolFontInfo(fontif)
    ad:SaveNew()
    full_art_table[table_placement] = ad:GetItemNo()
    assignArticulation(full_art_table[table_placement])
end

local function deleteArticulation(id_num)
    for noteentry in eachentrysaved(finenv.Region()) do
        local artics = noteentry:CreateArticulations()
        for a in eachbackwards(artics) do
            local defs = a:CreateArticulationDef()
            if defs:GetItemNo() == id_num then
                a:DeleteData()
            end
        end
    end
end

local function addArticulation(art_id)
    local artic_ids = {}
    for noteentry in eachentrysaved(finenv.Region()) do
        local artics = noteentry:CreateArticulations()
        for a in each(artics) do
            local defs = a:CreateArticulationDef()
            table.insert(artic_ids, defs:GetItemNo())
        end
    end

    local found_artic = 0

    for key, value in pairs(artic_ids) do
        if value == art_id then
            found_artic = 1
        end
    end

    if found_artic ~= 0 then
        deleteArticulation(art_id)
    else
        assignArticulation(art_id)
    end
end

local function findArticulation(table_placement, AboveSymbolChar)
    local articulationdefs = finale.FCArticulationDefs()
    articulationdefs:LoadAll()
    local first_id_table = {}
    for ad in each(articulationdefs) do
        if (ad:GetAboveSymbolChar() == AboveSymbolChar) then
            table.insert(first_id_table, ad.ItemNo)
        end
    end
    if first_id_table[1] ~= nil then
        full_art_table[table_placement] = first_id_table[1]
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

local function deleteHairpins()
    local ssmm = finale.FCSmartShapeMeasureMarks()
    ssmm:LoadAllForRegion(finenv.Region(), true) 
    for mark in each(ssmm) do
        local sm = mark:CreateSmartShape()
        if sm:IsHairpin() then
            sm:DeleteData()
        end
    end
end

local function deleteDynamics()
    local expressions = finale.FCExpressions()
    expressions:LoadAllForRegion(finenv.Region())
    for exp in each(expressions) do
        local ex_def = exp:CreateTextExpressionDef()
        local cat_num = finale.FCCategoryDef()
        cat_num:Load(1)
        if ex_def:GetCategoryID(cat_num) then
            exp:DeleteData()
        end
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
                if (exp:CreateTextString():GetCharacterAt(33) == glyph_nums[1])  or (exp:CreateTextString():GetCharacterAt(32) == glyph_nums[1]) then
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

local function func_0001()
    findExpression("^^fontMus", {235}, first_expression, "fortissississimo (velocity = 127)")
    getFirstNoteInRegion()
end

local function func_0002()    
    findExpression("^^fontMus", {236}, first_expression, "fortississimo (velocity = 114)")
    getFirstNoteInRegion()
end

local function func_0003()    
    findExpression("^^fontMus", {196}, first_expression, "fortissimo (velocity = 101)")
    getFirstNoteInRegion()
end

local function func_0004()
    findExpression("^^fontMus", {102}, first_expression, "forte (velocity = 88)")
    getFirstNoteInRegion()
end

local function func_0005()    
    findExpression("^^fontMus", {70}, first_expression, "mezzo forte (velocity = 75)")
    getFirstNoteInRegion()
end

local function func_0006()    
    findExpression("^^fontMus", {80}, first_expression, "mezzo piano (velocity = 62)")
    getFirstNoteInRegion()
end

local function func_0007()    
    findExpression("^^fontMus", {112}, first_expression, "piano (velocity = 49)")
    getFirstNoteInRegion()
end

local function func_0008()
    findExpression("^^fontMus", {185}, first_expression, "pianissimo (velocity = 36)")
    getFirstNoteInRegion()
end

local function func_0009()    
    findExpression("^^fontMus", {184}, first_expression, "pianississimo (velocity = 23)")
    getFirstNoteInRegion()
end

local function func_0010()    
    findExpression("^^fontMus", {175}, first_expression, "pianissississimo (velocity = 10)")
    getFirstNoteInRegion()
end

local function func_0011()
    findExpression("^^fontMus", {234}, first_expression, "forte piano")
    getFirstNoteInRegion()
end

local function func_0012()
    findExpression("^^fontMus", {90}, first_expression, "forzando")
    getFirstNoteInRegion()
end

local function func_0013()
    findExpression("^^fontMus", {150}, first_expression, "niente (velocity = 0)")
    getFirstNoteInRegion()
end

local function func_0014()
    findExpression("^^fontMus", {142, 102}, first_expression, "rinforte")
    getFirstNoteInRegion()
end

local function func_0015()
    findExpression("^^fontMus", {142, 90}, first_expression, "rinforzando")
    getFirstNoteInRegion()
end

local function func_0016()
    findExpression("^^fontMus", {83}, first_expression, "sforzando")
    getFirstNoteInRegion()
end

local function func_0017()
    findExpression("^^fontMus", {141}, first_expression, "sforzato")
    getFirstNoteInRegion()
end

local function func_0018()
    findExpression("^^fontMus", {130}, first_expression, "sforzato piano")
    getFirstNoteInRegion()
end

local function func_0019()
    findExpression("^^fontMus", {182}, first_expression, "sforzato pianissimo")
    getFirstNoteInRegion()
end

local function func_0020()
    findExpression("^^fontMus", {167}, first_expression, "sforzato")
    getFirstNoteInRegion()
end

local function func_0021()
    findExpression("^^fontMus", {167, 112}, first_expression, "sforzando piano")
    getFirstNoteInRegion()
end

local function func_0022()
    setHairpinRange(finale.SMARTSHAPE_CRESCENDO)
end

local function func_0023()
    setHairpinRange(finale.SMARTSHAPE_DIMINUENDO)
end

local function func_0024()
    setSwellRange(finale.SMARTSHAPE_CRESCENDO, finale.SMARTSHAPE_DIMINUENDO)
end

local function func_0025()
    setSwellRange(finale.SMARTSHAPE_DIMINUENDO, finale.SMARTSHAPE_CRESCENDO)
end

local function func_0026()
    deleteHairpins()
end

local function func_0027()
    deleteDynamics()
end

local function func_0100()
    findArticulation(1, 62)
    if full_art_table[1] == 0 then
        createArticulation(1, 62, "Maestro", 62, true, true, false, false, 1, false, 62, false, 0, 0, 125, true, false, false, 14, false, 0, -4, 0, -25, 62, "Maestro", false, false, true, 0, 0, 125, true, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[1])
    end
end

local function func_0101()
    findArticulation(2, 94)
    if full_art_table[2] == 0 then
        createArticulation(2, 94, "Maestro", 94, true, true, false, false, 5, false, 118, false, 0, 0, 140, true, false, false, 16, false, 0, -4, 0, -18, 118, "Maestro", false, false, true, 0, 0, 140, true, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[2])
    end
end

local function func_0102()
    findArticulation(3, 46)
    if full_art_table[3] == 0 then
        createArticulation(3, 46, "Maestro", 46, true, false, false, false, 1, true, 46, false, 0, 40, 0, true, false, false, 16, true, 0, -3, 0, -3, 46, "Maestro", true, false, true, 0, 40, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[3])
    end
end

local function func_0103()
    findArticulation(4, 45)
    if full_art_table[4] == 0 then
        createArticulation(4, 45, "Maestro", 45, true, false, false, false, 1, true, 45, false, 0, 0, 0, true, false, false, 14, false, 0, -3, 0, -3, 45, "Maestro", true, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 26, 26, false, false, false, false, 0, false, false, "Maestro", 26, 26, false, false)
    else
        addArticulation(full_art_table[4])
    end
end

local function func_0104()
    findArticulation(5, 171)
    if full_art_table[5] == 0 then
        createArticulation(5, 171, "Maestro", 171, true, true, false, false, 1, true, 216, false, 0, 30, 0, true, false, false, 12, true, 0, 12, 0, -22, 216, "Maestro", false, false, true, 0, 30, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[5])
    end
end

local function func_0105()
    findArticulation(6, 174)
    if full_art_table[6] == 0 then
        createArticulation(6, 174, "Maestro", 174, true, true, false, false, 1, true, 39, false, 0, 30, 0, true, false, false, 12, true, 0, 12, 0, -22, 216, "Maestro", false, false, true, 0, 30, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[6])
    end
end

local function func_0106()
    findArticulation(7, 33)
    if full_art_table[7] == 0 then
        createArticulation(7, 33, "Maestro", 33, true, false, false, false, 0, false, 33, false, 0, 0, 0, true, false, false, 21, false, 0, 0, 0, 0, 33, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[7])
    end
end

local function func_0107()
    findArticulation(8, 64)
    if full_art_table[8] == 0 then
        createArticulation(8, 64, "Maestro", 64, true, false, false, false, 0, false, 64, false, 0, 0, 0, true, false, false, 12, false, 0, 0, 0, 0, 64, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[8])
    end
end

local function func_0108()
    findArticulation(9, 190)
    if full_art_table[9] == 0 then
        createArticulation(9, 190, "Maestro", 190, true, false, false, false, 0, false, 190, false, 0, 0, 0, true, false, false, 11, false, 0, 0, 0, 0, 190, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[9])
    end
end

local function func_0109()
    findArticulation(10, 85)
    if full_art_table[10] == 0 then
        createArticulation(10, 85, "Maestro", 85, true, true, false, false, 5, false, 117, false, 0, 0, 0, true, false, false, 14, false, 0, 0, 0, 0, 117, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 22, 22, false, false, false, false, 0, false, false, "Maestro", 22, 22, false, false)
    else
        addArticulation(full_art_table[10])
    end
end

local function func_0110()
    findArticulation(11, 43)
    if full_art_table[11] == 0 then
        createArticulation(11, 43, "Maestro", 43, true, true, false, false, 5, true, 43, false, 0, 0, 0, true, false, false, 12, false, 0, 12, 0, -12, 43, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[11])
    end
end

local function func_0111()
    findArticulation(12, 111)
    if full_art_table[12] == 0 then
        createArticulation(12, 111, "Maestro", 111, true, true, false, false, 5, true, 111, false, 0, 0, 0, true, false, false, 14, false, 0, 8, 0, 0, 111, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[12])
    end
end

local function func_0112()
    findArticulation(13, 178)
    if full_art_table[13] == 0 then
        createArticulation(13, 178, "Maestro", 178, true, true, false, false, 5, false, 178, true, 0, 0, 0, true, false, false, 12, false, 0, 0, 0, 0, 178, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[13])
    end
end

local function func_0113()
    findArticulation(14, 179)
    if full_art_table[14] == 0 then
        createArticulation(14, 179, "Maestro", 179, true, true, false, false, 5, false, 179, true, 0, 0, 0, true, false, false, 12, false, 0, 0, 0, 0, 179, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[14])
    end
end

local function func_0114()
    findArticulation(15, 217)
    if full_art_table[15] == 0 then
        createArticulation(15, 217, "Maestro", 217, true, true, false, false, 5, true, 217, false, 0, 0, 0, true, false, false, 14, false, 3, 12, -3, -20, 217, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[15])
    end
end

local function func_0115()
    findArticulation(16, 109)
    if full_art_table[16] == 0 then
        createArticulation(16, 109, "Maestro", 109, true, true, false, false, 5, true, 109, false, 0, 0, 0, true, false, false, 12, false, 0, 0, 0, -28, 109, "Maestro", true, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[16])
    end
end

local function func_0116()
    findArticulation(17, 77)
    if full_art_table[17] == 0 then
        createArticulation(17, 77, "Maestro", 77, true, true, false, false, 5, true, 77, false, 0, 0, 0, true, false, false, 16, false, 0, 4, 0, -28, 77, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[17])
    end
end

local function func_0117()
    findArticulation(18, 84)
    if full_art_table[18] == 0 then
        createArticulation(18, 84, "Maestro", 84, true, true, false, false, 5, true, 84, false, 0, 0, 0, true, false, false, 12, false, 0, 18, 0, -18, 84, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[18])
    end
end

local function func_0118()
    findArticulation(19, 155)
    if full_art_table[19] == 0 then
        createArticulation(19, 155, "Broadway Copyist", 155, true, false, false, false, 2, false, 155, false, 0, 0, 0, true, false, false, 0, false, 42, 20, 42, 44, 155, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 24, 24, false, false, false, false, 0, false, false, "Broadway Copyist", 24, 24, false, false)
    else
        addArticulation(full_art_table[19])
    end
end

local function func_0119()
    findArticulation(20, 152)
    if full_art_table[20] == 0 then
        createArticulation(20, 152, "Broadway Copyist", 152, true, false, false, false, 2, false, 152, false, 0, 0, 0, true, false, false, 0, false, 39, -20, 40, 10, 152, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 24, 24, false, false, false, false, 0, false, false, "Broadway Copyist", 24, 24, false, false)
    else
        addArticulation(full_art_table[20])
    end
end

local function func_0120()
    findArticulation(21, 147)
    if full_art_table[21] == 0 then
        createArticulation(21, 147, "Broadway Copyist", 147, true, false, false, false, 2, false, 147, false, 0, 0, 0, true, false, false, 0, false, -66, -36, -66, -12, 147, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 24, 24, false, false, false, false, 0, false, false, "Broadway Copyist", 24, 24, false, false)
    else
        addArticulation(full_art_table[21])
    end
end

local function func_0121()
    findArticulation(22, 146)
    if full_art_table[22] == 0 then
        createArticulation(22, 146, "Broadway Copyist", 146, true, false, false, false, 2, false, 146, false, 0, 0, 0, true, false, false, 0, false, 66, -34, 66, -6, 146, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 24, 24, false, false, false, false, 0, false, false, "Broadway Copyist", 24, 24, false, false)
    else
        addArticulation(full_art_table[22])
    end
end

local function func_0122()
    local articulationdefs = finale.FCArticulationDefs()
    articulationdefs:LoadAll()
    local art_table = {0, 0, 0, 0}

    for k, v in pairs({46, 62, 45, 94}) do
        local first_id_table = {}
        for ad in each(articulationdefs) do
            if (ad:GetAboveSymbolChar() == v) and (ad:GetFlippedSymbolChar() > 0) then
                table.insert(first_id_table, ad.ItemNo)
            end
        end
        if first_id_table[1] ~= nil then
            art_table[k] = first_id_table[1]
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

local function func_0123()
    for noteentry in eachentrysaved(finenv.Region()) do
        local a = finale.FCArticulation()
        a:SetNoteEntry(noteentry)
        while a:LoadFirst() do
            a:DeleteData()
        end
    end
end

local function func_0300()
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

local function func_9000()
    for entry in eachentrysaved(finenv.Region()) do
        if (entry.Count ~= 2) then goto continue end
        local highestnote = entry:CalcHighestNote(nil)
        local lowestnote = entry:CalcLowestNote(nil)
        local mididiff = highestnote:CalcMIDIKey() - lowestnote:CalcMIDIKey()
        if ((mididiff ~= 12 and mididiff > 7) or 3 > mididiff or mididiff == 6)then goto continue end
        local notehead = finale.FCNoteheadMod()
        notehead:EraseAt(lowestnote)
        notehead:EraseAt(highestnote)
        notehead.CustomChar = 79
        notehead.Resize = 110
        notehead:SaveAt(highestnote)
        ::continue::
     end
end

dialog:SetTypes("String")
dialog:SetDescriptions("Function Number")

local returnvalues = dialog:Execute() 

if returnvalues ~= nil then
    if returnvalues[1] == "0001" then
        func_0001()
    end
    if returnvalues[1] == "0002" then
        func_0002()
    end
    if returnvalues[1] == "0003" then
        func_0003()
    end
    if returnvalues[1] == "0004" then
        func_0004()
    end
    if returnvalues[1] == "0005" then
        func_0005()
    end
    if returnvalues[1] == "0006" then
        func_0006()
    end
    if returnvalues[1] == "0007" then
        func_0007()
    end
    if returnvalues[1] == "0008" then
        func_0008()
    end
    if returnvalues[1] == "0009" then
        func_0009()
    end
    if returnvalues[1] == "0010" then
        func_0010()
    end
    if returnvalues[1] == "0011" then
        func_0011()
    end
    if returnvalues[1] == "0012" then
        func_0012()
    end
    if returnvalues[1] == "0013" then
        func_0013()
    end
    if returnvalues[1] == "0014" then
        func_0014()
    end
    if returnvalues[1] == "0015" then
        func_0015()
    end
    if returnvalues[1] == "0016" then
        func_0016()
    end
    if returnvalues[1] == "0017" then
        func_0017()
    end
    if returnvalues[1] == "0018" then
        func_0018()
    end
    if returnvalues[1] == "0019" then
        func_0019()
    end
    if returnvalues[1] == "0020" then
        func_0020()
    end
    if returnvalues[1] == "0021" then
        func_0021()
    end
    if returnvalues[1] == "0022" then
        func_0022()
    end
    if returnvalues[1] == "0023" then
        func_0023()
    end
    if returnvalues[1] == "0024" then
        func_0024()
    end
    if returnvalues[1] == "0025" then
        func_0025()
    end
    if returnvalues[1] == "0026" then
        func_0026()
    end
    if returnvalues[1] == "0027" then
        func_0027()
    end
    if returnvalues[1] == "0100" then
        func_0100()
    end
    if returnvalues[1] == "0101" then
        func_0101()
    end
    if returnvalues[1] == "0102" then
        func_0102()
    end
    if returnvalues[1] == "0103" then
        func_0103()
    end
    if returnvalues[1] == "0104" then
        func_0104()
    end
    if returnvalues[1] == "0105" then
        func_0105()
    end
    if returnvalues[1] == "0106" then
        func_0106()
    end
    if returnvalues[1] == "0107" then
        func_0107()
    end
    if returnvalues[1] == "0108" then
        func_0108()
    end
    if returnvalues[1] == "0109" then
        func_0109()
    end
    if returnvalues[1] == "0110" then
        func_0110()
    end
    if returnvalues[1] == "0111" then
        func_0111()
    end
    if returnvalues[1] == "0112" then
        func_0112()
    end
    if returnvalues[1] == "0113" then
        func_0113()
    end
    if returnvalues[1] == "0114" then
        func_0114()
    end
    if returnvalues[1] == "0115" then
        func_0115()
    end
    if returnvalues[1] == "0116" then
        func_0116()
    end
    if returnvalues[1] == "0117" then
        func_0117()
    end
    if returnvalues[1] == "0118" then
        func_0118()
    end
    if returnvalues[1] == "0119" then
        func_0119()
    end
    if returnvalues[1] == "0120" then
        func_0120()
    end
    if returnvalues[1] == "0121" then
        func_0121()
    end
    if returnvalues[1] == "0122" then
        func_0122()
    end
    if returnvalues[1] == "0123" then
        func_0123()
    end
    if returnvalues[1] == "0300" then
        func_0300()
    end
    if returnvalues[1] == "9000" then
        func_9000()
    end
end