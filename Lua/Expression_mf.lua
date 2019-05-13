function plugindef()
    finaleplugin.RequireSelection = true
    finaleplugin.Author = "CJ Garcia"
    finaleplugin.Copyright = "© 2019 CJ Garcia Music"
    finaleplugin.Version = "0.1"
    finaleplugin.Date = "5/10/2019"
    finaleplugin.CategoryTags = "Expression"
    return "Expression - Add mf", "Expression - Add mf", "Adds a mf to the selected notes in a region"
end

first_expression = {}

function CreateExpression(glyph, table_name)
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
    -- ex_ted:
    ex_ted:SaveNew()
    table.insert(table_name, ex_ted:GetItemNo())  
end

function findExpression(font, glyph, table_name)
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
        print("Needs to be created", already_exists)
        print("Creating expression...")
        CreateExpression(string.sub(glyph, 2), table_name)
    else
        print("It exists:", matching_glyphs[1])
        -- exp_def:Load(matching_glyphs[1])
        -- table.insert(table_name, exp_def:GetItemNo())  
    end
end

findExpression("^^fontMus", ")F", first_expression)

for key, value in pairs(first_expression) do
    print("Expression located at:", value)
end