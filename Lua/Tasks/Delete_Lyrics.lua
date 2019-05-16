function plugindef()
    finaleplugin.RequireSelection = true
    finaleplugin.Author = "CJ Garcia"
    finaleplugin.Copyright = "© 2019 CJ Garcia Music"
    finaleplugin.Version = "0.1"
    finaleplugin.Date = "5/11/2019"
    finaleplugin.CategoryTags = "Expression"
    return "Delete All Lyrics", "Delete All Lyrics", "Deltes all of the lyrics in the selected region, does not delete them from the document."
end

for noteentry in eachentry(finenv.Region()) do
    --delete Chorus Lyrics
    local cs = finale.FCChorusSyllable()
    cs:SetNoteEntry(noteentry)
    if cs:LoadFirst() then
        cs:DeleteData()
    end
    --delete Verse Lyrics
    local vs = finale.FCVerseSyllable()
    vs:SetNoteEntry(noteentry)
    if vs:LoadFirst() then
        vs:DeleteData()
    end
    --delete Section Lyrics
    local ss = finale.FCSectionSyllable()
    ss:SetNoteEntry(noteentry)
    if ss:LoadFirst() then
        local myBooleanResult = ss:DeleteData()
    end
end