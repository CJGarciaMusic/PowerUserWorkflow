function plugindef()
    finaleplugin.RequireSelection = false
    finaleplugin.Version = "190904"
    finaleplugin.Date = "9/04/2019"
    return "JetStream Finale Controller", "JetStream Finale Controller", "Input four digit codes to access JetStream Finale Controller features."
end

local dialog = finenv.UserValueInput()
dialog.Title = "JetStream Finale Controller"

local full_art_table = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

function assignArticulation(art_id)
    for noteentry in eachentrysaved(finenv.Region()) do
        local a = finale.FCArticulation()
        a:SetNoteEntry(noteentry)
        local ad = finale.FCArticulationDef()
        if (art_id == full_art_table[20]) or (art_id == full_art_table[21]) or (art_id == full_art_table[25]) or (art_id == full_art_table[26]) then
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

function assignNewArticulation(noteentry, art_id)
    local a = finale.FCArticulation()
    a:SetNoteEntry(noteentry)
    if (art_id == full_art_table[27]) or (art_id == full_art_table[28]) or (art_id == full_art_table[29]) or (art_id == full_art_table[30]) then
        if noteentry:IsTiedBackwards() == false then
            a:SetID(art_id)
            a:SaveNew()
        end
    elseif (art_id == full_art_table[31]) or (art_id == full_art_table[32]) or (art_id == full_art_table[33]) or (art_id == full_art_table[34]) then
        if noteentry:IsTied() == false then
            a:SetID(art_id)
            a:SaveNew()
        end
    elseif noteentry:IsTiedBackwards() == false then
        a:SetID(art_id)
        a:SaveNew()
    end
end

function createArticulation(table_placement, MainSymbolChar, MainSymbolFont, AboveSymbolChar, AboveUsesMain, AlwaysPlaceOutsideStaff, AttachToTopNote, AttackIsPercent, AutoPosSide, AvoidStaffLines, BelowSymbolChar, BelowUsesMain, BottomAttack, BottomDuration, BottomVelocity, CenterHorizontally, CopyMainSymbol, CopyMainSymbolHorizontally, DefaultVerticalPos, DurationIsPercent, MainHandleHorizontalOffset, MainHandleVerticalOffset, FlippedHandleHorizontalOffset, FlippedHandleVerticalOffset, FlippedSymbolChar, FlippedSymbolFont, InsideSlurs, OnScreenOnly, Playback, TopAttack, TopDuration, TopVelocity, VelocityIsPercent, fm_Absolute, fm_Bold, fm_EnigmaStyles, fm_Hidden, fm_Italic, fm_Name, fm_Size, fm_SizeFloat, fm_StrikeOut, fm_Underline, ff_Absolute, ff_Bold, ff_EnigmaStyles, ff_Hidden, ff_Italic, ff_Name, ff_Size, ff_SizeFloat, ff_StrikeOut, ff_Underline)
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

function createNewArticulation(table_placement, MainSymbolChar, MainSymbolFont, AboveSymbolChar, AboveUsesMain, AlwaysPlaceOutsideStaff, AttachToTopNote, AttackIsPercent, AutoPosSide, AvoidStaffLines, BelowSymbolChar, BelowUsesMain, BottomAttack, BottomDuration, BottomVelocity, CenterHorizontally, CopyMainSymbol, CopyMainSymbolHorizontally, DefaultVerticalPos, DurationIsPercent, MainHandleHorizontalOffset, MainHandleVerticalOffset, FlippedHandleHorizontalOffset, FlippedHandleVerticalOffset, FlippedSymbolChar, FlippedSymbolFont, InsideSlurs, OnScreenOnly, Playback, TopAttack, TopDuration, TopVelocity, VelocityIsPercent, fm_Absolute, fm_Bold, fm_EnigmaStyles, fm_Hidden, fm_Italic, fm_Name, fm_Size, fm_SizeFloat, fm_StrikeOut, fm_Underline, ff_Absolute, ff_Bold, ff_EnigmaStyles, ff_Hidden, ff_Italic, ff_Name, ff_Size, ff_SizeFloat, ff_StrikeOut, ff_Underline)
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
end

function deleteArticulation(id_num)
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

function deleteNewArticulation(noteentry, id_num)
    local artics = noteentry:CreateArticulations()
    for a in eachbackwards(artics) do
        local defs = a:CreateArticulationDef()
        if defs:GetItemNo() == id_num then
            a:DeleteData()
        end
    end
end

function addArticulation(art_id)
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

function addNewArticulation(note_entry, art_id)
    local artic_ids = {}
    local artics = note_entry:CreateArticulations()
    for a in each(artics) do
        local defs = a:CreateArticulationDef()
        table.insert(artic_ids, defs:GetItemNo())
    end

    local found_artic = 0

    for key, value in pairs(artic_ids) do
        if value == art_id then
            found_artic = 1
        end
    end

    if found_artic ~= 0 then
        deleteNewArticulation(note_entry, art_id)
    else
        assignNewArticulation(note_entry, art_id)
    end
end

function findArticulation(table_placement, AboveSymbolChar, font_name)
    local articulationdefs = finale.FCArticulationDefs()
    articulationdefs:LoadAll()
    local first_id_table = {}
    for ad in each(articulationdefs) do
        if font_name == "" then
            if (ad:GetAboveSymbolChar() == AboveSymbolChar) then
                table.insert(first_id_table, ad.ItemNo)
            end
        else
            if (ad:GetAboveSymbolChar() == AboveSymbolChar) and (ad:GetMainSymbolFont() == font_name) then
                table.insert(first_id_table, ad.ItemNo)
            end
        end
    end
    if first_id_table[1] ~= nil then
        full_art_table[table_placement] = first_id_table[1]
    end
end

function getUsedFontName(standard_name)
    local font_name = standard_name
    if string.find(os.tmpname(), "/") then
        font_name = standard_name
    elseif string.find(os.tmpname(), "\\") then
        font_name = string.gsub(standard_name, "%s", "")
    end
    return font_name
end

function adjustHairpins(addstaff, start_meas, end_meas, start_pos, end_pos)
    local music_reg = finenv.Region()
    music_reg:SetStartStaff(addstaff)
    music_reg:SetEndStaff(addstaff)
    music_reg:SetStartMeasure(start_meas)
    music_reg:SetStartMeasurePos(start_pos)
    music_reg:SetEndMeasure(end_meas)
    music_reg:SetEndMeasurePos(end_pos)

    if end_pos > 1000000 then
        local get_time = finale.FCMeasure()
        get_time:Load(end_meas)
        local new_right_end = get_time:GetTimeSignature()
        local beat = new_right_end:GetBeats()
        local duration = new_right_end:GetBeatDuration()
        end_pos = (beat * duration) - (duration / 2)
    end

    local staff_pos = {}
    local lowest_note = 0
    for noteentry in eachentrysaved(music_reg) do
        if noteentry:IsNote() then
            for note in each(noteentry) do
                table.insert(staff_pos, note:CalcStaffPosition())
            end
        end
    end

    table.sort(staff_pos)

    if staff_pos[1] ~= nil then
        lowest_note = (staff_pos[1] * 12) - 45
    else
        lowest_note = 0 
    end
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
            local left_entry_offset = 0
            local left_baseline_offset = 0
            local left_additional = 0
            local left_note_pos = {}
            for noteentry in eachentrysaved(music_reg) do
                if noteentry:IsNote() then
                    for note in each(noteentry) do
                        table.insert(left_note_pos, note:CalcStaffPosition())
                    end
                end
            end
            table.sort(left_note_pos)

            local left_note_y = 0
            if left_note_pos[1] ~= nil then
                left_note_y = left_note_pos[1] * 12
            end
            for le in each(left_expressions) do
                local create_def = le:CreateTextExpressionDef()
                local cd = finale.FCCategoryDef()
                if cd:Load(create_def:GetCategoryID()) then
                    if string.find(cd:CreateName().LuaString, "Dynamic") then
                        has_left_dyn = 1
                        local text_met = finale.FCTextMetrics()
                        text_met:LoadString(create_def:CreateTextString(), create_def:CreateTextString():CreateLastFontInfo(), 100)
                        left_x_value = ((text_met:CalcWidthEVPUs() - 1027) / 2) + (le:GetHorizontalPos())
                        left_entry_offset = create_def:GetVerticalEntryOffset()
                        left_baseline_offset = -180 + create_def:GetVerticalBaselineOffset()
                        left_additional = le:GetVerticalPos()
                    end
                end
            end

            local left_y_offset = -144
           
            if has_left_dyn == 1 then
                if (left_note_y + left_entry_offset + left_additional) <= left_y_offset then
                    left_y_offset = (left_note_y + left_entry_offset + left_additional)
                else
                    left_y_offset = -171 
                end
            end
            local leftseg = smartshape:GetTerminateSegmentLeft()
            leftseg:SetMeasure(start_meas)
            leftseg.Staff = addstaff
            leftseg:SetCustomOffset(false)
            leftseg:SetEndpointOffsetX(left_x_value)
            leftseg:SetMeasurePos(music_reg:GetStartMeasurePos())

            local has_right_dyn = 0
            local right_x_value = 0
            music_reg:SetStartMeasure(end_meas)
            music_reg:SetEndMeasure(end_meas)
            music_reg:SetStartMeasurePos(end_pos)
            music_reg:SetEndMeasurePos(end_pos)

            local right_expressions = finale.FCExpressions()
            right_expressions:LoadAllForRegion(music_reg)
            local right_add_offset = 0
            local right_entry_offset = 0
            local right_baseline_offset = 0
            local right_additional = 0
            local right_note_pos = {}
            for noteentry in eachentrysaved(music_reg) do
                if noteentry:IsNote() then
                    for note in each(noteentry) do
                        table.insert(right_note_pos, note:CalcStaffPosition())
                    end
                end
            end

            table.sort(right_note_pos)

            local right_note_y = -153
            if right_note_pos[1] ~= nil then
                right_note_y = right_note_pos[1] * 12
            end

            for re in each(right_expressions) do
                local create_def = re:CreateTextExpressionDef()
                local cd = finale.FCCategoryDef()
                if cd:Load(create_def:GetCategoryID()) then
                    if string.find(cd:CreateName().LuaString, "Dynamic") then
                        has_right_dyn = 1
                        local text_met = finale.FCTextMetrics()
                        text_met:LoadString(create_def:CreateTextString(), create_def:CreateTextString():CreateLastFontInfo(), 100)
                        right_x_value = (0 - (text_met:CalcWidthEVPUs() - 1000) / 2) + (re:GetHorizontalPos())
                        right_entry_offset = create_def:GetVerticalEntryOffset()
                        right_baseline_offset = -180 + create_def:GetVerticalBaselineOffset()
                        right_additional = re:GetVerticalPos()
                    end
                end
            end

            local right_y_offset = -153
            if has_right_dyn == 1 then
                if (right_note_y + right_entry_offset + right_additional) <= right_y_offset then
                    right_y_offset = (right_note_y + right_entry_offset + right_additional)
                end
            end
            local distance_table = {right_y_offset, left_y_offset, lowest_note}
            table.sort(distance_table)

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
            leftseg:SetEndpointOffsetY(distance_table[1])
            rightseg:SetEndpointOffsetY(distance_table[1])
            smartshape:Save()
        end
    end
end

function setAdjustHairpinRange()
    local music_region = finenv.Region()
    music_region:SetCurrentSelection()
    local range_settings = {}
    
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        music_region:SetStartStaff(addstaff)
        music_region:SetEndStaff(addstaff)

        local measure_pos_table = {}
        local measure_table = {}
        local duration_table = {}
        
        local count = 0
        
        for noteentry in eachentrysaved(music_region) do
            if noteentry:IsNote() then
                table.insert(measure_pos_table, noteentry:GetMeasurePos())
                table.insert(measure_table, noteentry:GetMeasure())
                table.insert(duration_table, noteentry:GetDuration())
                count = count + 1
            end
        end

        local start_pos = measure_pos_table[1]
        local end_pos = measure_pos_table[count]
        local start_measure = measure_table[1]
        local end_measure = measure_table[count]

        if count ~= 0 then
            if duration_table[count] > 1536 then
                end_pos = music_region:GetEndMeasurePos() 
            end
        
            range_settings[addstaff] = {addstaff, start_measure, end_measure, start_pos, end_pos}
        end
    end

    for key, value in pairs(range_settings) do
        adjustHairpins(value[1], value[2], value[3], value[4], value[5])
    end
end

function createHairpin(staff, measure_start, measure_end, leftpos, rightpos, shape, gap_num)    
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
        rightpos = (beat * duration) - (duration / 2)
    end

    local leftseg = smartshape:GetTerminateSegmentLeft()
    leftseg:SetMeasure(measure_start)
    leftseg.Staff = staff
    leftseg:SetCustomOffset(false)
    leftseg:SetEndpointOffsetY(0)
    leftseg:SetEndpointOffsetX(0)
    leftseg:SetMeasurePos(leftpos)

    local rightseg = smartshape:GetTerminateSegmentRight()
    rightseg:SetMeasure(measure_end)
    rightseg.Staff = staff
    rightseg:SetCustomOffset(false)
    rightseg:SetEndpointOffsetX(0)
    rightseg:SetEndpointOffsetY(0)
    rightseg:SetMeasurePos(rightpos)
    smartshape:SaveNewEverything(nil, nil)
end

function deleteHairpins()
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

function createEntryBasedSL(staff, measure_start, measure_end, leftnote, rightnote, shape)
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

