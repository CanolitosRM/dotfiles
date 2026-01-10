import XMonad

-- Layouts
import XMonad.Layout.Spacing
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders

-- Utilities
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import XMonad.Util.Loggers

-- Hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.EwmhDesktops

-- Actions
import XMonad.Actions.Warp

import qualified Data.Map            as M
import qualified XMonad.StackSet     as W


-------------------------------------------------------------------------------
-- MAIN
-------------------------------------------------------------------------------
main :: IO ()
main = xmonad
    . docks
    . ewmhFullscreen
    . ewmh
    . withEasySB (statusBarProp myXMobar1 (pure mainXmobarPP)) defToggleStrutsKey
    $ myConfig

-------------------------------------------------------------------------------
-- CONFIGURACIÓN BASE
-------------------------------------------------------------------------------
myConfig = def
    { terminal           = myTerminal
    , modMask            = myModMask
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormalBorder
    , focusedBorderColor = myFocusedBorder
    , startupHook        = myStartupHook
    , manageHook         = myManageHook <+> manageHook def
    , layoutHook         = mySpacing $ myLayout
    , workspaces         = myWorkspaces
    , keys               = myKeys
    } `additionalKeysP` myAdditionalKeys

-------------------------------------------------------------------------------
-- VARIABLES Y ESTÉTICA
-------------------------------------------------------------------------------
myTerminal      = "alacritty"
myModMask       = mod4Mask -- Tecla Super (Windows)

myBorderWidth   = 3
myNormalBorder  = "#EAE2B7"
myFocusedBorder = pink

-- Espaciado (Gaps)
mySpacing = spacingRaw False
    (Border 8 8 8 8) True
    (Border 8 8 8 8) True

-- Workspaces (Simplificado para un solo monitor)
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-------------------------------------------------------------------------------
-- STARTUP & HOOKS
-------------------------------------------------------------------------------
myStartupHook = do
    spawnOnce "pipewire"
    spawnOnce "nitrogen --restore"
    spawnOnce "picom"
    spawnOnce "xrdb -merge ~/.config/X11/Xresources"
    spawnOnce "xsetroot -cursor_name left_ptr"

myManageHook = composeAll
    [ isDialog --> doRectFloat (W.RationalRect 0.3 0.3 0.4 0.4)
    , isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_NOTIFICATION"
        --> doRectFloat (W.RationalRect 0.35 0.35 0.3 0.2)
    , className =? "Gimp" --> doFloat
    , className =? "zenity" --> doRectFloat (W.RationalRect 0.3 0.3 0.4 0.4)
    -- Agrega aquí más reglas de ventanas si lo necesitas
    ]

-------------------------------------------------------------------------------
-- LAYOUTS
-------------------------------------------------------------------------------
myLayout = avoidStruts (tiled ||| Grid ||| smartBorders Full)
    where
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

-------------------------------------------------------------------------------
-- KEYBINDINGS (EZConfig - Estilo amigable)
-------------------------------------------------------------------------------
myAdditionalKeys :: [(String, X ())]
myAdditionalKeys =
    [ ("M-i", spawn "firefox")
    , ("M-f", sendMessage ToggleStruts)
    , ("M-S-b", withFocused $ windows . W.sink)  -- Floating de vuelta al sink
    -- AUDIO (pactl)
    , ("<XF86AudioMute>",          spawn "pamixer -t")
    , ("<XF86AudioLowerVolume>",   spawn "pamixer -d 5")
    , ("<XF86AudioRaiseVolume>",   spawn "pamixer -i 5")
    ]

-------------------------------------------------------------------------------
-- KEYBINDINGS (Estilo Clásico/Haskell)
-------------------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,               xK_p     ), spawn "rofi -show drun")
    , ((modm .|. shiftMask, xK_c     ), kill)
    , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm,               xK_n     ), refresh)
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp)
    , ((modm,               xK_m     ), windows W.focusMaster)
    , ((modm,               xK_Return), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown)
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp)
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)
    , ((modm,               xK_comma ), sendMessage (IncMasterN 1))
    , ((modm,               xK_period), sendMessage (IncMasterN (-1)))
    , ((modm,               xK_q     ), spawn "xmonad --recompile && xmonad --restart")
    , ((modm,               xK_z     ), warpToWindow (1/2) (1/2))
    ]
    ++
    -- Mod-1..9 para cambiar workspaces
    [((m .|. modm, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-------------------------------------------------------------------------------
-- XMOBAR CONFIG (Pretty Printing)
-------------------------------------------------------------------------------
myXMobar1 = "xmobar --dock ~/.config/xmonad/xmobarrc1"

mainXmobarPP :: PP
mainXmobarPP = def
    { ppSep             = magenta "  \xf01d9  "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = xmobarColor mauve "" . wrap "" "" . xmobarBorder "Bottom" yellow 4
    , ppHidden          = white . wrap " " ""
    , ppUrgent          = xmobarColor red "" . wrap (xmobarColor yellow "" "!") (xmobarColor yellow "" "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
    where
    formatFocused   = wrap (white "[") (white "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue . ppWindow
    ppWindow        = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 10

-- Colores para XMobar
magenta     = xmobarColor "#f38ba8" ""
blue        = xmobarColor "#cba6f7" ""
white       = xmobarColor "#f5e0dc" ""
lowWhite    = xmobarColor "#f2cdcd" ""
rosewater   = "#dc8a78"
flamingo    = "#dd7878"
pink        = "#ea76cb"
mauve       = "#8839ef"
red         = "#d29f39"
maroon      = "#e64553"
peach       = "#fe640b"
yellow      = "#df8e1d"
