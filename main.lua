-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

local time = 0
local sable = 1
local sablier = sable

local lstEnnemi = {
    angle = 0
}
local imgEnnemi = love.graphics.newImage("/assets/tank.png")

local lstZoneSpawn = {}

lstZoneSpawn[1] = {
    x = love.graphics.getWidth() / 2,
    y = 0,
    angle = math.pi / 2
}

lstZoneSpawn[2] = {
    x = love.graphics.getWidth() / 2,
    y = love.graphics.getHeight() - 32,
    angle = math.pi * 1.5
}

lstZoneSpawn[3] = {
    x = 1,
    y = love.graphics.getHeight() / 2,
    angle = 0
}




function spawn()

    local dice = math.random(1, #lstZoneSpawn)

    local ennemi = {
        x = lstZoneSpawn[dice].x + imgEnnemi:getWidth() / 2,
        y = lstZoneSpawn[dice].y + imgEnnemi:getHeight() / 2,
        angle = lstZoneSpawn[dice].angle
    }

    table.insert(lstEnnemi, ennemi)
    print("spawn!")
end

function love.load()
end

function love.update(dt)
    -- time = time + dt
    sablier = sablier - dt 
    if sablier <= 0 then
        spawn()
        sablier = sable
    end

    for nb = 1, #lstEnnemi do 
        lstEnnemi[nb].x = lstEnnemi[nb].x + 120 * dt
    end


end

function love.draw()
    -- love.graphics.print(time)
    -- love.graphics.print(sablier)

    for zone = 1, #lstZoneSpawn do 
        love.graphics.rectangle("fill", lstZoneSpawn[zone].x, lstZoneSpawn[zone].y, 32, 32)
    end

    for nb = 1, #lstEnnemi do 
        love.graphics.draw(imgEnnemi, lstEnnemi[nb].x, lstEnnemi[nb].y, lstEnnemi[nb].angle, 1, 1, imgEnnemi:getHeight() / 2, imgEnnemi:getWidth() / 2)
    end
end

function love.keypressed()
end