function setFirstLastNoteRangeEntry(smart_shape)
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

        if count ~= 0 then
            range_settings[addstaff] = {addstaff, start_measure, end_measure, start_pos, end_pos}
        end
    end

    for key, value in pairs(range_settings) do
        createEntryBasedSL(value[1], value[2], value[3], value[4], value[5], smart_shape)
    end
end

function setFirstLastNoteRangeBeat(smart_shape)
    local music_region = finenv.Region()
    local range_settings = {}
    
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        music_region:SetStartStaff(addstaff)
        music_region:SetEndStaff(addstaff)

        local measure_pos_table = {}
        local measure_table = {}
        local duration_table = {}
        
        local count = 0
        
        for noteentry in eachentrysaved(music_region) do
            if noteentry:IsNote() then
                table.insert(measure_pos_table, noteentry:GetMeasurePos())
                table.insert(measure_table, noteentry:GetMeasure())
                table.insert(duration_table, noteentry:GetDuration())
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

        if count > 0 then
            if (duration_table[count] > 1536) then
                end_pos = music_region:GetEndMeasurePos() 
            end
            range_settings[addstaff] = {addstaff, start_measure, end_measure, start_pos, end_pos}
        end
    end

    for key, value in pairs(range_settings) do
        createHairpin(value[1], value[2], value[3], value[4], value[5], smart_shape, 0)
    end
end

function createBBSL(staff, measure_start, measure_end, leftpos, rightpos, shape)    
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

function createBeatBasedSL(smart_shape)
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

function increaseDynamic()
    local dyn_table = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    local dyn_char = {150, 175, 184, 185, 112, 80, 70, 102, 196, 236, 235}
    
    local expressions = finale.FCTextExpressionDefs()
    expressions:LoadAll()
    for exp in each(expressions) do
        local cat_num = finale.FCCategoryDef()
        cat_num:Load(1)
        if exp:GetCategoryID(cat_num) then
            for key, value in pairs(dyn_char) do
                local exp_string = exp:CreateTextString()
                exp_string:TrimEnigmaTags()
                if (exp_string:GetCharacterAt(0) == value) and (exp_string:GetCharacterAt(-1) == value) then
                    dyn_table[key] = exp:GetItemNo()
                end
            end
        end
    end
    
    local expressions = finale.FCExpressions()
    expressions:LoadAllForRegion(finenv.Region())
    for exp in each(expressions) do
        local ex_def = exp:CreateTextExpressionDef()
        local cat_num = finale.FCCategoryDef()
        cat_num:Load(1)
        if ex_def:GetCategoryID(cat_num) then
            for key, value in pairs(dyn_char) do
                local exp_string = ex_def:CreateTextString()
                exp_string:TrimEnigmaTags()
                if key < 11 then
                    if (exp_string:GetCharacterAt(0) == value) and (exp_string:GetCharacterAt(-1) == value) then
                        exp:SetID(dyn_table[key + 1])
                        exp:Save()
                    end
                end
            end
        end
    end
    setAdjustHairpinRange()
end

function decreaseDynamic()
    local dyn_table = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    local dyn_char = {150, 175, 184, 185, 112, 80, 70, 102, 196, 236, 235}
    
    local expressions = finale.FCTextExpressionDefs()
    expressions:LoadAll()
    for exp in each(expressions) do
        local cat_num = finale.FCCategoryDef()
        cat_num:Load(1)
        if exp:GetCategoryID(cat_num) then
            for key, value in pairs(dyn_char) do
                local exp_string = exp:CreateTextString()
                exp_string:TrimEnigmaTags()
                if (exp_string:GetCharacterAt(0) == value) and (exp_string:GetCharacterAt(-1) == value) then
                    dyn_table[key] = exp:GetItemNo()
                end
            end
        end
    end
    
    local expressions = finale.FCExpressions()
    expressions:LoadAllForRegion(finenv.Region())
    for exp in each(expressions) do
        local ex_def = exp:CreateTextExpressionDef()
        local cat_num = finale.FCCategoryDef()
        cat_num:Load(1)
        if ex_def:GetCategoryID(cat_num) then
            for key, value in pairs(dyn_char) do
                local exp_string = ex_def:CreateTextString()
                exp_string:TrimEnigmaTags()
                if key > 1 then
                    if (exp_string:GetCharacterAt(0) == value) and (exp_string:GetCharacterAt(-1) == value) then
                        exp:SetID(dyn_table[key - 1])
                        exp:Save()
                    end
                end
            end
        end
    end
    setAdjustHairpinRange()
end

function deleteDynamics()
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

function deleteBeatSmartShape(shape_num)
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

function deleteEntrySmartShape(shape_num)
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

local first_expression = {}

function add_dynamic(staff_num, measure_num, measure_pos)
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
    setAdjustHairpinRange()
end

function dynamic_region(note_range)
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
        if (start_pos ~= nil) or (end_pos ~= nil) or (start_measure ~= nil) or (end_measure ~= nil) then
            range_settings[addstaff] = {addstaff, start_measure, end_measure, start_pos, end_pos}
        end
    end

    for key, value in pairs(range_settings) do
        if note_range == "Start" then
            add_dynamic(value[1], value[2], value[4])
        end
        if note_range == "End" then
            add_dynamic(value[1], value[3], value[5])
        end
    end
end

function create_dynamic(glyph_list, table_name, exp_description)
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

function find_dynamic(font, glyph_nums, table_name, description_text)
    local matching_glyphs = {}
    local exp_defs = finale.FCTextExpressionDefs()
    local exp_def = finale.FCTextExpressionDef()
    exp_defs:LoadAll()
    for exp in each(exp_defs) do
        local glyph_length = 0
        local exp_string = finale.FCString()
        exp_string.LuaString = ""
        for key, value in pairs(glyph_nums) do
            exp_string:AppendCharacter(value)
            glyph_length = glyph_length + 1
        end
        local current_string = exp:CreateTextString()
        current_string:TrimEnigmaTags()
        if glyph_length > 1 then
            if ((current_string:GetCharacterAt(-1) == glyph_nums[2]) and (current_string:GetCharacterAt(0) == glyph_nums[1])) then
                table.insert(matching_glyphs, exp:GetItemNo())
            end
        else
            if (current_string:GetCharacterAt(0) == glyph_nums[1]) then
                table.insert(matching_glyphs, exp:GetItemNo()) 
            end
        end
    end
    if matching_glyphs[1] == nil then
        create_dynamic(glyph_nums, table_name, description_text)
    else
        exp_def:Load(matching_glyphs[1])
        table.insert(table_name, exp_def:GetItemNo())  
    end
end

function changeNoteheads(font_name, quarter_glyph, half_glyph, whole_glyph, breve_glyph)
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

function change_notehead_size(layer, size, resize_top_bottom)
    for noteentry in eachentrysaved(finenv.Region()) do
        if noteentry.LayerNumber == layer then
            local nm = finale.FCNoteheadMod()
            nm:SetNoteEntry(noteentry)
            if resize_top_bottom ~= nil then
                for note in each(noteentry) do
                    local top_note = noteentry:CalcHighestNote(nil)
                    local bottom_note = noteentry:CalcLowestNote(nil)
                    local note_exception = bottom_note
                    if resize_top_bottom == true then
                       note_exception = top_note
                    end
                    if note:CalcMIDIKey() ~= note_exception:CalcMIDIKey() then
                        nm:LoadAt(note)
                        nm:SetResize(size)
                        nm:SaveAt(note)
                    else
                        nm:LoadAt(note)
                        nm:SetResize(100)
                        nm:SaveAt(note)
                    end
                end
            else
                for note in each(noteentry) do
                    nm:SetResize(size)
                    nm:SaveAt(note)
                end
            end
        end
    end
end

local text_expression = {}

function addTextExpression(staff_num, measure_num, measure_pos)
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
        
        if e.ID == text_expression[1] then
            e:DeleteData()
            return
        else
            local ted = e:CreateTextExpressionDef()
            ted:Load(text_expression[1])
            if ted:GetCategoryID() == 1 then
                e:DeleteData()
            end
        end
    end
    add_expression=finale.FCExpression()
    add_expression:SetStaff(staff_num)
    add_expression:SetVisible(true)

    add_expression:SetMeasurePos(measure_pos)
    add_expression:SetScaleWithEntry(true)
    add_expression:SetPartAssignment(true)
    add_expression:SetScoreAssignment(true)
    add_expression:SetID(text_expression[1])
    local and_cell = finale.FCCell(measure_num, staff_num)
    add_expression:SaveNewToCell(and_cell)
end

function getFirstNoteInRegionText(note_range)
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
        local start_measure = measure_table[1]
        if (note_range == "Region Start") or (start_pos == nil) then
            start_pos = music_region:GetStartMeasurePos()
            start_measure = music_region:GetStartMeasure()
        end
        local end_pos = measure_pos_table[count]
        local end_measure = measure_table[count]
        if (note_range == "Region End") or (end_pos == nil) then
            end_measure = music_region:GetEndMeasure()
            end_pos = music_region:GetEndMeasurePos()
            if end_pos > 1000000 then
                local get_time = finale.FCMeasure()
                get_time:Load(end_measure)
                local new_right_end = get_time:GetTimeSignature()
                local beat = new_right_end:GetBeats()
                local duration = new_right_end:GetBeatDuration()
                end_pos = beat * duration
            end
        end

        if count == 1 then
            end_pos = music_region:GetEndMeasurePos() 
        end
    
        if (start_pos ~= nil) or (end_pos ~= nil) or (start_measure ~= nil) or (end_measure ~= nil) then
            range_settings[addstaff] = {addstaff, start_measure, end_measure, start_pos, end_pos}
        end
    end

    for key, value in pairs(range_settings) do
        if (note_range == "Start") or (note_range == "Region Start") then
            addTextExpression(value[1], value[2], value[4])
        end
        if (note_range == "End") or (note_range == "Region End") then
            addTextExpression(value[1], value[3], value[5])
        end
    end
end

function CreateTextExpression(exp_string_list, table_name, exp_description, category_number)
    local ex_ted = finale.FCTextExpressionDef()
    local ex_textstr = finale.FCString()
    local cat_def = finale.FCCategoryDef()
    cat_def:Load(category_number)
    local fonti = cat_def:CreateTextFontInfo()
    local text_font = "^fontTxt"..fonti:CreateEnigmaString(finale.FCString()).LuaString
    cat_def:GetMusicFontInfo(fonti)
    local music_font = "^fontMus"..fonti:CreateEnigmaString(finale.FCString()).LuaString
    if exp_string_list[2] ~= nil then
        if tonumber(exp_string_list[2]) ~= nil then
            local exp_string_p2 = finale.FCString()
            exp_string_p2.LuaString = music_font
            exp_string_p2:AppendCharacter(exp_string_list[2])
            ex_textstr.LuaString = text_font..exp_string_list[1].." "..exp_string_p2.LuaString
        elseif tonumber(exp_string_list[1]) ~= nil then
            local exp_string_p1 = finale.FCString()
            exp_string_p1.LuaString = music_font
            exp_string_p1:AppendCharacter(exp_string_list[1])
            ex_textstr.LuaString = exp_string_p1.LuaString.." "..text_font..exp_string_list[2]
        end
    else
        ex_textstr.LuaString = text_font..exp_string_list[1]
    end
    ex_ted:SaveNewTextBlock(ex_textstr)
    
    local and_descriptionstr = finale.FCString()
    and_descriptionstr.LuaString = exp_description
    ex_ted:SetDescription(and_descriptionstr)
    local cat_def = finale.FCCategoryDef()
    cat_def:Load(category_number)
    ex_ted:AssignToCategory(cat_def)
    ex_ted:SetUseCategoryPos(true)
    ex_ted:SetUseCategoryFont(true)
    ex_ted:SaveNew()
    table.insert(table_name, ex_ted:GetItemNo())  
end

function findTextExpression(exp_string_list, table_name, description_text, category_num)
    local matching_glyphs = {}
    local exp_defs = finale.FCTextExpressionDefs()
    local exp_def = finale.FCTextExpressionDef()
    exp_defs:LoadAll()
    for exp in each(exp_defs) do
        local current_string = exp:CreateTextString()
        current_string:TrimEnigmaTags()
        if exp_string_list[2] ~= nil then
            if tonumber(exp_string_list[2]) ~= nil then
                local exp_string_p2 = finale.FCString()
                exp_string_p2.LuaString = ""
                exp_string_p2:AppendCharacter(exp_string_list[2])
                if current_string.LuaString == exp_string_list[1].." "..exp_string_p2.LuaString then
                    table.insert(matching_glyphs, exp:GetItemNo())
                end
            elseif tonumber(exp_string_list[1]) ~= nil then
                local exp_string_p1 = finale.FCString()
                exp_string_p1.LuaString = ""
                exp_string_p1:AppendCharacter(exp_string_list[1])
                if current_string.LuaString == exp_string_p1.LuaString.." "..exp_string_list[2] then
                    table.insert(matching_glyphs, exp:GetItemNo())
                end
            end
        else
            if current_string.LuaString == exp_string_list[1] then
                table.insert(matching_glyphs, exp:GetItemNo())
            end
        end
    end
    if matching_glyphs[1] == nil then
        CreateTextExpression(exp_string_list, table_name, description_text, category_num)
    else
        exp_def:Load(matching_glyphs[1])
        table.insert(table_name, exp_def:GetItemNo())  
    end
end

