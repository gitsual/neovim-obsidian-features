
-- Importamos las otras funcionalidades desde sus respectivos archivos
local links = require('neovim-obsidian-features.links')
local callouts = require('neovim-obsidian-features.callouts')

local M = {} -- El módulo principal

function M.setup(config)
    -- Configuración general del plugin
    config = config or {}

    -- Configura las características de enlaces
    local link_config = config.links or {}
    links.setup(link_config)

    -- Configura las características de callouts
    local callout_config = config.callouts or {}
    callouts.setup(callout_config)
end

-- Exponer funciones para que los usuarios puedan utilizarlas directamente si lo desean
M.create_link = links.create
M.follow_link = links.follow
M.highlight_link = links.highlight

M.highlight_callout = callouts.highlight

return M
