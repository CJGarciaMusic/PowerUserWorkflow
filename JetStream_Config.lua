function plugindef()
  -- This function and the 'finaleplugin' namespace
  -- are both reserved for the plug-in definition.
  finaleplugin.Author = "Jacob Winkler"
  finaleplugin.Copyright = "2022"
  finaleplugin.Version = ".1"
  finaleplugin.Date = "2/13/2022"
  return "JetStream Configuration", "JetStream Configuration", "JetStream Configuration"
end

function path_set(filename)
  local path = finale.FCString()
  local path_more = finale.FCString()
  local ui = finenv.UI()
  path:SetUserOptionsPath()
  if ui:IsOnMac() then
    path_more.LuaString = "/"
  elseif ui:IsOnWindows() then
    path_more.LuaString = "\\"
  end
  path.LuaString = path.LuaString..path_more.LuaString..filename
  return path
end


function config_load()
  local path = path_set("com.jetstreamfinale.config.txt")
  local config_settings = {}
  local init_settings = {"Tacet", "tacet al fine", "PLAY", "BARS", "PLAY", "MORE", 18, 0,}
  local init_count = 0
  for i,k in pairs(init_settings) do
    init_count = init_count + 1
  end
  --
  local file_r = io.open(path.LuaString, "r")
  if file_r == nil then
    print("Config file does not exist. Creating one.")
    --[[ DEFAULT JETSTREAM VARIABLES ]]
    config_settings = init_settings
    ----------------------------------------------
    config_save(config_settings)
    file_r = io.open(path.LuaString, "r")
  end
  for line in file_r:lines() do
    line = line:gsub("[\n\r]", "")
    table.insert(config_settings, line)
  end
  --[[This is to take into account older config files so they don't get confused when we add new configurable parameters.
Instead, it will grab the new parameter default values and insert them in for saving.
]]
--require('mobdebug').start()
  for i = 0, init_count do
    if config_settings[i] == nil then
      config_settings[i] = init_settings[i]
    end
  end
  return(config_settings)
end -- config_load()


function config_save(config_settings)
  local path = path_set("com.jetstreamfinale.config.txt")
  local file_w = io.open(path.LuaString, "w") 
  for a, b in pairs(config_settings) do
    file_w:write(config_settings[a].."\n")
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
  for i = 1, 11 do
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
  tacet_text.LuaString = config_settings[1]
  --
  local al_fine_text = finale.FCString()
  al_fine_text.LuaString = config_settings[2]
  --
  local play_x_bars_prefix = finale.FCString()
  play_x_bars_prefix.LuaString = config_settings[3]
  local play_x_bars_suffix = finale.FCString()
  play_x_bars_suffix.LuaString = config_settings[4]
--
  local play_x_more_prefix = finale.FCString()
  play_x_more_prefix.LuaString = config_settings[5]
  local play_x_more_suffix = finale.FCString()
  play_x_more_suffix.LuaString = config_settings[6]
--
  local dynamic_cushion = finale.FCString()
  dynamic_cushion.LuaString = config_settings[7]
--
  --local x_type = finale.FCString()
  --x_type.LuaString = config_settings[8]
  local x_type = tonumber(config_settings[8])
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
  local dynamic_cushion_static = add_ctrl(dialog, "static", "Dynamic/hairpin cushion: (EVPUs)", col[1], row[7], row_h * 2, col_w, 0, 0)
  local dynamic_cushion_edit = add_ctrl(dialog, "edit", dynamic_cushion.LuaString, col[2], row[7], row_h, 40, 0, 0)
  --
  add_ctrl(dialog, "horizontalline", "", col[1], row[8] + 10, 1, col_w * 3, 0, 0)
  --
  local x_type_static = add_ctrl(dialog, "static", "Default X-notehead type:", col[1], row[9], row_h, col_w, 0, 0)
  local x_type_popup = add_ctrl(dialog, "popup", "", col[2], row[9], row_h, col_w, 0, 0)
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
    config_settings[1] = tacet_text.LuaString
    --
    al_fine_edit:GetText(al_fine_text)
    config_settings[2] = al_fine_text.LuaString
    --
    play_x_bars_prefix_edit:GetText(play_x_bars_prefix)
    config_settings[3] = play_x_bars_prefix.LuaString
    play_x_bars_suffix_edit:GetText(play_x_bars_suffix)
    config_settings[4] = play_x_bars_suffix.LuaString
    --
    play_x_more_prefix_edit:GetText(play_x_more_prefix)
    config_settings[5] = play_x_more_prefix.LuaString
    play_x_more_suffix_edit:GetText(play_x_more_suffix)
    config_settings[6] = play_x_more_suffix.LuaString
    --
    dynamic_cushion_edit:GetText(dynamic_cushion)
    config_settings[7] = dynamic_cushion.LuaString
    --
    config_settings[8] = x_type_popup:GetSelectedItem()
    --
    config_save(config_settings)
  end
end -- config_jetstream()

--config_jetstream()