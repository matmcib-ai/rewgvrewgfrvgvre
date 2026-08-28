-- Place this as a Script inside ServerScriptService

local function removeAccessories(character)
    for _, item in ipairs(character:GetChildren()) do
        if item:IsA("Accessory") then
            item:Destroy()
        end
    end
end

-- Strip accessories from all Players
for _, player in ipairs(game.Players:GetPlayers()) do
    if player.Character then
        removeAccessories(player.Character)
    end
end

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        removeAccessories(character)
    end)
end)

-- Strip accessories from all existing NPCs
for _, model in ipairs(workspace:GetDescendants()) do
    if model:IsA("Model") and model:FindFirstChildOfClass("Humanoid") then
        removeAccessories(model)
    end
end

-- Watch for NEW NPCs being added anywhere in Workspace
workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("Model") and descendant:FindFirstChildOfClass("Humanoid") then
        removeAccessories(descendant)
    end
end)

-- Continuously watch for accessories being added to any NPC (in case they re-equip or accessories load late)
workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("Accessory") then
        local character = descendant.Parent
        if character and character:FindFirstChildOfClass("Humanoid") then
            descendant:Destroy()
        end
    end
end)