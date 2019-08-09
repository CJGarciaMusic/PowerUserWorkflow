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

local full_art_table = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

local function assignArticulation(art_id)
    for noteentry in eachentrysaved(finenv.Region()) do
        local a = finale.FCArticulation()
        a:SetNoteEntry(noteentry)
        local ad = finale.FCArticulationDef()
        if (art_id == full_art_table[20]) or (art_id == full_art_table[21]) or (art_id == full_art_table[25]) then
            if (noteentry:IsNote()) and (noteentry:IsTied() == false) then
                a:SetID(art_id)
                a:SaveNew()  
            end
        else      
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
    -- ad:SetBelowSymbolChar(BelowSymbolChar)
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
    smartshape.LineID = shape

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
    local start_meas = music_region:GetStartMeasure()
    local end_meas = music_region:GetEndMeasure()
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        music_region:SetStartStaff(addstaff)
        music_region:SetEndStaff(addstaff)
        
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
        createHairpin(addstaff, start_meas, end_meas, start_pos, end_pos, smart_shape, 0)
    end
end

local function deleteHairpins()
    local ssmm = finale.FCSmartShapeMeasureMarks()
    ssmm:LoadAllForRegion(finenv.Region(), true)
    for mark in each(ssmm) do
        local sm = mark:CreateSmartShape()
        if sm ~= nil then
            if sm:IsHairpin() then
                sm:DeleteData()
            end
        end
    end
end

local function adjustHairpins(addstaff, start_meas, end_meas, start_pos, end_pos)
    local music_reg = finenv.Region()
    music_reg:SetStartStaff(addstaff)
    music_reg:SetEndStaff(addstaff)
    music_reg:SetStartMeasure(start_meas)
    music_reg:SetStartMeasurePos(start_pos)
    music_reg:SetEndMeasure(end_meas)
    music_reg:SetEndMeasurePos(end_pos)
    local ssmm = finale.FCSmartShapeMeasureMarks()
    ssmm:LoadAllForRegion(music_reg, true)
    for mark in each(ssmm) do
        local smartshape = mark:CreateSmartShape()
        if smartshape:IsHairpin() then
            local has_left_dyn = 0
            local left_x_value = 0
            music_reg:SetStartMeasure(start_meas)
            music_reg:SetEndMeasure(start_meas)
            music_reg:SetStartMeasurePos(start_pos)
            music_reg:SetEndMeasurePos(start_pos)

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
                    end
                end
            end

            local leftseg = smartshape:GetTerminateSegmentLeft()
            leftseg:SetMeasure(start_meas)
            leftseg.Staff = addstaff
            leftseg:SetCustomOffset(false)
            leftseg:SetEndpointOffsetX(left_x_value)
            leftseg:SetMeasurePos(music_reg:GetStartMeasurePos())

            local has_right_dyn = 0
            music_reg:SetStartMeasure(end_meas)
            music_reg:SetEndMeasure(end_meas)
            music_reg:SetStartMeasurePos(end_pos)
            music_reg:SetEndMeasurePos(end_pos)

            local right_expressions = finale.FCExpressions()
            right_expressions:LoadAllForRegion(music_reg)
            
            for re in each(right_expressions) do
                local create_def = re:CreateTextExpressionDef()
                local cd = finale.FCCategoryDef()
                if cd:Load(create_def:GetCategoryID()) then
                    if string.find(cd:CreateName().LuaString, "Dynamic") then
                        has_right_dyn = 1
                        local text_met = finale.FCTextMetrics()
                        text_met:LoadString(create_def:CreateTextString(), create_def:CreateTextString():CreateLastFontInfo(), 100)
                        right_x_value = (0 - (text_met:CalcWidthEVPUs() - 1000) / 2) + (re:GetHorizontalPos())
                    end
                end
            end

            local rightseg = smartshape:GetTerminateSegmentRight()
            rightseg:SetMeasure(end_meas)
            rightseg.Staff = addstaff
            rightseg:SetCustomOffset(false)
            if right_x_value == 0 then
                rightseg:SetEndpointOffsetX(0)
            else
                rightseg:SetEndpointOffsetX(right_x_value)
            end
            rightseg:SetMeasurePos(music_reg:GetEndMeasurePos())
            smartshape:Save()
        end
    end
end

local function setAdjustHairpinRange()
    local music_region = finenv.Region()
    local range_settings = {}
    
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        music_region:SetStartStaff(addstaff)
        music_region:SetEndStaff(addstaff)

        local measure_pos_table = {}
        local measure_table = {}
        
        local count = 0
        
        for noteentry in eachentrysaved(music_region) do
            if noteentry:IsNote() then
                table.insert(measure_pos_table, noteentry:GetMeasurePos())
                table.insert(measure_table, noteentry:GetMeasure())
                count = count + 1
            end
        end

        local start_pos = measure_pos_table[1]
        local end_pos = measure_pos_table[count]
        local start_measure = measure_table[1]
        local end_measure = measure_table[count]

        if count == 1 then
            end_pos = music_region:GetEndMeasurePos() 
        end
    
        range_settings[addstaff] = {addstaff, start_measure, end_measure, start_pos, end_pos}
    end

    for key, value in pairs(range_settings) do
        adjustHairpins(value[1], value[2], value[3], value[4], value[5])
    end
end

local function createEntryBasedSL(staff, measure_start, measure_end, leftnote, rightnote, shape)
    local smartshape = finale.FCSmartShape()
    smartshape.ShapeType = shape
    smartshape:SetEntryAttachedFlags(true)
    if smartshape:IsAutoSlur() then
        smartshape:SetSlurFlags(true)
    end
    smartshape.EntryBased = true
    smartshape.PresetShape = true
    smartshape.Visible = true
    -- smartshape.LineID = shape

    local leftseg = smartshape:GetTerminateSegmentLeft()
    leftseg:SetMeasure(measure_start)
    leftseg:SetStaff(staff)
    leftseg:SetEntry(leftnote)

    local rightseg = smartshape:GetTerminateSegmentRight()
    rightseg:SetMeasure(measure_end)
    rightseg:SetStaff(staff)
    rightseg:SetEntry(rightnote)
    if (shape == 26) or (shape == 25) then
        leftseg.NoteID = 1
        rightseg.NoteID = 1
    end
    smartshape:SaveNewEverything(leftnote, rightnote)
end

