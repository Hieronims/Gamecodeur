-- calcule les vecteurs depuis un angle
        function calcul_vx_vy()         
          balle.vx=balle.vitesse*math.cos(math.rad(balle.angle))
          balle.vy=balle.vitesse*math.sin(math.rad(balle.angle))      
        end
-- Fin de la fonction vecteurs
