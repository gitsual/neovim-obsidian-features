
local M = {}  -- El módulo de links

-- Grupos de resaltado personalizados para enlaces internos
local function setup_highlight_groups()
    vim.api.nvim_exec([[
        hi ObsidianLink guifg=#4287f5 ctermfg=blue
    ]], false)
end

local function highlight_links()
    -- Esta función identificará y resaltará todos los enlaces internos del tipo [[Link]]
    setup_highlight_groups()
    
    -- Aplica el resaltado a los patrones [[Link]]
    vim.api.nvim_exec([[
        syn match ObsidianLinkPattern /\[\[.*\]\]/
        hi link ObsidianLinkPattern ObsidianLink
    ]], false)
end

local function follow_link_at_cursor()
    -- Identifica el nombre del archivo destino en el enlace
    local link_text = vim.fn.matchstr(vim.fn.getline('.'), '\\[\\[\\zs.*\\ze\\]\\]')
    
    -- Verifica si el archivo existe
    local filepath = vim.fn.findfile(link_text .. '.md')
    
    if filepath == "" then
        -- Si el archivo no existe, informa al usuario o crea el archivo
        print("El archivo no existe. Puedes crearlo si lo deseas.")
    else
        -- Si el archivo existe, ábrelo
        vim.cmd('edit ' .. filepath)
    end
end

local function create_link_from_selected_text()
    -- Obtiene el texto seleccionado
    local selected_text = vim.fn.getreg('"')
    
    -- Reemplaza el texto seleccionado con el formato [[texto]]
    vim.api.nvim_command('s/' .. selected_text .. '/[[' .. selected_text .. ']]/')
end

function M.setup(config)
    -- Configura cosas específicas para los enlaces, como el color del resaltado
    if config.highlight then
        highlight_links()
    end
end

-- Exponer las funciones para que puedan ser usadas desde main.lua o por los usuarios del plugin
M.highlight = highlight_links
M.follow = follow_link_at_cursor
M.create = create_link_from_selected_text

return M
