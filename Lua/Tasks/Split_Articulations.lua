function plugindef()
    finaleplugin.RequireSelection = true
    finaleplugin.Author = "CJ Garcia"
    finaleplugin.Copyright = "© 2019 MakeMusic"
    finaleplugin.Version = "1.2"
    finaleplugin.Date = "4/25/2019"
    finaleplugin.CategoryTags = "Articulation"
    return "Split Articulations", "Split Articulations", "Separates out the combined articulations in a region into two different articulations"
end

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