function CreateSpecialTextExpression(exp_string_list, font_details, table_name, exp_description, category_number)
    local ex_ted = finale.FCTextExpressionDef()
    local ex_textstr = finale.FCString()
    local exp_string_p1 = finale.FCString()
    exp_string_p1.LuaString = "^fontMus("..font_details[1]..","..font_details[2]..")^size("..font_details[3]..")^nfx("..font_details[4]..")"
    exp_string_p1:AppendCharacter(exp_string_list[1])
    ex_textstr.LuaString = exp_string_p1.LuaString
    ex_ted:SaveNewTextBlock(ex_textstr)
    
    local and_descriptionstr = finale.FCString()
    and_descriptionstr.LuaString = exp_description
    ex_ted:SetDescription(and_descriptionstr)
    local cat_def = finale.FCCategoryDef()
    cat_def:Load(category_number)
    ex_ted:AssignToCategory(cat_def)
    ex_ted:SetUseCategoryPos(true)
    ex_ted:SetUseCategoryFont(false)
    ex_ted:SaveNew()
    table.insert(table_name, ex_ted:GetItemNo())  
end

function findSpecialExpression(exp_string_list, font_details, table_name, description_text, category_num)
    local matching_glyphs = {}
    local exp_defs = finale.FCTextExpressionDefs()
    local exp_def = finale.FCTextExpressionDef()
    exp_defs:LoadAll()
    local already_exists = 0
    for exp in each(exp_defs) do
        if tonumber(exp_string_list[1]) ~= nil then
            local exp_string_p1 = finale.FCString()
            exp_string_p1.LuaString = "%^fontMus%("..font_details[1]..","..font_details[2].."%)%^size%("..font_details[3].."%)%^nfx%("..font_details[4].."%)"
            exp_string_p1:AppendCharacter(exp_string_list[1])
            local exp_string_p2 = finale.FCString()
            exp_string_p2.LuaString = "%^fontTxt%("..font_details[1]..","..font_details[2].."%)%^size%("..font_details[3].."%)%^nfx%("..font_details[4].."%)"
            exp_string_p2:AppendCharacter(exp_string_list[1])

            if (exp:CreateTextString().LuaString == string.gsub(exp_string_p1.LuaString, "%%", "")) or (exp:CreateTextString().LuaString == string.gsub(exp_string_p2.LuaString, "%%", "")) then
                already_exists = exp:GetItemNo()
                table.insert(matching_glyphs, already_exists)
            end
        end
    end
    if matching_glyphs[1] == nil then
        CreateSpecialTextExpression(exp_string_list, font_details, table_name, description_text, category_num)
    else
        exp_def:Load(matching_glyphs[1])
        table.insert(table_name, exp_def:GetItemNo())  
    end
end

function barline_change(style, bookend)
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

function add_rehearsal_marks(measure_num, reh_type)
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

    function add_exp(exp_id)
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

function delete_rehearsal_marks()
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

function find_double_barlines(rehearsal_mark_type)
    delete_rehearsal_marks()
    local measures = finale.FCMeasures()
    measures:LoadRegion(finenv.Region())
    for m in each(measures) do
        if m.Barline == 2 then
            add_rehearsal_marks(m.ItemNo + 1, rehearsal_mark_type)
        end
    end
end

function alter_bass(placement)
    local chords = finale.FCChords()
    chords:LoadAllForRegion(finenv.Region())
    for c in each(chords) do
       c.ChordAlternateBassPlacement = placement
        c:Save()
    end
end

function set_time(beat_num, beat_duration)
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

function applyStaffStyle(StaffStyleType)
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

function playback_type(start_meas, end_meas, playback_staves)
    local pbs = finale.FCPlaybackPrefs()
    local mus_reg = finenv.Region()
    pbs:Load(1)
    if start_meas == "Region" then
        mus_reg:SetCurrentSelection()
        pbs:SetStartMeasure(mus_reg:GetStartMeasure())
    elseif start_meas == "Document" then
        mus_reg:SetFullDocument()
        pbs:SetStartMeasure(mus_reg:GetStartMeasure())
    end
    if end_meas == "Region" then
        mus_reg:SetCurrentSelection()
        pbs:SetStopMeasure(mus_reg:GetEndMeasure())
    elseif end_meas == "Document" then
        mus_reg:SetFullDocument()
        pbs:SetStopMeasure(mus_reg:GetEndMeasure())
    end
    pbs:Save()
    pbs:Reload()
    mus_reg:SetCurrentSelection()
    local fulldocregion = finale.FCMusicRegion()
    fulldocregion:SetFullDocument()
    for slot = fulldocregion.StartSlot, fulldocregion.EndSlot do    
        local staffnumber = mus_reg:CalcStaffNumber(slot)
        local staff = finale.FCStaff()  
        staff:Load(staffnumber)
        local playbackdata = staff:CreateInstrumentPlaybackData()
        for layer = 1, 4 do
            local layerdef = playbackdata:GetNoteLayerData(layer)
            if playback_staves == "Document" then
                layerdef.Play = true
            elseif playback_staves == "Region" then
                layerdef.Play = mus_reg:IsStaffIncluded(staffnumber)
            end
        end
        playbackdata:Save()
    end
end

function measureWidth(direction_change)
    local measures = finale.FCMeasures()
    measures:LoadRegion(finenv.Region())

    for m in each(measures) do
        if direction_change == "Increase" then
            m:SetWidth(m:GetWidth() / 0.95)
        elseif direction_change == "Decrease" then
            m:SetWidth(m:GetWidth() * 0.95)
        end
        m:Save()
    end
end

function tuplet_options(tuplet_parameters)
    for noteentry in eachentry(finenv.Region()) do
        local t = finale.FCTuplet()
        t:SetNoteEntry(noteentry)
        if t:LoadFirst() then
            for key, value in pairs(tuplet_parameters) do
                if value == "Always Flat On" then
                    t:SetAlwaysFlat(true)
                elseif value == "Always Flat Off" then
                    t:SetAlwaysFlat(false)
                elseif value == "Allow Horizontal Drag On" then
                    t:SetAllowHorizontalDrag(true)
                elseif value == "Allow Horizontal Drag Off" then
                    t:SetAllowHorizontalDrag(false)
                elseif value == "Bottom Note On" then
                    t:SetUseBottomNote(true)
                elseif value == "Bottom Note Off" then
                    t:SetUseBottomNote(false)
                elseif value == "Engraver On" then
                    t:SetEngraverTuplet(true)
                elseif value == "Engraver Off" then
                    t:SetEngraverTuplet(false)
                elseif value == "Avoid Staff On" then
                    t:SetAvoidStaff(true)
                elseif value == "Avoid Staff Off" then
                    t:SetAvoidStaff(false)
                elseif value == "Bracket Always" then
                    t:SetBracketMode(0)
                elseif value == "Center Duration On" then
                    t:SetCenterUsingDuration(true)
                elseif value == "Center Duration Off" then
                    t:SetCenterUsingDuration(false)
                elseif value == "Ignore Horizontal On" then
                    t:SetIgnoreNumberOffset(true)
                elseif value == "Ignore Horizontal Off" then
                    t:SetIgnoreNumberOffset(false)
                elseif value == "Full Duration On" then
                    t:SetBracketFullDuration(true)
                elseif value == "Full Duration Off" then
                    t:SetBracketFullDuration(false)
                elseif value == "Match Hooks On" then
                    t:SetMatchHookLengths(true)
                elseif value == "Match Hooks Off" then
                    t:SetMatchHookLengths(false)
                elseif value == "Bracket Unbeamed" then
                    t:SetBracketMode(1)
                elseif value == "Bracket Never Beamed" then
                    t:SetBracketMode(2)
                elseif value == "Placement Manual" then
                    t:SetPlacementMode(0)
                elseif value == "Placement Stem" then
                    t:SetPlacementMode(1)
                elseif value == "Placement Note" then
                    t:SetPlacementMode(2)
                elseif value == "Placement Above" then
                    t:SetPlacementMode(3)
                elseif value == "Placement Below" then
                    t:SetPlacementMode(4)
                elseif value == "Increase Space" then
                    t:SetVerticalOffset(t:GetVerticalOffset() + 9)
                elseif value == "Decrease Space" then
                    if (t:GetVerticalOffset() - 9) > 0 then
                        t:SetVerticalOffset(t:GetVerticalOffset() - 9)
                    end
                elseif value == "Increase Bracket" then
                    if t:GetVerticalOffset() == 24 then
                        t:SetVerticalOffset(t:GetVerticalOffset() + 18)
                    end
                    t:SetLeftHookLength(t:GetLeftHookLength() + 9)
                    t:SetRightHookLength(t:GetRightHookLength() + 9)
                    t:SetVerticalOffset(t:GetVerticalOffset() + 9)
                elseif value == "Decrease Bracket" then
                    if (t:GetVerticalOffset() - 9) > 24 then
                        t:SetVerticalOffset(t:GetVerticalOffset() - 9)
                    end
                    if (t:GetLeftHookLength() - 9) > 12 then
                        t:SetLeftHookLength(t:GetLeftHookLength() - 9)
                    end
                    if (t:GetRightHookLength() - 9) > 12 then
                        t:SetRightHookLength(t:GetRightHookLength() - 9)
                    end
                elseif value == "Shape None" then
                    t:SetShapeStyle(0)
                elseif value == "Shape Bracket" then
                    t:SetShapeStyle(1) 
                elseif value == "Shape Slur" then
                    t:SetShapeStyle(2)
                elseif value == "Number None" then
                    t:SetNumberStyle(0)
                elseif value == "Number Regular" then
                    t:SetNumberStyle(1)
                elseif value == "Number Ratio" then
                    t:SetNumberStyle(2)
                elseif value == "Number Ratio Last" then
                    t:SetNumberStyle(3)
                elseif value == "Number Ration Both" then
                    t:SetNumberStyle(4)  
                end
            end
            t:Save()
        end
    end
end

function move_markers(marker_pos)
    local staff_sys = finale.FCStaffSystems()
    staff_sys:LoadAll()

    for sys in each(staff_sys) do
        local exps = finale.FCExpressions()
        local first_meas = sys:GetFirstMeasure()
        local first_staff = sys:CalcTopStaff()
        exps:LoadAllForItem(sys:GetFirstMeasure())
        local distanceprefs = finale.FCDistancePrefs()
        distanceprefs:Load(1)
        local space_before_clef = distanceprefs:GetClefSpaceBefore()
        for exp in each(exps) do
            local ted = finale.FCTextExpressionDef()
            ted:Load(exp:GetID())
            if ted:IsAutoRehearsalMark() then
                local first_region = finenv.Region()
                first_region:SetStartMeasure(first_meas)
                first_region:SetEndMeasure(first_meas)
                first_region:SetStartStaff(first_staff)
                first_region:SetEndStaff(first_staff)
                for m, s in eachcell(first_region) do
                   local cellpos = finale.FCCellPos(m, s, 0)
                   local clef_id = cellpos:CalcClefIndex()
                    if (clef_id == 0) or (clef_id == 5) or (clef_id == 8) or (clef_id == 13) then
                        if marker_pos == "Clef Center" then
                            exp:SetHorizontalPos(space_before_clef + 42)
                        end
                    elseif (clef_id == 3) or (clef_id == 6) or (clef_id == 7) or (clef_id == 14) then
                        if marker_pos == "Clef Center" then
                            exp:SetHorizontalPos(space_before_clef + 32)
                        end
                     elseif clef_id == 12 then
                        if marker_pos == "Clef Center" then
                            exp:SetHorizontalPos(space_before_clef + 16)
                        end
                     elseif (clef_id == 1) or (clef_id == 2) or (clef_id == 9) or (clef_id == 10) or (clef_id == 11) then
                        if marker_pos == "Clef Center" then
                            exp:SetHorizontalPos(space_before_clef + 31)
                        end
                    end
                end
                exp:Save()
            end
        end
    end
end

function staff_spacing_adjust(moveBy)
    local music_region = finenv.Region()
    local regionCount = 1
    local staffCount = 1
    local moveCount = 1
    local totalMove = 0
    local sysstaves = finale.FCSystemStaves()
    sysstaves:LoadAllForRegion(music_region)
    local allstaves = finale.FCSystemStaves()
    local regionStaves = {}

    local start_measure = music_region:GetStartMeasure()
    local end_measure = music_region:GetEndMeasure()
    local systems = finale.FCStaffSystems()
    systems:LoadAll()
    local system = systems:FindMeasureNumber(start_measure)
    local lastSys = systems:FindMeasureNumber(end_measure)
    local system_number = system:GetItemNo()
    local lastSys_number = lastSys:GetItemNo()

    for sys in each(sysstaves) do
        local staffNum = sys.Staff
        table.insert(regionStaves, staffNum)
        regionCount = regionCount + 1
    end

    for i = system_number, lastSys_number do
        allstaves:LoadAllForItem(i)
        staffCount = 1
        moveCount = 1
        totalMove = 0
        for sys in each(allstaves) do
            local staffNum = sys.Staff
                for j = 1, regionCount, 1 do
                    if staffNum == regionStaves[j] then
                        staffCount = j
                    end
                end
            if staffNum == regionStaves[staffCount] then
                local ss = finale.FCStaffSystem()
                ss:Load(sys:GetItemCmper())
                if sys:GetStaff() ~= ss:CalcTopStaff() then
                    sys:SetDistance(sys:GetDistance() + (moveBy * moveCount))
                    sys:Save()
                    totalMove = totalMove + moveBy
                    moveCount = moveCount + 1
                end
                staffCount = staffCount + 1
            elseif regionStaves[staffCount] == nil then
                local moveTo = sys:GetDistance() + totalMove
                sys.Distance = moveTo
                sys:Save()
            else
            end
        end
    end
end

