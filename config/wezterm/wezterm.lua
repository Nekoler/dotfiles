local wezterm = require('wezterm')
local config = {}
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.default_cursor_style = 'BlinkingBlock'
config.enable_scroll_bar = true
config.font = wezterm.font_with_fallback({ 'Consolas', 'HarmonyOS Sans SC' })
config.hide_mouse_cursor_when_typing = false
config.initial_cols = 120
config.initial_rows = 30
config.window_decorations = 'INTEGRATED_BUTTONS'
config.window_frame = { font_size = 12 }
config.window_padding = { left = 4, right = 12, top = 0, bottom = 0 }
config.prefer_to_spawn_tabs = true
config.launch_menu = { { label = 'Bash', args = { 'bash' } } }
config.default_prog = config.launch_menu[1].args
config.colors = {
    foreground = '#CCCCCC',
    background = '#282828',
    cursor_fg = '#282828',
    cursor_bg = '#FFFFFF',
    cursor_border = '#FFFFFF',
    selection_fg = '#282828',
    selection_bg = '#FFFFFF',
    scrollbar_thumb = '#9D9D9D',
    tab_bar = { active_tab = { fg_color = '#F7F7F7', bg_color = '#282828' } },
}
config.disable_default_key_bindings = true
config.keys = {
    { key = 'w',   mods = 'CTRL', action = wezterm.action.CloseCurrentTab({ confirm = true }) },
    { key = '=',   mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
    { key = '-',   mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
    { key = 'f',   mods = 'CTRL', action = wezterm.action.Search({ CaseInSensitiveString = '' }) },
    { key = 'F11', mods = 'NONE', action = wezterm.action.ToggleFullScreen },
}
config.disable_default_mouse_bindings = true
config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = { WheelUp = 1 } } },
        mods = 'NONE',
        action = wezterm.action.ScrollByLine(-3),
    },
    {
        event = { Down = { streak = 1, button = { WheelDown = 1 } } },
        mods = 'NONE',
        action = wezterm.action.ScrollByLine(3),
    },
    {
        event = { Down = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
    {
        event = { Down = { streak = 1, button = 'Left' } },
        mods = 'SHIFT',
        action = wezterm.action.ExtendSelectionToMouseCursor('Cell'),
    },
    {
        event = { Down = { streak = 2, button = 'Left' } },
        mods = 'NONE',
        action = wezterm.action.ExtendSelectionToMouseCursor('Word'),
    },
    { event = { Down = { streak = 1, button = 'Left' } }, mods = 'NONE', action = wezterm.action.ClearSelection },
    {
        event = { Drag = { streak = 1, button = 'Left' } },
        mods = 'NONE',
        action = wezterm.action.ExtendSelectionToMouseCursor('Cell'),
    },
    {
        event = { Down = { streak = 1, button = 'Right' } },
        mods = 'NONE',
        action = wezterm.action_callback(function(window, pane)
            if window:get_selection_text_for_pane(pane) == '' then
                window:perform_action(wezterm.action.PasteFrom('Clipboard'), pane)
            else
                window:perform_action(wezterm.action.CopyTo('Clipboard'), pane)
                window:perform_action(wezterm.action.ClearSelection, pane)
            end
        end),
    },
}
return config
