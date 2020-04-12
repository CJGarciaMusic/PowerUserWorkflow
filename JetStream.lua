function plugindef()
    finaleplugin.RequireSelection = false
    finaleplugin.Version = "120420"
    finaleplugin.Date = "4/12/2020"
    return "JetStream Finale Controller", "JetStream Finale Controller", "Input four digit codes to access JetStream Finale Controller features."
end

local dialog = finenv.UserValueInput()
dialog.Title = "JetStream Finale Controller"

local full_art_table = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

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

function delete_duplicate_articulations(note_entry)
    local art_list = {}
    local arts = note_entry:CreateArticulations()
    for a in each(arts) do
        table.insert(art_list, a:GetID())
    end 

    local sort_list = {}
    local unique_list = {}
    for k,v in ipairs(art_list) do
        if (not sort_list[v]) then
            unique_list[#unique_list + 1] = v
            sort_list[v] = true
        end
    end
    for key, value in pairs(art_list) do
        for a in each(arts) do
            a:DeleteData()
        end
    end
    for key, value in pairs(unique_list) do
        local art = finale.FCArticulation()
        art:SetNoteEntry(note_entry)
        art:SetID(value)
        art:SaveNew()
    end
end

function split_articulations()
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
        local remove_duplicates = 0
        local arts = noteentry:CreateArticulations()
        for a in each(arts) do
            local ad = finale.FCArticulationDef()
            if ad:Load(a:GetID()) then
                if ad:GetAboveSymbolChar() == 249 then
                    a:SetID(art_table[2])
                    a:Save()
                    a:SetID(art_table[1])
                    a:SaveNew()
                    remove_duplicates = remove_duplicates + 1
                end
                if (ad:GetAboveSymbolChar() == 138) or (ad:GetAboveSymbolChar() == 251) then
                    a:SetID(art_table[2])
                    a:Save()
                    a:SetID(art_table[3])
                    a:SaveNew()
                    remove_duplicates = remove_duplicates + 1
                end
                if ad:GetAboveSymbolChar() == 248 then
                    a:SetID(art_table[3])
                    a:Save()
                    a:SetID(art_table[1])
                    a:SaveNew()
                    remove_duplicates = remove_duplicates + 1
                end
                if ad:GetAboveSymbolChar() == 172 then
                    a:SetID(art_table[4])
                    a:Save()
                    a:SetID(art_table[1])
                    a:SaveNew()
                    remove_duplicates = remove_duplicates + 1
                end
            end
        end
        if remove_duplicates > 0 then
            delete_duplicate_articulations(noteentry)
        end
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

function adjustHairpins(range_settings)

    function vertical_space(region)
        local staff_pos = {}
        local lowest_note = 0
        local music_reg = finenv.Region()
        music_reg:SetStartStaff(region[1])
        music_reg:SetEndStaff(region[1])
        music_reg:SetStartMeasure(region[2])
        music_reg:SetStartMeasurePos(region[4])
        music_reg:SetEndMeasure(region[3])
        music_reg:SetEndMeasurePos(region[5])
        for noteentry in eachentrysaved(music_reg) do
            if noteentry:IsNote() then
                for note in each(noteentry) do
                    table.insert(staff_pos, note:CalcStaffPosition())
                end
            end
        end

        table.sort(staff_pos)

        if staff_pos[1] ~= nil then
            local below_note_cushion = 45
            lowest_note = (staff_pos[1] * 12) - below_note_cushion
        else
            lowest_note = 0 
        end
        
        local expressions = finale.FCExpressions()
        expressions:LoadAllForRegion(music_reg)
        local expression_list = {}
        local note_positions_to_check = {}
        for e in each(expressions) do
            local create_def = e:CreateTextExpressionDef()
            local cd = finale.FCCategoryDef()
            if cd:Load(create_def:GetCategoryID()) then
                if string.find(cd:CreateName().LuaString, "Dynamic") then
                    table.insert(note_positions_to_check, {e:GetMeasure(), e:GetMeasurePos(), create_def:GetVerticalBaselineOffset(), create_def:GetVerticalEntryOffset(), e:GetVerticalPos()})
                else
                    return false
                end
            end
        end
        
        local lowest_expression = {}
        for k, v in pairs(note_positions_to_check) do
            local entry_offset = 0
            local baseline_offset = 0
            local exp_baseline = 0
            local staff_height = 0
            local baseline_offset = 0
            local distance_to_baseline = 0
            local vertical_pos = 0
            local total = 0
            music_reg:SetStartMeasure(v[1])
            music_reg:SetEndMeasure(v[1])
            music_reg:SetStartMeasurePos(v[2])
            music_reg:SetEndMeasurePos(v[2])
            vertical_pos = v[5]
            for noteentry in eachentrysaved(music_reg) do
                for note in each(noteentry) do
                    if (noteentry:CalcStemUp()) and (note:CalcStaffPosition() < -7) then
                        entry_offset = (note:CalcStaffPosition() * 12) + v[4]
                    elseif (noteentry:CalcStemUp() == false) and (note:CalcStaffPosition() < -1) then
                        entry_offset = (note:CalcStaffPosition() * 12) + v[4]
                    else
                        local staffsystems = finale.FCStaffSystems()
                        staffsystems:LoadAll()
                        local exp_baseline = 0
                        for sys in each(staffsystems) do
                            if sys:ContainsMeasure(music_reg:GetStartMeasure()) then    
                                local baselines = finale.FCBaselines()
                                baselines:LoadAllForSystem(finale.BASELINEMODE_EXPRESSIONBELOW, sys:GetItemNo())
                                local bl = baselines:AssureSavedStaff(finale.BASELINEMODE_EXPRESSIONBELOW, sys:GetItemNo(), region[1])
                                exp_baseline = bl:GetVerticalOffset()
                            end
                        end
                        baseline_offset = v[3]
                        distance_to_baseline = -80
                        local staff = finale.FCStaff()
                        staff:Load(region[1])
                        if staff:GetLineCount() > 1 then
                            staff_height = 0 - ((staff:GetLineCount() - 1) * (staff:GetLineSpacing()/64))
                        else
                            staff_height = 0 - (staff:GetLineSpacing()/64)
                        end
                    end
                    total = staff_height + distance_to_baseline + baseline_offset + entry_offset + exp_baseline + vertical_pos
                    table.insert(lowest_expression, total)
                end
            end
        end
        local original_lowest_expressions = {}
        for k, v in pairs(lowest_expression) do
            table.insert(original_lowest_expressions, v)
        end
        table.sort(lowest_expression)
        local lowest_item = {lowest_expression[1], lowest_note}
        music_reg:SetStartStaff(region[1])
        music_reg:SetEndStaff(region[1])
        music_reg:SetStartMeasure(region[2])
        music_reg:SetStartMeasurePos(region[4])
        music_reg:SetEndMeasure(region[3])
        music_reg:SetEndMeasurePos(region[5])

        local ssmm = finale.FCSmartShapeMeasureMarks()
        ssmm:LoadAllForRegion(music_reg, true)
        for mark in each(ssmm) do
            local smartshape = mark:CreateSmartShape()
            if smartshape:IsHairpin() then
                left_seg = smartshape:GetTerminateSegmentLeft()
                right_seg = smartshape:GetTerminateSegmentRight()
                table.insert(lowest_item, left_seg:GetEndpointOffsetY())
                table.insert(lowest_item, right_seg:GetEndpointOffsetY())
            end
        end
        table.sort(lowest_item)
        for k, v in pairs(note_positions_to_check) do
            music_reg:SetStartMeasure(v[1])
            music_reg:SetEndMeasure(v[1])
            music_reg:SetStartMeasurePos(v[2])
            music_reg:SetEndMeasurePos(v[2])
            local expressions = finale.FCExpressions()
            expressions:LoadAllForRegion(music_reg)
            for e in each(expressions) do
                local create_def = e:CreateTextExpressionDef()
                local cd = finale.FCCategoryDef()
                if cd:Load(create_def:GetCategoryID()) then
                    if string.find(cd:CreateName().LuaString, "Dynamic") then
                        local difference = lowest_item[1] - original_lowest_expressions[k]
                        if difference ~= 0 then
                            e:SetVerticalPos(e:GetVerticalPos() + difference)
                            e:Save()
                        end
                        print(lowest_item[1], original_lowest_expressions[k], "="..difference)
                    else
                        return false
                    end
                end
            end
        end
        music_reg:SetStartStaff(region[1])
        music_reg:SetEndStaff(region[1])
        music_reg:SetStartMeasure(region[2])
        music_reg:SetStartMeasurePos(region[4])
        music_reg:SetEndMeasure(region[3])
        music_reg:SetEndMeasurePos(region[5])
        local ssmm = finale.FCSmartShapeMeasureMarks()
        ssmm:LoadAllForRegion(music_reg, true)
        for mark in each(ssmm) do
            local smartshape = mark:CreateSmartShape()
            if smartshape:IsHairpin() then
                left_seg = smartshape:GetTerminateSegmentLeft()
                right_seg = smartshape:GetTerminateSegmentRight()
                left_seg:SetEndpointOffsetY(lowest_item[1])
                right_seg:SetEndpointOffsetY(lowest_item[1])
                smartshape:Save()
            end
        end
    end

    function left_right_space(left_or_right, hairpin, region)
        local the_seg = hairpin:GetTerminateSegmentLeft()
        local left_dynamic_cushion = 9
        local right_dynamic_cushion = -9
        local left_selection_cushion = 0
        local right_selection_cushion = -18
        if left_or_right == "left" then
            the_seg = hairpin:GetTerminateSegmentLeft()
        elseif left_or_right == "right" then
            the_seg = hairpin:GetTerminateSegmentRight()
        end
        
        region:SetStartMeasure(the_seg:GetMeasure())
        region:SetEndMeasure(the_seg:GetMeasure())
        region:SetStartMeasurePos(the_seg:GetMeasurePos())
        region:SetEndMeasurePos(the_seg:GetMeasurePos())
        local expressions = finale.FCExpressions()
        expressions:LoadAllForRegion(region)
        local expression_list = {}
        for e in each(expressions) do
            local create_def = e:CreateTextExpressionDef()
            local cd = finale.FCCategoryDef()
            if cd:Load(create_def:GetCategoryID()) then
                if string.find(cd:CreateName().LuaString, "Dynamic") then
                    local text_met = finale.FCTextMetrics()
                    local string = create_def:CreateTextString()
                    string:TrimEnigmaTags()
                    text_met:LoadString(string, create_def:CreateTextString():CreateLastFontInfo(), 100)
                    table.insert(expression_list, {text_met:CalcWidthEVPUs(), e, e:GetItemInci()})
                end
            end
        end
        if #expression_list > 0 then
            local dyn_width = (expression_list[1][1] / 2)
            local dyn_def = expression_list[1][2]:CreateTextExpressionDef()
            local manual_horizontal = expression_list[1][2]:GetHorizontalPos()
            local horizontal_offset = dyn_def:GetHorizontalOffset()
            local total_offset = manual_horizontal + horizontal_offset
            if left_or_right == "left" then
                local total_x = dyn_width + left_dynamic_cushion + total_offset
                the_seg:SetEndpointOffsetX(total_x)
            elseif left_or_right == "right" then
                range_settings[6] = false
                local total_x = (0 - dyn_width)+ right_dynamic_cushion + total_offset
                the_seg:SetEndpointOffsetX(total_x)
            end
        end
        if range_settings[6] == true then
            the_seg = hairpin:GetTerminateSegmentRight()
            the_seg:SetEndpointOffsetX(right_selection_cushion)
        end
        hairpin:Save()
    end

    local music_reg = finenv.Region()
    music_reg:SetStartStaff(range_settings[1])
    music_reg:SetEndStaff(range_settings[1])
    music_reg:SetStartMeasure(range_settings[2])
    music_reg:SetStartMeasurePos(range_settings[4])
    music_reg:SetEndMeasure(range_settings[3])
    music_reg:SetEndMeasurePos(range_settings[5])
    local hairpin_list = {}

    local ssmm = finale.FCSmartShapeMeasureMarks()
    ssmm:LoadAllForRegion(music_reg, true)
    for mark in each(ssmm) do
        local smartshape = mark:CreateSmartShape()
        if smartshape:IsHairpin() then
            table.insert(hairpin_list, smartshape)
        end
    end
    
    for key, value in pairs(hairpin_list) do 
        left_right_space("left", value, music_reg)
        left_right_space("right", value, music_reg)
    end
    vertical_space(range_settings)
end

function createHairpin(range_settings, shape)
    local smartshape = finale.FCSmartShape()
    smartshape.ShapeType = shape
    smartshape.EntryBased = false
    smartshape.MakeHorizontal = true
    smartshape.BeatAttached= true
    smartshape.PresetShape = true
    smartshape.Visible = true
    smartshape.LineID = shape

    local leftseg = smartshape:GetTerminateSegmentLeft()
    leftseg:SetMeasure(range_settings[2])
    leftseg.Staff = range_settings[1]
    leftseg:SetCustomOffset(false)
    leftseg:SetEndpointOffsetY(0)
    leftseg:SetEndpointOffsetX(0)
    leftseg:SetMeasurePos(range_settings[4])

    local rightseg = smartshape:GetTerminateSegmentRight()
    rightseg:SetMeasure(range_settings[3])
    rightseg.Staff = range_settings[1]
    rightseg:SetCustomOffset(false)
    rightseg:SetEndpointOffsetX(0)
    rightseg:SetEndpointOffsetY(0)
    rightseg:SetMeasurePos(range_settings[5])
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

    local leftseg = smartshape:GetTerminateSegmentLeft()
    leftseg:SetMeasure(measure_start)
    leftseg:SetStaff(staff)
    leftseg:SetEntry(leftnote)

    local rightseg = smartshape:GetTerminateSegmentRight()
    rightseg:SetMeasure(measure_end)
    rightseg:SetStaff(staff)
    rightseg:SetEntry(rightnote)
    if (shape == 26) or (shape == 25) then
        if (shape == 25) then
            smartshape.LineID = 1
        end
        leftseg.NoteID = 1
        rightseg.NoteID = 1
    end
    smartshape:SaveNewEverything(leftnote, rightnote)
end

function setFirstLastNoteRangeEntry(smart_shape)
    local music_region = finenv.Region()
    local range_settings = {}
    music_region:SetCurrentSelection()
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

function set_first_last_note_in_range(staff)
    
    function find_dyanmic(last_measure, last_pos)
        local region = finenv.Region()
        region:SetStartStaff(staff)
        region:SetEndStaff(staff)
        region:SetStartMeasure(last_measure)
        region:SetEndMeasure(last_measure)
        region:SetStartMeasurePos(last_pos)
        region:SetEndMeasurePos(last_pos)
        local expressions = finale.FCExpressions()
        expressions:LoadAllForRegion(region)
        local expression_list = {}
        for e in each(expressions) do
            local create_def = e:CreateTextExpressionDef()
            local cd = finale.FCCategoryDef()
            if cd:Load(create_def:GetCategoryID()) then
                if string.find(cd:CreateName().LuaString, "Dynamic") then
                    table.insert(expression_list, e)
                end
            end
        end
        if #expression_list > 0 then
            return true
        else
            return false
        end
    end

    local music_region = finenv.Region()
    local range_settings = {}
    music_region:SetCurrentSelection()
    music_region:SetStartStaff(staff)
    music_region:SetEndStaff(staff)

    local items_in_region = {}
    local notes_in_region = {}

    for noteentry in eachentrysaved(music_region) do
        if noteentry:IsNote() then
            table.insert(notes_in_region, noteentry)
        end
        table.insert(items_in_region, noteentry)
    end

    if #notes_in_region > 0 then
        local end_cusion = false
        
        local start_pos = notes_in_region[1]:GetMeasurePos()
        
        local end_pos = notes_in_region[#notes_in_region]:GetMeasurePos() 

        if notes_in_region[#notes_in_region]:GetDuration() > 1536 then
            end_pos = end_pos + notes_in_region[#notes_in_region]:GetDuration()
            end_cusion = true
        end

        local start_measure = notes_in_region[1]:GetMeasure()

        local end_measure = notes_in_region[#notes_in_region]:GetMeasure()

        if items_in_region[#items_in_region] == notes_in_region[#notes_in_region] then
            if find_dyanmic(end_measure, end_pos) == false then
                local get_time = finale.FCMeasure()
                get_time:Load(notes_in_region[#notes_in_region]:GetMeasure())
                local new_right_end = get_time:GetTimeSignature()
                local beat = new_right_end:GetBeats()
                local duration = new_right_end:GetBeatDuration()
                end_pos = (beat * duration)
                end_cushion = true
            end
        end
        range_settings[staff] = {staff, start_measure, end_measure, start_pos, end_pos, end_cushion}
    end
    for key, value in pairs(range_settings) do
        local a = value[1]
        local b = value[2]
        local c = value[3]
        local d = value[4]
        local e = value[5]
        local f = value[6]
        return {a, b, c, d, e, f}
    end
end

function createBBSL(staff, measure_start, measure_end, leftpos, rightpos, shape, above_staff)    
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

    if above_staff == true then
        if staff_pos[count] == nil then
            y_value = base_line_offset 
        else
            if staff_pos[count] >= 0 then
                y_value = (staff_pos[count] * 12) + entry_offset
            else
                y_value = base_line_offset 
            end
        end
    else
        base_line_offset = 54
        entry_offset = 54
        if staff_pos[1] == nil then
            y_value = 0 - (108 + base_line_offset) 
        else
            if staff_pos[1] <= -9 then
                y_value = ((staff_pos[1] * 12) - entry_offset)
            else
                y_value = 0 - (108 + base_line_offset) 
            end
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

function createBeatBasedSL(smart_shape, place_above)
    local music_region = finenv.Region()
    local range_settings = {}
    music_region:SetCurrentSelection()
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
        createBBSL(value[1], value[2], value[3], value[4], value[5], smart_shape, place_above)
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
    local music_region = finenv.Region()
    music_region:SetCurrentSelection()
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        adjustHairpins(set_first_last_note_in_range(addstaff))
    end
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
    local music_region = finenv.Region()
    music_region:SetCurrentSelection()
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        adjustHairpins(set_first_last_note_in_range(addstaff))
    end
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
    local music_region = finenv.Region()
    music_region:SetCurrentSelection()
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        adjustHairpins(set_first_last_note_in_range(addstaff))
    end
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

function find_dynamic(glyph_nums, table_name, description_text)
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
            if resize_top_bottom ~= nil then
                local nm = finale.FCNoteheadMod()
                nm:SetNoteEntry(noteentry)
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
                noteentry:SetNoteDetailFlag(true)
                local entry_mod = finale.FCEntryAlterMod()
                entry_mod:SetNoteEntry(noteentry)
                entry_mod:SetResize(size)
                entry_mod:Save()
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
            if (ted:IsAutoRehearsalMark()) and (ted:GetRehearsalMarkStyle() == 1) then
                table.insert(rehearsal_letters, ted.ItemNo)
            end
            if (ted:IsAutoRehearsalMark()) and (ted:GetRehearsalMarkStyle() == 5) then
                table.insert(rehearsal_numbers, ted.ItemNo)
            end
            if (ted:IsAutoRehearsalMark()) and (ted:GetRehearsalMarkStyle() == 6) then
                table.insert(rehearsal_measures, ted.ItemNo)
            end
        end
    end

    local rehearsal_staff = {}

    function get_rehearsal_staves()
        local item_num = 0
        local sll = finale.FCStaffListLookup()
        if (sll:LoadCategoryList(6)) then 
            local sl = finale.FCStaffList()
            sl:SetMode(finale.SLMODE_CATEGORY_SCORE)
            if sl:LoadFirst() then
                item_num = sl:GetItemNo()
                if (sl:IncludesTopStaff()) then
                    table.insert(rehearsal_staff, 1)
                end
                local staves = finale.FCStaves()
                staves:LoadAll()
                for staff in each(staves) do
                    if sl:IncludesStaff(staff:GetItemNo()) then
                        table.insert(rehearsal_staff, staff:GetItemNo())
                    end
                end
            end
        end
    end

    function add_marks(exp_id)
        local add_expression = finale.FCExpression()
        for key, value in pairs(rehearsal_staff) do
            add_expression:SetPartAssignment(false)
            add_expression:SetScoreAssignment(true)
            add_expression:SetStaff(value)
            add_expression:SetStaffGroupID(1)
            add_expression:SetStaffListID(1)
            add_expression:SetVisible(true)
            add_expression:SetID(exp_id)
            local and_cell = finale.FCCell(measure_num, value)
            add_expression:SaveNewToCell(and_cell)
        end
        add_expression:SetPartAssignment(true)
        add_expression:SetScoreAssignment(false)
        add_expression:SetStaff(-1)
        add_expression:SetStaffGroupID(1)
        add_expression:SetStaffListID(1)
        add_expression:SetVisible(true)
        add_expression:SetID(exp_id)
        local and_cell = finale.FCCell(measure_num, -1)
        add_expression:SaveNewToCell(and_cell)
    end

    if reh_type == "Letter" then
        if rehearsal_letters[1] == nil then
            finenv.UI():AlertInfo("There doesn't appear to be any Auto-Rehearsal Marks using Letters in the Rehearsal Marks Category. Please create one and try again.", NULL)
        else
            get_rehearsal_staves()
            add_marks(rehearsal_letters[1])
        end
    end
    if reh_type == "Number" then
        if rehearsal_numbers[1] == nil then
            finenv.UI():AlertInfo("There doesn't appear to be any Auto-Rehearsal Marks using Numbers in the Rehearsal Marks Category. Please create one and try again.", NULL)
        else
            get_rehearsal_staves()
            add_marks(rehearsal_numbers[1])
        end
    end
    if reh_type == "Measure" then
        if rehearsal_measures[1] == nil then
            finenv.UI():AlertInfo("There doesn't appear to be any Auto-Rehearsal Marks using Measure Numbers in the Rehearsal Marks Category. Please create one and try again.", NULL)
        else
            get_rehearsal_staves()
            add_marks(rehearsal_measures[1])
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
            local the_staves = finenv.Region()
            the_staves:SetFullDocument()
            for addstaff = the_staves.StartStaff, the_staves.EndStaff do
                e:DeleteData()
            end
        end
    end
end

function find_double_barlines(rehearsal_mark_type)
    delete_rehearsal_marks()
    local measures = finale.FCMeasures()
    local the_region = finenv.Region()
    the_region:SetCurrentSelection()
    measures:LoadRegion(the_region)
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
                elseif value == "Number Ratio Both" then
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
    lyr = lyr - 1
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
            if string.find(user_number, "%s?[qQhHwWeEsSxX][.]?%s?%)?") then
                user_number = number_font.." = "..music_font..user_number
            else
                user_number = number_font.." = "..user_number
            end
        end

        if user_parentheses == false then
            if beat_duration ~= "" then
                if (user_text:sub(-1) == " ") or (user_text == "") then
                    start_parentheses = ""
                else
                    start_parentheses = " "
                end
            else
                start_parentheses = ""
            end
            end_parentheses = ""
        else
            local unbold_text = string.gsub(text_font, "nfx%(%d+%)", "nfx(0)")
            if user_text:sub(-1) == " " then
                start_parentheses = unbold_text.."("
            elseif user_text == "" then
                start_parentheses = unbold_text.."("
            else
                start_parentheses = unbold_text.." ("
            end
            end_parentheses = unbold_text..")"
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
                if (user_text:sub(-1) == " ") or (user_text == "") then
                    start_parentheses = ""
                else
                    start_parentheses = " "
                end
            else
                start_parentheses = ""
            end
            end_parentheses = ""
        else
            if user_text:sub(-1) == " " then
                start_parentheses = "("
            elseif user_text == "" then
                start_parentheses = "("
            else
                start_parentheses = " ("
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
        if (string.match(the_string, "%(?%s?[qQhHwWeEsSxX][.]?%s?=%s?%d+%s?[%-%–%—]?%s?%d+%s?%)?")) then
            local new_string = string.find(the_string, "%(?%s?[qQhHwWeEsSxX][.]?%s?=%s?%d+%s?[%-%–%—]?%s?%d+%s?%)?")
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
            if string.find(metronome_text, "%d+%s?[%-%–%—]?%s?%d+") then
                beat_number = metronome_text:sub(string.find(metronome_text, "%d+%s?[%-%–%—]?%s?%d+"))
            end
        elseif (string.match(the_string, "%(?%s?[qQhHwWeEsSxX][.]?%s?=%s?[qQhHwWeEsSxX][.]?%s?%)?")) then
            if string.find(the_string, "%(") then
                parenthetical_bool = true
            end
            if string.find(the_string, "%(?%s?[qQhHwWeEsSxX][.]?%s?=") then
                beat_duration = the_string:sub(string.find(the_string, "%(?%s?[qQhHwWeEsSxX][.]?%s?="))
                beat_duration = string.gsub(beat_duration, "[%s?=%s?]", "")
                beat_duration = string.gsub(beat_duration, "%(?", "")
            end
            if string.find(the_string, "=%s?[qQhHwWeEsSxX][.]?%s?%)?") then
                beat_number = the_string:sub(string.find(the_string, "=%s?[qQhHwWeEsSxX][.]?%s?%)?"))
                beat_number = string.gsub(beat_number, "[%s?=%s?]", "")
                beat_number = string.gsub(beat_number, "%)?", "")
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
        input_dialog.Title = "JetStream Expression Input"
        input_dialog:SetTypes("String")
        input_dialog:SetDescriptions("Please Enter Your "..display_type.." Text")
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

function baseline_reset(baseline_type)
    local region = finenv.Region()
    local systems = finale.FCStaffSystems()
    systems:LoadAll()

    local start_measure = region:GetStartMeasure()
    local end_measure = region:GetEndMeasure()
    local system = systems:FindMeasureNumber(start_measure)
    local lastSys = systems:FindMeasureNumber(end_measure)
    local system_number = system:GetItemNo()
    local lastSys_number = lastSys:GetItemNo()
    local start_staff = region:GetStartStaff()
    local end_staff = region:GetEndStaff()

    for i = system_number, lastSys_number, 1 do
        local baselines = finale.FCBaselines()
        baselines:LoadAllForSystem(baseline_type, i)
        for j = start_staff, end_staff, 1 do
            bl = baselines:AssureSavedStaff(baseline_type, i, j)
            bl.VerticalOffset = 0
            bl:Save()
        end
    end
end

function remove_lyrics_from_document()
    local verse_lyrics = finale.FCVerseLyricsText()
    local chorus_lyrics = finale.FCChorusLyricsText()
    local section_lyrics = finale.FCSectionLyricsText()

    for i = 0, 999 do
        if verse_lyrics:Load(i) then
            verse_lyrics:DeleteData()
        end
        if chorus_lyrics:Load(i) then
            chorus_lyrics:DeleteData()
        end
        if section_lyrics:Load(i) then
            section_lyrics:DeleteData()
        end
    end

    local fullregion = finale.FCMusicRegion()

    fullregion:SetFullDocument()

    for e in eachentrysaved(fullregion) do
        e.LyricFlag = false
    end
end

function staff_groups(bracket_style, barline_mode)
    local music_region = finenv.Region()
    if (music_region:IsEmpty()) ~= true then
        local top_staff = music_region:GetStartStaff()
        local bottom_staff = music_region:GetEndStaff()
        local sg_cmper = {}
        local sg = finale.FCGroup()
        if bracket_style ~= finale.GRBRAC_DESK then
            local staff_groups = finale.FCGroups()
            staff_groups:LoadAll()
            for sg in each(staff_groups) do
                table.insert(sg_cmper, sg:GetItemID())
                for addstaff = top_staff, bottom_staff do
                    if sg:ContainsStaff(addstaff) then
                        sg:DeleteData()
                    end
                end
            end
            table.sort(sg_cmper)
            sg:SetStartStaff(top_staff)
            sg:SetEndStaff(bottom_staff)
            sg:SetStartMeasure(1)
            sg:SetEndMeasure(32767)
            sg:SetBracketStyle(bracket_style)
            if top_staff == bottom_staff then
                sg:SetBracketSingleStaff(true)
            end
            sg:SetDrawBarlineMode(barline_mode)
            sg:SetBracketHorizontalPos(-12)
            if sg_cmper[1] == nil then
                sg:SaveNew(1)
            else
                local save_num = sg_cmper[1] + 1
                sg:SaveNew(save_num)
            end
        else
            local sub_list = {}
            local staff_groups = finale.FCGroups()
            staff_groups:LoadAll()
            for sg in each(staff_groups) do
                table.insert(sg_cmper, sg:GetItemID())
                for addstaff = top_staff, bottom_staff do
                    if sg:ContainsStaff(addstaff) then
                        if sg:GetBracketStyle() == 8 then
                            table.insert(sub_list, sg:GetItemID())
                            sg:DeleteData()
                        end
                    end
                end
            end
            if sub_list[1] == nil then
                sg:SetStartStaff(top_staff)
                sg:SetEndStaff(bottom_staff)
                sg:SetStartMeasure(1)
                sg:SetEndMeasure(32767)
                sg:SetBracketStyle(bracket_style)
                if top_staff == bottom_staff then
                    sg:SetBracketSingleStaff(true)
                end
                sg:SetBracketHorizontalPos(-30)
                table.sort(sg_cmper)
                if sg_cmper[2] ~= nil or sg_cmper[1] ~= nil then
                    local save_num = sg_cmper[1] + 1 
                    sg:SaveNew(save_num)
                else
                    sg:SaveNew(1)
                end
            else
                sg:Load(sub_list[1], sub_list[2])
                sg:SetStartStaff(top_staff)
                sg:SetEndStaff(bottom_staff)
                sg:SetStartMeasure(1)
                sg:SetEndMeasure(32767)
                sg:SetBracketStyle(bracket_style)
                if top_staff == bottom_staff then
                    sg:SetBracketSingleStaff(true)
                end
                if sg_cmper[2] ~= nil or sg_cmper[1] ~= nil then
                    local save_num = sg_cmper[1] + 1 
                    sg:SaveNew(save_num)
                else
                    sg:SaveNew(1)
                end
            end
        end
    end
end

function change_key_signature(major_minor, alteration_num)
    local measures = finale.FCMeasures()
    measures:LoadRegion(finenv.Region())

    for m in each(measures) do
        local key_sig = m:GetKeySignature()
        if major_minor == "Major" then
            m:SetKeyless(false)
            m:SetHideKeySigShowAccis(false)
            key_sig:SetMajorKey(alteration_num)
            key_sig:Save()
        elseif major_minor == "Minor" then
            m:SetKeyless(false)
            m:SetHideKeySigShowAccis(false)
            key_sig:SetMinorKey(alteration_num)
            key_sig:Save()
        elseif major_minor == "Keyless" then
            m:SetHideKeySigShowAccis(false)
            m:SetKeyless(true)
        elseif major_minor == "HideShow" then
            m:SetKeyless(false)
            m:SetHideKeySigShowAccis(true)
        end
        m:Save()
    end
end

function simple_art_to_exp_swap(art_to_find, description, char_num)
    local breath_mark_id = {}

    local function swap_artic_for_exp()
        local music_region = finenv.Region()
        for noteentry in eachentrysaved(music_region) do 
            local artics = noteentry:CreateArticulations()
            for a in each(artics) do
                local def = a:CreateArticulationDef()
                if def:GetAboveSymbolChar() == char_num then
                    a:DeleteData()
                    local and_expression=finale.FCExpression()
                    and_expression:SetStaff(noteentry.Staff)
                    and_expression:SetVisible(true)
                    and_expression:SetMeasurePos(noteentry.MeasurePos)
                    and_expression:SetScaleWithEntry(true)
                    and_expression:SetLayerAssignment(noteentry.LayerNumber)
                    and_expression:SetPartAssignment(true)
                    and_expression:SetScoreAssignment(true)
                    and_expression:SetPlaybackLayerAssignment(1)
                    and_expression:SetID(breath_mark_id[1])
                    local and_cell = finale.FCCell(noteentry.Measure, noteentry.Staff)
                    and_expression:SaveNewToCell(and_cell)
                end
            end
        end
    end
    
    local function createBreathMark()
        local exp_def = finale.FCTextExpressionDef()
        local textstr = finale.FCString()
        textstr.LuaString = "^fontMus(Font0,0)^size(24)^nfx(0)"..art_to_find
        exp_def:SaveNewTextBlock(textstr)
        local descriptionstr = finale.FCString()
        descriptionstr.LuaString = description
        exp_def:SetDescription(descriptionstr)
        local cat_def = finale.FCCategoryDef()
        cat_def:Load(7)
        exp_def:AssignToCategory(cat_def)
        exp_def:SetUseCategoryPos(false)
        exp_def:SetVerticalAlignmentPoint(finale.ALIGNVERT_STAFF_REFERENCE_LINE)
        exp_def:SetVerticalBaselineOffset(36)
        exp_def:SetHorizontalJustification(finale.EXPRJUSTIFY_LEFT)
        exp_def:SetHorizontalAlignmentPoint(finale.ALIGNHORIZ_RIGHTALLNOTEHEADS)
        exp_def:SetHorizontalOffset(48)
        exp_def:SetBreakMMRest(false)
        exp_def:SaveNew()
        breath_mark_id[1] = exp_def:GetItemNo()
        swap_artic_for_exp()
    end
    
    local function getBreathID()
        local exp_defs = finale.FCTextExpressionDefs()
        exp_defs:LoadAll()
        for ted in each(exp_defs) do
            local current_exp = ted:CreateTextString()
            current_exp:TrimEnigmaTags()
            if current_exp.LuaString == art_to_find then
                table.insert(breath_mark_id, ted:GetItemNo())
            end
        end
        if breath_mark_id[1] == nil then
            createBreathMark()
        else
            swap_artic_for_exp()
        end
    end
    
    getBreathID()
end

function change_octave(pitch_string, n)
    pitch_string.LuaString = pitch_string.LuaString:sub(1, -2)..(tonumber(string.sub(pitch_string.LuaString, -1)) + n)
    return pitch_string
end

function down_diatonic_fifth(pitch_string)
    local letters = "ABCDEFGABCDEFG"
    local note_name_pos = letters:find(pitch_string.LuaString:sub(1,1))
    local new_note = letters:sub(note_name_pos + 3, note_name_pos + 3)
    pitch_string.LuaString = new_note .. pitch_string.LuaString:sub(2)

    if (note_name_pos < 7) and (note_name_pos > 2) then
        pitch_string = change_octave(pitch_string, -1)
    end
    return pitch_string
end

function delete_circle_articulation(entry)
    local artics = entry:CreateArticulations()
    for a in eachbackwards(artics) do
        local defs = a:CreateArticulationDef()
        if defs:GetAboveSymbolChar() == 111 then
            a:DeleteData()
        end
    end
end

function down_diatonic_third(pitch_string)
    local letters = "ABCDEFGABCDEFG"
    local note_name_pos = letters:find(pitch_string.LuaString:sub(1,1))
    local new_note = letters:sub(note_name_pos + 5, note_name_pos + 5)
    pitch_string.LuaString = new_note .. pitch_string.LuaString:sub(2)

    if (note_name_pos < 5) and (note_name_pos > 2) then
        pitch_string = change_octave(pitch_string, -1)
    end
    return pitch_string
end

function up_diatonic_third(pitch_string)
    local letters = "ABCDEFGABCDEFG"
    local note_name_pos = letters:find(pitch_string.LuaString:sub(1,1))
    local new_note = letters:sub(note_name_pos + 2, note_name_pos + 2)
    pitch_string.LuaString = new_note .. pitch_string.LuaString:sub(2)

    if (note_name_pos >= 8) or (note_name_pos <= 2) then
        pitch_string = change_octave(pitch_string, 1)
    end
    return pitch_string
end

function up_diatonic_fourth(pitch_string)
    local letters = "ABCDEFGABCDEFG"
    local note_name_pos = letters:find(pitch_string.LuaString:sub(1,1))
    local new_note = letters:sub(note_name_pos + 3, note_name_pos + 3)
    pitch_string.LuaString = new_note .. pitch_string.LuaString:sub(2)

    if (note_name_pos >= 7) or (note_name_pos <= 2) then
        pitch_string = change_octave(pitch_string, 1)
    end
    return pitch_string
end

function chord_line_delete_bottom()
    for entry in eachentrysaved(finenv.Region()) do
        if (entry.Count >= 2) then
            local bottom_note = entry:CalcLowestNote(nil)
            entry:DeleteNote(bottom_note)
        end
    end
end

function chord_line_delete_top() 
    for entry in eachentrysaved(finenv.Region()) do
        if (entry.Count >= 2) then
            local top_note = entry:CalcHighestNote(nil)
            entry:DeleteNote(top_note)
        end
    end
end

function chord_line_keep_top() 
    for entry in eachentrysaved(finenv.Region()) do
        while (entry.Count >= 2) do
            local bottom_note = entry:CalcLowestNote(nil)
            entry:DeleteNote(bottom_note)
        end
    end
end

function chord_line_keep_bottom() 
    for entry in eachentrysaved(finenv.Region()) do
        while (entry.Count >= 2) do
            local top_note = entry:CalcHighestNote(nil)
            entry:DeleteNote(top_note)
        end
    end
end

function double_octave_higher() 
    for entry in eachentrysaved(finenv.Region()) do
        if (entry.Count == 1) then 
            local note = entry:CalcLowestNote(nil)
            local pitch_string = finale.FCString()
            local measure = entry:GetMeasure()
            measure_object = finale.FCMeasure()
            measure_object:Load(measure)
            local key_sig = measure_object:GetKeySignature()
            note:GetString(pitch_string, key_sig, false, false)
            pitch_string = change_octave(pitch_string, 1)
            local new_note = entry:AddNewNote()
            new_note:SetString(pitch_string, key_sig, false)
        end
    end
end

function double_octave_lower() 
    for entry in eachentrysaved(finenv.Region()) do
        if (entry.Count == 1) then 
            local note = entry:CalcLowestNote(nil)
            local pitch_string = finale.FCString()
            local measure = entry:GetMeasure()
            measure_object = finale.FCMeasure()
            measure_object:Load(measure)
            local key_sig = measure_object:GetKeySignature()
            note:GetString(pitch_string, key_sig, false, false)
            pitch_string = change_octave(pitch_string, -1)
            local new_note = entry:AddNewNote()
            new_note:SetString(pitch_string, key_sig, false)
        end
    end
end

function double_third_higher() 
    for entry in eachentrysaved(finenv.Region()) do
        if (entry.Count == 1) then 
            local note = entry:CalcLowestNote(nil)
            local pitch_string = finale.FCString()
            local measure = entry:GetMeasure()
            measure_object = finale.FCMeasure()
            measure_object:Load(measure)
            local key_sig = measure_object:GetKeySignature()
            note:GetString(pitch_string, key_sig, false, false)
            pitch_string = up_diatonic_third(pitch_string)
            local new_note = entry:AddNewNote()
            new_note:SetString(pitch_string, key_sig, false)
            new_note.RaiseLower = note.RaiseLower
        end
    end
end

function double_third_lower() 
    for entry in eachentrysaved(finenv.Region()) do
        if (entry.Count == 1) then 
            local note = entry:CalcLowestNote(nil)
            local pitch_string = finale.FCString()
            local measure = entry:GetMeasure()
            measure_object = finale.FCMeasure()
            measure_object:Load(measure)
            local key_sig = measure_object:GetKeySignature()
            note:GetString(pitch_string, key_sig, false, false)
            pitch_string = down_diatonic_third(pitch_string)
            local new_note = entry:AddNewNote()
            new_note:SetString(pitch_string, key_sig, false)
            new_note.RaiseLower = note.RaiseLower
        end
    end
end

function rotate_chord_up() 
    for entry in eachentrysaved(finenv.Region()) do
        if (entry.Count >= 2) then
            local note = entry:CalcLowestNote(nil)
            local top_note = entry:CalcHighestNote(nil)

            local pitch_string = finale.FCString()
            local measure = entry:GetMeasure()
            measure_object = finale.FCMeasure()
            measure_object:Load(measure)
            local key_sig = measure_object:GetKeySignature()
            note:GetString(pitch_string, key_sig, false, false)

            while note:CalcMIDIKey() < top_note:CalcMIDIKey() do
                pitch_string = change_octave(pitch_string, 1)
                note:SetString(pitch_string, key_sig, false)
            end
        end
    end
end

function rotate_chord_down() 
    for entry in eachentrysaved(finenv.Region()) do
        if (entry.Count >= 2) then
            local note = entry:CalcHighestNote(nil)
            local bottom_note = entry:CalcLowestNote(nil)

            local pitch_string = finale.FCString()
            local measure = entry:GetMeasure()
            measure_object = finale.FCMeasure()
            measure_object:Load(measure)
            local key_sig = measure_object:GetKeySignature()
            note:GetString(pitch_string, key_sig, false, false)

            while note:CalcMIDIKey() > bottom_note:CalcMIDIKey() do
                pitch_string = change_octave(pitch_string, -1)
                note:SetString(pitch_string, key_sig, false)
            end
        end
    end
end

function string_harmonics_touch(interval_num) 
    local ran = false
    for entry in eachentrysaved(finenv.Region()) do
        if (entry.Count == 1) then 
            ran = true

            delete_circle_articulation(entry)

            local note = entry:CalcLowestNote(nil)
            local pitch_string = finale.FCString()
            local measure = entry:GetMeasure()
            measure_object = finale.FCMeasure()
            measure_object:Load(measure)
            local key_sig = measure_object:GetKeySignature()
            note:GetString(pitch_string, key_sig, false, false)
            if (interval_num == 3) or (interval_num == 4) then
                pitch_string = change_octave(pitch_string, -2)
            elseif interval_num == 5 then
                pitch_string = change_octave(pitch_string, -1)
            end

            local new_note = entry:AddNewNote()

            if interval_num == 4 then
                note:SetString(pitch_string, keysig, false)
            else
                new_note:SetString(pitch_string, key_sig, false)
            end

            new_note.Tie = note.Tie

            if interval_num == 3 then
                note:SetString(down_diatonic_third(pitch_string), key_sig, false)
                if (new_note:CalcMIDIKey() - note:CalcMIDIKey() ~= 4) then
                    local error = new_note:CalcMIDIKey() - note:CalcMIDIKey() - 4
                    note.RaiseLower = note.RaiseLower + error
                end
            elseif interval_num == 4 then
                new_note:SetString(up_diatonic_fourth(pitch_string), key_sig, false)
                if (new_note:CalcMIDIKey() - note:CalcMIDIKey() ~= 5) then
                    local error = new_note:CalcMIDIKey() - note:CalcMIDIKey() - 5
                    new_note.RaiseLower = new_note.RaiseLower - error
                end
            elseif interval_num == 5 then
                note:SetString(down_diatonic_fifth(pitch_string), key_sig, false)
                if (new_note:CalcMIDIKey() - note:CalcMIDIKey() ~= 7) then
                    local error = new_note:CalcMIDIKey() - note:CalcMIDIKey() - 7
                    note.RaiseLower = note.RaiseLower + error
                end
            end
        
            local notehead = finale.FCNoteheadMod()
            notehead:EraseAt(new_note)
            notehead.CustomChar = 79
            notehead.Resize = 110
            if(entry:GetDuration() == 4096) then
                notehead.HorizontalPos = -4
            end
            notehead:SaveAt(new_note)
        end
    end
    if not ran then
        local dialog = finale.FCCustomWindow()
        local str = finale.FCString()
        str.LuaString = "String Harmonics 5th - Sounding Pitch"
        dialog:SetTitle(str)
        local static = dialog:CreateStatic(0, 0)
        str.LuaString = "No eligible notes to create a harmonic"
        static:SetText(str)
        dialog:CreateHorizontalLine(0, 16, 390)
        dialog:CreateOkButton()
        dialog:ExecuteModal(nil)
    end
end

function func_0000()
    package.path = "/Users/cgarcia/CJGit/JetStream/JetStreamConfig.lua"
    local config = require "JetStreamConfig"
    local dialog = finenv.UserValueInput()
    dialog:SetTypes(
        --hairpins
        "Number", "NumberedList", 
        --fonts
        "NumberedList", "NumberedList", 
        --Save?
        "Boolean")
    dialog:SetDescriptions(
        --hairpins
        "Cushion", "Apply To:", 
        --fonts
        "Notehead Font", "Page Text Font", 
        --Save?
        "Save Settings?")
    dialog:SetLists(
    nil, config.hairpin.region_or_notes,
    config.fonts.notehead_font, config.fonts.page_text_font,
    nil)
    dialog:SetInitValues(
        config.hairpin.cushion, config.hairpin.region_or_notes[1], 
        config.fonts.notehead_font[1], config.fonts.page_text_font[1], 
        true)

    local return_values = dialog:Execute() 

    if return_values ~= nil then
        if return_values[#return_values] == true then
            config.hairpin.cushion = return_values[1]
            config.hairpin.region_or_notes = return_values[2]
            config.fonts.notehead_font = return_values[3]
            config.fonts.page_text_font = return_values[4]
        end
    end
end

function func_0001()
    find_dynamic({235}, first_expression, "fortissississimo (velocity = 127)")
    dynamic_region("Start")
end

function func_0002()    
    find_dynamic({236}, first_expression, "fortississimo (velocity = 114)")
    dynamic_region("Start")
end

function func_0003()    
    find_dynamic({196}, first_expression, "fortissimo (velocity = 101)")
    dynamic_region("Start")
end

function func_0004()
    find_dynamic({102}, first_expression, "forte (velocity = 88)")
    dynamic_region("Start")
end

function func_0005()    
    find_dynamic({70}, first_expression, "mezzo forte (velocity = 75)")
    dynamic_region("Start")
end

function func_0006()    
    find_dynamic({80}, first_expression, "mezzo piano (velocity = 62)")
    dynamic_region("Start")
end

function func_0007()    
    find_dynamic({112}, first_expression, "piano (velocity = 49)")
    dynamic_region("Start")
end

function func_0008()
    find_dynamic({185}, first_expression, "pianissimo (velocity = 36)")
    dynamic_region("Start")
end

function func_0009()    
    find_dynamic({184}, first_expression, "pianississimo (velocity = 23)")
    dynamic_region("Start")
end

function func_0010()    
    find_dynamic({175}, first_expression, "pianissississimo (velocity = 10)")
    dynamic_region("Start")
end

function func_0011()
    find_dynamic({234}, first_expression, "forte piano")
    dynamic_region("Start")
end

function func_0012()
    find_dynamic({90}, first_expression, "forzando")
    dynamic_region("Start")
end

function func_0013()
    findSpecialExpression({150}, {"Font0", 0, 24, 0}, first_expression, "niente (velocity = 0)", 1)
    dynamic_region("Start")
end

function func_0014()
    find_dynamic({142, 102}, first_expression, "rinforte")
    dynamic_region("Start")
end

function func_0015()
    find_dynamic({142, 90}, first_expression, "rinforzando")
    dynamic_region("Start")
end

function func_0016()
    find_dynamic({83}, first_expression, "sforzando")
    dynamic_region("Start")
end

function func_0017()
    find_dynamic({141}, first_expression, "sforzato")
    dynamic_region("Start")
end

function func_0018()
    find_dynamic({130}, first_expression, "sforzato piano")
    dynamic_region("Start")
end

function func_0019()
    find_dynamic({182}, first_expression, "sforzato pianissimo")
    dynamic_region("Start")
end

function func_0020()
    find_dynamic({167}, first_expression, "sforzato")
    dynamic_region("Start")
end

function func_0021()
    find_dynamic({167, 112}, first_expression, "sforzando piano")
    dynamic_region("Start")
end

function func_0022()
    deleteHairpins()
    local music_region = finenv.Region()
    local range_settings = {}
    music_region:SetCurrentSelection()
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        createHairpin(set_first_last_note_in_range(addstaff), finale.SMARTSHAPE_CRESCENDO)
        adjustHairpins(set_first_last_note_in_range(addstaff))
    end
end

function func_0023()
    deleteHairpins()
    local music_region = finenv.Region()
    local range_settings = {}
    music_region:SetCurrentSelection()
    for addstaff = music_region:GetStartStaff(), music_region:GetEndStaff() do
        createHairpin(set_first_last_note_in_range(addstaff), finale.SMARTSHAPE_DIMINUENDO)
        adjustHairpins(set_first_last_note_in_range(addstaff))
    end
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
    find_dynamic({235}, first_expression, "fortissississimo (velocity = 127)")
    dynamic_region("End")
end

function func_0029()    
    find_dynamic({236}, first_expression, "fortississimo (velocity = 114)")
    dynamic_region("End")
end

function func_0030()    
    find_dynamic({196}, first_expression, "fortissimo (velocity = 101)")
    dynamic_region("End")
end

function func_0031()
    find_dynamic({102}, first_expression, "forte (velocity = 88)")
    dynamic_region("End")
end

function func_0032()    
    find_dynamic({70}, first_expression, "mezzo forte (velocity = 75)")
    dynamic_region("End")
end

function func_0033()    
    find_dynamic({80}, first_expression, "mezzo piano (velocity = 62)")
    dynamic_region("End")
end

function func_0034()    
    find_dynamic({112}, first_expression, "piano (velocity = 49)")
    dynamic_region("End")
end

function func_0035()
    find_dynamic({185}, first_expression, "pianissimo (velocity = 36)")
    dynamic_region("End")
end

function func_0036()    
    find_dynamic({184}, first_expression, "pianississimo (velocity = 23)")
    dynamic_region("End")
end

function func_0037()    
    find_dynamic({175}, first_expression, "pianissississimo (velocity = 10)")
    dynamic_region("End")
end

function func_0038()
    find_dynamic({234}, first_expression, "forte piano")
    dynamic_region("End")
end

function func_0039()
    find_dynamic({90}, first_expression, "forzando")
    dynamic_region("End")
end

function func_0040()
    findSpecialExpression({150}, {"Font0", 0, 24, 0}, first_expression, "niente (velocity = 0)", 1)
    dynamic_region("End")
end

function func_0041()
    find_dynamic({142, 102}, first_expression, "rinforte")
    dynamic_region("End")
end

function func_0042()
    find_dynamic({142, 90}, first_expression, "rinforzando")
    dynamic_region("End")
end

function func_0043()
    find_dynamic({83}, first_expression, "sforzando")
    dynamic_region("End")
end

function func_0044()
    find_dynamic({141}, first_expression, "sforzato")
    dynamic_region("End")
end

function func_0045()
    find_dynamic({130}, first_expression, "sforzato piano")
    dynamic_region("End")
end

function func_0046()
    find_dynamic({182}, first_expression, "sforzato pianissimo")
    dynamic_region("End")
end

function func_0047()
    find_dynamic({167}, first_expression, "sforzato")
    dynamic_region("End")
end

function func_0048()
    find_dynamic({167, 112}, first_expression, "sforzando piano")
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
    split_articulations()
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

function func_0138()
    findArticulation(35, 248, "")
    if full_art_table[35] == 0 then
        createArticulation(35, 248, "Maestro", 248, true, true, false, false, 1, true, false, 0, 75, 110, true, false, false, 16, true, 0, -2, 0, -21, 60, "Maestro", true, false, true, 0, 75, 110, true, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[35])
    end
end

function func_0139()
    findArticulation(36, 249, "")
    if full_art_table[36] == 0 then
        createArticulation(36, 249, "Maestro", 249, true, true, false, false, 1, false, false, 0, 50, 125, true, false, false, 19, true, 0, 0, 0, -35, 223, "Maestro", false, false, true, 0, 50, 125, true, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[36])
    end
end

function func_0140()
    findArticulation(37, 138, "")
    if full_art_table[37] == 0 then
        local font_name = getUsedFontName("Engraver Font Set")
        findArticulation(37, 251, font_name)
        if full_art_table[37] == 0 then
            createArticulation(37, 138, "Maestro", 138, true, true, false, false, 1, false, false, 0, 0, 125, true, false, false, 12, false, 0, 0, 0, -30, 137, "Maestro", false, false, true, 0, 0, 125, true, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
        end
    else
        addArticulation(full_art_table[37])
    end
end

function func_0141()
    findArticulation(38, 172, "")
    if full_art_table[38] == 0 then
        createArticulation(38, 172, "Maestro", 172, true, true, false, false, 5, false, false, 0, 75, 140, true, false, false, 16, true, 0, -4, 0, -18, 232, "Maestro", false, false, true, 0, 75, 140, true, false, false, 0, false, false, "Maestro", 24, 24, false, false, false, false, 0, false, false, "Maestro", 24, 24, false, false)
    else
        addArticulation(full_art_table[38])
    end
end

function func_0142()
    findArticulation(39, 122, "")
    if full_art_table[39] == 0 then
        createArticulation(39, 122, "Maestro", 122, true, false, false, false, 0, false, false, 0, 0, 0, true, false, false, 10, false, 0, 0, 0, -9, 122, "Maestro", false, false, false, 0, 0, 0, false, false, false, 0, false, false, "Maestro", 30, 30, false, false, false, false, 0, false, false, "Maestro", 30, 30, false, false)
    else
        addArticulation(full_art_table[39])
    end
end

function func_0143()
    for noteentry in eachentrysaved(finenv.Region()) do
        delete_duplicate_articulations(noteentry)
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
            noteentry:SetFloatingRest(true)
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

function func_0227()
    changeNoteheads("Maestro Percussion", 120, 84, 84, 84)
    local nm = finale.FCNoteheadMod()
    for noteentry in eachentrysaved(finenv.Region()) do
        nm:SetNoteEntry(noteentry)
        if noteentry.Duration > 1536 then
            for note in each(noteentry) do
                nm:LoadAt(note)
                nm:SetResize(130)
                nm:SaveAt(note)
            end
        else
            for note in each(noteentry) do
                nm:LoadAt(note)
                nm:SetResize(100)
                nm:SaveAt(note)
            end
        end
    end
end

function func_0228()
    local nm = finale.FCNoteheadMod()
    nm:SetUseCustomFont(true)
    nm.FontName = "Maestro Percussion"

    for noteentry in eachentrysaved(finenv.Region()) do 
        nm:SetNoteEntry(noteentry)
        for note in each(noteentry) do
            if note:CalcStaffPosition() >= -1 then
                if noteentry.Duration < 2048 then
                    nm.CustomChar = 120
                    nm:SetResize(100)
                end
                if (noteentry.Duration > 1536) then
                    nm.CustomChar = 84
                    nm:SetResize(130)
                end
                nm:SaveAt(note)
            end
        end
    end
end

function func_0280()
    string_harmonics_touch(3)
end

function func_0281()
    string_harmonics_touch(4)
end

function func_0282()
    string_harmonics_touch(5)
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

function func_0301()
    local region = finenv.Region()
    local systems = finale.FCStaffSystems()
    systems:LoadAll()

    local start_measure = region:GetStartMeasure()
    local end_measure = region:GetEndMeasure()
    local system = systems:FindMeasureNumber(start_measure)
    local lastSys = systems:FindMeasureNumber(end_measure)
    local system_number = system:GetItemNo()
    local lastSys_number = lastSys:GetItemNo()
    local start_staff = region:GetStartStaff()
    local end_staff = region:GetEndStaff()


    for i = system_number, lastSys_number, 1 do
        local baselines_verse = finale.FCBaselines()
        local baselines_chorus = finale.FCBaselines()
        local baselines_section = finale.FCBaselines()
        local lyric_number = 1
        baselines_verse:LoadAllForSystem(finale.BASELINEMODE_LYRICSVERSE, i)
        baselines_chorus:LoadAllForSystem(finale.BASELINEMODE_LYRICSCHORUS, i)
        baselines_section:LoadAllForSystem(finale.BASELINEMODE_LYRICSSECTION, i)
        for j = start_staff, end_staff, 1 do
            for k = lyric_number, 100, 1 do
                bl_v = baselines_verse:AssureSavedLyricNumber(finale.BASELINEMODE_LYRICSVERSE, i, j, k)
                bl_v.VerticalOffset = 0
                bl_v:Save()
                bl_c = baselines_chorus:AssureSavedLyricNumber(finale.BASELINEMODE_LYRICSCHORUS, i, j, k)
                bl_c.VerticalOffset = 0
                bl_c:Save()
                bl_s = baselines_section:AssureSavedLyricNumber(finale.BASELINEMODE_LYRICSSECTION, i, j, k)
                bl_s.VerticalOffset = 0
                bl_s:Save()
            end
        end
    end
end

function  func_0302()
    local confirm_delete = finenv.UI():AlertYesNo("This will completely remove all Verse, Chorus and Section Lyrics from the current document. (To erase lyrics from the score without removing them from the file, use Clear Lyrics.) Are you sure you want to proceed?", "WARNING!")

    if confirm_delete == 2 then
        remove_lyrics_from_document()
    else
        return
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

function func_0530()
    double_octave_higher()
end

function func_0531()
    double_octave_lower()
end

function func_0532()
    double_third_higher()
end

function func_0533()
    double_third_lower()
end

function func_0534()
    rotate_chord_up()
end

function func_0535()
    rotate_chord_down()
end

function func_0536()
    chord_line_delete_top()
end

function func_0537()
    chord_line_delete_bottom()
end

function func_0538()
    chord_line_keep_top()
end

function func_0539()
    chord_line_keep_bottom()
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
    deleteBeatSmartShape(finale.SMARTSHAPE_TRILLEXT)
    deleteBeatSmartShape(finale.SMARTSHAPE_TRILL)
    createBeatBasedSL(finale.SMARTSHAPE_TRILL, true)
end

function func_0601()
    deleteBeatSmartShape(finale.SMARTSHAPE_TRILL)
    deleteBeatSmartShape(finale.SMARTSHAPE_TRILLEXT)
    createBeatBasedSL(finale.SMARTSHAPE_TRILLEXT, true)
end

function func_0602()
    deleteBeatSmartShape(finale.SMARTSHAPE_DASHLINE)
    createBeatBasedSL(finale.SMARTSHAPE_DASHLINE, true)
end

function func_0603()
    deleteBeatSmartShape(finale.SMARTSHAPE_SOLIDLINE)
    createBeatBasedSL(finale.SMARTSHAPE_SOLIDLINE, true)
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
    deleteBeatSmartShape(finale.SMARTSHAPE_SOLIDLINEDOWN)
    deleteBeatSmartShape(finale.SMARTSHAPE_DASHLINEDOWN)
    createBeatBasedSL(finale.SMARTSHAPE_DASHLINEDOWN, true)
end

function func_0607()
    deleteBeatSmartShape(finale.SMARTSHAPE_DASHLINEDOWN)
    deleteBeatSmartShape(finale.SMARTSHAPE_SOLIDLINEDOWN)
    createBeatBasedSL(finale.SMARTSHAPE_SOLIDLINEDOWN, true)
end

function func_0608()
    deleteBeatSmartShape(finale.SMARTSHAPE_CUSTOM)
    createBeatBasedSL(finale.SMARTSHAPE_CUSTOM, true)
end

function func_0609()
    deleteEntrySmartShape(finale.SMARTSHAPE_DASHEDSLURAUTO)
    deleteEntrySmartShape(finale.SMARTSHAPE_SLURAUTO)
    setFirstLastNoteRangeEntry(finale.SMARTSHAPE_SLURAUTO)
end

function func_0610()
    deleteEntrySmartShape(finale.SMARTSHAPE_SLURAUTO)
    deleteEntrySmartShape(finale.SMARTSHAPE_DASHEDSLURAUTO)
    setFirstLastNoteRangeEntry(finale.SMARTSHAPE_DASHEDSLURAUTO)
end

function func_0611()
    deleteBeatSmartShape(finale.SMARTSHAPE_SOLIDLINEDOWN2)
    deleteBeatSmartShape(finale.SMARTSHAPE_DASHLINEDOWN2)
    createBeatBasedSL(finale.SMARTSHAPE_DASHLINEDOWN2, true)
end

function func_0612()
    deleteBeatSmartShape(finale.SMARTSHAPE_DASHLINEDOWN2)
    deleteBeatSmartShape(finale.SMARTSHAPE_SOLIDLINEDOWN2)
    createBeatBasedSL(finale.SMARTSHAPE_SOLIDLINEDOWN2, true)
end

function func_0613()
    deleteBeatSmartShape(finale.SMARTSHAPE_TWOOCTAVEUP)
    deleteBeatSmartShape(finale.SMARTSHAPE_OCTAVEUP)
    createBeatBasedSL(finale.SMARTSHAPE_OCTAVEUP, true)
end

function func_0614()
    deleteBeatSmartShape(finale.SMARTSHAPE_OCTAVEUP)
    deleteBeatSmartShape(finale.SMARTSHAPE_TWOOCTAVEUP)
    createBeatBasedSL(finale.SMARTSHAPE_TWOOCTAVEUP, true)
end

function func_0615()
    deleteBeatSmartShape(finale.SMARTSHAPE_TWOOCTAVEDOWN)
    deleteBeatSmartShape(finale.SMARTSHAPE_OCTAVEDOWN)
    createBeatBasedSL(finale.SMARTSHAPE_OCTAVEDOWN, false)
end

function func_0616()
    deleteBeatSmartShape(finale.SMARTSHAPE_OCTAVEDOWN)
    deleteBeatSmartShape(finale.SMARTSHAPE_TWOOCTAVEDOWN)
    createBeatBasedSL(finale.SMARTSHAPE_TWOOCTAVEDOWN, false)
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
    findTextExpression({"cresc."}, text_expression, "crescendo", 4)
    getFirstNoteInRegionText("Start")
end

function func_0801()
    findTextExpression({"dim."}, text_expression, "diminuendo", 4)
    getFirstNoteInRegionText("Start")
end

function func_0802()
    findTextExpression({"espr."}, text_expression, "espressivo", 4)
    getFirstNoteInRegionText("Start")
end

function func_0803()
    findTextExpression({"poco"}, text_expression, "poco", 4)
    getFirstNoteInRegionText("Start")
end

function func_0804()
    findTextExpression({"poco a poco"}, text_expression, "poco a poco", 4)
    getFirstNoteInRegionText("Start")
end

function func_0805()
    findTextExpression({"molto"}, text_expression, "molto", 4)
    getFirstNoteInRegionText("Start")
end

function func_0806()
    findTextExpression({"più", 102}, text_expression, "piu forte", 1)
    getFirstNoteInRegionText("Start")
end

function func_0807()
    findTextExpression({185, "sub."}, text_expression, "pianissimo subito", 1)
    getFirstNoteInRegionText("Start")
end

function func_0808()
    findTextExpression({112, "sub."}, text_expression, "piano subito", 1)
    getFirstNoteInRegionText("Start")
end

function func_0809()
    findTextExpression({80, "sub."}, text_expression, "mezzo piano subito", 1)
    getFirstNoteInRegionText("Start")
end

function func_0810()
    findTextExpression({70, "sub."}, text_expression, "mezzo forte subito", 1)
    getFirstNoteInRegionText("Start")
end

function func_0811()
    findTextExpression({102, "sub."}, text_expression, "forte subito", 1)
    getFirstNoteInRegionText("Start")
end

function func_0812()
    findTextExpression({196, "sub."}, text_expression, "fortissimo subito", 1)
    getFirstNoteInRegionText("Start")
end

function func_0813()
    findTextExpression({"solo"}, text_expression, "solo", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0814()
    findTextExpression({"unis."}, text_expression, "unis", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0815()
    findTextExpression({"tutti"}, text_expression, "tutti", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0816()
    findTextExpression({"loco"}, text_expression, "loco", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0817()
    findSpecialExpression({44}, {"Font0", 0, 24, 0}, text_expression, "Breath Mark", 5)
    getFirstNoteInRegionText("End")
end

function func_0818()
    findSpecialExpression({34}, {"Font0", 0, 24, 0}, text_expression, "Caesura", 5)
    getFirstNoteInRegionText("Region End")
end

function func_0819()
    findSpecialExpression({59}, {"Broadway Copyist", 8191, 24, 0}, text_expression, "Eyeglasses (WATCH!)", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0820()
    findTextExpression({"mute"}, text_expression, "mute", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0821()
    findTextExpression({"open"}, text_expression, "open", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0822()
    findTextExpression({"Cup Mute"}, text_expression, "Cup Mute", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0823()
    findTextExpression({"Straight Mute"}, text_expression, "Straight Mute", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0824()
    findTextExpression({"1°"}, text_expression, "1°", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0825()
    findTextExpression({"2°"}, text_expression, "2°", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0826()
    findTextExpression({"a2"}, text_expression, "a2", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0827()
    findTextExpression({"a3"}, text_expression, "a3", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0828()
    findTextExpression({"a4"}, text_expression, "a4", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0829()
    findTextExpression({"arco"}, text_expression, "arco", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0830()
    findTextExpression({"pizz."}, text_expression, "pizz.", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0831()
    findTextExpression({"spicc."}, text_expression, "spicc.", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0832()
    findTextExpression({"col legno"}, text_expression, "col legno", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0833()
    findTextExpression({"con sord."}, text_expression, "con sord", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0834()
    findTextExpression({"ord."}, text_expression, "ord.", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0835()
    findTextExpression({"sul pont."}, text_expression, "sul pont.", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0836()
    findTextExpression({"sul tasto"}, text_expression, "sul tasto", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0837()
    findTextExpression({"senza sord."}, text_expression, "senza sord.", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0838()
    findTextExpression({"trem."}, text_expression, "trem.", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0839()
    findTextExpression({"½ pizz. ½ arco"}, text_expression, "half pizz. half arco", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0840()
    findTextExpression({"½ trem. ½ ord."}, text_expression, "half trem. half ord.", 5)
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

function func_0855()
    findTextExpression({"div."}, text_expression, "div.", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0856()
    findTextExpression({"3°"}, text_expression, "3°", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0857()
    findTextExpression({"4°"}, text_expression, "4°", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0858()
    findTextExpression({"marc."}, text_expression, "marcato", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0859()
    findTextExpression({"stacc."}, text_expression, "staccato", 5)
    getFirstNoteInRegionText("Region Start")
end

function func_0860()
    findSpecialExpression({"[S\\T\\R\\A\\I\\G\\\\HT]"}, {"Finale Copyist Text", 4096, 14, 0}, text_expression, "Straight mute", 5)
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

function func_0927()
    tuplet_options({"Shape Bracket", "Bracket Always", "Always Flat Off", "Placement Stem"}) 
end

function func_0928()
    tuplet_options({"Shape Bracket", "Bracket Always", "Always Flat On", "Placement Below", "Avoid Staff On"}) 
end

function func_0929()
    tuplet_options({"Shape Bracket", "Bracket Always", "Always Flat On"}) 
end

function func_0930()
    tuplet_options({"Shape Bracket", "Bracket Always", "Always Flat On", "Placement Above", "Avoid Staff On"}) 
end

function func_0931()
    tuplet_options({"Shape None", "Number Regular", "Placement Stem", "Avoid Staff On"}) 
end

function func_0932()
    tuplet_options({"Shape None", "Number Regular", "Placement Note", "Avoid Staff On"}) 
end

function func_0933()
    tuplet_options({"Shape None", "Number Regular", "Placement Stem", "Avoid Staff Off"}) 
end

function func_0934()
    tuplet_options({"Shape None", "Number Regular", "Placement Note", "Avoid Staff Off"}) 
end

function func_0935()
    tuplet_options({"Allow Horizontal Drag On"}) 
end

function func_0936()
    tuplet_options({"Allow Horizontal Drag Off"}) 
end

function func_1000()
    staff_groups(finale.GRBRAC_NONE, finale.GROUPBARLINESTYLE_ONLYBETWEEN)
end

function func_1001()
    staff_groups(finale.GRBRAC_NONE, finale.GROUPBARLINESTYLE_ONLYON)
end

function func_1002()
    staff_groups(finale.GRBRAC_NONE, finale.GROUPBARLINESTYLE_THROUGH)
end

function func_1003()
    staff_groups(finale.GRBRAC_PLAIN, finale.GROUPBARLINESTYLE_ONLYBETWEEN)
end

function func_1004()
    staff_groups(finale.GRBRAC_PLAIN, finale.GROUPBARLINESTYLE_ONLYON)
end

function func_1005()
    staff_groups(finale.GRBRAC_PLAIN, finale.GROUPBARLINESTYLE_THROUGH)
end

function func_1006()
    staff_groups(finale.GRBRAC_CHORUS, finale.GROUPBARLINESTYLE_ONLYBETWEEN)
end

function func_1007()
    staff_groups(finale.GRBRAC_CHORUS, finale.GROUPBARLINESTYLE_ONLYON)
end

function func_1008()
    staff_groups(finale.GRBRAC_CHORUS, finale.GROUPBARLINESTYLE_THROUGH)
end

function func_1009()
    staff_groups(finale.GRBRAC_PIANO, finale.GROUPBARLINESTYLE_ONLYBETWEEN)
end

function func_1010()
    staff_groups(finale.GRBRAC_PIANO, finale.GROUPBARLINESTYLE_ONLYON)
end

function func_1011()
    staff_groups(finale.GRBRAC_PIANO, finale.GROUPBARLINESTYLE_THROUGH)
end

function func_1012()
    staff_groups(finale.GRBRAC_REVERSECHORUS, finale.GROUPBARLINESTYLE_ONLYBETWEEN)
end

function func_1013()
    staff_groups(finale.GRBRAC_REVERSECHORUS, finale.GROUPBARLINESTYLE_ONLYON)
end

function func_1014()
    staff_groups(finale.GRBRAC_REVERSECHORUS, finale.GROUPBARLINESTYLE_THROUGH)
end

function func_1015()
    staff_groups(finale.GRBRAC_REVERSEPIANO, finale.GROUPBARLINESTYLE_ONLYBETWEEN)
end

function func_1016()
    staff_groups(finale.GRBRAC_REVERSEPIANO, finale.GROUPBARLINESTYLE_ONLYON)
end

function func_1017()
    staff_groups(finale.GRBRAC_REVERSEPIANO, finale.GROUPBARLINESTYLE_THROUGH)
end

function func_1018()
    staff_groups(finale.GRBRAC_CURVEDCHORUS, finale.GROUPBARLINESTYLE_ONLYBETWEEN)
end

function func_1019()
    staff_groups(finale.GRBRAC_CURVEDCHORUS, finale.GROUPBARLINESTYLE_ONLYON)
end

function func_1020()
    staff_groups(finale.GRBRAC_CURVEDCHORUS, finale.GROUPBARLINESTYLE_THROUGH)
end

function func_1021()
    staff_groups(finale.GRBRAC_REVERSECURVEDCHORUS, finale.GROUPBARLINESTYLE_ONLYBETWEEN)
end

function func_1022()
    staff_groups(finale.GRBRAC_REVERSECURVEDCHORUS, finale.GROUPBARLINESTYLE_ONLYON)
end

function func_1023()
    staff_groups(finale.GRBRAC_REVERSECURVEDCHORUS, finale.GROUPBARLINESTYLE_THROUGH)
end

function func_1024()
    staff_groups(finale.GRBRAC_DESK, nil)
end

function func_1025()
    staff_groups(finale.GRBRAC_REVERSEDESK, nil)
end

function func_1100()
    change_key_signature("Major", -4)
end

function func_1101()
    change_key_signature("Minor", -7)
end

function func_1102()
    change_key_signature("Major", 3)
end

function func_1103()
    change_key_signature("Minor", 0)
end

function func_1104()
    change_key_signature("Minor", 7)
end

function func_1105()
    change_key_signature("Major", -2)
end

function func_1106()
    change_key_signature("Minor", -5)
end

function func_1107()
    change_key_signature("Major", 5)
end

function func_1108()
    change_key_signature("Minor", 2)
end

function func_1109()
    change_key_signature("Major", -7)
end

function func_1110()
    change_key_signature("Major", 0)
end

function func_1111()
    change_key_signature("Minor", -3)
end

function func_1112()
    change_key_signature("Major", 7)
end

function func_1113()
    change_key_signature("Minor", 4)
end

function func_1114()
    change_key_signature("Major", -5)
end

function func_1115()
    change_key_signature("Major", 2)
end

function func_1116()
    change_key_signature("Minor", -1)
end

function func_1117()
    change_key_signature("Minor", 6)
end

function func_1118()
    change_key_signature("Major", -3)
end

function func_1119()
    change_key_signature("Minor", -6)
end

function func_1120()
    change_key_signature("Major", 4)
end

function func_1121()
    change_key_signature("Minor", 1)
end

function func_1122()
    change_key_signature("Major", -1)
end

function func_1123()
    change_key_signature("Minor", -4)
end

function func_1124()
    change_key_signature("Major", 6)
end

function func_1125()
    change_key_signature("Minor", 3)
end

function func_1126()
    change_key_signature("Major", -6)
end

function func_1127()
    change_key_signature("Major", 1)
end

function func_1128()
    change_key_signature("Minor", -2)
end

function func_1129()
    change_key_signature("Minor", 5)
end

function func_1130()
    change_key_signature("HideShow", nil)
end

function func_1131()
    change_key_signature("Keyless", nil)
end

function func_1200()
    local music_region = finenv.Region()
    local m = finale.FCMeasure()
    if m:Load(music_region:GetStartMeasure()) then
        m.PageBreak = true
        m:Save()
    end
end

function func_1201()
    local music_region = finenv.Region()
    local m = finale.FCMeasure()
    if m:Load(music_region:GetStartMeasure()) then
        m.PageBreak = false
        m:Save()
    end
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

function func_9031()
    baseline_reset(finale.BASELINEMODE_EXPRESSIONBELOW)
end

function func_9032()
    baseline_reset(finale.BASELINEMODE_EXPRESSIONABOVE)
end

function func_9033()
    baseline_reset(finale.BASELINEMODE_EXPRESSIONBELOW)
    baseline_reset(finale.BASELINEMODE_EXPRESSIONABOVE)
end

function func_9034()
    baseline_reset(finale.BASELINEMODE_CHORD)
end

function func_9035()
    baseline_reset(finale.BASELINEMODE_FRETBOARD)
end

function func_9036()
    baseline_reset(finale.BASELINEMODE_CHORD)
    baseline_reset(finale.BASELINEMODE_FRETBOARD)
end

function func_9037()
    simple_art_to_exp_swap(",", "Breath Mark", 44)
end

function func_9038()
    simple_art_to_exp_swap("\"", "Caesura", 34)
end

function func_9039()
    for e in eachentrysaved(finenv.Region()) do
    if e:IsRest() then
            if e:GetArticulationFlag() then
                e:SetArticulationFlag(false)
            end
        end
    end
end

function func_9040()
    function change_octave(pitch_string, n)
        pitch_string.LuaString = pitch_string.LuaString:sub(1, -2) .. (tonumber(string.sub(pitch_string.LuaString, -1)) + n)
        return pitch_string
    end

    function up_diatonic_fourth(pitch_string)
        local letters = "ABCDEFGABCDEFG"
        local note_name_pos = letters:find(pitch_string.LuaString:sub(1,1))
        local new_note = letters:sub(note_name_pos + 3, note_name_pos + 3)
        pitch_string.LuaString = new_note .. pitch_string.LuaString:sub(2)

        if (note_name_pos >= 7) or (note_name_pos <= 2) then
            pitch_string = change_octave(pitch_string, 1)
        end
        return pitch_string
    end

    function main() 
        for entry in eachentrysaved(finenv.Region()) do
            if (entry.Count == 1) then 
                local note = entry:CalcLowestNote(nil)
                local pitch_string = finale.FCString()
                local measure = entry:GetMeasure()
                measure_object = finale.FCMeasure()
                measure_object:Load(measure)
                local key_sig = measure_object:GetKeySignature()
                note:GetString(pitch_string, key_sig, false, false)
                pitch_string = change_octave(pitch_string, -2)
                note:SetString(pitch_string, key_sig, false)
                local new_note = entry:AddNewNote()
            
                new_note:SetString(up_diatonic_fourth(pitch_string), key_sig, false)
            
                if (new_note:CalcMIDIKey() - note:CalcMIDIKey() ~= 5) then
                    local error = new_note:CalcMIDIKey() - note:CalcMIDIKey() - 5
                    new_note.RaiseLower = new_note.RaiseLower - error
                end
            
                local notehead = finale.FCNoteheadMod()
                notehead:EraseAt(new_note)
                notehead.CustomChar = 79
                notehead.Resize = 110
                notehead:SaveAt(new_note)
            end
        end
    end

    main()
end

dialog:SetTypes("String")
dialog:SetDescriptions("Enter a JetStream Finale Controller code:")

local returnvalues = dialog:Execute() 

if returnvalues ~= nil then
    if finenv.Region():IsEmpty() ~= true then
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
        if returnvalues[1] == "0138" then
            func_0138()
        end
        if returnvalues[1] == "0139" then
            func_0139()
        end
        if returnvalues[1] == "0140" then
            func_0140()
        end
        if returnvalues[1] == "0141" then
            func_0141()
        end
        if returnvalues[1] == "0142" then
            func_0142()
        end
        if returnvalues[1] == "0143" then
            func_0143()
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
        if returnvalues[1] == "0227" then
            func_0227()
        end
        if returnvalues[1] == "0228" then
            func_0228()
        end
        if returnvalues[1] == "0280" then
            func_0280()
        end
        if returnvalues[1] == "0281" then
            func_0281()
        end
        if returnvalues[1] == "0282" then
            func_0282()
        end
        if returnvalues[1] == "0300" then
            func_0300()
        end
        if returnvalues[1] == "0301" then
            func_0301()
        end
        if returnvalues[1] == "0302" then
            func_0302()
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
        if returnvalues[1] == "0530" then
            func_0530()
        end
        if returnvalues[1] == "0531" then
            func_0531()
        end
        if returnvalues[1] == "0532" then
            func_0532()
        end
        if returnvalues[1] == "0533" then
            func_0533()
        end
        if returnvalues[1] == "0534" then
            func_0534()
        end
        if returnvalues[1] == "0535" then
            func_0535()
        end
        if returnvalues[1] == "0536" then
            func_0536()
        end
        if returnvalues[1] == "0537" then
            func_0537()
        end
        if returnvalues[1] == "0538" then
            func_0538()
        end
        if returnvalues[1] == "0539" then
            func_0539()
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
        if returnvalues[1] == "0855" then
            func_0855()
        end
        if returnvalues[1] == "0856" then
            func_0856()
        end
        if returnvalues[1] == "0857" then
            func_0857()
        end
        if returnvalues[1] == "0858" then
            func_0858()
        end
        if returnvalues[1] == "0859" then
            func_0859()
        end
        if returnvalues[1] == "0860" then
            func_0860()
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
        if returnvalues[1] == "0927" then
            func_0927()
        end
        if returnvalues[1] == "0928" then
            func_0928()
        end
        if returnvalues[1] == "0929" then
            func_0929()
        end
        if returnvalues[1] == "0930" then
            func_0930()
        end
        if returnvalues[1] == "0931" then
            func_0931()
        end
        if returnvalues[1] == "0932" then
            func_0932()
        end
        if returnvalues[1] == "0933" then
            func_0933()
        end
        if returnvalues[1] == "0934" then
            func_0934()
        end
        if returnvalues[1] == "0935" then
            func_0935()
        end
        if returnvalues[1] == "0936" then
            func_0936()
        end
        if returnvalues[1] == "1000" then
            func_1000()
        end
        if returnvalues[1] == "1001" then
            func_1001()
        end
        if returnvalues[1] == "1002" then
            func_1002()
        end
        if returnvalues[1] == "1003" then
            func_1003()
        end
        if returnvalues[1] == "1004" then
            func_1004()
        end
        if returnvalues[1] == "1005" then
            func_1005()
        end
        if returnvalues[1] == "1006" then
            func_1006()
        end
        if returnvalues[1] == "1007" then
            func_1007()
        end
        if returnvalues[1] == "1008" then
            func_1008()
        end
        if returnvalues[1] == "1009" then
            func_1009()
        end
        if returnvalues[1] == "1010" then
            func_1010()
        end
        if returnvalues[1] == "1011" then
            func_1011()
        end
        if returnvalues[1] == "1012" then
            func_1012()
        end
        if returnvalues[1] == "1013" then
            func_1013()
        end
        if returnvalues[1] == "1014" then
            func_1014()
        end
        if returnvalues[1] == "1015" then
            func_1015()
        end
        if returnvalues[1] == "1016" then
            func_1016()
        end
        if returnvalues[1] == "1017" then
            func_1017()
        end
        if returnvalues[1] == "1018" then
            func_1018()
        end
        if returnvalues[1] == "1019" then
            func_1019()
        end
        if returnvalues[1] == "1020" then
            func_1020()
        end
        if returnvalues[1] == "1021" then
            func_1021()
        end
        if returnvalues[1] == "1022" then
            func_1022()
        end
        if returnvalues[1] == "1023" then
            func_1023()
        end
        if returnvalues[1] == "1024" then
            func_1024()
        end
        if returnvalues[1] == "1025" then
            func_1025()
        end
        if returnvalues[1] == "1100" then
            func_1100()
        end
        if returnvalues[1] == "1101" then
            func_1101()
        end
        if returnvalues[1] == "1102" then
            func_1102()
        end
        if returnvalues[1] == "1103" then
            func_1103()
        end
        if returnvalues[1] == "1104" then
            func_1104()
        end
        if returnvalues[1] == "1105" then
            func_1105()
        end
        if returnvalues[1] == "1106" then
            func_1106()
        end
        if returnvalues[1] == "1107" then
            func_1107()
        end
        if returnvalues[1] == "1108" then
            func_1108()
        end
        if returnvalues[1] == "1109" then
            func_1109()
        end
        if returnvalues[1] == "1110" then
            func_1110()
        end
        if returnvalues[1] == "1111" then
            func_1111()
        end
        if returnvalues[1] == "1112" then
            func_1112()
        end
        if returnvalues[1] == "1113" then
            func_1113()
        end
        if returnvalues[1] == "1114" then
            func_1114()
        end
        if returnvalues[1] == "1115" then
            func_1115()
        end
        if returnvalues[1] == "1116" then
            func_1116()
        end
        if returnvalues[1] == "1117" then
            func_1117()
        end
        if returnvalues[1] == "1118" then
            func_1118()
        end
        if returnvalues[1] == "1119" then
            func_1119()
        end
        if returnvalues[1] == "1120" then
            func_1120()
        end
        if returnvalues[1] == "1121" then
            func_1121()
        end
        if returnvalues[1] == "1122" then
            func_1122()
        end
        if returnvalues[1] == "1123" then
            func_1123()
        end
        if returnvalues[1] == "1124" then
            func_1124()
        end
        if returnvalues[1] == "1125" then
            func_1125()
        end
        if returnvalues[1] == "1126" then
            func_1126()
        end
        if returnvalues[1] == "1127" then
            func_1127()
        end
        if returnvalues[1] == "1128" then
            func_1128()
        end
        if returnvalues[1] == "1129" then
            func_1129()
        end
        if returnvalues[1] == "1130" then
            func_1130()
        end
        if returnvalues[1] == "1131" then
            func_1131()
        end
        if returnvalues[1] == "1200" then
            func_1200()
        end
        if returnvalues[1] == "1201" then
            func_1201()
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
        if returnvalues[1] == "9031" then
            func_9031()
        end
        if returnvalues[1] == "9032" then
            func_9032()
        end
        if returnvalues[1] == "9033" then
            func_9033()
        end
        if returnvalues[1] == "9034" then
            func_9034()
        end
        if returnvalues[1] == "9035" then
            func_9035()
        end
        if returnvalues[1] == "9036" then
            func_9036()
        end
        if returnvalues[1] == "9037" then
            func_9037()
        end
        if returnvalues[1] == "9038" then
            func_9038()
        end
        if returnvalues[1] == "9039" then
            func_9039()
        end
        if returnvalues[1] == "9040" then
            func_9040()
        end
    else
        if returnvalues[1] == "0000" then
            func_0000()
        elseif returnvalues[1] == "8000" then
            func_8000()
        elseif returnvalues[1] == "8001" then
            func_8001()
        elseif returnvalues[1] == "9004" then
            func_9004()
        else
            finenv.UI():AlertInfo("Please select a region and try again.", nil)
            return
        end
    end
end