function swap_layers(swapA, swapB)
    local region = finenv.Region()
    local start=region.StartMeasure
    local stop=region.EndMeasure
    local sysstaves = finale.FCSystemStaves()
    sysstaves:LoadAllForRegion(region)

    swapA = swapA - 1
    swapB = swapB - 1
    
    for sysstaff in each(sysstaves) do
        staffNum = sysstaff.Staff
        local noteentrylayer = finale.FCNoteEntryLayer(swapA,staffNum,start,stop)
        noteentrylayer:Load()
        noteentrylayer.LayerIndex=swapB

        local noteentrylayer2 = finale.FCNoteEntryLayer(swapB,staffNum,start,stop)
        noteentrylayer2:Load()
        noteentrylayer2.LayerIndex=swapA
        noteentrylayer:Save()
        noteentrylayer2:Save()
    end
end

function clear_Layer(lyr)
    lyr = lyr - 1 -- Turn 1 based layer to 0 based layer
    local region = finenv.Region()
    local start=region.StartMeasure
    local stop=region.EndMeasure
    local sysstaves = finale.FCSystemStaves()
    sysstaves:LoadAllForRegion(region)
    for sysstaff in each(sysstaves) do
        staffNum = sysstaff.Staff
        local noteentrylayer = finale.FCNoteEntryLayer(lyr,staffNum,start,stop)
        noteentrylayer:Load()
        noteentrylayer:ClearAllEntries()
    end
end

function user_expression_input(the_expression)
    local text_expression = {}

    function add_text_expression(staff_num, measure_num, measure_pos)
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
            if e.ID == text_expression[1] then
                e:DeleteData()
                return
            end
        end
        local add_expression = finale.FCExpression()
        add_expression:SetStaff(staff_num)
        add_expression:SetVisible(true)
        add_expression:SetMeasurePos(measure_pos)
        add_expression:SetScaleWithEntry(true)
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(true)
        add_expression:SetID(text_expression[1])
        local and_cell = finale.FCCell(measure_num, staff_num)
        add_expression:SaveNewToCell(and_cell)
    end

    local staff_list = {}

    function get_tempo_staves()
        local item_num = 0
        local sll = finale.FCStaffListLookup()
        if (sll:LoadCategoryList(2)) then 
            local sl = finale.FCStaffList()
            sl:SetMode(finale.SLMODE_CATEGORY_SCORE)
            if sl:LoadFirst() then
                item_num = sl:GetItemNo()
                if (sl:IncludesTopStaff()) then
                    table.insert(staff_list, 1)
                end
                local staves = finale.FCStaves()
                staves:LoadAll()
                for staff in each(staves) do
                    if sl:IncludesStaff(staff:GetItemNo()) then
                        table.insert(staff_list, staff:GetItemNo())
                    end
                end
            end
        end
    end

    function add_tempo(measure_num)
        local count = 0
        local add_expression = finale.FCExpression()
        for key, value in pairs(staff_list) do
            add_expression:SetPartAssignment(false)
            add_expression:SetScoreAssignment(true)
            add_expression:SetStaff(value)
            add_expression:SetStaffGroupID(1)
            add_expression:SetStaffListID(1)
            add_expression:SetVisible(true)
            add_expression:SetID(text_expression[1])
            local and_cell = finale.FCCell(measure_num, value)
            add_expression:SaveNewToCell(and_cell)
            count = count + 1
        end
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(false)
        add_expression:SetStaff(-1)
        add_expression:SetStaffGroupID(1)
        add_expression:SetStaffListID(1)
        add_expression:SetVisible(true)
        add_expression:SetID(text_expression[1])
        local and_cell = finale.FCCell(measure_num, -1)
        add_expression:SaveNewToCell(and_cell)
    end

    function text_expression_region(note_range)
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
            local start_measure = measure_table[1]
            if (note_range == "Region Start") or (start_pos == nil) then
                start_pos = music_region:GetStartMeasurePos()
                start_measure = music_region:GetStartMeasure()
            elseif note_range == "Tempo" then
                start_measure = music_region:GetStartMeasure()
                start_pos = 0
            end
            local end_pos = measure_pos_table[count]
            local end_measure = measure_table[count]
            if (note_range == "Region End") or (end_pos == nil) then
                end_measure = music_region:GetEndMeasure()
                end_pos = music_region:GetEndMeasurePos()
                if end_pos > 1000000 then
                    local get_time = finale.FCMeasure()
                    get_time:Load(end_measure)
                    local new_right_end = get_time:GetTimeSignature()
                    local beat = new_right_end:GetBeats()
                    local duration = new_right_end:GetBeatDuration()
                    end_pos = beat * duration
                end
            end

            if count == 1 then
                end_pos = music_region:GetEndMeasurePos() 
            end
        
            if (start_pos ~= nil) or (end_pos ~= nil) or (start_measure ~= nil) or (end_measure ~= nil) then
                range_settings[addstaff] = {addstaff, start_measure, end_measure, start_pos, end_pos}
            end
        end

        for key, value in pairs(range_settings) do
            if (note_range == "Start") or (note_range == "Region Start") then
                add_text_expression(value[1], value[2], value[4])
            end
            if (note_range == "End") or (note_range == "Region End") then
                add_text_expression(value[1], value[3], value[5])
            end
            if note_range == "Tempo" then
                get_tempo_staves()
                add_tempo(value[2])
            end
        end
    end

    function create_text_expression(text, category)
        local cat_def = finale.FCCategoryDef()
        cat_def:Load(category)
        local fonti = cat_def:CreateTextFontInfo()
        local text_font = "^fontTxt"..fonti:CreateEnigmaString(finale.FCString()).LuaString
        local full_string = text_font..text

        local exp_ted = finale.FCTextExpressionDef()
        local exp_str = finale.FCString()
        exp_str.LuaString = full_string
        exp_ted:SaveNewTextBlock(exp_str)
        local and_descriptionstr = finale.FCString()
        and_descriptionstr.LuaString = text
        exp_ted:SetDescription(and_descriptionstr)
        local cat_def = finale.FCCategoryDef()
        cat_def:Load(category)
        exp_ted:AssignToCategory(cat_def)
        exp_ted:SetUseCategoryPos(true)
        exp_ted:SaveNew()
        local item_no = exp_ted:GetItemNo()
        table.insert(text_expression, item_no)
    end

    function create_tempo_expression(text, category)
        local exp_ted = finale.FCTextExpressionDef()
        local exp_str = finale.FCString()
        exp_str.LuaString = text
        exp_ted:SaveNewTextBlock(exp_str)
        local and_descriptionstr = finale.FCString()
        local description_text = ""
        and_descriptionstr.LuaString = description_text
        exp_ted:SetDescription(and_descriptionstr)
        local cat_def = finale.FCCategoryDef()
        cat_def:Load(category)
        exp_ted:AssignToCategory(cat_def)
        exp_ted:SetUseCategoryPos(true)
        exp_ted:SaveNew()
        local item_no = exp_ted:GetItemNo()
        table.insert(text_expression, item_no)
    end

    function create_tempo_string(tempo_text, beat_duration, beat_number, parenthetical_bool)
        local cat_def = finale.FCCategoryDef()
        cat_def:Load(2)
        local staff_id = cat_def:GetStaffListID()
        local fonti = cat_def:CreateTextFontInfo()
        cat_def:GetMusicFontInfo(fonti)
        local music_font = "^fontMus"..fonti:CreateEnigmaString(finale.FCString()).LuaString
        cat_def:GetTextFontInfo(fonti)
        local text_font = "^fontTxt"..fonti:CreateEnigmaString(finale.FCString()).LuaString
        cat_def:GetNumberFontInfo(fonti)
        local number_font = "^fontNum"..fonti:CreateEnigmaString(finale.FCString()).LuaString
        local user_text = tempo_text
        local user_duration = beat_duration
        local user_number = beat_number
        local user_parentheses = parenthetical_bool
        local start_parentheses = "("
        local end_parentheses = text_font..")"

        if user_text ~= "" then
            user_text = text_font..user_text
        end
        
        if user_duration ~= "" then
            user_duration = music_font..user_duration
        end
        
        if user_number ~= "" then
            user_number = number_font.." = "..user_number
        end

        if user_parentheses == false then
            if beat_duration ~= "" then
                if user_text:sub(-1) == " " then
                    start_parentheses = ""
                else
                    start_parentheses = " "
                end
            else
                start_parentheses = ""
            end
            end_parentheses = ""
        else
            if user_text:sub(-1) ~= " " then
                start_parentheses = " ("
            else
                start_parentheses = "("
            end
        end
        
        local full_string = user_text..start_parentheses..user_duration..user_number..end_parentheses
        create_tempo_expression(full_string, 2)
    end

    local tempo_string = ""

    function create_tempo_string2(tempo_text, beat_duration, beat_number, parenthetical_bool)
        local user_text = tempo_text
        local user_duration = beat_duration
        local user_number = beat_number
        local user_parentheses = parenthetical_bool
        local start_parentheses = "("
        local end_parentheses = ")"
    
        if user_number ~= "" then
            user_number = " = "..user_number
        end

        if user_parentheses == false then
            if beat_duration ~= "" then
                if user_text:sub(-1) == " " then
                    start_parentheses = ""
                else
                    start_parentheses = " "
                end
            else
                start_parentheses = ""
            end
            end_parentheses = ""
        else
            if user_text:sub(-1) ~= " " then
                start_parentheses = " ("
            else
                start_parentheses = "("
            end
            end_parentheses = ")"
        end
        tempo_string = user_text..start_parentheses..user_duration..user_number..end_parentheses
    end

    function find_text_expression(exp_text, cat_id)
        local theID = {}
        local teds = finale.FCTextExpressionDefs()
        teds:LoadAll()
        for ted in each(teds) do
            if ted.CategoryID == cat_id then
                local ted_str = ted:CreateTextString()
                ted_str:TrimEnigmaTags()
                if ted_str.LuaString == exp_text then
                    table.insert(theID, ted:GetItemNo())
                end
            end
        end
        if theID[1] == nil then
            if cat_id == 2 then
                return false
            else
                create_text_expression(exp_text, cat_id, staff_id)
            end
        else
            table.insert(text_expression, theID[1])
        end
    end

    function parse_tempo(the_string, find_string)
        local tempo_text = ""
        local beat_duration = ""
        local beat_number = ""
        local parenthetical_bool = false
        if (string.match(the_string, "%(?[qQhHwWeEsSxX][.]?%s?=%s?%d+%s?[%-–—]?%s?%d+%)?")) then
            local new_string = string.find(the_string, "%(?[qQhHwWeEsSxX][.]?%s?=%s?%d+%)?")
            if (new_string) > 1 then
                tempo_text = the_string:sub(1, (new_string - 1))
            else
                tempo_text = ""
            end
            local metronome_text = the_string:sub(new_string)
            if string.find(metronome_text, "%(") then
                parenthetical_bool = true
            end
            if string.find(metronome_text, "[qQhHwWeEsSxX][.]?") then
                beat_duration = metronome_text:sub(string.find(metronome_text, "[qQhHwWeEsSxX][.]?"))
            end
            if string.find(metronome_text, "%d+%s?[%-–—]?%s?%d+") then
                beat_number = metronome_text:sub(string.find(metronome_text, "%d+%s?[%-–—]?%s?%d+"))
            end
        elseif (string.match(the_string, "%(?[qQhHwWeEsSxX][.]?%s?=%s?[qQhHwWeEsSxX][.]?%s?%)?")) then
            local new_string = string.find(the_string, "%(?[qQhHwWeEsSxX][.]?%s?=%s?%d+%)?")
            if (new_string) > 1 then
                tempo_text = the_string:sub(1, (new_string - 1))
            else
                tempo_text = ""
            end
            local metronome_text = the_string:sub(new_string)
            if string.find(metronome_text, "%(") then
                parenthetical_bool = true
            end
        else
            if string.match(the_string, "%a*") then
                tempo_text = the_string
            end
        end
        if find_string then
            create_tempo_string2(tempo_text, beat_duration, beat_number, parenthetical_bool)
        else
            create_tempo_string(tempo_text, beat_duration, beat_number, parenthetical_bool)
        end
    end

    function user_input(display_type)
        local input_dialog = finenv.UserValueInput()
        input_dialog:SetTypes("String")
        input_dialog:SetDescriptions("Pleaes Enter Your "..display_type.." Text")
        local returnvalues = input_dialog:Execute()

        if returnvalues ~= nil then
            if returnvalues[1] ~= "" then
                if display_type == "Tempo" then
                    parse_tempo(returnvalues[1], true)
                    if find_text_expression(tempo_string, 2) == false then
                        parse_tempo(returnvalues[1], false)
                    end
                    text_expression_region("Tempo")
                elseif display_type == "Expressive" then
                    find_text_expression(returnvalues[1], 4)
                    text_expression_region("Start")
                elseif display_type == "Technique" then
                    find_text_expression(returnvalues[1], 5)
                    text_expression_region("Start")
                end
            end
        end
    end
    user_input(the_expression)
end

function func_0001()
    find_dynamic("^^fontMus", {235}, first_expression, "fortissississimo (velocity = 127)")
    dynamic_region("Start")
end

function func_0002()    
    find_dynamic("^^fontMus", {236}, first_expression, "fortississimo (velocity = 114)")
    dynamic_region("Start")
end

function func_0003()    
    find_dynamic("^^fontMus", {196}, first_expression, "fortissimo (velocity = 101)")
    dynamic_region("Start")
end

