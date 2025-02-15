-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

local time = 0
local sable = 1
local sablier = sable
local angle = 0
local imgEnnemi = love.graphics.newImage("/assets/tank.png")
local lstZoneSpawn = {}
local ennemiWidth = imgEnnemi:getWidth()
local ennemiHeight = imgEnnemi:getHeight()

local lstEnnemi = {
    angle = 0
}


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

    --On parcours a l'envers car on à de la suppression de tanks
    for nb = 1, #lstEnnemi -1 do 

        local vx = 120 * math.cos(lstEnnemi[nb].angle) * dt
        local vy = 120 * math.sin(lstEnnemi[nb].angle) * dt
        local ennemi = lstEnnemi[nb]

        ennemi.x = ennemi.x + vx
        ennemi.y = ennemi.y + vy

        -- effet tank ivre 😁
        ennemi.angle = ennemi.angle + math.random(-20, 20) / 100


        --suppresion tank qui sort de l'ecran 😥
        if ennemi.x + ennemiWidth / 2 < 0 or
         ennemi.x + ennemiWidth / 2 > love.graphics.getWidth() or
          ennemi.y + ennemiHeight / 2 < 0 or
           ennemi.y + ennemiHeight / 2 > love.graphics.getHeight() then

            table.remove(lstEnnemi, nb)
        end

        
    end


end

function love.draw()

    for zone = 1, #lstZoneSpawn do 
        love.graphics.rectangle("fill", lstZoneSpawn[zone].x, lstZoneSpawn[zone].y, 32, 32)
    end

    for nb = 1, #lstEnnemi do 
        love.graphics.draw(imgEnnemi, lstEnnemi[nb].x, lstEnnemi[nb].y, lstEnnemi[nb].angle, 1, 1, imgEnnemi:getHeight() / 2, imgEnnemi:getWidth() / 2)
        love.graphics.print("nb of tank(s): "..tostring(#lstEnnemi))
    end
end

function love.keypressed()
end