-- Installer packer:
-- $ yay -S nvim-packer-git
-- :PackerSync

return require('packer').startup(function (use)
  -- theme de couleur
  use({'dracula/vim', as = 'dracula'})
end)
