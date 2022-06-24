function plugindef()
  -- This function and the 'finaleplugin' namespace
  -- are both reserved for the plug-in definition.
  finaleplugin.Author = "Jacob Winkler"
  finaleplugin.Copyright = "2022"
  finaleplugin.Version = ".1"
  finaleplugin.Date = "2/13/2022"
  return "JetStream Configuration", "JetStream Configuration", "JetStream Configuration"
end
-- finalelua library functions

local strip_leading_trailing_whitespace = function (str)
  return str:match("^%s*(.-)%s*$") -- lua pattern magic taken from the Internet
end

local parse_parameter -- forward function declaration

local parse_table = function(val_string)
  local ret_table = {}
  for element in val_string:gmatch('[^,%s]+') do  -- lua pattern magic taken from the Internet
    local parsed_element = parse_parameter(element)
    table.insert(ret_table, parsed_element)
  end
  return ret_table
end

parse_parameter = function(val_string)
  if '"' == val_string:sub(1,1) and '"' == val_string:sub(#val_string,#val_string) then -- double-quote string
    return string.gsub(val_string, '"(.+)"', "%1") -- lua pattern magic: "(.+)" matches all characters between two double-quote marks (no escape chars)
  elseif "'" == val_string:sub(1,1) and "'" == val_string:sub(#val_string,#val_string) then -- single-quote string
    return string.gsub(val_string, "'(.+)'", "%1") -- lua pattern magic: '(.+)' matches all characters between two single-quote marks (no escape chars)
  elseif "{" == val_string:sub(1,1) and "}" == val_string:sub(#val_string,#val_string) then
    return parse_table(string.gsub(val_string, "{(.+)}", "%1"))
  elseif "true" == val_string then
    return true
  elseif "false" == val_string then
    return false
  end
--    return tonumber(val_string)
  return val_string
end

local get_parameters_from_file = function(file_name) -- modified
  local parameters = {}
  for line in io.lines(file_name) do
    local comment_marker = "--"
    local parameter_delimiter = "="
    local comment_at = string.find(line, comment_marker, 1, true) -- true means find raw string rather than lua pattern
    if nil ~= comment_at then
      line = string.sub(line, 1, comment_at-1)
    end
    local delimiter_at = string.find(line, parameter_delimiter, 1, true)
    if nil ~= delimiter_at then
      local name = strip_leading_trailing_whitespace(string.sub(line, 1, delimiter_at-1))
      local val_string = strip_leading_trailing_whitespace(string.sub(line, delimiter_at+1))
      parameters[name] = parse_parameter(val_string)
    end
  end

  return parameters
end

-- this one is still from library, but modified...
function get_parameters(file_name, parameter_list)

  local file_parameters = get_parameters_from_file(file_name)

  if nil ~= file_parameters then
    for param_name, def_val in pairs(file_parameters) do
      local param_val = file_parameters[param_name]
      if nil ~= param_val then
        parameter_list[param_name] = param_val
      end
    end
  end
  return parameter_list
end

--------------------------------------
function path_set(filename)
  local path = finale.FCString()
  local path_delimiter = finale.FCString()
  local ui = finenv.UI()
  path:SetUserOptionsPath()
  if ui:IsOnMac() then
    path_delimiter.LuaString = "/"
  elseif ui:IsOnWindows() then
    path_delimiter.LuaString = "\\"
    --path_delimiter.LuaString = "/" -- apparently Windows can use either! Go figure!
  end
  path.LuaString = path.LuaString..path_delimiter.LuaString..filename
  return path
end

function config_load()
  local path = path_set("com.jetstreamfinale.config.txt")
  local config_settings = {}
  local init_settings = {tacet_text = "Tacet", al_fine_text = "tacet al fine", play_x_bars_prefix = "PLAY", play_x_bars_suffix = "BARS", play_x_more_prefix = "PLAY", play_x_more_suffix = "MORE", dynamic_L_cushion = 18, dynamic_R_cushion = 18, noteentry_cushion = 32, staff_cushion = 24, nudge_normal = 12, nudge_large = 24, x_type = 0,}
  local init_count = 0
  -- This next might not be needed... But doesn't hurt so leaving it in for now...
  for i,k in pairs(init_settings) do
    init_count = init_count + 1
  end
  --
  local file_r = io.open(path.LuaString, "r")
  if file_r == nil then
    config_settings = init_settings
    config_save(config_settings)
    file_r = io.open(path.LuaString, "r")
  end

  config_settings = get_parameters(path.LuaString, config_settings)

  for key, val in pairs(init_settings) do
    if config_settings[key] == nil then
      config_settings[key] = val
    end
  end
  return config_settings
end -- config_load()

function config_save(config_settings)
  local path = path_set("com.jetstreamfinale.config.txt")
  local file_w = io.open(path.LuaString, "w") 
  for key, val in pairs(config_settings) do
    file_w:write(key.." = "..val.."\n")
  end
  file_w:close()
end -- config_save()


function config_jetstream()
  local row_h = 20
  local col_w = 140
  local col_gap = 10
  local str = finale.FCString()
  str.LuaString = "JetStream Finale Controller - Settings"
  local dialog = finale.FCCustomLuaWindow()
  dialog:SetTitle(str)
--
  local row = {}
  for i = 1, 100 do
    row[i] = (i -1) * row_h
  end
--
  local col = {}
  for i = 1, 11 do
    col[i] = (i - 1) * col_w
  end
--
--[[ File IO stuff ]]--
  local config_settings = config_load()
--[[ VARIABLES FOR JETSTREAM ]]--
  local tacet_text = finale.FCString()
  tacet_text.LuaString = config_settings.tacet_text
  --
  local al_fine_text = finale.FCString()
  al_fine_text.LuaString = config_settings.al_fine_text
  --
  local play_x_bars_prefix = finale.FCString()
  play_x_bars_prefix.LuaString = config_settings.play_x_bars_prefix
  local play_x_bars_suffix = finale.FCString()
  play_x_bars_suffix.LuaString = config_settings.play_x_bars_suffix
--
  local play_x_more_prefix = finale.FCString()
  play_x_more_prefix.LuaString = config_settings.play_x_more_prefix
  local play_x_more_suffix = finale.FCString()
  play_x_more_suffix.LuaString = config_settings.play_x_more_suffix
--
  local dynamic_L_cushion = finale.FCString()
  dynamic_L_cushion.LuaString = config_settings.dynamic_L_cushion
  local dynamic_R_cushion = finale.FCString()
  dynamic_R_cushion.LuaString = config_settings.dynamic_R_cushion
--
  local noteentry_cushion = finale.FCString()
  noteentry_cushion.LuaString = config_settings.noteentry_cushion
  local staff_cushion = finale.FCString()
  staff_cushion.LuaString = config_settings.staff_cushion
  --
  local nudge_normal = finale.FCString()
  nudge_normal.LuaString = config_settings.nudge_normal
  local nudge_large = finale.FCString()
  nudge_large.LuaString = config_settings.nudge_large
  --
--  local x_type = tonumber(config_settings.x_type)
  local x_type = config_settings.x_type
--
  function add_ctrl(dialog, ctrl_type, text, x, y, h, w, min, max)
    str.LuaString = text
    local ctrl = ""
    if ctrl_type == "button" then
      ctrl = dialog:CreateButton(x, y)
    elseif ctrl_type == "checkbox" then
      ctrl = dialog:CreateCheckbox(x, y)
    elseif ctrl_type == "datalist" then
      ctrl = dialog:CreateDataList(x, y)
    elseif ctrl_type == "edit" then
      ctrl = dialog:CreateEdit(x, y - 2)
    elseif ctrl_type == "horizontalline" then
      ctrl = dialog:CreateHorizontalLine(x, y, w)
    elseif ctrl_type == "listbox" then
      ctrl = dialog:CreateListBox(x, y)
    elseif ctrl_type == "popup" then
      ctrl = dialog:CreatePopup(x, y)
    elseif ctrl_type == "slider" then
      ctrl = dialog:CreateSlider(x, y)
      ctrl:SetMaxValue(max)
      ctrl:SetMinValue(min)
    elseif ctrl_type == "static" then
      ctrl = dialog:CreateStatic(x, y)
    elseif ctrl_type == "switcher" then
      ctrl = dialog:CreateSwitcher(x, y)
    elseif ctrl_type == "tree" then
      ctrl = dialog:CreateTree(x, y)
    elseif ctrl_type == "updown" then
      ctrl = dialog:CreateUpDown(x, y)
    elseif ctrl_type == "verticalline" then
      ctrl = dialog:CreateVerticalLine(x, y, h)
    end
    if ctrl_type == "edit" then
      ctrl:SetHeight(h-2)
      ctrl:SetWidth(w - col_gap)
    else
      ctrl:SetHeight(h)
      ctrl:SetWidth(w)
    end
    ctrl:SetText(str)
    return ctrl
  end -- add_ctrl()

  local tacet_static = add_ctrl(dialog, "static", "Text for 'Tacet' parts:", col[1], row[1], row_h, col_w, 0, 0)
  local tacet_edit = add_ctrl(dialog, "edit", tacet_text.LuaString, col[2], row[1], row_h, col_w, 0, 0)
  --
  local al_fine_static = add_ctrl(dialog, "static", "Text for 'tacet al fine':", col[1], row[2], row_h, col_w, 0, 0)
  local al_fine_edit = add_ctrl(dialog, "edit", al_fine_text.LuaString, col[2], row[2], row_h, col_w, 0, 0)
  --
  add_ctrl(dialog, "horizontalline", "", col[1], row[3] + 10, 1, col_w * 3, 0, 0)
  --
  local play_x_bars_static = add_ctrl(dialog, "static", "Play X Bars:", col[1], row[4], row_h, col_w, 0, 0)
  local play_x_bars_prefix_edit = add_ctrl(dialog, "edit", play_x_bars_prefix.LuaString, col[2], row[4], row_h, col_w - 40, 0, 0)
  local play_x_bars_x_static = add_ctrl(dialog, "static", "X", col[3] - 45, row[4], row_h, col_w, 0, 0)
  local play_x_bars_suffix_edit = add_ctrl(dialog, "edit", play_x_bars_suffix.LuaString, col[3] - 30, row[4], row_h, col_w - 40, 0, 0)
  --
  local play_x_more_static = add_ctrl(dialog, "static", "Play X More:", col[1], row[5], row_h, col_w, 0, 0)
  local play_x_more_prefix_edit = add_ctrl(dialog, "edit", play_x_more_prefix.LuaString, col[2], row[5], row_h, col_w - 40, 0, 0)
  local play_x_more_x_static = add_ctrl(dialog, "static", "X", col[3] - 45, row[5], row_h, col_w, 0, 0)
  local play_x_more_suffix_edit = add_ctrl(dialog, "edit", play_x_more_suffix.LuaString, col[3] - 30, row[5], row_h, col_w - 40, 0, 0)
  --
  add_ctrl(dialog, "horizontalline", "", col[1], row[6] + 10, 1, col_w * 3, 0, 0)
  --
  local dynamics_cushions_static = add_ctrl(dialog, "static", "Dynamics Cushions (EVPUs: 24 = 1 space)", col[1], row[7], row_h, col_w * 3, 0, 0)
  local dynamic_cushion_1_static = add_ctrl(dialog, "static", "Dynamic to Hairpins:", col[1], row[8], row_h, col_w, 0, 0)
  local L = add_ctrl(dialog, "static", "L", col[2] - 10, row[8], row_h, 20, 0, 0)
  local R = add_ctrl(dialog, "static", "R", col[2] + 50, row[8], row_h, 20, 0, 0)
  local dynamic_L_cushion_edit = add_ctrl(dialog, "edit", dynamic_L_cushion.LuaString, col[2], row[8], row_h, 40, 0, 0)
  local dynamic_R_cushion_edit = add_ctrl(dialog, "edit", dynamic_R_cushion.LuaString, col[2] + 60, row[8], row_h, 40, 0, 0)
  --

  local dynamic_cushion_2_static = add_ctrl(dialog, "static", "Lone Hairpins:", col[1], row[9], row_h, col_w +20, 0, 0)

  local noteentry_cushion_static = add_ctrl(dialog, "static", "Notes", col[2] - 30, row[9], row_h, 40, 0, 0)
  local staff_cushion_static = add_ctrl(dialog, "static", "Staff", col[2] + 35, row[9], row_h, 40, 0, 0)
  local noteentry_cushion_edit = add_ctrl(dialog, "edit", noteentry_cushion.LuaString, col[2], row[9], row_h, 40, 0, 0)
  local staff_cushion_edit = add_ctrl(dialog, "edit", staff_cushion.LuaString, col[2] + 60, row[9], row_h, 40, 0, 0)
--
  local nudge_static = add_ctrl(dialog, "static", "Nudge amounts:", col[1], row[10], row_h, col_w, 0, 0)
  local nudge_normal_edit = add_ctrl(dialog, "edit", nudge_normal.LuaString, col[2], row[10], row_h, 40, 0, 0)
  local nudge_large_edit = add_ctrl(dialog, "edit", nudge_large.LuaString, col[2] + 60, row[10], row_h, 40, 0, 0)



  --
  add_ctrl(dialog, "horizontalline", "", col[1], row[11] + 10, 1, col_w * 3, 0, 0)
  --
  local x_type_static = add_ctrl(dialog, "static", "Default X-notehead type:", col[1], row[12], row_h, col_w, 0, 0)
  local x_type_popup = add_ctrl(dialog, "popup", "", col[2], row[12], row_h, col_w, 0, 0)
  local x_types = {"Xs and Circled Xs","Xs and Diamonds"}
  for i,j in pairs(x_types) do
    str.LuaString = x_types[i]
    x_type_popup:AddString(str)
  end   
  x_type_popup:SetSelectedItem(x_type)

--[[ ]]
  dialog:CreateOkButton()
  dialog:CreateCancelButton()
--
  function callback(ctrl)
  end -- callback
--
  dialog:RegisterHandleCommand(callback)
--
  if dialog:ExecuteModal(nil) == finale.EXECMODAL_OK then
    tacet_edit:GetText(tacet_text)
    config_settings.tacet_text = tacet_text.LuaString
    --
    al_fine_edit:GetText(al_fine_text)
    config_settings.al_fine_text = al_fine_text.LuaString
    --
    play_x_bars_prefix_edit:GetText(play_x_bars_prefix)
    config_settings.play_x_bars_prefix = play_x_bars_prefix.LuaString
    play_x_bars_suffix_edit:GetText(play_x_bars_suffix)
    config_settings.play_x_bars_suffix = play_x_bars_suffix.LuaString
    --
    play_x_more_prefix_edit:GetText(play_x_more_prefix)
    config_settings.play_x_more_prefix = play_x_more_prefix.LuaString
    play_x_more_suffix_edit:GetText(play_x_more_suffix)
    config_settings.play_x_more_suffix = play_x_more_suffix.LuaString
    --
    dynamic_L_cushion_edit:GetText(dynamic_L_cushion)
    config_settings.dynamic_L_cushion = dynamic_L_cushion.LuaString
    dynamic_R_cushion_edit:GetText(dynamic_R_cushion)
    config_settings.dynamic_R_cushion = dynamic_R_cushion.LuaString
    noteentry_cushion_edit:GetText(noteentry_cushion)
    config_settings.noteentry_cushion = noteentry_cushion.LuaString
    staff_cushion_edit:GetText(staff_cushion)
    config_settings.staff_cushion = staff_cushion.LuaString
    --
    nudge_normal_edit:GetText(nudge_normal)
    config_settings.nudge_normal = nudge_normal.LuaString
    nudge_large_edit:GetText(nudge_large)
    config_settings.nudge_large = nudge_large.LuaString
    --
    config_settings.x_type = x_type_popup:GetSelectedItem()
    --
    config_save(config_settings)
  end
end -- config_jetstream()

--config_jetstream()