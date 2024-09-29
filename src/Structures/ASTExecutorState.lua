--[[
  Name: ASTExecutorState.lua
  Date: 2024-04-26
  Description:
--]]

-- * LuaState * --
local LuaState = {}
function LuaState:new()
  local LuaStateObject = {}

  LuaStateObject.upvalues = {}
  LuaStateObject.env = {}
  LuaStateObject.register = {}
  LuaStateObject.protos = {}
  LuaStateObject.vararg = {}
  LuaStateObject.parameters = {}

  return LuaStateObject
end

return LuaState