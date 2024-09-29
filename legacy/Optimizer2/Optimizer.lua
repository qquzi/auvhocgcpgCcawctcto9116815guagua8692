--[[
  Name: Optimizer.lua
  Date: 2024-04-25
--]]

--* Dependencies *--
local ASTOptimizer = require("Optimizer/ASTOptimizer/ASTOptimizer")

--* Optimizer *--
local Optimizer = {}
function Optimizer:optimizeAST(ast)
  local newASTOptimizerInstance = ASTOptimizer:new(ast)
  return newASTOptimizerInstance:run()
end

return Optimizer