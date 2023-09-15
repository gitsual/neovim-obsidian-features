
local M = {}  -- El módulo de callouts

-- Configura grupos de resaltado personalizados para callouts
local function setup_highlight_groups()
    vim.api.nvim_exec([[
        hi ObsidianCalloutNote guifg=#ffffff guibg=#4287f5 ctermfg=white ctermbg=blue
    ]], false)
end

local function highlight_callouts()
    -- Esta función identificará y resaltará los callouts del tipo > [!note]
    setup_highlight_groups()
    
    -- Aplica el resaltado a los patrones > [!note]
    vim.api.nvim_exec([[
        syn match ObsidianCalloutPattern /^>\s*\[!note\].*$/
        hi link ObsidianCalloutPattern ObsidianCalloutNote
    ]], false)
end

function M.setup(config)
    -- Configura cosas específicas para los callouts, como el color del resaltado
    if config.highlight then
        highlight_callouts()
    end
end

-- Exponer la función de resaltado para que pueda ser usada desde main.lua o por los usuarios del plugin
M.highlight = highlight_callouts

return M
