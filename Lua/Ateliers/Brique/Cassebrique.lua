-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

-- Variables
local pad = {}
pad.x = 0
pad.y = 0
pad.largeur = 0
pad.hauteur = 0

local balle = {}
balle.x = 0
balle.y = 0
balle.rayon = 10
balle.colle = false
balle.vx = -0
balle.vy = -400
balle.start_vitesse = 500
balle.start_angle = 90
balle.vitesse = 0 --  vitesse actuelle de la balle, initialisé à balle.start_vitesse dans l'init
balle.angle = 0 -- angle actuelle de la balle, initialisé à balle.start_angle dans l'init
balle.vitesseMax = 700
balle.vitesseMin = 100

local brique = {}

-- calcule les vecteurs depuis un angle
        function calcul_vx_vy()         
          balle.vx=balle.vitesse*math.cos(math.rad(balle.angle))
          balle.vy=balle.vitesse*math.sin(math.rad(balle.angle))      
        end
        -- Fin de la fonction vecteurs
        
        -- Retourne un angle en fournissant les coordonées
        function returnangle(x,y,x2,y2)   
          return 360-(math.atan2(x - x2, y- y2) * 180 /math.pi +90)
        end
        -- Fin de la fonction qui retourne un angle

function Demarre()
  balle.colle = true
  
  niveau = {}
     for ligne = 1,6 do
      niveau[ligne] = {}
      for colonne = 1,15 do
        niveau[ligne][colonne] = 1
      end
    end

  
end
 -- Fonction de love 2d
 
function love.mousepressed(x, y, n)
  if balle.colle == true then
    balle.colle = false
  end
end
function love.load()
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  pad.largeur = largeur / 11
  pad.hauteur = hauteur / 30
  pad.x = largeur * 0.5
  pad.y = hauteur - ( pad.hauteur * 0.5 )
  
  brique.hauteur = 25
  brique.largeur = largeur / 15
  
  balle.vitesse = balle.start_vitesse
  balle.angle = balle.start_angle
  calcul_vx_vy()    -- calcul les vecteurs à partir de l'angle
  
  Demarre()
end
function love.update(dt)
  pad.x = love.mouse.getX() -- Le pad a les coordonnées x de la souris
  -- Suivant le la balle est collée ou non, on applique la force 
  if balle.colle == true then
    balle.x = pad.x 
    balle.y = pad.y - pad.hauteur 
  else
   balle.x = balle.x + balle.vx * dt
   balle.y = balle.y + balle.vy * dt
  end
  -- Ici on détecte si la balle sort du cadre de l'écran
  if balle.x > largeur then
    balle.x=largeur
    balle.vx =  0 - balle.vx
  end
  if balle.x < 0 then
    balle.x= 0
    balle.vx =  0 - balle.vx
  end 
  if balle.y < 0 then
    balle.y= 0
    balle.vy =  0 - balle.vy
  end
  if balle.y > hauteur then
    balle.colle = true
    balle.vitesse = balle.start_vitesse
    balle.angle = balle.start_angle
    calcul_vx_vy()
    
  end
  
  -- ici on détecte si la balle touche la raquette
  
 local posCollisionPadY = pad.y - (( pad.hauteur * 0.5 ) + balle.rayon)
 if balle.y > posCollisionPadY then
   local dist = math.abs(pad.x - balle.x)
   if dist < ( pad.largeur * 0.5 ) then
    -- gestion de l'angle de la balle
    local cosBalleX = ( -1 *( pad.x - balle.x ) / pad.largeur * 0.5)
    local radBalle  = math.acos(cosBalleX)
    local sinBalleY = math.sin(radBalle)
    
    balle.vx = cosBalleX * balle.vitesse
    balle.vy = sinBalleY * -balle.vitesse
    balle.y = posCollisionPadY
    balle.angle = returnangle(0 ,0 ,balle.vx ,balle.vy )   -- comme on modifie les vecteurs on recalcule le nouvel angle
   end
 
 end
 
end
function love.draw()
  
  love.graphics.rectangle("fill", pad.x - (pad.largeur * 0.5) ,pad.y -  (pad.hauteur * 0.5),pad.largeur ,pad.hauteur )
  
  love.graphics.circle("fill", balle.x, balle.y, balle.rayon)

  local briqueX, briqueY = 0, 0
    for ligne = 1,6 do
      briqueX = 0
      for colonne = 1,15 do
        if niveau[ligne][colonne] == 1 then
        love.graphics.rectangle("fill", briqueX +1, briqueY+1, brique.largeur-2, brique.hauteur-2)
      end
        briqueX = briqueX + brique.largeur
      end
    briqueY = briqueY + brique.hauteur
   end
  
  
  
end
