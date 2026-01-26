# === PATH & ENVIRONMENT ===

# CARGO
. "$HOME/.cargo/env"

# GHCup
[ -f "/home/jairorm/.local/share/ghcup/env" ] && . "/home/jairorm/.local/share/ghcup/env"

# Agregar el bin local siempre y cuando no exista
case ":$PATH:" in
    *:"/home/jairorm/.local/bin":*)
        ;;
    *)
        export PATH=/home/jairorm/.local/bin:$PATH
        ;;
esac

# === XDG DIRS ===
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# === CARGA DE RUTAS XDG USER DIRS ===
export XDG_USER_CONFIG="$HOME/.config/user-dirs.dirs"

if [[ -f "$XDG_USER_CONFIG" ]]; then
    # Leemos el archivo, quitamos las comillas y exportamos cada línea
    # Usamos 'eval' para que Zsh expanda el $HOME correctamente
    while read -r line; do
        [[ "$line" =~ ^XDG ]] && eval "export $line"
    done < "$XDG_USER_CONFIG"
fi

# Prevenir entradas duplicadas y remover entradas duplicadas
export HISTCONTROL=ignoreboth:erasedups

# === GPG con estándar XDG ===
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GPG_TTY=$(tty)

# === STACK/GHCUP ===
export STACK_ROOT="$XDG_DATA_HOME/stack"
export GHCUP_USE_XDG_DIRS=1
export GHCUP_INSTALL_BASE_PREFIX="$XDG_DATA_HOME/ghcup"

# Configuración de Qt
export QT_STYLE_OVERRIDE=kvantum

# Procesar Shaders Vulkan más rápido en Steam
export mesa_glsl_cache_max_size=2G
export RADV_PERFTEST=ngc

# Variables para configuraciones de lanzamiento de Steam
export WINEDLLOVERRIDES="d3dcompiler_47=n;d3d9=n,b"
export MANGOHUD=1