local function setFirstLastNoteRangeEntry(smart_shape)
    local music_region = finenv.Region()
    local range_settings = {}
    
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        music_region:SetStartStaff(addstaff)
        music_region:SetEndStaff(addstaff)

        local measure_pos_table = {}
        local measure_table = {}
        
        local count = 0
        
        for noteentry in eachentrysaved(music_region) do
            if noteentry:IsNote() then
                table.insert(measure_pos_table, noteentry)
                table.insert(measure_table, noteentry:GetMeasure())
                count = count + 1
            end
        end

        local start_pos = measure_pos_table[1]
        local end_pos = measure_pos_table[count]
        local start_measure = measure_table[1]
        local end_measure = measure_table[count]

        if count == 1 then
            end_pos = music_region:GetEndMeasurePos() 
        end
    
        range_settings[addstaff] = {addstaff, start_measure, end_measure, start_pos, end_pos}
    end

    for key, value in pairs(range_settings) do
        createEntryBasedSL(value[1], value[2], value[3], value[4], value[5], smart_shape)
    end
end


local function setFirstLastNoteRangeBeat(smart_shape)
    local music_region = finenv.Region()
    local range_settings = {}
    
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        music_region:SetStartStaff(addstaff)
        music_region:SetEndStaff(addstaff)

        local measure_pos_table = {}
        local measure_table = {}
        
        local count = 0
        
        for noteentry in eachentrysaved(music_region) do
            if noteentry:IsNote() then
                table.insert(measure_pos_table, noteentry:GetMeasurePos())
                table.insert(measure_table, noteentry:GetMeasure())
                count = count + 1
            end
        end

        local start_pos = measure_pos_table[1]
        local end_pos = measure_pos_table[count]
        local start_measure = measure_table[1]
        local end_measure = measure_table[count]

        if count == 1 then
            end_pos = music_region:GetEndMeasurePos() 
        end
    
        range_settings[addstaff] = {addstaff, start_measure, end_measure, start_pos, end_pos}
    end

    for key, value in pairs(range_settings) do
        createHairpin(value[1], value[2], value[3], value[4], value[5], smart_shape, 0)
    end
end

local function createBBSL(staff, measure_start, measure_end, leftpos, rightpos, shape)    
    local smartshape = finale.FCSmartShape()
    smartshape.ShapeType = shape
    smartshape.EntryBased = false
    smartshape.MakeHorizontal = true
    smartshape.BeatAttached= true
    smartshape.PresetShape = true
    smartshape.Visible = true
    smartshape.LineID = shape

    if rightpos ~= nil then
        if rightpos > 1000000 then
            local get_time = finale.FCMeasure()
            get_time:Load(measure_end)
            local new_right_end = get_time:GetTimeSignature()
            local beat = new_right_end:GetBeats()
            local duration = new_right_end:GetBeatDuration()
            rightpos = (beat * duration)
        end
    end

    local staff_pos = {}
    local count = 0
    local music_reg = finenv.Region()
    music_reg:SetStartStaff(staff)
    music_reg:SetEndStaff(staff)

    for noteentry in eachentrysaved(music_reg) do
        if noteentry:IsNote() then
            for note in each(noteentry) do
                table.insert(staff_pos, note:CalcStaffPosition())
                count = count + 1
            end
        end
    end

    local base_line_offset = 36
    local entry_offset  = 36

    table.sort(staff_pos)

    if staff_pos[count] == nil then
        y_value = base_line_offset 
    else
        if staff_pos[count] >= 0 then
            y_value = (staff_pos[count] * 12) + entry_offset
        else
            y_value = base_line_offset 
        end
    end

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
    rightseg:SetEndpointOffsetY(y_value)
    rightseg:SetMeasurePos(rightpos)
    smartshape:SaveNewEverything(nil, nil)
end

local function createBeatBasedSL(smart_shape)
    local music_region = finenv.Region()
    local range_settings = {}
    
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        music_region:SetStartStaff(addstaff)
        music_region:SetEndStaff(addstaff)

        local measure_pos_table = {}
        local measure_table = {}
        
        local count = 0
        
        for noteentry in eachentrysaved(music_region) do
            if noteentry:IsNote() then
                table.insert(measure_pos_table, noteentry:GetMeasurePos())
                table.insert(measure_table, noteentry:GetMeasure())
                count = count + 1
            end
        end

        local start_pos = measure_pos_table[1]
        if start_pos == nil then
            start_pos = music_region:GetStartMeasurePos()
        end

        local end_pos = measure_pos_table[count]
        if end_pos == nil then
            end_pos = music_region:GetEndMeasurePos()    
        end

        local start_measure = measure_table[1]
        if start_measure == nil then
            start_measure = music_region:GetStartMeasure()
        end

        local end_measure = measure_table[count]
        if end_measure == nil then
            end_measure = music_region:GetEndMeasure()
        end

        if count == 1 then
            end_pos = music_region:GetEndMeasurePos() 
        end
    
        range_settings[addstaff] = {addstaff, start_measure, end_measure, start_pos, end_pos}
    end

    for key, value in pairs(range_settings) do
        createBBSL(value[1], value[2], value[3], value[4], value[5], smart_shape)
    end
end

local function increaseDynamic()
    local dyn_table = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    local dyn_char = {175, 184, 185, 112, 80, 70, 102, 196, 236, 235}
    
    local tex_defs = finale.FCTextExpressionDefs()
    tex_defs:LoadAll()
    for tex in each(tex_defs) do
        for key, value in pairs(dyn_char) do
            if tex:CreateTextString():GetCharacterAt(33) == value then
                dyn_table[key] = tex:GetItemNo()
            end
        end
    end
    
    local expressions = finale.FCExpressions()
    expressions:LoadAllForRegion(finenv.Region())
    for exp in each(expressions) do
        local ex_def = exp:CreateTextExpressionDef()
        for key, value in pairs(dyn_char) do
            if key < 10 then
                if ex_def:CreateTextString():GetCharacterAt(33) == value then
                    exp:SetID(dyn_table[key + 1])
                    exp:Save()
                end
            end
        end
    end
    setAdjustHairpinRange()
end

local function decreaseDynamic()
    local dyn_table = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    local dyn_char = {175, 184, 185, 112, 80, 70, 102, 196, 236, 235}
    
    local tex_defs = finale.FCTextExpressionDefs()
    tex_defs:LoadAll()
    for tex in each(tex_defs) do
        for key, value in pairs(dyn_char) do
            if tex:CreateTextString():GetCharacterAt(33) == value then
                dyn_table[key] = tex:GetItemNo()
            end
        end
    end
    
    local expressions = finale.FCExpressions()
    expressions:LoadAllForRegion(finenv.Region())
    for exp in each(expressions) do
        local ex_def = exp:CreateTextExpressionDef()
        for key, value in pairs(dyn_char) do
            if key > 1 then
                if ex_def:CreateTextString():GetCharacterAt(33) == value then
                    exp:SetID(dyn_table[key - 1])
                    exp:Save()
                end
            end
        end
    end
    setAdjustHairpinRange()
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

