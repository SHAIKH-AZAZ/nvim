return {
	"RishabhRD/popfix",
	"RishabhRD/nvim-lsputils",
  config = function()
  local lsp_handlers = vim.lsp.handlers

      lsp_handlers["textDocument/codeAction"] = function(_, _, actions)
        require("lsputil.codeAction").code_action_handler(nil, actions, nil, nil, nil)
      end

      lsp_handlers["textDocument/references"] = function(_, _, result, _, bufnr)
        require("lsputil.locations").references_handler(nil, result, { bufnr = bufnr }, nil)
      end

      lsp_handlers["textDocument/definition"] = function(_, method, result, _, bufnr)
        require("lsputil.locations").definition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
      end

      lsp_handlers["textDocument/declaration"] = function(_, method, result, _, bufnr)
        require("lsputil.locations").declaration_handler(nil, result, { bufnr = bufnr, method = method }, nil)
      end

      lsp_handlers["textDocument/typeDefinition"] = function(_, method, result, _, bufnr)
        require("lsputil.locations").typeDefinition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
      end

      lsp_handlers["textDocument/implementation"] = function(_, method, result, _, bufnr)
        require("lsputil.locations").implementation_handler(nil, result, { bufnr = bufnr, method = method }, nil)
      end

      lsp_handlers["textDocument/documentSymbol"] = function(_, _, result, _, bufnr)
        require("lsputil.symbols").document_handler(nil, result, { bufnr = bufnr }, nil)
      end

      lsp_handlers["workspace/symbol"] = function(_, _, result, _, bufnr)
        require("lsputil.symbols").workspace_handler(nil, result, { bufnr = bufnr }, nil)
      end
  end

}