function func_0004()
    find_dynamic("^^fontMus", {102}, first_expression, "forte (velocity = 88)")
    dynamic_region("Start")
end

function func_0005()    
    find_dynamic("^^fontMus", {70}, first_expression, "mezzo forte (velocity = 75)")
    dynamic_region("Start")
end

function func_0006()    
    find_dynamic("^^fontMus", {80}, first_expression, "mezzo piano (velocity = 62)")
    dynamic_region("Start")
end

function func_0007()    
    find_dynamic("^^fontMus", {112}, first_expression, "piano (velocity = 49)")
    dynamic_region("Start")
end

function func_0008()
    find_dynamic("^^fontMus", {185}, first_expression, "pianissimo (velocity = 36)")
    dynamic_region("Start")
end

function func_0009()    
    find_dynamic("^^fontMus", {184}, first_expression, "pianississimo (velocity = 23)")
    dynamic_region("Start")
end

function func_0010()    
    find_dynamic("^^fontMus", {175}, first_expression, "pianissississimo (velocity = 10)")
    dynamic_region("Start")
end

function func_0011()
    find_dynamic("^^fontMus", {234}, first_expression, "forte piano")
    dynamic_region("Start")
end

function func_0012()
    find_dynamic("^^fontMus", {90}, first_expression, "forzando")
    dynamic_region("Start")
end

function func_0013()
    findSpecialExpression({150}, {"Maestro", 8191, 24, 0}, first_expression, "niente (velocity = 0)", 1)
    dynamic_region("Start")
end

function func_0014()
    find_dynamic("^^fontMus", {142, 102}, first_expression, "rinforte")
    dynamic_region("Start")
end

function func_0015()
    find_dynamic("^^fontMus", {142, 90}, first_expression, "rinforzando")
    dynamic_region("Start")
end

function func_0016()
    find_dynamic("^^fontMus", {83}, first_expression, "sforzando")
    dynamic_region("Start")
end

function func_0017()
    find_dynamic("^^fontMus", {141}, first_expression, "sforzato")
    dynamic_region("Start")
end

function func_0018()
    find_dynamic("^^fontMus", {130}, first_expression, "sforzato piano")
    dynamic_region("Start")
end

function func_0019()
    find_dynamic("^^fontMus", {182}, first_expression, "sforzato pianissimo")
    dynamic_region("Start")
end

function func_0020()
    find_dynamic("^^fontMus", {167}, first_expression, "sforzato")
    dynamic_region("Start")
end

function func_0021()
    find_dynamic("^^fontMus", {167, 112}, first_expression, "sforzando piano")
    dynamic_region("Start")
end

function func_0022()
    deleteHairpins()
    setFirstLastNoteRangeBeat(finale.SMARTSHAPE_CRESCENDO)
    setAdjustHairpinRange()
end

function func_0023()
    deleteHairpins()
    setFirstLastNoteRangeBeat(finale.SMARTSHAPE_DIMINUENDO)
    setAdjustHairpinRange()
end

function func_0024()
    setSwellRange(finale.SMARTSHAPE_CRESCENDO, finale.SMARTSHAPE_DIMINUENDO)
end

function func_0025()
    setSwellRange(finale.SMARTSHAPE_DIMINUENDO, finale.SMARTSHAPE_CRESCENDO)
end

function func_0026()
    deleteHairpins()
end

function func_0027()
    deleteDynamics()
end

function func_0028()
    find_dynamic("^^fontMus", {235}, first_expression, "fortissississimo (velocity = 127)")
    dynamic_region("End")
end

function func_0029()    
    find_dynamic("^^fontMus", {236}, first_expression, "fortississimo (velocity = 114)")
    dynamic_region("End")
end

function func_0030()    
    find_dynamic("^^fontMus", {196}, first_expression, "fortissimo (velocity = 101)")
    dynamic_region("End")
end

function func_0031()
    find_dynamic("^^fontMus", {102}, first_expression, "forte (velocity = 88)")
    dynamic_region("End")
end

function func_0032()    
    find_dynamic("^^fontMus", {70}, first_expression, "mezzo forte (velocity = 75)")
    dynamic_region("End")
end

function func_0033()    
    find_dynamic("^^fontMus", {80}, first_expression, "mezzo piano (velocity = 62)")
    dynamic_region("End")
end

function func_0034()    
    find_dynamic("^^fontMus", {112}, first_expression, "piano (velocity = 49)")
    dynamic_region("End")
end

function func_0035()
    find_dynamic("^^fontMus", {185}, first_expression, "pianissimo (velocity = 36)")
    dynamic_region("End")
end

function func_0036()    
    find_dynamic("^^fontMus", {184}, first_expression, "pianississimo (velocity = 23)")
    dynamic_region("End")
end

function func_0037()    
    find_dynamic("^^fontMus", {175}, first_expression, "pianissississimo (velocity = 10)")
    dynamic_region("End")
end

function func_0038()
    find_dynamic("^^fontMus", {234}, first_expression, "forte piano")
    dynamic_region("End")
end

function func_0039()
    find_dynamic("^^fontMus", {90}, first_expression, "forzando")
    dynamic_region("End")
end

function func_0040()
    findSpecialExpression({150}, {"Maestro", 8191, 24, 0}, first_expression, "niente (velocity = 0)", 1)
    dynamic_region("End")
end

function func_0041()
    find_dynamic("^^fontMus", {142, 102}, first_expression, "rinforte")
    dynamic_region("End")
end

function func_0042()
    find_dynamic("^^fontMus", {142, 90}, first_expression, "rinforzando")
    dynamic_region("End")
end

function func_0043()
    find_dynamic("^^fontMus", {83}, first_expression, "sforzando")
    dynamic_region("End")
end

function func_0044()
    find_dynamic("^^fontMus", {141}, first_expression, "sforzato")
    dynamic_region("End")
end

function func_0045()
    find_dynamic("^^fontMus", {130}, first_expression, "sforzato piano")
    dynamic_region("End")
end

function func_0046()
    find_dynamic("^^fontMus", {182}, first_expression, "sforzato pianissimo")
    dynamic_region("End")
end

function func_0047()
    find_dynamic("^^fontMus", {167}, first_expression, "sforzato")
    dynamic_region("End")
end

function func_0048()
    find_dynamic("^^fontMus", {167, 112}, first_expression, "sforzando piano")
    dynamic_region("End")
end

function func_0049()
    increaseDynamic()
end

function func_0050()
    decreaseDynamic()
end

function func_0100()
    findArticulation(1, 62, "")
    if full_art_table[1] == 0 then
        createArticulation(1, 62, "Maestro", 62, true, true, false, false, 1, false, 62, false, 0, 0, 125, true, false, false, 14, false, 0, -4, 0, -25, 62, "Maestro", false, false, true, 0, 0, 125, true, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[1])
    end
end

function func_0101()
    findArticulation(2, 94, "")
    if full_art_table[2] == 0 then
        createArticulation(2, 94, "Maestro", 94, true, true, false, false, 5, false, 118, false, 0, 0, 140, true, false, false, 16, false, 0, -4, 0, -18, 118, "Maestro", false, false, true, 0, 0, 140, true, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[2])
    end
end

function func_0102()
    findArticulation(3, 46, "")
    if full_art_table[3] == 0 then
        createArticulation(3, 46, "Maestro", 46, true, false, false, false, 1, true, 46, false, 0, 40, 0, true, false, false, 16, true, 0, -3, 0, -3, 46, "Maestro", true, false, true, 0, 40, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[3])
    end
end

function func_0103()
    findArticulation(4, 45, "")
    if full_art_table[4] == 0 then
        createArticulation(4, 45, "Maestro", 45, true, false, false, false, 1, true, 45, false, 0, 0, 0, true, false, false, 14, false, 0, -3, 0, -3, 45, "Maestro", true, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 26, 26, false, false, false, false, 0, false, false, "Maestro", 26, 26, false, false)
    else
        addArticulation(full_art_table[4])
    end
end

function func_0104()
    findArticulation(5, 171, "")
    if full_art_table[5] == 0 then
        createArticulation(5, 171, "Maestro", 171, true, true, false, false, 1, true, 216, false, 0, 30, 0, true, false, false, 12, true, 0, 12, 0, -22, 216, "Maestro", false, false, true, 0, 30, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[5])
    end
end

function func_0105()
    findArticulation(6, 174, "")
    if full_art_table[6] == 0 then
        createArticulation(6, 174, "Maestro", 174, true, true, false, false, 1, true, 39, false, 0, 30, 0, true, false, false, 12, true, 0, 12, 0, -22, 39, "Maestro", false, false, true, 0, 30, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[6])
    end
end

