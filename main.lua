-- TB Project - Leaderboard System

local Leaderboard = {}

-- Create a new leaderboard
function Leaderboard:new()
    local lb = { players = {} }
    setmetatable(lb, self)
    self.__index = self
    return lb
end

-- Add or update a player's score
function Leaderboard:addScore(name, score)
    -- Check if player exists and update, or add new
    for i, player in ipairs(self.players) do
        if player.name == name then
            player.score = math.max(player.score, score)
            return
        end
    end
    table.insert(self.players, { name = name, score = score })
end

-- Sort leaderboard by score (highest first)
function Leaderboard:sort()
    table.sort(self.players, function(a, b)
        return a.score > b.score
    end)
end

-- Display the leaderboard
function Leaderboard:display(limit)
    limit = limit or #self.players
    self:sort()
    
    print("\n=== LEADERBOARD ===")
    for i = 1, math.min(limit, #self.players) do
        local player = self.players[i]
        print(string.format("%d. %-20s %d", i, player.name, player.score))
    end
    print("==================\n")
end

-- Example usage
local function main()
    local lb = Leaderboard:new()
    
    -- Add some scores
    lb:addScore("Alice", 1500)
    lb:addScore("Bob", 2000)
    lb:addScore("Charlie", 1800)
    lb:addScore("Diana", 2100)
    lb:addScore("Alice", 1800)  -- Updates Alice's score

    -- Display top 5
    lb:display(5)
end

-- Run the main function
main()