local function deleteBeatSmartShape(shape_num)
    local music_region = finenv.Region()
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        music_region:SetStartStaff(addstaff)
        music_region:SetEndStaff(addstaff)
        local ssmm = finale.FCSmartShapeMeasureMarks()
        ssmm:LoadAllForRegion(music_region, true)
        for mark in each(ssmm) do
            local sm = mark:CreateSmartShape()
            if sm ~= nil then
                if sm.ShapeType == shape_num then
                    sm:DeleteData()
                end
            end
        end
    end
end

local function deleteEntrySmartShape(shape_num)
    local music_region = finenv.Region()
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        music_region:SetStartStaff(addstaff)
        music_region:SetEndStaff(addstaff)
        for noteentry in eachentrysaved(music_region) do
            local ssmms = finale.FCSmartShapeEntryMarks(noteentry)
            ssmms:LoadAll(music_region)
            for ssmm in each(ssmms) do
                local sm = ssmm:CreateSmartShape()
                if sm ~= nil then
                    if ssmm:CalcLeftMark() or (ssmm:CalcRightMark()) then
                        if sm.ShapeType == shape_num then
                            sm:DeleteData()
                        end
                    end
                end
            end
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

local function getFirstNoteInRegion(note_range)
    local music_region = finenv.Region()
    local range_settings = {}
    
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        music_region:SetStartStaff(addstaff)
        music_region:SetEndStaff(addstaff)

        local measure_pos_table = {}
        local measure_table = {}
        
        local count = 0
        
        for noteentry in eachentrysaved(music_region) do
            if noteentry:IsNote() then
                table.insert(measure_pos_table, noteentry:GetMeasurePos())
                table.insert(measure_table, noteentry:GetMeasure())
                count = count + 1
            end
        end

        local start_pos = measure_pos_table[1]
        local end_pos = measure_pos_table[count]
        local start_measure = measure_table[1]
        local end_measure = measure_table[count]

        if count == 1 then
            end_pos = music_region:GetEndMeasurePos() 
        end
    
        range_settings[addstaff] = {addstaff, start_measure, end_measure, start_pos, end_pos}
    end

    for key, value in pairs(range_settings) do
        if note_range == "Start" then
            addExpression(value[1], value[2], value[4])
        end
        if note_range == "End" then
            addExpression(value[1], value[3], value[5])
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

local function changeNoteheads(font_name, quarter_glyph, half_glyph, whole_glyph, breve_glyph)
    if font_name == "" then
        local fontinfo = finale.FCFontInfo()
        if fontinfo:LoadFontPrefs(23) then
            font_name = fontinfo:GetName()  
        end
    end

    local nm = finale.FCNoteheadMod()
    nm:SetUseCustomFont(true)
    nm.FontName = font_name

    for noteentry in eachentrysaved(finenv.Region()) do 
        nm:SetNoteEntry(noteentry)
        for note in each(noteentry) do
            if noteentry.Duration < 2048 then
                nm.CustomChar = quarter_glyph
            end
            if (noteentry.Duration >= 2048) and (noteentry.Duration < 4096) then
                nm.CustomChar = half_glyph
                if half_glyph == 124 then
                    nm:SetUseDefaultVerticalPos(false)
                    nm:SetVerticalPos(-24)
                end
            end
            if (noteentry.Duration >= 4096) and (noteentry.Duration < 8192) then
                nm.CustomChar = whole_glyph
                if half_glyph == 124 then
                    nm:SetUseDefaultVerticalPos(false)
                    nm:SetVerticalPos(-24)
                end
            end
            if (noteentry.Duration >= 8192) then
                nm.CustomChar = breve_glyph
            end
            nm:SaveAt(note)
        end
    end
end

local function barline_change(style, bookend)
    local measure = finale.FCMeasure()
    local music_region = finenv.Region()
    if bookend then
        measure:Load(music_region:GetStartMeasure() - 1)
        measure.Barline = style
        measure:Save()
    end
    measure:Load(music_region:GetEndMeasure())
    measure.Barline = style
    measure:Save()
end

local function add_rehearsal_marks(measure_num, reh_type)
    local teds = finale.FCTextExpressionDefs()
    teds:LoadAll()
    local rehearsal_letters = {}
    local rehearsal_numbers = {}
    local rehearsal_measures = {}
    for ted in each(teds) do
        if ted:GetCategoryID() == 6 then
            if (ted:IsAutoRehearsalMark()) and (string.find(ted:CreateDescription().LuaString, "Rehearsal Letters")) then
                table.insert(rehearsal_letters, ted.ItemNo)
            end
            if (ted:IsAutoRehearsalMark()) and (string.find(ted:CreateDescription().LuaString, "Rehearsal Numbers")) then
                table.insert(rehearsal_numbers, ted.ItemNo)
            end
            if (ted:IsAutoRehearsalMark()) and (string.find(ted:CreateDescription().LuaString, "Measure Number")) then
                table.insert(rehearsal_measures, ted.ItemNo)
            end
        end
    end

    local function add_exp(exp_id)
        add_expression=finale.FCExpression()
        add_expression:SetStaff(1)
        add_expression:SetVisible(true)
        add_expression:SetMeasurePos(0)
        add_expression:SetScaleWithEntry(false)
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(true)
        add_expression:SetID(exp_id)
        local and_cell = finale.FCCell(measure_num, 1)
        add_expression:SaveNewToCell(and_cell)
    end
    if reh_type == "Letter" then
        if rehearsal_letters[1] == nil then
            finenv.UI():AlertInfo("There doesn't appear to be any Auto-Rehearsal Marks using Letters in the Rehearsal Marks Category. Please create one and try again.", NULL)
        else
            add_exp(rehearsal_letters[1])
        end
    end
    if reh_type == "Number" then
        if rehearsal_numbers[1] == nil then
            finenv.UI():AlertInfo("There doesn't appear to be any Auto-Rehearsal Marks using Numbers in the Rehearsal Marks Category. Please create one and try again.", NULL)
        else
            add_exp(rehearsal_numbers[1])
        end
    end
    if reh_type == "Measure" then
        if rehearsal_measures[1] == nil then
            finenv.UI():AlertInfo("There doesn't appear to be any Auto-Rehearsal Marks using Measure Numbers in the Rehearsal Marks Category. Please create one and try again.", NULL)
        else
            add_exp(rehearsal_measures[1])
        end
    end  
