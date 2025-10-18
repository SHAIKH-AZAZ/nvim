
local ok, extras = pcall(require, "none-ls.diagnostics.eslint_d")
if not ok then
  return {}
end

return {
  extras, -- eslint diagnostics via none-ls-extras
}
