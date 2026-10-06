-- Config
hl.config({
    ecosystem = {
        enforce_permissions = true
    }
})

hl.config({
    xwayland = {
        force_zero_scaling = true
    }
})

hl.config({
    general = {
        gaps_in          = 0,
        gaps_out         = 0,
        col              = {
            active_border   = '#007F7FFF',
            inactive_border = '#808080FF'
        },
        allow_tearing    = true,
        resize_on_border = true,
        layout           = 'scrolling'
    },
})

hl.config({
    decoration = {
        shadow = {
            enabled = false
        },
        blur   = {
            enabled = false
        }
    }
})

hl.config({
    animations = {
        enabled = true
    }
})

hl.config({
    misc = {
        force_default_wallpaper  = -1,
        disable_hyprland_logo    = false,
        middle_click_paste       = false,
        disable_splash_rendering = true
    }
})

hl.config({
    input = {
        numlock_by_default = true,
        touchpad           = {
            natural_scroll = true
        }
    }
})

hl.monitor({
    output   = '',
    mode     = '2560x1440@60',
    position = 'auto',
    scale    = 'auto'
})
-- Autostart
hl.on('hyprland.start', function()
    hl.exec_cmd('exec fcitx5 --replace')
    hl.exec_cmd('exec swayosd-server')
    hl.exec_cmd('exec systemctl --user start activate-graphical-session.target')
    hl.exec_cmd('exec udiskie --smart-tray')
    hl.exec_cmd('exec wl-paste --watch cliphist store')
end)
-- Env
hl.env('XCURSOR_SIZE', '32')
hl.env('HYPRCURSOR_SIZE', '32')
hl.env('HYPRCURSOR_THEME', 'rose-pine-hyprcursor')
-- Permission
hl.permission({ binary = '/usr/.+/grim', type = 'screencopy', mode = 'allow' })
hl.permission({ binary = '/usr/.+/hyprpicker', type = 'screencopy', mode = 'allow' })
hl.permission({ binary = '/usr/.+/xdg-desktop-portal-.+', type = 'screencopy', mode = 'allow' })
-- Animation
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
hl.bind('SUPER + e', hl.dsp.exec_raw('exec kitty -e spf'))
hl.bind('SUPER + l', hl.dsp.exec_raw('exec ${HOME}/.config/hypr/power.sh'), { long_press = true })
hl.bind('SUPER + r', hl.dsp.exec_raw('exec wofi'))
hl.bind('SUPER + t', hl.dsp.exec_raw('exec kitty'))

hl.bind('Print', hl.dsp.exec_raw('slurp | grim -g - - | wl-copy'))
hl.bind('SUPER + c', hl.dsp.exec_raw('exec ${HOME}/.config/hypr/clipboard.sh'))
hl.bind('SUPER + XF86AudioLowerVolume', hl.dsp.exec_raw('exec swayosd-client --brightness=-1'), { repeating = true })
hl.bind('SUPER + XF86AudioRaiseVolume', hl.dsp.exec_raw('exec swayosd-client --brightness=+1'), { repeating = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_raw('exec swayosd-client --output-volume=-1'), { repeating = true })
hl.bind('XF86AudioMute', hl.dsp.exec_raw('exec swayosd-client --output-volume=mute-toggle'))
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_raw('exec swayosd-client --output-volume=+1'), { repeating = true })

hl.bind('SUPER + up', hl.dsp.focus({ direction = 'up' }))
hl.bind('SUPER + down', hl.dsp.focus({ direction = 'down' }))
hl.bind('SUPER + left', hl.dsp.layout('move -col'))
hl.bind('SUPER + right', hl.dsp.layout('move +col'))
hl.bind('SUPER + mouse_up', hl.dsp.layout('move -col'))
hl.bind('SUPER + mouse_down', hl.dsp.layout('move +col'))
hl.bind('SUPER + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind('SUPER + mouse:273', hl.dsp.window.resize(), { mouse = true })
hl.bind('SUPER + mouse:274', hl.dsp.exec_raw('killall hyprpicker && sleep 0.2 ; exec hyprpicker --scale=6 --radius=500'))

hl.bind('SUPER + p', hl.dsp.window.pseudo())
hl.bind('SUPER + Tab', hl.dsp.window.float({ action = 'toggle' }))
hl.bind('SUPER + w', hl.dsp.window.close())

for i = 0, 10 do
    local key = i % 10
    hl.bind('SUPER + ' .. key, hl.dsp.focus({ workspace = i }))
    hl.bind('SUPER + SHIFT + ' .. key, hl.dsp.window.move({ workspace = i }))
end
-- Rule
hl.window_rule({
    name     = 'fix-xwayland-drags',
    match    = {
        class    = '^$',
        title    = '^$',
        xwayland = true,
        float    = true
    },
    no_focus = true
})

hl.window_rule({
    name = 'no-border-float',
    match = {
        float = true
    },
    border_size = 0
})

hl.window_rule({
    name = 'popup-float',
    match = {
        title = '^$|.*(?:设置|更新)$'
    },
    float = true
})

hl.layer_rule({
    name = 'wofi-no-animation',
    match = {
        namespace = 'wofi'
    },
    no_anim = true
})