end

local function delete_rehearsal_marks()
    local expressions = finale.FCExpressions()
    local music_reg = finenv.Region():GetEndMeasure()
    expressions:LoadAllForItem(music_reg + 1)
    for e in each(expressions) do
        local ex_def = finale.FCTextExpressionDef()
        ex_def:Load(e.ID)
        if ex_def:GetCategoryID() == 6 then
            e:DeleteData()
        end
    end
end

local function find_double_barlines(rehearsal_mark_type)
    delete_rehearsal_marks()
    local measures = finale.FCMeasures()
    measures:LoadRegion(finenv.Region())
    for m in each(measures) do
        if m.Barline == 2 then
            add_rehearsal_marks(m.ItemNo + 1, rehearsal_mark_type)
        end
    end
end

local function alter_bass(placement)
    local chords = finale.FCChords()
    chords:LoadAllForRegion(finenv.Region())
    for c in each(chords) do
       c.ChordAlternateBassPlacement = placement
        c:Save()
    end
end

local function set_time(beat_num, beat_duration)
    local measures = finale.FCMeasures()
    measures:LoadRegion(finenv.Region())
    for m in each(measures) do
        local time_sig = m:GetTimeSignature()
        time_sig:SetBeats(beat_num)
        time_sig:SetBeatDuration(beat_duration)
        time_sig:Save()
        m:Save()
    end
end

local function applyStaffStyle(StaffStyleType)
    local ssds = finale.FCStaffStyleDefs()
    ssds:LoadAll()
    style_table = {}
    for ssd in each(ssds) do    
        if StaffStyleType == "Slash Notation" then
            if ssd:GetAltNotationStyle() == 1 then
                table.insert(style_table, ssd:GetItemNo())
            end
        end
        if StaffStyleType == "Rythmic Notation" then
            if ssd:GetAltNotationStyle() == 2 then
                table.insert(style_table, ssd:GetItemNo())
            end
        end
        if StaffStyleType == "Blank Notation: Layer 1" then
            if (ssd:GetAltNotationStyle() == 6) and (ssd:GetAltNotationLayer() == 1) then
                table.insert(style_table, ssd:GetItemNo())
            end
        end
        if StaffStyleType == "Blank Notation with Rests: Layer 1" then
            if (ssd:GetAltNotationStyle() == 5) and (ssd:GetAltNotationLayer() == 1) then
                table.insert(style_table, ssd:GetItemNo())
            end
        end
        if StaffStyleType == "Blank Notation: Layer 4" then
            if (ssd:GetAltNotationStyle() == 6) and (ssd:GetAltNotationLayer() == 4) then
                table.insert(style_table, ssd:GetItemNo())
            end
        end
        if StaffStyleType == "Blank Notation with Rests: Layer 4" then
            if (ssd:GetAltNotationStyle() == 5) and (ssd:GetAltNotationLayer() == 4) then
                table.insert(style_table, ssd:GetItemNo())
            end
        end
        if StaffStyleType == "Blank Notation: All Layers" then
            if (ssd:GetAltNotationStyle() == 6) and (ssd:GetShowChords() == false) then
                table.insert(style_table, ssd:GetItemNo())
            end
        end
        if StaffStyleType == "One Bar Repeat" then
            if (ssd:GetAltNotationStyle() == 3) then
                table.insert(style_table, ssd:GetItemNo())
            end
        end
        if StaffStyleType == "Two Bar Repeat" then
            if (ssd:GetAltNotationStyle() == 4) then
                table.insert(style_table, ssd:GetItemNo())
            end
        end
        if StaffStyleType == "Stemless Notes" then
            if (ssd:GetShowStems() == false) then
                table.insert(style_table, ssd:GetItemNo())
            end
        end
        if StaffStyleType == "Cutaway" then
            if (ssd:GetUseHideMode() == true) and (ssd:GetHideMode() == 3)then
                table.insert(style_table, ssd:GetItemNo())
            end
        end
        if StaffStyleType == "Collapse" then
            if (ssd:GetUseHideMode() == true) and (ssd:GetHideMode() == 2)then
                table.insert(style_table, ssd:GetItemNo())
            end
        end
    end

    local staff_style_ID = style_table[1]

    if staff_style_ID == nil then
        finenv.UI():AlertInfo("That kind of staff style couldn't be found...\n\nPlease try creating it or uploading the default staff style library and try again.", nil)
        return
    else
        local music_region = finenv.Region()
        for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
            local start_meas = music_region:GetStartMeasure()
            local end_meas = music_region:GetEndMeasure()
            local start_pos = music_region:GetStartMeasurePos()
            local end_pos = music_region:GetEndMeasurePos()
            music_region:SetStartStaff(addstaff)
            music_region:SetEndStaff(addstaff)
            local staff_style = finale.FCStaffStyleAssign()
            staff_style:SetStartMeasure(start_meas)
            staff_style:SetEndMeasure(end_meas)
            staff_style:SetStartMeasurePos(start_pos)
            staff_style:SetEndMeasurePos(end_pos)
            staff_style:SetStyleID(staff_style_ID)
            staff_style:SaveNew(addstaff)
        end
    end
end

local function func_0001()
    findExpression("^^fontMus", {235}, first_expression, "fortissississimo (velocity = 127)")
    getFirstNoteInRegion("Start")
end

local function func_0002()    
    findExpression("^^fontMus", {236}, first_expression, "fortississimo (velocity = 114)")
    getFirstNoteInRegion("Start")
end

local function func_0003()    
    findExpression("^^fontMus", {196}, first_expression, "fortissimo (velocity = 101)")
    getFirstNoteInRegion("Start")
end

local function func_0004()
    findExpression("^^fontMus", {102}, first_expression, "forte (velocity = 88)")
    getFirstNoteInRegion("Start")
end

local function func_0005()    
    findExpression("^^fontMus", {70}, first_expression, "mezzo forte (velocity = 75)")
    getFirstNoteInRegion("Start")
end

local function func_0006()    
    findExpression("^^fontMus", {80}, first_expression, "mezzo piano (velocity = 62)")
    getFirstNoteInRegion("Start")
end

local function func_0007()    
    findExpression("^^fontMus", {112}, first_expression, "piano (velocity = 49)")
    getFirstNoteInRegion("Start")
end

local function func_0008()
    findExpression("^^fontMus", {185}, first_expression, "pianissimo (velocity = 36)")
    getFirstNoteInRegion("Start")
end

