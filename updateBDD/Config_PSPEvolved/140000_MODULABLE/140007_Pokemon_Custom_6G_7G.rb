module POKEMON_S
  class Pokemon
    alias mega_type2 type2
    def type2
      type2 = -1
      #---------- Forme Alola -------------
      if @form == 1
        case name
        when "Noadkoko"
          type2 = 15
        when "Ossatueur"
          type2 = 14
        when "Racaillou", "Gravalanch", "Grolem"
          type2 = 4
        when "Raichu"
          type2 = 11
        end
      end
      return type2 if type2 != - 1
      #---------- Méga-Pokémon -------------
      if @mega == 1
        case name
        when "Nanméouïe", "Altaria"
          type2 = 18
        when "Leviator"
          type2 = 17
        when "Scarabrute"
          type2 = 10
        when "Galeking"
          type2 = 0
        end
      end
      return type2 if type2 != -1
      #---------- Autre Forme -------------
      if name =="Necrozma"
        type2 = 11 if (@form == 0 or @form == 3)
        type2 = 2 if @form == 1
        type2 = 3 if @form == 2
      end
      return (type2 != - 1 ? type2 : mega_type2)
    end
    
    alias mega_temp_base_atk base_atk
    def base_atk
      if name == "Exagide" and @form == 1#087
        return 150 
      end
      atk = -1
      if @mega == 1
        case name
        when  "Élecsprint"
          atk = 75
        when "Gardevoir"
          atk = 85
        when "Gallame"
          atk = 165
        when "Ectoplasma" 
          atk = 65
        when "Scarhino"
          atk = 185
        when "Lucario"
          atk = 145
        when "Tyranocif"
          atk = 164
        when  "Altaria"
          atk = 110
        when "Blizzaroi"
          atk = 132
        when  "Cizayox"
          atk = 150
        when "Métalosse", "Drattak"
          atk = 145
        when "Camérupt", "Oniglali"
          atk = 120
        when "Galeking", "Sharpedo"
          atk = 140
        when "Léviator"
          atk = 155
        when "Carchacrok" 
          atk = 170
        when "Charmina"
          atk = 100
        when "Scarabrute"
          atk = 155
        when "Démolosse"
          atk = 90
        when "Steelix"
          atk = 125
        when  "Mysdibule"
          atk = 105
        when "Nanméouïe"
          atk = 60
        end
        return atk if atk != -1
      end
      return mega_temp_base_atk
    end
    
    alias mega_temp_base_dfe base_dfe
    def base_dfe
      if name == "Exagide" and @form == 1 #087
        return 50 
      end
      dfe = -1
      if @mega == 1
        case name
        when "Élecsprint", "Ectoplasma", "Oniglali"
          dfe = 80
        when "Gardevoir"
          dfe = 65
        when  "Gallame"
          dfe = 95
        when "Scarhino", "Carchacrok"
          dfe = 115
        when "Lucario"
          dfe = 88
        when "Tyranocif"
          dfe = 150
        when "Altaria"
          dfe = 110
        when "Blizzaroi"
          dfe = 105
        when "Cizayox"
          dfe = 140
        when "Métalosse"
          dfe = 150
        when "Camérupt"
          dfe = 100
        when "Galeking",  "Steelix"
          dfe = 230
        when "Léviator"
          dfe = 109
        when "Sharpedo"
          dfe = 70
        when "Drattak"
          dfe = 130
        when "Charmina"
          dfe = 85
        when "Scarabrute"
          dfe = 120
        when "Démolosse"
          dfe = 90
        when "Mysdibule"
          dfe = 125
        when "Nanméouïe"
          dfe = 126
        end
        return dfe if dfe != -1
      end
      return mega_temp_base_dfe
    end
    
    alias mega_temp_base_spd base_spd
    def base_spd
      if name == "Exagide" and @form == 1 #087
        return 60
      end
      spd = -1
      if @mega == 1
        case name
        when "Élecsprint"
          spd = 135
        when "Gardevoir", "Oniglali", "Charmina"
          spd = 100
        when "Gallame", "Métalosse"
          spd = 110
        when "Ectoplasma"
          spd = 130
        when "Scarhino", "Cizayox" 
          spd = 75
        when "Lucario"
          spd = 112
        when "Tyranocif"
          spd = 71
        when "Altaria"
          spd = 80
        when "Blizzaroi", "Steelix"
          spd = 30
        when  "Camérupt"
          spd = 20
        when "Galeking", "Mysdibule", "Nanméouïe"
          spd = 50
        when "Léviator"
          spd = 81
        when "Carchacrok"
          spd = 92
        when "Sharpedo", "Scarabrute"
          spd = 105
        when "Drattak"
          spd = 120
        when "Démolosse"
          spd = 115
        end
        return spd if spd != -1
      end
      return mega_temp_base_spd
    end
     
    alias mega_temp_base_ats base_ats
    def base_ats
      if name == "Exagide" and @form == 1 #087
        return 150 
      end
      ats = -1
      if @mega == 1
        case name
        when "Élecsprint"
          ats = 135
        when "Gardevoir"
          ats = 165
        when "Gallame", "Cizayox", "Scarabrute"
          ats = 65
        when "Ectoplasma"
          ats = 170
        when "Scarhino"
          ats = 40
        when "Lucario", "Démolosse"
          ats = 140
        when "Tyranocif"
          ats = 95
        when "Altaria", "Sharpedo"
          ats = 110
        when "Blizzaroi" 
          ats = 132
        when "Métalosse"
          ats = 105
        when "Camérupt"
          ats = 145
        when "Galeking"
          ats = 60
        when "Léviator"
          ats = 70
        when "Carchacrok", "Oniglali", "Drattak"
          ats = 120
        when "Charmina", "Nanméouïe"
          ats = 80
        when "Steelix", "Mysdibule"
          ats = 55
        end
        return ats if ats != -1
      end
      return mega_temp_base_ats
    end
    
    alias mega_temp_base_dfs base_dfs
    def base_dfs
      if name == "Exagide" and @form == 1 #087
        return 50
      end
      dfs = -1
      if @mega == 1
        case name
        when "Élecsprint", "Galeking", "Oniglali", "Charmina"
          dfs = 80
        when "Gardevoir"
          dfs = 135
        when "Gallame"
          dfs = 115
        when "Ectoplasma", "Carchacrok"
          dfs = 95
        when "Scarhino", "Altaria", "Blizzaroi", "Camérupt"
          dfs = 105
        when "Lucario"
          dfs = 70
        when "Tyranocif"
          dfs = 120
        when "Cizayox"
          dfs = 100
        when "Métalosse"
          dfs = 110
        when "Léviator"
          dfs = 130
        when "Sharpedo", "Scarabrute"
          dfs = 65
        when "Drattak"
          dfs = 90
        when "Démolosse" 
          dfs = 140
        when "Steelix", "Mysdibule"
          dfs = 55
        when "Nanméouïe"
          dfs = 126
        end
        return dfs if dfs != -1
      end
      return mega_temp_base_dfs
    end
  end
end