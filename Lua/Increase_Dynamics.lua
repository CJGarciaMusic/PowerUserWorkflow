function plugindef()
    finaleplugin.RequireSelection = false
    finaleplugin.Author = "CJ Garcia"
    finaleplugin.Copyright = "© 2019 CJ Garcia Music"
    finaleplugin.Version = "0.1"
    finaleplugin.Date = "5/10/2019"
    finaleplugin.CategoryTags = "Expression"
    return "Increase Dynamic", "Increase Dynamic", "Increases the dynamic by 1 up to ffff starting at pppp"
end

expression_list = {}

function findExpression(font, glyph)
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
    exp_def:Load(matching_glyphs[1])
    table.insert(expression_list, exp_def:GetItemNo())  
end

findExpression("^^fontMus", ")ë")
findExpression("^^fontMus", ")ì")
findExpression("^^fontMus", ")Ä")
findExpression("^^fontMus", ")f")
findExpression("^^fontMus", ")F")
findExpression("^^fontMus", ")P")
findExpression("^^fontMus", ")p")
findExpression("^^fontMus", ")¹")
findExpression("^^fontMus", ")¸")
findExpression("^^fontMus", ")¯")

function increaseByOne()
    local expressions = finale.FCExpressions()
    expressions:LoadAllForRegion()
    for expression in each(expressions) do
        local item_no = expression:GetID()
        print(item_no)
    end
end