local function func_0009()    
    findExpression("^^fontMus", {184}, first_expression, "pianississimo (velocity = 23)")
    getFirstNoteInRegion("Start")
end

local function func_0010()    
    findExpression("^^fontMus", {175}, first_expression, "pianissississimo (velocity = 10)")
    getFirstNoteInRegion("Start")
end

local function func_0011()
    findExpression("^^fontMus", {234}, first_expression, "forte piano")
    getFirstNoteInRegion("Start")
end

local function func_0012()
    findExpression("^^fontMus", {90}, first_expression, "forzando")
    getFirstNoteInRegion("Start")
end

local function func_0013()
    findExpression("^^fontMus", {150}, first_expression, "niente (velocity = 0)")
    getFirstNoteInRegion("Start")
end

local function func_0014()
    findExpression("^^fontMus", {142, 102}, first_expression, "rinforte")
    getFirstNoteInRegion("Start")
end

local function func_0015()
    findExpression("^^fontMus", {142, 90}, first_expression, "rinforzando")
    getFirstNoteInRegion("Start")
end

local function func_0016()
    findExpression("^^fontMus", {83}, first_expression, "sforzando")
    getFirstNoteInRegion("Start")
end

local function func_0017()
    findExpression("^^fontMus", {141}, first_expression, "sforzato")
    getFirstNoteInRegion("Start")
end

local function func_0018()
    findExpression("^^fontMus", {130}, first_expression, "sforzato piano")
    getFirstNoteInRegion("Start")
end

local function func_0019()
    findExpression("^^fontMus", {182}, first_expression, "sforzato pianissimo")
    getFirstNoteInRegion("Start")
end

local function func_0020()
    findExpression("^^fontMus", {167}, first_expression, "sforzato")
    getFirstNoteInRegion("Start")
end

local function func_0021()
    findExpression("^^fontMus", {167, 112}, first_expression, "sforzando piano")
    getFirstNoteInRegion("Start")
end

local function func_0022()
    deleteHairpins()
    setFirstLastNoteRangeBeat(finale.SMARTSHAPE_CRESCENDO)
end

local function func_0023()
    deleteHairpins()
    setFirstLastNoteRangeBeat(finale.SMARTSHAPE_DIMINUENDO)
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

local function func_0028()
    findExpression("^^fontMus", {235}, first_expression, "fortissississimo (velocity = 127)")
    getFirstNoteInRegion("End")
end

local function func_0029()    
    findExpression("^^fontMus", {236}, first_expression, "fortississimo (velocity = 114)")
    getFirstNoteInRegion("End")
end

local function func_0030()    
    findExpression("^^fontMus", {196}, first_expression, "fortissimo (velocity = 101)")
    getFirstNoteInRegion("End")
end

local function func_0031()
    findExpression("^^fontMus", {102}, first_expression, "forte (velocity = 88)")
    getFirstNoteInRegion("End")
end

local function func_0032()    
    findExpression("^^fontMus", {70}, first_expression, "mezzo forte (velocity = 75)")
    getFirstNoteInRegion("End")
end

local function func_0033()    
    findExpression("^^fontMus", {80}, first_expression, "mezzo piano (velocity = 62)")
    getFirstNoteInRegion("End")
end

local function func_0034()    
    findExpression("^^fontMus", {112}, first_expression, "piano (velocity = 49)")
    getFirstNoteInRegion("End")
end

local function func_0035()
    findExpression("^^fontMus", {185}, first_expression, "pianissimo (velocity = 36)")
    getFirstNoteInRegion("End")
end

local function func_0036()    
    findExpression("^^fontMus", {184}, first_expression, "pianississimo (velocity = 23)")
    getFirstNoteInRegion("End")
end

local function func_0037()    
    findExpression("^^fontMus", {175}, first_expression, "pianissississimo (velocity = 10)")
    getFirstNoteInRegion("End")
end

local function func_0038()
    findExpression("^^fontMus", {234}, first_expression, "forte piano")
    getFirstNoteInRegion("End")
end

local function func_0039()
    findExpression("^^fontMus", {90}, first_expression, "forzando")
    getFirstNoteInRegion("End")
end

local function func_0040()
    findExpression("^^fontMus", {150}, first_expression, "niente (velocity = 0)")
    getFirstNoteInRegion("End")
end

local function func_0041()
    findExpression("^^fontMus", {142, 102}, first_expression, "rinforte")
    getFirstNoteInRegion("End")
end

local function func_0042()
    findExpression("^^fontMus", {142, 90}, first_expression, "rinforzando")
    getFirstNoteInRegion("End")
end

local function func_0043()
    findExpression("^^fontMus", {83}, first_expression, "sforzando")
    getFirstNoteInRegion("End")
end

local function func_0044()
    findExpression("^^fontMus", {141}, first_expression, "sforzato")
    getFirstNoteInRegion("End")
end

local function func_0045()
    findExpression("^^fontMus", {130}, first_expression, "sforzato piano")
    getFirstNoteInRegion("End")
end

local function func_0046()
    findExpression("^^fontMus", {182}, first_expression, "sforzato pianissimo")
    getFirstNoteInRegion("End")
end

local function func_0047()
    findExpression("^^fontMus", {167}, first_expression, "sforzato")
    getFirstNoteInRegion("End")
end

local function func_0048()
    findExpression("^^fontMus", {167, 112}, first_expression, "sforzando piano")
    getFirstNoteInRegion("End")
end

local function func_0049()
    increaseDynamic()
end

local function func_0050()
    decreaseDynamic()
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
        createArticulation(6, 174, "Maestro", 174, true, true, false, false, 1, true, 39, false, 0, 30, 0, true, false, false, 12, true, 0, 12, 0, -22, 39, "Maestro", false, false, true, 0, 30, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[6])
    end
end