function func_0106()
    findArticulation(7, 33, "")
    if full_art_table[7] == 0 then
        createArticulation(7, 33, "Maestro", 33, true, false, false, false, 0, false, 33, false, 0, 0, 0, true, false, false, 21, false, 0, 0, 0, 0, 33, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        findArticulation(8, 64, "")
        deleteArticulation(full_art_table[8])
        findArticulation(9, 190, "")
        deleteArticulation(full_art_table[9])
        addArticulation(full_art_table[7])
    end
end

function func_0107()
    findArticulation(8, 64, "")
    if full_art_table[8] == 0 then
        createArticulation(8, 64, "Maestro", 64, true, false, false, false, 0, false, 64, false, 0, 0, 0, true, false, false, 12, false, 0, 0, 0, 0, 64, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        findArticulation(7, 33, "")
        deleteArticulation(full_art_table[7])
        findArticulation(9, 190, "")
        deleteArticulation(full_art_table[9])
        addArticulation(full_art_table[8])
    end
end

function func_0108()
    findArticulation(9, 190, "")
    if full_art_table[9] == 0 then
        createArticulation(9, 190, "Maestro", 190, true, false, false, false, 0, false, 190, false, 0, 0, 0, true, false, false, 11, false, 0, 0, 0, 0, 190, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        findArticulation(7, 33, "")
        deleteArticulation(full_art_table[7])
        findArticulation(8, 64, "")
        deleteArticulation(full_art_table[8])
        addArticulation(full_art_table[9])
    end
end

function func_0109()
    findArticulation(10, 85, "")
    if full_art_table[10] == 0 then
        createArticulation(10, 85, "Maestro", 85, true, true, false, false, 5, false, 117, false, 0, 0, 0, true, false, false, 14, false, 0, 0, 0, 0, 117, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 22, 22, false, false, false, false, 0, false, false, "Maestro", 22, 22, false, false)
    else
        addArticulation(full_art_table[10])
    end
end

function func_0110()
    findArticulation(11, 43, "")
    if full_art_table[11] == 0 then
        createArticulation(11, 43, "Maestro", 43, true, true, false, false, 5, true, 43, false, 0, 0, 0, true, false, false, 12, false, 0, 12, 0, -12, 43, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[11])
    end
end

function func_0111()
    findArticulation(12, 111, "")
    if full_art_table[12] == 0 then
        createArticulation(12, 111, "Maestro", 111, true, true, false, false, 5, true, 111, false, 0, 0, 0, true, false, false, 14, false, 0, 8, 0, 0, 111, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[12])
    end
end

function func_0112()
    findArticulation(13, 178, "")
    if full_art_table[13] == 0 then
        createArticulation(13, 178, "Maestro", 178, true, true, false, false, 5, false, 178, true, 0, 0, 0, true, false, false, 12, false, 0, 0, 0, 0, 178, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[13])
    end
end

function func_0113()
    findArticulation(14, 179, "")
    if full_art_table[14] == 0 then
        createArticulation(14, 179, "Maestro", 179, true, true, false, false, 5, false, 179, true, 0, 0, 0, true, false, false, 12, false, 0, 0, 0, 0, 179, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[14])
    end
end

function func_0114()
    findArticulation(15, 217, "")
    if full_art_table[15] == 0 then
        createArticulation(15, 217, "Maestro", 217, true, true, false, false, 5, true, 217, false, 0, 0, 0, true, false, false, 14, false, 3, 12, -3, -20, 217, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[15])
    end
end

function func_0115()
    findArticulation(16, 109, "")
    if full_art_table[16] == 0 then
        createArticulation(16, 109, "Maestro", 109, true, true, false, false, 5, true, 109, false, 0, 0, 0, true, false, false, 12, false, 0, 0, 0, -28, 109, "Maestro", true, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[16])
    end
end

function func_0116()
    findArticulation(17, 77, "")
    if full_art_table[17] == 0 then
        createArticulation(17, 77, "Maestro", 77, true, true, false, false, 5, true, 77, false, 0, 0, 0, true, false, false, 16, false, 0, 4, 0, -28, 77, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[17])
    end
end

function func_0117()
    findArticulation(18, 84, "")
    if full_art_table[18] == 0 then
        createArticulation(18, 84, "Maestro", 84, true, true, false, false, 5, true, 84, false, 0, 0, 0, true, false, false, 12, false, 0, 18, 0, -18, 84, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[18])
    end
end

function func_0118()
    findArticulation(19, 103, "")
    if full_art_table[19] == 0 then
        createArticulation(19, 103, "Maestro", 103, true, false, false, false, 0, false, 103, true, -256, 0, 0, false, true, false, 0, false, -28, -28, -22, 0, 103, "Maestro", false, false, true, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[19])
    end
end

function func_0119()
    findArticulation(20, 152, "Broadway Copyist")
    if full_art_table[20] == 0 then
        createArticulation(20, 152, "Broadway Copyist", 152, true, false, false, false, 2, false, 152, false, 0, 0, 0, true, false, false, 0, false, 36, -30, 36, 0, 152, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 20, 20, false, false, false, false, 0, false, false, "Broadway Copyist", 20, 20, false, false)
    else
        addArticulation(full_art_table[20])
    end
end

function func_0120()
    findArticulation(21, 92, "Broadway Copyist")
    if full_art_table[21] == 0 then
        createArticulation(21, 92, "Broadway Copyist", 92, true, false, false, false, 2, false, 92, false, 0, 0, 0, true, false, false, 0, false, 54, -54, 54, -30, 92, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 24, 24, false, false, false, false, 0, false, false, "Broadway Copyist", 24, 24, false, false)
    else
        addArticulation(full_art_table[21])
    end
end

function func_0121()
    findArticulation(22, 151, "Broadway Copyist")
    if full_art_table[22] == 0 then
        createArticulation(22, 151, "Broadway Copyist", 151, true, false, false, false, 2, false, 151, false, 0, 0, 0, true, false, false, 0, false, -48, -36, -48, -6, 151, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 18, 18, false, false, false, false, 0, false, false, "Broadway Copyist", 18, 18, false, false)
    else
        addArticulation(full_art_table[22])
    end
end

function func_0122()
    findArticulation(23, 149, "Broadway Copyist")
    if full_art_table[23] == 0 then
        createArticulation(23, 149, "Broadway Copyist", 149, true, false, false, false, 2, false, 149, false, 0, 0, 0, true, false, false, 0, false, -54, -36, -54, -12, 149, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 18, 18, false, false, false, false, 0, false, false, "Broadway Copyist", 18, 18, false, false)
    else
        addArticulation(full_art_table[23])
    end
end

function func_0123()
    findArticulation(24, 155, "Broadway Copyist")
    if full_art_table[24] == 0 then
        createArticulation(24, 155, "Broadway Copyist", 155, true, false, false, false, 2, false, 155, false, 0, 0, 0, true, false, false, 0, false, -36, -24, -36, 0, 155, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 18, 18, false, false, false, false, 0, false, false, "Broadway Copyist", 18, 18, false, false)
    else
        addArticulation(full_art_table[24])
    end
end

function func_0124()
    findArticulation(25, 243, "Broadway Copyist")
    if full_art_table[25] == 0 then
        createArticulation(25, 243, "Broadway Copyist", 243, true, false, false, false, 2, false, 243, false, 0, 0, 0, true, false, false, 0, false, 42, 6, 42, 30, 243, "Broadway Copyist", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Broadway Copyist", 20, 20, false, false, false, false, 0, false, false, "Broadway Copyist", 20, 20, false, false)
    else
        addArticulation(full_art_table[25])
    end
end

function func_0125()
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

function func_0126()
    for noteentry in eachentrysaved(finenv.Region()) do
        local a = finale.FCArticulation()
        a:SetNoteEntry(noteentry)
        while a:LoadFirst() do
            a:DeleteData()
        end
    end
end

function func_0127()
    local font_name = getUsedFontName("Engraver Font Set")
    findArticulation(26, 105, font_name)
    if full_art_table[26] == 0 then
        createArticulation(26, 105, font_name, 105, true, false, false, false, 2, true, 73, false, 0, 0, 0, true, false, false, 0, false, 39, -6, 39, 7, 73, font_name, false, false, false, 0, 0, 0, false, false, false, 0, false, false, font_name, 28, 28, false, false, false, false, 0, false, false, font_name, 28, 28, false, false)
    else
        addArticulation(full_art_table[26])
    end
end

function func_0128(noteentry)
    local font_name = getUsedFontName("Engraver Font Set")
    findArticulation(27, 193, font_name)
    if full_art_table[27] == 0 then
        createNewArticulation(27, 193, font_name, 193, true, false, false, false, 2, false, 193, false, 0, 0, 0, true, false, false, 0, false, -66, -12, -36, 24, 193, font_name, true, false, false, 0, 0, 0, false, false, false, 0, false, false, font_name, 24, 24, false, false, false, false, 0, false, false, font_name, 24, 24, false, false)
        assignNewArticulation(noteentry, full_art_table[27])
    else
        addNewArticulation(noteentry, full_art_table[27])
    end
end
            
function func_0129(noteentry)
    local font_name = getUsedFontName("Engraver Font Set")
    findArticulation(28, 170, font_name)
    if full_art_table[28] == 0 then
        createNewArticulation(28, 170, font_name, 170, true, false, false, false, 2, false, 170, false, 0, 0, 0, true, false, false, 0, false, -36, -12, -36, 42, 170, font_name, false, false, false, 0, 0, 0, false, false, false, 0, false, false, font_name, 24, 24, false, false, false, false, 0, false, false, font_name, 24, 24, false, false)
        assignNewArticulation(noteentry, full_art_table[28])
    else
        addNewArticulation(noteentry, full_art_table[28])
    end
end

function func_0130(noteentry)
    local font_name = getUsedFontName("Engraver Font Set")
    findArticulation(29, 163, font_name)
    if full_art_table[29] == 0 then
        createNewArticulation(29, 163, font_name, 163, true, false, false, false, 2, false, 163, false, 0, 0, 0, true, false, false, 0, false, -36, -18, -36, 66, 163, font_name, false, false, false, 0, 0, 0, false, false, false, 0, false, false, font_name, 24, 24, false, false, false, false, 0, false, false, font_name, 24, 24, false, false)
        assignNewArticulation(noteentry, full_art_table[29])
    else
        addNewArticulation(noteentry, full_art_table[29])
    end
end

function func_0131(noteentry)
    local font_name = getUsedFontName("Engraver Font Set")
    findArticulation(30, 162, font_name)
    if full_art_table[30] == 0 then
        createNewArticulation(30, 162, font_name, 162, true, false, false, false, 2, false, 162, false, 0, 0, 0, true, false, false, 0, false, -36, -18, -36, 90, 162, font_name, false, false, false, 0, 0, 0, false, false, false, 0, false, false, font_name, 24, 24, false, false, false, false, 0, false, false, font_name, 24, 24, false, false)
        assignNewArticulation(noteentry, full_art_table[30])
    else
        addNewArticulation(noteentry, full_art_table[30])
    end
end

function func_0132()
    for noteentry in eachentrysaved(finenv.Region()) do
        local note_range = noteentry:CalcDisplacementRange()
        if (note_range == 1) then
            func_0128(noteentry)
        end
        if (note_range == 2) or (note_range == 3) then
            func_0129(noteentry)
        end
        if (note_range == 4) or (note_range == 5) then
            func_0130(noteentry)
        end
        if (note_range == 6) or (note_range == 7) then
            func_0131(noteentry) 
        end
    end
end

function func_0133(noteentry)
    local font_name = getUsedFontName("Engraver Font Set")
    findArticulation(31, 176, font_name)
    if full_art_table[31] == 0 then
        createNewArticulation(31, 176, font_name, 176, true, false, false, false, 2, false, 176, false, 0, 0, 0, true, false, false, 0, false, 36, -12, 66, 24, 176, font_name, false, false, false, 0, 0, 0, false, false, false, 0, false, false, font_name, 24, 24, false, false, false, false, 0, false, false, font_name, 24, 24, false, false)
        assignNewArticulation(noteentry, full_art_table[31])
    else
        addNewArticulation(noteentry, full_art_table[31])
    end
end
            
function func_0134(noteentry)
    local font_name = getUsedFontName("Engraver Font Set")
    findArticulation(32, 164, font_name)
    if full_art_table[32] == 0 then
        createNewArticulation(32, 164, font_name, 164, true, false, false, false, 2, false, 164, false, 0, 0, 0, true, false, false, 0, false, 36, -12, 36, 42, 164, font_name, false, false, false, 0, 0, 0, false, false, false, 0, false, false, font_name, 24, 24, false, false, false, false, 0, false, false, font_name, 24, 24, false, false)
        assignNewArticulation(noteentry, full_art_table[32])
    else
        addNewArticulation(noteentry, full_art_table[32])
    end
end

function func_0135(noteentry)
    local font_name = getUsedFontName("Engraver Font Set")
    findArticulation(33, 166, font_name)
    if full_art_table[33] == 0 then
        createNewArticulation(33, 166, font_name, 166, true, false, false, false, 2, false, 166, false, 0, 0, 0, true, false, false, 0, false, 36, -18, 36, 66, 166, font_name, false, false, false, 0, 0, 0, false, false, false, 0, false, false, font_name, 24, 24, false, false, false, false, 0, false, false, font_name, 24, 24, false, false)
        assignNewArticulation(noteentry, full_art_table[33])
    else
        addNewArticulation(noteentry, full_art_table[33])
    end
end

function func_0136(noteentry)
    local font_name = getUsedFontName("Engraver Font Set")
    findArticulation(34, 165, font_name)
    if full_art_table[34] == 0 then
        createNewArticulation(34, 165, font_name, 165, true, false, false, false, 2, false, 165, false, 0, 0, 0, true, false, false, 0, false, 36, -18, 36, 90, 165, font_name, false, false, false, 0, 0, 0, false, false, false, 0, false, false, font_name, 24, 24, false, false, false, false, 0, false, false, font_name, 24, 24, false, false)
        assignNewArticulation(noteentry, full_art_table[34])
    else
        addNewArticulation(noteentry, full_art_table[34])
    end
end

function func_0137()
    for noteentry in eachentrysaved(finenv.Region()) do
        local note_range = noteentry:CalcDisplacementRange()
        if (note_range == 1) then
            func_0133(noteentry)
        end
        if (note_range == 2) or (note_range == 3) then
            func_0134(noteentry)
        end
        if (note_range == 4) or (note_range == 5) then
            func_0135(noteentry)
        end
        if (note_range == 6) or (note_range == 7) then
            func_0136(noteentry) 
        end
    end
end

function func_0200()
    changeNoteheads("Maestro Percussion", 120, 88, 88, 88)
end

function func_0201()
    changeNoteheads("Maestro Percussion", 122, 90, 90, 90)
end

function func_0202()
    changeNoteheads("Maestro Percussion", 49, 33, 33, 33)
end

function func_0203()
    changeNoteheads("Maestro Percussion", 45, 95, 95, 95)
end

function func_0204()
    changeNoteheads("Maestro Percussion", 51, 35, 35, 35)
end

function func_0205()
    changeNoteheads("Maestro Percussion", 101, 69, 69, 69)
end

function func_0206()
    changeNoteheads("Maestro Percussion", 102, 70, 70, 70)
end

function func_0207()
    changeNoteheads("Maestro", 243, 124, 124, 218)
end

function func_0208()
    changeNoteheads("Maestro Percussion", 54, 94, 94, 94)
end

function func_0209()
    changeNoteheads("Maestro Percussion", 104, 72, 72, 72)
end

function func_0210()
    changeNoteheads("Maestro", 32, 32, 32, 32)
end

function func_0211()
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

function func_0212()
    for noteentry in eachentrysaved(finenv.Region()) do
        if noteentry:IsRest() then
            print(noteentry:SetFloatingRest(true))
        end
    end
end

function func_0213()
    change_notehead_size(1, 75, nil)
end

function func_0214()
    change_notehead_size(2, 75, nil)
end

function func_0215()
    change_notehead_size(3, 75, nil)
end

function func_0216()
    change_notehead_size(4, 75, nil)
end

function func_0217()
    change_notehead_size(1, 75, true)
end

function func_0218()
    change_notehead_size(2, 75, true)
end

function func_0219()
    change_notehead_size(3, 75, true)
end

function func_0220()
    change_notehead_size(4, 75, true)
end

function func_0221()
    change_notehead_size(1, 75, false)
end

function func_0222()
    change_notehead_size(2, 75, false)
end

function func_0223()
    change_notehead_size(3, 75, false)
end

function func_0224()
    change_notehead_size(4, 75, false)
end

function func_0225()
    change_notehead_size(1, 100, nil)
    change_notehead_size(2, 100, nil)
    change_notehead_size(3, 100, nil)
    change_notehead_size(4, 100, nil)
end

function func_0226()
    change_notehead_size(1, 75, nil)
    change_notehead_size(2, 75, nil)
    change_notehead_size(3, 75, nil)
    change_notehead_size(4, 75, nil)
end

function func_0300()
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

function func_0400()
    barline_change(0, false)
end

function func_0401()
    barline_change(1, false)
end

function func_0402()
    barline_change(2, false)
end

function func_0403()
    barline_change(3, false)
end

function func_0404()
    barline_change(4, false)
end

function func_0405()
    barline_change(5, false)
end

function func_0406()
    barline_change(6, false)
end

function func_0407()
    barline_change(7, false)
end

function func_0408()
    barline_change(0, true)
end

function func_0409()
    barline_change(1, true)
end

function func_0410()
    barline_change(2, true)
end

function func_0411()
    barline_change(3, true)
end

function func_0412()
    barline_change(4, true)
end

function func_0413()
    barline_change(5, true)
end

function func_0414()
    barline_change(6, true)
end

function func_0415()
    barline_change(7, true)
end

function func_0416()
    local measures = finale.FCMeasures()
    measures:LoadRegion(finenv.Region())
    for measure in each(measures) do
        measure.Barline = 1
        measure:Save()
    end    
end

function func_0417()
    find_double_barlines("Letter")
end

function func_0418()
    find_double_barlines("Number")
end

function func_0419()
    find_double_barlines("Measure")
end

function func_0420()
    delete_rehearsal_marks()
end

function func_0500()
    alter_bass(0)
end

function func_0501()
    alter_bass(1)
end

function func_0502()
    alter_bass(2)
end

function func_0503()
    local chords = finale.FCChords()
    chords:LoadAllForRegion(finenv.Region())
    for c in each(chords) do
        c:SetChordVerticalPos(0)
        c:SetChordHorizontalPos(0)
        c:Save()
    end
end

function func_0550()
   set_time(2, 1024) 
end

function func_0551()
    set_time(2, 2048) 
end

function func_0552()
    set_time(3, 2048) 
end

function func_0553()
    set_time(3, 1024) 
end

function func_0554()
    set_time(1, 1536) 
end

function func_0555()
    set_time(4, 1024) 
end

function func_0556()
    set_time(5, 1024) 
end

function func_0557()
    set_time(5, 512) 
end

function func_0558()
    set_time(2, 1536) 
end

function func_0559()
    set_time(7, 512) 
end

function func_0560()
    set_time(3, 1536) 
end

function func_0561()
    set_time(4, 1536) 
end

function func_0562()
    set_time(6, 1024) 
end

function func_0600()
    deleteBeatSmartShape(finale.SMARTSHAPE_TRILL)
    createBeatBasedSL(finale.SMARTSHAPE_TRILL)
end

function func_0601()
    deleteBeatSmartShape(finale.SMARTSHAPE_TRILLEXT)
    createBeatBasedSL(finale.SMARTSHAPE_TRILLEXT)
end

function func_0602()
    deleteBeatSmartShape(finale.SMARTSHAPE_DASHLINE)
    createBeatBasedSL(finale.SMARTSHAPE_DASHLINE)
end

function func_0603()
    deleteBeatSmartShape(finale.SMARTSHAPE_SOLIDLINE)
    createBeatBasedSL(finale.SMARTSHAPE_SOLIDLINE)
end

function func_0604()
    deleteEntrySmartShape(finale.SMARTSHAPE_TABSLIDE)
    setFirstLastNoteRangeEntry(finale.SMARTSHAPE_TABSLIDE)
end

function func_0605()
    deleteEntrySmartShape(finale.SMARTSHAPE_GLISSANDO)
    setFirstLastNoteRangeEntry(finale.SMARTSHAPE_GLISSANDO)
end

function func_0606()
    deleteBeatSmartShape(finale.SMARTSHAPE_DASHLINEDOWN)
    createBeatBasedSL(finale.SMARTSHAPE_DASHLINEDOWN)
end

function func_0607()
    deleteBeatSmartShape(finale.SMARTSHAPE_SOLIDLINEDOWN)
    createBeatBasedSL(finale.SMARTSHAPE_SOLIDLINEDOWN)
end

function func_0608()
    deleteBeatSmartShape(finale.SMARTSHAPE_CUSTOM)
    createBeatBasedSL(finale.SMARTSHAPE_CUSTOM)
end

function func_0609()
    deleteEntrySmartShape(finale.SMARTSHAPE_SLURAUTO)
    setFirstLastNoteRangeEntry(finale.SMARTSHAPE_SLURAUTO)
end

function func_0610()
    deleteEntrySmartShape(finale.SMARTSHAPE_DASHEDSLURAUTO)
    setFirstLastNoteRangeEntry(finale.SMARTSHAPE_DASHEDSLURAUTO)
end

function func_0611()
    deleteBeatSmartShape(finale.SMARTSHAPE_DASHLINEDOWN2)
    createBeatBasedSL(finale.SMARTSHAPE_DASHLINEDOWN2)
end

function func_0612()
    deleteBeatSmartShape(finale.SMARTSHAPE_SOLIDLINEDOWN2)
    createBeatBasedSL(finale.SMARTSHAPE_SOLIDLINEDOWN2)
end

function func_0612()
    deleteBeatSmartShape(finale.SMARTSHAPE_SOLIDLINEDOWN2)
    createBeatBasedSL(finale.SMARTSHAPE_SOLIDLINEDOWN2)
end

function func_0613()
    deleteBeatSmartShape(finale.SMARTSHAPE_OCTAVEUP)
    createBeatBasedSL(finale.SMARTSHAPE_OCTAVEUP)
end

function func_0614()
    deleteBeatSmartShape(finale.SMARTSHAPE_TWOOCTAVEUP)
    createBeatBasedSL(finale.SMARTSHAPE_TWOOCTAVEUP)
end

function func_0615()
    deleteBeatSmartShape(finale.SMARTSHAPE_OCTAVEDOWN)
    createBeatBasedSL(finale.SMARTSHAPE_OCTAVEDOWN)
end

function func_0616()
    deleteBeatSmartShape(finale.SMARTSHAPE_TWOOCTAVEDOWN)
    createBeatBasedSL(finale.SMARTSHAPE_TWOOCTAVEDOWN)
end

function func_0700()
    applyStaffStyle("Slash Notation")
end

function func_0701()
    applyStaffStyle("Rythmic Notation")
end

function func_0702()
    applyStaffStyle("Blank Notation: Layer 1")
end

function func_0703()
    applyStaffStyle("Blank Notation with Rests: Layer 1")
end

function func_0704()
    applyStaffStyle("Blank Notation: Layer 4")
end

function func_0705()
    applyStaffStyle("Blank Notation with Rests: Layer 4")
end

function func_0706()
    applyStaffStyle("Blank Notation: All Layers")
end

function func_0707()
    applyStaffStyle("One Bar Repeat")
end

function func_0708()
    applyStaffStyle("Two Bar Repeat")
end

function func_0709()
    applyStaffStyle("Stemless Notes")
end

function func_0710()
    applyStaffStyle("Cutaway")
end

function func_0711()
    applyStaffStyle("Collapse")
end

function func_0800()
    findTextExpression({"cresc."}, text_expression, "crescendo", 4, 2)
    getFirstNoteInRegionText("Start")
end

function func_0801()
    findTextExpression({"dim."}, text_expression, "diminuendo", 4, 2)
    getFirstNoteInRegionText("Start")
end

function func_0802()
    findTextExpression({"espr."}, text_expression, "espressivo", 4, 2)
    getFirstNoteInRegionText("Start")
end

function func_0803()
    findTextExpression({"poco"}, text_expression, "poco", 4, 2)
    getFirstNoteInRegionText("Start")
end

function func_0804()
    findTextExpression({"poco a poco"}, text_expression, "poco a poco", 4, 2)
    getFirstNoteInRegionText("Start")
end

function func_0805()
    findTextExpression({"molto"}, text_expression, "molto", 4, 2)
    getFirstNoteInRegionText("Start")
end

function func_0806()
    findTextExpression({"più", 102}, text_expression, "piu forte", 1, 2)
    getFirstNoteInRegionText("Start")
end

function func_0807()
    findTextExpression({185, "sub."}, text_expression, "pianissimo subito", 1, 2)
    getFirstNoteInRegionText("Start")
end

function func_0808()
    findTextExpression({112, "sub."}, text_expression, "piano subito", 1, 2)
    getFirstNoteInRegionText("Start")
end

function func_0809()
    findTextExpression({80, "sub."}, text_expression, "mezzo piano subito", 1, 2)
    getFirstNoteInRegionText("Start")
end

function func_0810()
    findTextExpression({70, "sub."}, text_expression, "mezzo forte subito", 1, 2)
    getFirstNoteInRegionText("Start")
end

function func_0811()
    findTextExpression({102, "sub."}, text_expression, "forte subito", 1, 2)
    getFirstNoteInRegionText("Start")
end

function func_0812()
    findTextExpression({196, "sub."}, text_expression, "fortissimo subito", 1, 2)
    getFirstNoteInRegionText("Start")
end

function func_0813()
    findTextExpression({"solo"}, text_expression, "solo", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0814()
    findTextExpression({"unis."}, text_expression, "unis", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0815()
    findTextExpression({"tutti"}, text_expression, "tutti", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0816()
    findTextExpression({"loco"}, text_expression, "loco", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0817()
    findSpecialExpression({44}, {"Maestro", 8191, 24, 0}, text_expression, "Breath Mark", 5)
    getFirstNoteInRegionText("End")
end

function func_0818()
    findSpecialExpression({34}, {"Maestro", 8191, 24, 0}, text_expression, "Caesura", 5)
    getFirstNoteInRegionText("Region End")
end

function func_0819()
    findSpecialExpression({59}, {"Broadway Copyist", 8191, 24, 0}, text_expression, "Eyeglasses (WATCH!)", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0820()
    findTextExpression({"mute"}, text_expression, "mute", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0821()
    findTextExpression({"open"}, text_expression, "open", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0822()
    findTextExpression({"Cup Mute"}, text_expression, "Cup Mute", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0823()
    findTextExpression({"Straight Mute"}, text_expression, "Straight Mute", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0824()
    findTextExpression({"1°"}, text_expression, "1°", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0825()
    findTextExpression({"2°"}, text_expression, "2°", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0826()
    findTextExpression({"a2"}, text_expression, "a2", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0827()
    findTextExpression({"a3"}, text_expression, "a3", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0828()
    findTextExpression({"a4"}, text_expression, "a4", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0829()
    findTextExpression({"arco"}, text_expression, "arco", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0830()
    findTextExpression({"pizz%."}, text_expression, "pizz.", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0831()
    findTextExpression({"spicc%."}, text_expression, "spicc.", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0832()
    findTextExpression({"col legno"}, text_expression, "col legno", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0833()
    findTextExpression({"con sord%."}, text_expression, "con sord", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0834()
    findTextExpression({"ord%."}, text_expression, "ord.", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0835()
    findTextExpression({"sul pont%."}, text_expression, "sul pont.", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0836()
    findTextExpression({"sul tasto"}, text_expression, "sul tasto", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0837()
    findTextExpression({"senza sord%."}, text_expression, "senza sord.", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0838()
    findTextExpression({"trem%."}, text_expression, "trem.", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0839()
    findTextExpression({"½ pizz%. ½ arco"}, text_expression, "half pizz. half arco", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0840()
    findTextExpression({"½ trem%. ½ ord%."}, text_expression, "half trem. half ord.", 5, 0)
    getFirstNoteInRegionText("Region Start")
end

function func_0841()
    findSpecialExpression({100}, {"Finale Percussion", 8191, 24, 0}, text_expression, "Bass Drum, hard", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0842()
    findSpecialExpression({115}, {"Finale Percussion", 8191, 24, 0}, text_expression, "Bass Drum, medium", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0843()
    findSpecialExpression({97}, {"Finale Percussion", 8191, 24, 0}, text_expression, "Bass Drum, soft", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0844()
    findSpecialExpression({106}, {"Finale Percussion", 8191, 24, 0}, text_expression, "Brass Mallet", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0845()
    findSpecialExpression({103}, {"Finale Percussion", 8191, 24, 0}, text_expression, "Sticks", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0846()
    findSpecialExpression({101}, {"Finale Percussion", 8191, 24, 0}, text_expression, "Timpani Mallet, hard", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0847()
    findSpecialExpression({119}, {"Finale Percussion", 8191, 24, 0}, text_expression, "Timpani Mallet, medium", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0848()
    findSpecialExpression({113}, {"Finale Percussion", 8191, 24, 0}, text_expression, "Timpani Mallet, soft", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0849()
    findSpecialExpression({114}, {"Finale Percussion", 8191, 24, 0}, text_expression, "Timpani Mallet, wood", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0850()
    findSpecialExpression({117}, {"Finale Percussion", 8191, 24, 0}, text_expression, "Xylophone, hard", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0851()
    findSpecialExpression({121}, {"Finale Percussion", 8191, 24, 0}, text_expression, "Xylophone, medium", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0852()
    findSpecialExpression({116}, {"Finale Percussion", 8191, 24, 0}, text_expression, "Xylophone, soft", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0853()
    findSpecialExpression({112}, {"Finale Percussion", 8191, 24, 0}, text_expression, "Yarn Mallet, medium", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0854()
    findSpecialExpression({111}, {"Finale Percussion", 8191, 24, 0}, text_expression, "Yarn Mallet, soft", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0900()
    tuplet_options({"Placement Manual"})
end

function func_0901()
    tuplet_options({"Placement Stem"})
end

function func_0902()
    tuplet_options({"Placement Note"})
end

function func_0903()
    tuplet_options({"Placement Above"}) 
end

function func_0904()
    tuplet_options({"Placement Below"}) 
end

function func_0905()
    for noteentry in eachentry(finenv.Region()) do
        local t = finale.FCTuplet()
        t:SetNoteEntry(noteentry)
        if t:LoadFirst() then
            if t:GetPlacementMode() == 1 then
                t:SetPlacementMode(2)
            elseif t:GetPlacementMode() == 2 then
                t:SetPlacementMode(1)
            elseif t:GetPlacementMode() == 3 then
                t:SetPlacementMode(4)
            elseif t:GetPlacementMode() == 4 then
                t:SetPlacementMode(3)
            elseif t:GetPlacementMode() == 0 then
                finenv.UI():AlertInfo("There is a tuplet with the placement style of \"Manual\" in this region. This will be changed to Stem/Beam side.", nil)
                t:SetPlacementMode(1)
            end
            t:Save()
        end
    end  
end

function func_0906()
    tuplet_options({"Always Flat On"})
end

function func_0907()
    tuplet_options({"Always Flat Off"}) 
end

function func_0908()
    tuplet_options({"Avoid Staff On"})
end

function func_0909()
    tuplet_options({"Avoid Staff Off"}) 
end

function func_0910()
    tuplet_options({"Bracket Always"})
end

function func_0911()
    tuplet_options({"Bracket Unbeamed"}) 
end

function func_0912()
    tuplet_options({"Bracket Never Beamed"})
end

function func_0913()
    tuplet_options({"Increase Space"})
end

function func_0914()
    tuplet_options({"Decrease Space"})
end

function func_0915()
    tuplet_options({"Increase Bracket"})
end

function func_0916()
    tuplet_options({"Decrease Bracket"})
end

function func_0917()
    tuplet_options({"Shape None"})
end

function func_0918()
    tuplet_options({"Shape Bracket"})
end

function func_0919()
    tuplet_options({"Shape Slur"})
end

function func_0920()
    tuplet_options({"Number None"})
end

function func_0921()
    tuplet_options({"Number Regular"})
end

function func_0922()
    tuplet_options({"Number Ratio"})
end

function func_0923()
    tuplet_options({"Number Ratio Last"})
end

function func_0924()
    tuplet_options({"Number Ration Both"})
end

function func_0925()
    tuplet_options({"Number None", "Shape None"}) 
end

function func_0926()
    tuplet_options({"Placement Stem", "Number Regular", "Bracket Never Beamed", "Avoid Staff Off", "Allow Horizontal Drag On"})
end

function func_8000()
    playback_type("Document", "Document", "Document") 
end

function func_8001()
    solo_staves()
    playback_type("Document", "Document") 
end

function func_8002()
    unmute_staves()
    playback_type("Document", "Region") 
end

function func_8003()
    solo_staves()
    playback_type("Document", "Region") 
end

function func_8004()
    unmute_staves()
    playback_type("Region", "Document") 
end

function func_8005()
    solo_staves()
    playback_type("Region", "Document") 
end

function func_8006()
    unmute_staves()
    playback_type("Region", "Region") 
end

function func_8007()
    playback_type("Region", "Region", "Region") 
end

function func_9000()
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

function func_9001()
    local count = 1
    for noteentry in eachentrysaved(finenv.Region()) do
        local nextentry = noteentry:Next()
        if count == 1 then 
                noteentry:SetBeamBeat(true)
        else 
            noteentry:SetBeamBeat(false)
            if  nextentry then
                nextentry:SetBeamBeat(true)
            end
        end
        count = count + 1
    end
end

function func_9002()
    measureWidth("Increase")
end

function func_9003()
    measureWidth("Decrease")
end

function func_9004()
    move_markers("Clef Center")
end

function func_9005()
    staff_spacing_adjust(24)
end

function func_9006()
    staff_spacing_adjust(-24)
end

function func_9007()
    swap_layers(1, 2)
end

function func_9008()
    swap_layers(1, 3)
end

function func_9009()
    swap_layers(1, 4)
end

function func_9010()
    swap_layers(2, 3)
end

function func_9011()
    swap_layers(2, 4)
end

function func_9012()
    swap_layers(3, 4)
end

function func_9013()
    swap_layers(1, 3)
    swap_layers(2, 4)
end

function func_9014()
    swap_layers(1, 2)
    swap_layers(3, 4)
end

function func_9015()
    clear_Layer(1)
end

function func_9016()
    clear_Layer(2)
end

function func_9017()
    clear_Layer(3)
end

function func_9018()
    clear_Layer(4)
end

function func_9019()
    clear_Layer(1)
    clear_Layer(2)
end

function func_9020()
    clear_Layer(1)
    clear_Layer(3)
end

function func_9021()
    clear_Layer(1)
    clear_Layer(4)
end

function func_9022()
    clear_Layer(1)
    clear_Layer(2)
    clear_Layer(3)
end

function func_9023()
    clear_Layer(1)
    clear_Layer(3)
    clear_Layer(4)
end

function func_9024()
    clear_Layer(2)
    clear_Layer(3)
end

function func_9025()
    clear_Layer(2)
    clear_Layer(4)
end

function func_9026()
    clear_Layer(2)
    clear_Layer(3)
    clear_Layer(4)
end

function func_9027()
    clear_Layer(3)
    clear_Layer(4)
end

function func_9028()
    user_expression_input("Expressive")
end

function func_9029()
    user_expression_input("Technique")
end

function func_9030()
    user_expression_input("Tempo")
end

dialog:SetTypes("String")
dialog:SetDescriptions("Enter a JetStream Finale Controller code:")

local returnvalues = dialog:Execute() 

if returnvalues ~= nil then
    if finenv.Region():GetStartMeasure() > 0 then
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
        if returnvalues[1] == "0127" then
            func_0127()
        end
        if returnvalues[1] == "0132" then
            func_0132()
        end
        if returnvalues[1] == "0137" then
            func_0137()
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
        if returnvalues[1] == "0212" then
            func_0212()
        end
        if returnvalues[1] == "0213" then
            func_0213()
        end
        if returnvalues[1] == "0214" then
            func_0214()
        end
        if returnvalues[1] == "0215" then
            func_0215()
        end
        if returnvalues[1] == "0216" then
            func_0216()
        end
        if returnvalues[1] == "0217" then
            func_0217()
        end
        if returnvalues[1] == "0218" then
            func_0218()
        end
        if returnvalues[1] == "0219" then
            func_0219()
        end
        if returnvalues[1] == "0220" then
            func_0220()
        end
        if returnvalues[1] == "0221" then
            func_0221()
        end
        if returnvalues[1] == "0222" then
            func_0222()
        end
        if returnvalues[1] == "0223" then
            func_0223()
        end
        if returnvalues[1] == "0224" then
            func_0224()
        end
        if returnvalues[1] == "0225" then
            func_0225()
        end
        if returnvalues[1] == "0226" then
            func_0226()
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
        if returnvalues[1] == "0503" then
            func_0503()
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
        if returnvalues[1] == "0562" then
            func_0562()
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
        if returnvalues[1] == "0800" then
            func_0800()
        end
        if returnvalues[1] == "0801" then
            func_0801()
        end
        if returnvalues[1] == "0802" then
            func_0802()
        end
        if returnvalues[1] == "0803" then
            func_0803()
        end
        if returnvalues[1] == "0804" then
            func_0804()
        end
        if returnvalues[1] == "0805" then
            func_0805()
        end
        if returnvalues[1] == "0806" then
            func_0806()
        end
        if returnvalues[1] == "0807" then
            func_0807()
        end
        if returnvalues[1] == "0808" then
            func_0808()
        end
        if returnvalues[1] == "0809" then
            func_0809()
        end
        if returnvalues[1] == "0810" then
            func_0810()
        end
        if returnvalues[1] == "0811" then
            func_0811()
        end
        if returnvalues[1] == "0812" then
            func_0812()
        end
        if returnvalues[1] == "0813" then
            func_0813()
        end
        if returnvalues[1] == "0814" then
            func_0814()
        end
        if returnvalues[1] == "0815" then
            func_0815()
        end
        if returnvalues[1] == "0816" then
            func_0816()
        end
        if returnvalues[1] == "0817" then
            func_0817()
        end
        if returnvalues[1] == "0818" then
            func_0818()
        end
        if returnvalues[1] == "0819" then
            func_0819()
        end
        if returnvalues[1] == "0820" then
            func_0820()
        end
        if returnvalues[1] == "0821" then
            func_0821()
        end
        if returnvalues[1] == "0822" then
            func_0822()
        end
        if returnvalues[1] == "0823" then
            func_0823()
        end
        if returnvalues[1] == "0824" then
            func_0824()
        end
        if returnvalues[1] == "0825" then
            func_0825()
        end
        if returnvalues[1] == "0826" then
            func_0826()
        end
        if returnvalues[1] == "0827" then
            func_0827()
        end
        if returnvalues[1] == "0828" then
            func_0828()
        end
        if returnvalues[1] == "0829" then
            func_0829()
        end
        if returnvalues[1] == "0830" then
            func_0830()
        end
        if returnvalues[1] == "0831" then
            func_0831()
        end
        if returnvalues[1] == "0832" then
            func_0832()
        end
        if returnvalues[1] == "0833" then
            func_0833()
        end
        if returnvalues[1] == "0834" then
            func_0834()
        end
        if returnvalues[1] == "0835" then
            func_0835()
        end
        if returnvalues[1] == "0836" then
            func_0836()
        end
        if returnvalues[1] == "0837" then
            func_0837()
        end
        if returnvalues[1] == "0838" then
            func_0838()
        end
        if returnvalues[1] == "0839" then
            func_0839()
        end
        if returnvalues[1] == "0840" then
            func_0840()
        end
        if returnvalues[1] == "0841" then
            func_0841()
        end
        if returnvalues[1] == "0842" then
            func_0842()
        end
        if returnvalues[1] == "0843" then
            func_0843()
        end
        if returnvalues[1] == "0844" then
            func_0844()
        end
        if returnvalues[1] == "0845" then
            func_0845()
        end
        if returnvalues[1] == "0846" then
            func_0846()
        end
        if returnvalues[1] == "0847" then
            func_0847()
        end
        if returnvalues[1] == "0848" then
            func_0848()
        end
        if returnvalues[1] == "0849" then
            func_0849()
        end
        if returnvalues[1] == "0850" then
            func_0850()
        end
        if returnvalues[1] == "0851" then
            func_0851()
        end
        if returnvalues[1] == "0852" then
            func_0852()
        end
        if returnvalues[1] == "0853" then
            func_0853()
        end
        if returnvalues[1] == "0854" then
            func_0854()
        end
        if returnvalues[1] == "0900" then
            func_0900()
        end
        if returnvalues[1] == "0901" then
            func_0901()
        end
        if returnvalues[1] == "0902" then
            func_0902()
        end
        if returnvalues[1] == "0903" then
            func_0903()
        end
        if returnvalues[1] == "0904" then
            func_0904()
        end
        if returnvalues[1] == "0905" then
            func_0905()
        end
        if returnvalues[1] == "0906" then
            func_0906()
        end
        if returnvalues[1] == "0907" then
            func_0907()
        end
        if returnvalues[1] == "0908" then
            func_0908()
        end
        if returnvalues[1] == "0909" then
            func_0909()
        end
        if returnvalues[1] == "0910" then
            func_0910()
        end
        if returnvalues[1] == "0911" then
            func_0911()
        end
        if returnvalues[1] == "0912" then
            func_0912()
        end
        if returnvalues[1] == "0913" then
            func_0913()
        end
        if returnvalues[1] == "0914" then
            func_0914()
        end
        if returnvalues[1] == "0915" then
            func_0915()
        end
        if returnvalues[1] == "0916" then
            func_0916()
        end
        if returnvalues[1] == "0917" then
            func_0917()
        end
        if returnvalues[1] == "0918" then
            func_0918()
        end
        if returnvalues[1] == "0919" then
            func_0919()
        end
        if returnvalues[1] == "0920" then
            func_0920()
        end
        if returnvalues[1] == "0921" then
            func_0921()
        end
        if returnvalues[1] == "0922" then
            func_0922()
        end
        if returnvalues[1] == "0923" then
            func_0923()
        end
        if returnvalues[1] == "0924" then
            func_0924()
        end
        if returnvalues[1] == "0925" then
            func_0925()
        end
        if returnvalues[1] == "0926" then
            func_0926()
        end
        if returnvalues[1] == "9000" then
            func_9000()
        end
        if returnvalues[1] == "9001" then
            func_9001()
        end
        if returnvalues[1] == "9002" then
            func_9002()
        end
        if returnvalues[1] == "9003" then
            func_9003()
        end
        if returnvalues[1] == "8002" then
            func_8002()
        end
        if returnvalues[1] == "8003" then
            func_8003()
        end
        if returnvalues[1] == "8004" then
            func_8004()
        end
        if returnvalues[1] == "8005" then
            func_8005()
        end
        if returnvalues[1] == "8006" then
            func_8006()
        end
        if returnvalues[1] == "8007" then
            func_8007()
        end
        if returnvalues[1] == "9005" then
            func_9005()
        end
        if returnvalues[1] == "9006" then
            func_9006()
        end
        if returnvalues[1] == "9007" then
            func_9007()
        end
        if returnvalues[1] == "9008" then
            func_9008()
        end
        if returnvalues[1] == "9009" then
            func_9009()
        end
        if returnvalues[1] == "9010" then
            func_9010()
        end
        if returnvalues[1] == "9011" then
            func_9011()
        end
        if returnvalues[1] == "9012" then
            func_9012()
        end
        if returnvalues[1] == "9013" then
            func_9013()
        end
        if returnvalues[1] == "9014" then
            func_9014()
        end
        if returnvalues[1] == "9015" then
            func_9015()
        end
        if returnvalues[1] == "9016" then
            func_9016()
        end
        if returnvalues[1] == "9017" then
            func_9017()
        end
        if returnvalues[1] == "9018" then
            func_9018()
        end
        if returnvalues[1] == "9019" then
            func_9019()
        end
        if returnvalues[1] == "9020" then
            func_9020()
        end
        if returnvalues[1] == "9021" then
            func_9021()
        end
        if returnvalues[1] == "9022" then
            func_9022()
        end
        if returnvalues[1] == "9023" then
            func_9023()
        end
        if returnvalues[1] == "9024" then
            func_9024()
        end
        if returnvalues[1] == "9025" then
            func_9025()
        end
        if returnvalues[1] == "9026" then
            func_9026()
        end
        if returnvalues[1] == "9027" then
            func_9027()
        end
        if returnvalues[1] == "9028" then
            func_9028()
        end
        if returnvalues[1] == "9029" then
            func_9029()
        end
        if returnvalues[1] == "9030" then
            func_9030()
        end
    else
        if returnvalues[1] == "8000" then
            func_8000()
        elseif returnvalues[1] == "8001" then
            func_8001()
        elseif returnvalues[1] == "9004" then
            func_9004()
        else
            finenv.UI():AlertInfo("Please select a region and try agian.", nil)
            return
        end
    end
end