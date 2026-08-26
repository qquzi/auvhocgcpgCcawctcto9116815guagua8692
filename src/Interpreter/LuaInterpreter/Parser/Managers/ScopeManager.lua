local ScopeManager = {}

function ScopeManager:pushScope(isFunctionScope)
    local newScope = {
        id = #self.scopes + 1,
        locals = {},
        parent = self.currentScope,
        isFunctionScope = isFunctionScope == true
    }

    self.currentScope = newScope
    self.scopes[#self.scopes + 1] = newScope

    return newScope
end

function ScopeManager:popScope()
    if not self.currentScope then
        error("Cannot pop scope, no scope to pop.")
    end

    local scope = self.currentScope
    self.currentScope = scope.parent
    self.scopes[#self.scopes] = nil

    return scope
end

return ScopeManager
