-- Config
hl.config({
    ecosystem = {
        enforce_permissions = true,
    },
})
hl.config({
    general = {
        gaps_in          = 2,
        col              = {
            active_border   = '#08FFFFFF',
            inactive_border = '#808080FF',
        },
        allow_tearing    = true,
        resize_on_border = true,
        layout           = 'dwindle',
    },
})
hl.config({
    decoration = {
        shadow = {
            enabled = false,
        },
        blur   = {
            enabled = false,
        },
    },
})
hl.config({
    animations = {
        enabled = true,
    },
})
hl.config({
    dwindle = {
        preserve_split = true,
    },
})
hl.config({
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
        middle_click_paste      = false,
    },
})

hl.config({
    input = {
        kb_layout   = 'us',
        sensitivity = 0,
        touchpad    = {
            natural_scroll = false,
        },
    },
})
-- Monitor
hl.monitor({
    output   = '',
    mode     = '2560x1440@60',
    position = 'auto',
    scale    = '1.5',
})
-- Autostart
hl.on('hyprland.start', function()
    hl.exec_raw('exec waybar')
    hl.exec_raw('exec hyprpaper')
    hl.exec_raw('exec /usr/libexec/fcitx5-wayland-launcher --reopen')
end)
-- Env
hl.env('XCURSOR_SIZE', '24')
hl.env('HYPRCURSOR_SIZE', '24')
-- Permission
hl.permission('/usr/.+/grim', 'screencopy', 'allow')
hl.permission('/usr/.+/xdg-desktop-portal-kde', 'screencopy', 'allow')
-- Animation
-- hl.curve('easeOutQuint', { type = 'bezier', points = { { 0.23, 1 }, { 0.32, 1 } } })
-- hl.curve('easeInOutCubic', { type = 'bezier', points = { { 0.65, 0.05 }, { 0.36, 1 } } })
-- hl.curve('linear', { type = 'bezier', points = { { 0, 0 }, { 1, 1 } } })
-- hl.curve('almostLinear', { type = 'bezier', points = { { 0.5, 0.5 }, { 0.75, 1 } } })
-- hl.curve('quick', { type = 'bezier', points = { { 0.15, 0 }, { 0.1, 1 } } })
-- hl.curve('easy', { type = 'spring', mass = 1, stiffness = 71.2633, dampening = 15.8273644 })
hl.curve('SpeedUpDown', { type = 'bezier', points = { { 1, 0 }, { 0, 1 } } })
hl.animation({ leaf = 'global', enabled = true, speed = 4, bezier = 'SpeedUpDown' })
-- hl.animation({ leaf = 'border', enabled = true, speed = 5.39, bezier = 'easeOutQuint' })
-- hl.animation({ leaf = 'windows', enabled = true, speed = 4.79, spring = 'easy' })
-- hl.animation({ leaf = 'windowsIn', enabled = true, speed = 4.1, spring = 'easy', style = 'popin 87%' })
-- hl.animation({ leaf = 'windowsOut', enabled = true, speed = 1.49, bezier = 'linear', style = 'popin 87%' })
-- hl.animation({ leaf = 'fadeIn', enabled = true, speed = 1.73, bezier = 'almostLinear' })
-- hl.animation({ leaf = 'fadeOut', enabled = true, speed = 1.46, bezier = 'almostLinear' })
-- hl.animation({ leaf = 'fade', enabled = true, speed = 3.03, bezier = 'quick' })
-- hl.animation({ leaf = 'layers', enabled = true, speed = 3.81, bezier = 'easeOutQuint' })
-- hl.animation({ leaf = 'layersIn', enabled = true, speed = 4, bezier = 'easeOutQuint', style = 'fade' })
-- hl.animation({ leaf = 'layersOut', enabled = true, speed = 1.5, bezier = 'linear', style = 'fade' })
-- hl.animation({ leaf = 'fadeLayersIn', enabled = true, speed = 1.79, bezier = 'almostLinear' })
-- hl.animation({ leaf = 'fadeLayersOut', enabled = true, speed = 1.39, bezier = 'almostLinear' })
-- hl.animation({ leaf = 'workspaces', enabled = true, speed = 1.94, bezier = 'almostLinear', style = 'fade' })
-- hl.animation({ leaf = 'workspacesIn', enabled = true, speed = 1.21, bezier = 'almostLinear', style = 'fade' })
-- hl.animation({ leaf = 'workspacesOut', enabled = true, speed = 1.94, bezier = 'almostLinear', style = 'fade' })
-- hl.animation({ leaf = 'zoomFactor', enabled = true, speed = 7, bezier = 'quick' })
-- Gesture
hl.gesture({
    fingers = 3,
    direction = 'horizontal',
    action = 'workspace'
})
-- Bind
local terminal    = 'exec wezterm start --cwd .'
local fileManager = 'exec wezterm start --cwd . -- spf'
local menu        = 'exec wofi'
local browser     = 'exec chromium'

hl.bind('SUPER + C', hl.dsp.exec_raw(browser))
hl.bind('SUPER + E', hl.dsp.exec_raw(fileManager))
hl.bind('SUPER + R', hl.dsp.exec_raw(menu))
hl.bind('SUPER + T', hl.dsp.exec_raw(terminal))
hl.bind('SUPER + L', hl.dsp.exec_raw('exec hyprshutdown', { long_press = true }))

hl.bind('Print', hl.dsp.exec_raw('slurp|grim -g - -|wl-copy'))
hl.bind('Print', hl.dsp.exec_raw('grim -|wl-copy'), { long_press = true })
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_raw('exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+'), { repeating = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_raw('exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-'), { repeating = true })
hl.bind('XF86AudioMute', hl.dsp.exec_raw('exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'))
hl.bind('SUPER + XF86AudioRaiseVolume', hl.dsp.exec_raw('exec brightnessctl set 1%+'), { repeating = true })
hl.bind('SUPER + XF86AudioLowerVolume', hl.dsp.exec_raw('exec brightnessctl set 1%-'), { repeating = true })

hl.bind('SUPER + up', hl.dsp.focus({ direction = 'up' }))
hl.bind('SUPER + down', hl.dsp.focus({ direction = 'down' }))
hl.bind('SUPER + left', hl.dsp.focus({ direction = 'left' }))
hl.bind('SUPER + right', hl.dsp.focus({ direction = 'right' }))
hl.bind('SUPER + mouse_down', hl.dsp.focus({ workspace = 'e+1' }))
hl.bind('SUPER + mouse_up', hl.dsp.focus({ workspace = 'e-1' }))
hl.bind('SUPER + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind('SUPER + mouse:273', hl.dsp.window.resize(), { mouse = true })

hl.bind('SUPER + Tab', hl.dsp.window.float({ action = 'toggle' }))
hl.bind('SUPER + W', hl.dsp.window.close())
hl.bind('SUPER + W', hl.dsp.window.kill(), { long_press = true })
hl.bind('SUPER + P', hl.dsp.window.pseudo())


for i = 0, 10 do
    local key = i % 10
    hl.bind('SUPER + ' .. key, hl.dsp.focus({ workspace = i }))
    hl.bind('SUPER + SHIFT + ' .. key, hl.dsp.window.move({ workspace = i }))
end
-- Misc
-- hl.window_rule({
--     name           = 'suppress-maximize-events',
--     match          = { class = '.*' },
--     suppress_event = 'maximize',
-- })
hl.window_rule({
    name     = 'fix-xwayland-drags',
    match    = {
        class      = '^$',
        title      = '^$',
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})
