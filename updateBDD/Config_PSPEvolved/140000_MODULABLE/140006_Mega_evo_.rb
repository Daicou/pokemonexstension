#Script de mega evolution et primo resurgence. (V2)
#
#                 Par FL0RENT_
 
ANIMMEGA = 505  #animation des mega evolutions.
ANIMPRIMO = 506  #animation des primo resurgences.
 
module POKEMON_S
  class Pokemon_Battle_Core
    def mega_list
      list =[]
      list.push([3, 1, 508]) #Florizarre
      list.push([6, 1, 509]) #Dracaufeu X
      list.push([6, 2, 510]) #Dracaufeu Y
      list.push([9, 1, 511]) #Tortank
      list.push([15, 1, 512]) #Dardargnan
      list.push([18, 1, 513]) #Roucarnage
      list.push([70, 1, 514]) #Alakazam
      list.push([87, 1, 515]) #Flagadoss
      list.push([102, 1, 516]) #Ectoplasma
      list.push([104, 1, 524]) #Steelix
      list.push([135, 1, 538]) #Sharpedo
      list.push([141, 1, 525]) #Cizayox
      list.push([151, 1, 518]) #Scarabrute
      list.push([155, 1, 519]) #Léviator
      list.push([184, 1, 520]) #Ptéra
      list.push([194, 1, 521]) #Mewtwo X
      list.push([194, 2, 522]) #Mewtwo Y
      list.push([231, 1, 523]) #Pharamp
      list.push([233, 1, 537]) #Élecsprint
      list.push([236, 1, 537]) #Varacine
      list.push([279, 1, 526]) #Scarhino
      list.push([297, 1, 527]) #Démolosse
      list.push([318, 1, 528]) #Tyranocif
      list.push([324, 1, 529]) #Jungko
      list.push([327, 1, 530]) #Braségali
      list.push([330, 1, 531]) #Laggron
      list.push([352, 1, 532]) #Gardevoir
      list.push([354, 1, 552]) #Gallame
      list.push([374, 1, 533]) #Ténéfix
      list.push([375, 1, 534]) #Mysdibule
      list.push([378, 1, 535]) #Galeking
      list.push([380, 1, 536]) #Charmina
      list.push([395, 1, 539]) #Camérupt
      list.push([407, 1, 540]) #Altaria
      list.push([433, 1, 542]) #Absol
      list.push([435, 1, 543]) #Onigali
      list.push([448, 1, 544]) #Drattak
      list.push([451, 1, 545]) #Métalosse
      list.push([456, 1, 546]) #Latias
      list.push([457, 1, 547]) #Latios
      list.push([460, 1])      #Rayquaza
      list.push([504, 1, 548]) #Lockpin
      list.push([520, 1, 549]) #Carchacrok
      list.push([522, 1, 550]) #Lucario
      list.push([532, 1, 551]) #Blizzaroi
    end
      
    def primo_list
      list =[]
      list.push([459, 1, 506])#Kyogre
      list.push([460, 1, 507])#Groudon
    end
     
       
       
       
     
    def clear_mega
      for actor in $pokemon_party.actors
        actor.mega = nil
        actor.statistic_refresh
      end
      $mega_on = nil
      $mega_evolution = nil
      @megaicon.dispose if @megaicon
    end
     
    def mega_evo(n, p = nil)
      list = mega_list
      list = primo_list if p == "primo"
      for a in list
        if a[0] == n.id or a[0] == n.name
          if a[2] == nil or a[2] == n.item_hold
            n.mega = a[1] 
            n.statistic_refresh
            break
          end
        end
      end
    end
     
    def mega_test(n)
      return false if n.mega
      if n != @actor or not $mega_evolution
        for a in mega_list
          if a[0] == n.id or a[0] == n.name
            return true if a[2] == nil or a[2] == n.item_hold
          end
        end
      end
      return false
    end
     
    def primo_test(n)
      return false
      return false if n.mega
      for a in primo_list
        if a[0] == n.id or a[0] == n.name
          return true if a[2] == nil or a[2] == n.item_hold
        end
      end
      return false
    end
     
    def bouton_mega
      @megaicon.dispose if @megaicon
      if mega_test(@actor) and not $mega_evolution
        @megaicon = Sprite.new
        if $mega_on == true
          @megaicon.bitmap = RPG::Cache.picture(DATA_BATTLE[:mega_off]) 
        else
          @megaicon.bitmap = RPG::Cache.picture(DATA_BATTLE[:mega_on]) 
        end
        @megaicon.x = 5
        @megaicon.y = 267
        @megaicon.z = @z_level + 30
      end
    end
     
    def bouton_mega2
      if mega_test(@actor) and not $mega_evolution
        if not $mega_on
          $mega_on = true
          @megaicon.bitmap = RPG::Cache.picture(DATA_BATTLE[:mega_off])
        else
          $mega_on = false
          @megaicon.bitmap = RPG::Cache.picture(DATA_BATTLE[:mega_on])
        end
        Audio.se_play("Audio/SE/#{DATA_AUDIO_SE[:mega_evo]}", 100) #son
      end
    end
     
    def mega_evolution
      @megaicon.dispose if @megaicon
      if mega_test(@enemy)
        mega_evo(@enemy) 
        draw_text(@enemy.given_name, "Mega évolue!")
        update_sprite
        animation = $data_animations[ANIMMEGA]
        @enemy_sprite.animation(animation, true)
        loop do
          @enemy_sprite.update
          $scene.battler_anim ; Graphics.update
          Input.update
          if not(@enemy_sprite.effect?)
            break
          end
        end
        $scene.battler_anim ; Graphics.update
        Input.update
        update_sprite
      end
      if $mega_on and not $mega_evolution
        mega_evo(@actor)
        draw_text(@actor.given_name, "Mega évolue!")
        update_sprite
        animation = $data_animations[ANIMMEGA]
        @actor_sprite.animation(animation, true)
        loop do
          @actor_sprite.update
          $scene.battler_anim ; Graphics.update
          Input.update
          if not(@actor_sprite.effect?)
            break
          end
        end
        $scene.battler_anim ; Graphics.update
        Input.update
        update_sprite
        $mega_evolution = true
      end
    end
     
    def primo_resurgence
      if primo_test(@enemy)
        mega_evo(@enemy, "primo") 
        draw_text("Primo résurgence de", @enemy.given_name+ " !")
        animation = $data_animations[ANIMPRIMO]
        @enemy_sprite.animation(animation, true)
        loop do
          @enemy_sprite.update
          $scene.battler_anim ; Graphics.update
          Input.update
          if not(@enemy_sprite.effect?)
            break
          end
        end
        $scene.battler_anim ; Graphics.update
        Input.update
        update_sprite
      end
      if primo_test(@actor)
        mega_evo(@actor, "primo")
        draw_text("Primo résurgence de", @actor.given_name+ " !")
        animation = $data_animations[ANIMPRIMO]
        @actor_sprite.animation(animation, true)
        loop do
          @actor_sprite.update
          $scene.battler_anim ; Graphics.update
          Input.update
          if not(@actor_sprite.effect?)
            break
          end
        end
        $scene.battler_anim ; Graphics.update
        Input.update
        update_sprite
        $mega_evolution = true
      end
    end
  end
end