local function func_0106()
    findArticulation(7, 33)
    if full_art_table[7] == 0 then
        createArticulation(7, 33, "Maestro", 33, true, false, false, false, 0, false, 33, false, 0, 0, 0, true, false, false, 21, false, 0, 0, 0, 0, 33, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        findArticulation(8, 64)
        deleteArticulation(full_art_table[8])
        findArticulation(9, 190)
        deleteArticulation(full_art_table[9])
        addArticulation(full_art_table[7])
    end
end

local function func_0107()
    findArticulation(8, 64)
    if full_art_table[8] == 0 then
        createArticulation(8, 64, "Maestro", 64, true, false, false, false, 0, false, 64, false, 0, 0, 0, true, false, false, 12, false, 0, 0, 0, 0, 64, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        findArticulation(7, 33)
        deleteArticulation(full_art_table[7])
        findArticulation(9, 190)
        deleteArticulation(full_art_table[9])
        addArticulation(full_art_table[8])
    end
end

local function func_0108()
    findArticulation(9, 190)
    if full_art_table[9] == 0 then
        createArticulation(9, 190, "Maestro", 190, true, false, false, false, 0, false, 190, false, 0, 0, 0, true, false, false, 11, false, 0, 0, 0, 0, 190, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        findArticulation(7, 33)
        deleteArticulation(full_art_table[7])
        findArticulation(8, 64)
        deleteArticulation(full_art_table[8])
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
    findArticulation(19, 103)
    if full_art_table[19] == 0 then
        createArticulation(19, 103, "Maestro", 103, true, false, false, false, 0, false, 103, true, -256, 0, 0, false, true, false, 0, false, -28, -28, -22, 0, 103, "Maestro", false, false, true, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[19])
    end
end

local function func_0119()
    findArticulation(20, 152)
    if full_art_table[20] == 0 then
        createArticulation(20, 152, "Broadway Copyist", 152, true, false, false, false, 2, false, 152, false, 0, 0, 0, true, false, false, 0, false, 36, -30, 36, 0, 152, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 20, 20, false, false, false, false, 0, false, false, "Broadway Copyist", 20, 20, false, false)
    else
        addArticulation(full_art_table[20])
    end
end

local function func_0120()
    findArticulation(21, 92)
    if full_art_table[21] == 0 then
        createArticulation(21, 92, "Broadway Copyist", 92, true, false, false, false, 2, false, 92, false, 0, 0, 0, true, false, false, 0, false, 54, -54, 54, -30, 92, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 24, 24, false, false, false, false, 0, false, false, "Broadway Copyist", 24, 24, false, false)
    else
        addArticulation(full_art_table[21])
    end
end

local function func_0121()
    findArticulation(22, 151)
    if full_art_table[22] == 0 then
        createArticulation(22, 151, "Broadway Copyist", 151, true, false, false, false, 2, false, 151, false, 0, 0, 0, true, false, false, 0, false, -48, -36, -48, -6, 151, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 18, 18, false, false, false, false, 0, false, false, "Broadway Copyist", 18, 18, false, false)
    else
        addArticulation(full_art_table[22])
    end
end

local function func_0122()
    findArticulation(23, 149)
    if full_art_table[23] == 0 then
        createArticulation(23, 149, "Broadway Copyist", 149, true, false, false, false, 2, false, 149, false, 0, 0, 0, true, false, false, 0, false, -54, -36, -54, -12, 149, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 18, 18, false, false, false, false, 0, false, false, "Broadway Copyist", 18, 18, false, false)
    else
        addArticulation(full_art_table[23])
    end
end

local function func_0123()
    findArticulation(24, 155)
    if full_art_table[24] == 0 then
        createArticulation(24, 155, "Broadway Copyist", 155, true, false, false, false, 2, false, 155, false, 0, 0, 0, true, false, false, 0, false, -36, -24, -36, 0, 155, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 18, 18, false, false, false, false, 0, false, false, "Broadway Copyist", 18, 18, false, false)
    else
        addArticulation(full_art_table[24])
    end
end

local function func_0124()
    findArticulation(25, 243)
    if full_art_table[25] == 0 then
        createArticulation(25, 243, "Broadway Copyist", 243, true, false, false, false, 2, false, 243, false, 0, 0, 0, true, false, false, 0, false, 42, 6, 42, 30, 243, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 20, 20, false, false, false, false, 0, false, false, "Broadway Copyist", 20, 20, false, false)
    else
        addArticulation(full_art_table[25])
    end
end

local function func_0125()
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

local function func_0126()
    for noteentry in eachentrysaved(finenv.Region()) do
        local a = finale.FCArticulation()
        a:SetNoteEntry(noteentry)
        while a:LoadFirst() do
            a:DeleteData()
        end
    end
end

local function func_0200()
    changeNoteheads("Maestro Percussion", 120, 88, 88, 88)
end

local function func_0201()
    changeNoteheads("Maestro Percussion", 122, 90, 90, 90)
end

local function func_0202()
    changeNoteheads("Maestro Percussion", 49, 33, 33, 33)
end

local function func_0203()
    changeNoteheads("Maestro Percussion", 45, 95, 95, 95)
end

local function func_0204()
    changeNoteheads("Maestro Percussion", 51, 35, 35, 35)
end

local function func_0205()
    changeNoteheads("Maestro Percussion", 101, 69, 69, 69)
end

local function func_0206()
    changeNoteheads("Maestro Percussion", 102, 70, 70, 70)
end

local function func_0207()
    changeNoteheads("Maestro", 243, 124, 124, 218)
end

local function func_0208()
    changeNoteheads("Maestro Percussion", 54, 94, 94, 94)
end

local function func_0209()
    changeNoteheads("Maestro Percussion", 104, 72, 72, 72)
end

local function func_0210()
    changeNoteheads("Maestro", 32, 32, 32, 32)
end

local function func_0211()
    local nm = finale.FCNoteheadMod()
    nm:SetUseCustomFont(false)
    
    for noteentry in eachentrysaved(finenv.Region()) do 
        nm:SetNoteEntry(noteentry)
        for note in each(noteentry) do
            nm:ClearChar()
            nm:SaveAt(note)
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

local function func_0400()
    barline_change(0, false)
end

local function func_0401()
    barline_change(1, false)
end

local function func_0402()
    barline_change(2, false)
end

local function func_0403()
    barline_change(3, false)
end

local function func_0404()
    barline_change(4, false)
end

local function func_0405()
    barline_change(5, false)
end

local function func_0406()
    barline_change(6, false)
end

local function func_0407()
    barline_change(7, false)
end

local function func_0408()
    barline_change(0, true)
end

local function func_0409()
    barline_change(1, true)
end

local function func_0410()
    barline_change(2, true)
end

local function func_0411()
    barline_change(3, true)
end

local function func_0412()
    barline_change(4, true)
end

local function func_0413()
    barline_change(5, true)
end

local function func_0414()
    barline_change(6, true)
end

local function func_0415()
    barline_change(7, true)
end

local function func_0416()
    local measures = finale.FCMeasures()
    measures:LoadRegion(finenv.Region())
    for measure in each(measures) do
        measure.Barline = 1
        measure:Save()
    end    
end

local function func_0417()
    find_double_barlines("Letter")
end

local function func_0418()
    find_double_barlines("Number")
end

local function func_0419()
    find_double_barlines("Measure")
end

local function func_0420()
    delete_rehearsal_marks()
end

local function func_0500()
    alter_bass(0)
end

local function func_0501()
    alter_bass(1)
end

local function func_0502()
    alter_bass(2)
end

local  function func_0550()
   set_time(2, 1024) 
end

local  function func_0551()
    set_time(2, 2048) 
end

local  function func_0552()
    set_time(3, 2048) 
end

local  function func_0553()
    set_time(3, 1024) 
end

local  function func_0554()
    set_time(1, 1536) 
end

local  function func_0555()
    set_time(4, 1024) 
end

local  function func_0556()
    set_time(5, 1024) 
end

local  function func_0557()
    set_time(5, 512) 
end

local  function func_0558()
    set_time(2, 1536) 
end

local  function func_0559()
    set_time(7, 512) 
end

local  function func_0560()
    set_time(3, 1536) 
end

local  function func_0561()
    set_time(4, 1536) 
end

local function func_0600()
    deleteBeatSmartShape(finale.SMARTSHAPE_TRILL)
    createBeatBasedSL(finale.SMARTSHAPE_TRILL)
end

local function func_0601()
    deleteBeatSmartShape(finale.SMARTSHAPE_TRILLEXT)
    createBeatBasedSL(finale.SMARTSHAPE_TRILLEXT)
end

local function func_0602()
    deleteBeatSmartShape(finale.SMARTSHAPE_DASHLINE)
    createBeatBasedSL(finale.SMARTSHAPE_DASHLINE)
end

local function func_0603()
    deleteBeatSmartShape(finale.SMARTSHAPE_SOLIDLINE)
    createBeatBasedSL(finale.SMARTSHAPE_SOLIDLINE)
end

local  function func_0604()
    deleteEntrySmartShape(finale.SMARTSHAPE_TABSLIDE)
    setFirstLastNoteRangeEntry(finale.SMARTSHAPE_TABSLIDE)
end

local function func_0605()
    deleteEntrySmartShape(finale.SMARTSHAPE_GLISSANDO)
    setFirstLastNoteRangeEntry(finale.SMARTSHAPE_GLISSANDO)
end

local function func_0606()
    deleteBeatSmartShape(finale.SMARTSHAPE_DASHLINEDOWN)
    createBeatBasedSL(finale.SMARTSHAPE_DASHLINEDOWN)
end

local function func_0607()
    deleteBeatSmartShape(finale.SMARTSHAPE_SOLIDLINEDOWN)
    createBeatBasedSL(finale.SMARTSHAPE_SOLIDLINEDOWN)
end

local function func_0608()
    deleteBeatSmartShape(finale.SMARTSHAPE_CUSTOM)
    createBeatBasedSL(finale.SMARTSHAPE_CUSTOM)
end

local  function func_0609()
    deleteEntrySmartShape(finale.SMARTSHAPE_SLURAUTO)
    setFirstLastNoteRangeEntry(finale.SMARTSHAPE_SLURAUTO)
end

local  function func_0610()
    deleteEntrySmartShape(finale.SMARTSHAPE_DASHEDSLURAUTO)
    setFirstLastNoteRangeEntry(finale.SMARTSHAPE_DASHEDSLURAUTO)
end

local function func_0611()
    deleteBeatSmartShape(finale.SMARTSHAPE_DASHLINEDOWN2)
    createBeatBasedSL(finale.SMARTSHAPE_DASHLINEDOWN2)
end

local function func_0612()
    deleteBeatSmartShape(finale.SMARTSHAPE_SOLIDLINEDOWN2)
    createBeatBasedSL(finale.SMARTSHAPE_SOLIDLINEDOWN2)
end

local function func_0612()
    deleteBeatSmartShape(finale.SMARTSHAPE_SOLIDLINEDOWN2)
    createBeatBasedSL(finale.SMARTSHAPE_SOLIDLINEDOWN2)
end

local function func_0613()
    deleteBeatSmartShape(finale.SMARTSHAPE_OCTAVEUP)
    createBeatBasedSL(finale.SMARTSHAPE_OCTAVEUP)
end

local function func_0614()
    deleteBeatSmartShape(finale.SMARTSHAPE_TWOOCTAVEUP)
    createBeatBasedSL(finale.SMARTSHAPE_TWOOCTAVEUP)
end

local function func_0615()
    deleteBeatSmartShape(finale.SMARTSHAPE_OCTAVEDOWN)
    createBeatBasedSL(finale.SMARTSHAPE_OCTAVEDOWN)
end

local function func_0616()
    deleteBeatSmartShape(finale.SMARTSHAPE_TWOOCTAVEDOWN)
    createBeatBasedSL(finale.SMARTSHAPE_TWOOCTAVEDOWN)
end

local function func_0700()
    applyStaffStyle("Slash Notation")
end

local function func_0701()
    applyStaffStyle("Rythmic Notation")
end

local function func_0702()
    applyStaffStyle("Blank Notation: Layer 1")
end

local function func_0703()
    applyStaffStyle("Blank Notation with Rests: Layer 1")
end

local function func_0704()
    applyStaffStyle("Blank Notation: Layer 4")
end

local function func_0705()
    applyStaffStyle("Blank Notation with Rests: Layer 4")
end

local function func_0706()
    applyStaffStyle("Blank Notation: All Layers")
end

local function func_0707()
    applyStaffStyle("One Bar Repeat")
end

local function func_0708()
    applyStaffStyle("Two Bar Repeat")
end

local function func_0709()
    applyStaffStyle("Stemless Notes")
end

local function func_0710()
    applyStaffStyle("Cutaway")
end

local function func_0711()
    applyStaffStyle("Collapse")
end

local function func_9000()
    for entry in eachentrysaved(finenv.Region()) do
        if (entry.Count ~= 2) then 
            goto continue 
        end
        local highestnote = entry:CalcHighestNote(nil)
        local lowestnote = entry:CalcLowestNote(nil)
        local mididiff = highestnote:CalcMIDIKey() - lowestnote:CalcMIDIKey()
        if ((mididiff ~= 12 and mididiff > 7) or (3 > mididiff) or (mididiff == 6)) then 
            goto continue 
        end
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
    if returnvalues[1] == "0028" then
        func_0028()
    end
    if returnvalues[1] == "0029" then
        func_0029()
    end
    if returnvalues[1] == "0030" then
        func_0030()
    end
    if returnvalues[1] == "0031" then
        func_0031()
    end
    if returnvalues[1] == "0032" then
        func_0032()
    end
    if returnvalues[1] == "0033" then
        func_0033()
    end
    if returnvalues[1] == "0034" then
        func_0034()
    end
    if returnvalues[1] == "0035" then
        func_0035()
    end
    if returnvalues[1] == "0036" then
        func_0036()
    end
    if returnvalues[1] == "0037" then
        func_0037()
    end
    if returnvalues[1] == "0038" then
        func_0038()
    end
    if returnvalues[1] == "0039" then
        func_0039()
    end
    if returnvalues[1] == "0040" then
        func_0040()
    end
    if returnvalues[1] == "0041" then
        func_0041()
    end
    if returnvalues[1] == "0042" then
        func_0042()
    end
    if returnvalues[1] == "0043" then
        func_0043()
    end
    if returnvalues[1] == "0044" then
        func_0044()
    end
    if returnvalues[1] == "0045" then
        func_0045()
    end
    if returnvalues[1] == "0046" then
        func_0046()
    end
    if returnvalues[1] == "0047" then
        func_0047()
    end
    if returnvalues[1] == "0048" then
        func_0048()
    end
    if returnvalues[1] == "0049" then
        func_0049()
    end
    if returnvalues[1] == "0050" then
        func_0050()
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
    if returnvalues[1] == "0124" then
        func_0124()
    end
    if returnvalues[1] == "0125" then
        func_0125()
    end
    if returnvalues[1] == "0126" then
        func_0126()
    end
    if returnvalues[1] == "0200" then
        func_0200()
    end
    if returnvalues[1] == "0201" then
        func_0201()
    end
    if returnvalues[1] == "0202" then
        func_0202()
    end
    if returnvalues[1] == "0203" then
        func_0203()
    end
    if returnvalues[1] == "0204" then
        func_0204()
    end
    if returnvalues[1] == "0205" then
        func_0205()
    end
    if returnvalues[1] == "0206" then
        func_0206()
    end
    if returnvalues[1] == "0207" then
        func_0207()
    end
    if returnvalues[1] == "0208" then
        func_0208()
    end
    if returnvalues[1] == "0209" then
        func_0209()
    end
    if returnvalues[1] == "0210" then
        func_0210()
    end
    if returnvalues[1] == "0211" then
        func_0211()
    end
    if returnvalues[1] == "0300" then
        func_0300()
    end
    if returnvalues[1] == "0400" then
        func_0400()
    end
    if returnvalues[1] == "0401" then
        func_0401()
    end
    if returnvalues[1] == "0402" then
        func_0402()
    end
    if returnvalues[1] == "0403" then
        func_0403()
    end
    if returnvalues[1] == "0404" then
        func_0404()
    end
    if returnvalues[1] == "0405" then
        func_0405()
    end
    if returnvalues[1] == "0406" then
        func_0406()
    end
    if returnvalues[1] == "0407" then
        func_0407()
    end
    if returnvalues[1] == "0408" then
        func_0408()
    end
    if returnvalues[1] == "0409" then
        func_0409()
    end
    if returnvalues[1] == "0410" then
        func_0410()
    end
    if returnvalues[1] == "0411" then
        func_0411()
    end
    if returnvalues[1] == "0412" then
        func_0412()
    end
    if returnvalues[1] == "0413" then
        func_0413()
    end
    if returnvalues[1] == "0414" then
        func_0414()
    end
    if returnvalues[1] == "0415" then
        func_0415()
    end
    if returnvalues[1] == "0416" then
        func_0416()
    end
    if returnvalues[1] == "0417" then
        func_0417()
    end
    if returnvalues[1] == "0418" then
        func_0418()
    end
    if returnvalues[1] == "0419" then
        func_0419()
    end
    if returnvalues[1] == "0420" then
        func_0420()
    end
    if returnvalues[1] == "0500" then
        func_0500()
    end
    if returnvalues[1] == "0501" then
        func_0501()
    end
    if returnvalues[1] == "0502" then
        func_0502()
    end
    if returnvalues[1] == "0550" then
        func_0550()
    end
    if returnvalues[1] == "0551" then
        func_0551()
    end
    if returnvalues[1] == "0552" then
        func_0552()
    end
    if returnvalues[1] == "0553" then
        func_0553()
    end
    if returnvalues[1] == "0554" then
        func_0554()
    end
    if returnvalues[1] == "0555" then
        func_0555()
    end
    if returnvalues[1] == "0556" then
        func_0556()
    end
    if returnvalues[1] == "0557" then
        func_0557()
    end
    if returnvalues[1] == "0558" then
        func_0558()
    end
    if returnvalues[1] == "0559" then
        func_0559()
    end
    if returnvalues[1] == "0560" then
        func_0560()
    end
    if returnvalues[1] == "0561" then
        func_0561()
    end
    if returnvalues[1] == "0600" then
        func_0600()
    end
    if returnvalues[1] == "0601" then
        func_0601()
    end
    if returnvalues[1] == "0602" then
        func_0602()
    end
    if returnvalues[1] == "0603" then
        func_0603()
    end
    if returnvalues[1] == "0604" then
        func_0604()
    end
    if returnvalues[1] == "0605" then
        func_0605()
    end
    if returnvalues[1] == "0606" then
        func_0606()
    end
    if returnvalues[1] == "0607" then
        func_0607()
    end
    if returnvalues[1] == "0608" then
        func_0608()
    end
    if returnvalues[1] == "0609" then
        func_0609()
    end
    if returnvalues[1] == "0610" then
        func_0610()
    end
    if returnvalues[1] == "0611" then
        func_0611()
    end
    if returnvalues[1] == "0612" then
        func_0612()
    end
    if returnvalues[1] == "0613" then
        func_0613()
    end
    if returnvalues[1] == "0614" then
        func_0614()
    end
    if returnvalues[1] == "0615" then
        func_0615()
    end
    if returnvalues[1] == "0616" then
        func_0616()
    end
    if returnvalues[1] == "0700" then
        func_0700()
    end
    if returnvalues[1] == "0701" then
        func_0701()
    end
    if returnvalues[1] == "0702" then
        func_0702()
    end
    if returnvalues[1] == "0703" then
        func_0703()
    end
    if returnvalues[1] == "0704" then
        func_0704()
    end
    if returnvalues[1] == "0705" then
        func_0705()
    end
    if returnvalues[1] == "0706" then
        func_0706()
    end
    if returnvalues[1] == "0707" then
        func_0707()
    end
    if returnvalues[1] == "0708" then
        func_0708()
    end
    if returnvalues[1] == "0709" then
        func_0709()
    end
    if returnvalues[1] == "0710" then
        func_0710()
    end
    if returnvalues[1] == "0711" then
        func_0711()
    end
    if returnvalues[1] == "9000" then
        func_9000()
    end
end