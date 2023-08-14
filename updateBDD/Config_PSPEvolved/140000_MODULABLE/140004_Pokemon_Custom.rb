#==============================================================================
# ■ Pokemon_Custom
# Pokemon Script Project - Krosk 
# 05/09/08
#-----------------------------------------------------------------------------
# Méthodes spéciales pour Pokémons et capacités spécifiques
#-----------------------------------------------------------------------------
# Ce script sert à placer les modifications de méthodes propres à certains 
# Pokémons ou capacités spéciales, pour éviter de modifier les scripts clés
#-----------------------------------------------------------------------------
# La méthode à suivre doit être comprise avant d'essayer d'ajouter des règles...
#-----------------------------------------------------------------------------
module POKEMON_S
  class Pokemon
    # -----------------------------------------------------------------
    #  Stat spéciale Munja
    # -----------------------------------------------------------------
    alias temp_maxhp_basis maxhp_basis
    def maxhp_basis
      if name == "Munja"
        return 1
      end
      temp_maxhp_basis
    end
    
    # -----------------------------------------------------------------
    #  Zarbi et Vivaldaim à l'état sauvage
    # -----------------------------------------------------------------
    alias temp_initialize initialize
    def initialize(id_data = 1, level = 1, shiny = false, no_shiny = false, trainer = Player)
      temp_initialize(id_data, level, shiny, no_shiny, trainer)
      if name == "Zarbi"
        @form = rand(27) + 1
      end
      if name == "Vivaldaim"
        @form = rand(4)
      end
      if name == "Haydaim"
        @form = rand(4)
      end
    end  
    


    
    # -----------------------------------------------------------------
    #  Objet tenu, changement de forme
    # -----------------------------------------------------------------
    def item_hold=(item_id)
      @item_hold = item_id
      if ability_symbol == :multi_type
        # 324 est la marge entre le numéro de la forme et l'ID de l'item
        @form = item_id - 324
        @form = 0 if @form < 2 or @form > 18
      else
        case name
        when "Deoxys"
          @form = 5 if item_id == 1
          @form = 0 if item_id != 1
        when "Giratina"
          @form = item_id == 343 ? 1 : 0 
          @ability = @form == 0 ? 46 : 26
        end
      end
    end
    
    
    #type formes
    def type1
      if ability_symbol == :multi_type or ability_symbol == :meteo
        type = @form > 1 ? @form : 0
      else
        type = @type1
      end
      return type
    end
    
    def type2
      case name
      when "Motisma"
        list = [14, 2, 3, 6, 10, 5]
        type = list[@form]
      else
        type = @type2
      end
      return type
    end
      
    # -----------------------------------------------------------------
    #  Stat spéciale Deoxys
    # -----------------------------------------------------------------
    # 1 : Attaque
    # 2 : Defense
    # 3 : Normal
    # 4 : Vitesse
    alias temp_base_atk base_atk
    def base_atk
      atk_tmp = nil
      case name
      when "Deoxys"
        list = [nil, 180, 70, 95]
        atk_tmp = list[@form] if @form < list.size
      when "Giratina"
        atk_tmp 120 if @form == 1
      end
      return atk_tmp if atk_tmp != nil
      temp_base_atk
    end
    
    alias temp_base_dfe base_dfe
    def base_dfe
      dfe_tmp = nil
      case name
      when "Deoxys"
        list = [nil, 20, 160, 90]
        dfe_tmp = list[@form] if @form < list.size
      when "Giratina"
        dfe_tmp 100 if @form == 1
      end
      return dfe_tmp if dfe_tmp != nil
      temp_base_dfe
    end
    
    alias temp_base_spd base_spd
    def base_spd
      spd_tmp = nil
      case name
      when "Deoxys"
        list = [nil, 150, 90, 180]
        spd_tmp = list[@form] if @form < list.size
      end
      return spd_tmp if spd_tmp != nil
      temp_base_spd
    end
    
    alias temp_base_ats base_ats
    def base_ats
      ats_tmp = nil
      case name
      when "Deoxys"
        list = [nil, 180, 70, 95]
        ats_tmp = list[@form] if @form < list.size
      when "Giratina"
        ats_tmp 120 if @form == 1
      end
      return ats_tmp if ats_tmp != nil
      temp_base_ats
    end
    
    alias temp_base_dfs base_dfs
    def base_dfs
      dfs_tmp = nil
      case name
      when "Deoxys"
        list = [nil, 20, 160, 90]
        dfs_tmp = list[@form] if @form < list.size
      when "Giratina"
        dfs_tmp 100 if @form == 1
      end
      return dfs_tmp if dfs_tmp != nil
      temp_base_dfs
    end
    
    
    # -----------------------------------------------------------------
    #  Effect
    # -----------------------------------------------------------------
    #  La suite n'est à modifier que si vous savez ce que vous faites
    # -----------------------------------------------------------------
    alias temp_skill_effect_reset skill_effect_reset
    def skill_effect_reset
      # Transform / Morphing cleaning
      if effect_list.include?(:morphing)
        index = effect_list.index(:morphing)
        transform_effect(@effect[index][2], true)
        @effect.delete_at(index)
      end
      # Copie / Mimic cleaning
      if effect_list.include?(:copie)
        index = effect_list.index(:copie)
        skill_index = @skills_set.index(@effect[index][2][1])
        @skills_set[skill_index] = @effect[index][2][0]
        @effect.delete(effect)
      end
      temp_skill_effect_reset
    end
    
    # --------- ----------
    # Morphing / Transform
    # --------- ----------
    def transform_effect(target, recover = false)
      @type1 = target.type1
      @type2 = target.type2
      @atk = target.atk
      @dfe = target.dfe
      @ats = target.ats
      @dfs = target.dfs
      @spd = target.spd
      @base_atk = target.base_atk
      @base_ats = target.base_ats
      @base_dfe = target.base_dfe
      @base_dfs = target.base_dfs
      @base_spd = target.base_spd
      @dv_atk = target.dv_atk
      @dv_ats = target.dv_ats
      @dv_dfe = target.dv_dfe
      @dv_dfs = target.dv_dfs
      @dv_spd = target.dv_spd
      @battle_stage = target.battle_stage
      @bonus = target.bonus
      @atk_plus = target.atk_plus
      @dfe_plus = target.dfe_plus
      @ats_plus = target.ats_plus
      @dfs_plus = target.dfs_plus
      @spd_plus = target.spd_plus
      @ability = target.ability
      @battler_id = target.id
      if recover
        @skills_set = target.skills_set
      end
      statistic_refresh
    end
    
    # -----------------------------------------------------------------
    #  Capacités spéciales
    # -----------------------------------------------------------------
    #  La suite n'est à modifier que si vous savez ce que vous faites
    # -----------------------------------------------------------------
    
    alias temp_change_stat change_stat
    def change_stat(stat_id, amount = 0, actor_change = self)
      # Corps sain / Clear Body (ab) // Mist / Brume
      if amount < 0 and (effect_list.include?(:brume) and 
                         actor_change.ability_symbol != :infiltration or 
                         ability_symbol == :corps_sain or 
                         effect_list.include?(:defense_spec))
        return 0 
      end
      # Regard Vif / Keen Eye (ab)
      if amount < 0 and stat_id == 6 and ability_symbol == :regard_vif
        return 0
      end
      # Hyper Cutter (ab)
      if amount < 0 and stat_id == 0 and ability_symbol == :hyper_cutter
        return 0
      end
      temp_change_stat(stat_id, amount, actor_change)
    end
    
    alias temp_spd_modifier spd_modifier
    def spd_modifier
      n = 1
      # Swift Swim / Glissade (ab)
      if ability_symbol == :glissade and $battle_var.rain?
        n *= 2
      end
      # Chlorophyle (ab)
      if ability_symbol == :chlorophyle and $battle_var.sunny?
        n *= 2
      end
      return n*temp_spd_modifier
    end
    
    alias temp_sleep_check sleep_check
    def sleep_check
      if ability_symbol == :matinal
        @status_count -= 1
      end
      temp_sleep_check
    end
  end
end


# Les modules suivants sont complémentaires et ne sont pas activés par défaut.
if false

module POKEMON_S
  # Météo automatique au combat
  class Pokemon_Battle_Variable
    def reset
      reset_weather
      @actor_last_used = nil
      @enemy_last_used = nil
      @battle_order = (0..5).to_a
      @enemy_battle_order = (0..5).to_a
      @in_battle = false
      @actor_last_taken_damage = 0
      @enemy_last_taken_damage = 0
      @have_fought = []
      @enemy_party = Pokemon_Party.new
      @action_id = 0
      @window_index = 0
      @last_index = 0
      @round = 0
      @run_count = 0
      @money = 0
    end
  end
end


module POKEMON_S
  # Capacités évolutives (idée de Mister-K)
  class Skill
    PAS_UTIL = 20
    PAS_PUIS = 10
   
    alias initialize_temp initialize
    def initialize(id)
      initialize_temp(id)
      @use_number = 0
    end
   
    def power
      @use_number = 0 if @use_number == nil # Protection indéfinition
      return Skill_Info.base_damage(id) + PAS_PUIS * @use_number / PAS_UTIL
    end
   
    alias use_temp use
    def use
      use_temp
      @use_number = 0 if @use_number == nil # Protection indéfinition
      @use_number += 1 if @usable
    end
  end
end
end
module POKEMON_S
  class Pokemon_Battle_Variable
    alias reset_temp reset
    def reset
      reset_temp
      reset_weather
    end
    
    def reset_weather
      @weather = [0, 0]
      case $game_screen.weather_type
      when 1
        set_rain
      when 2
        set_rain
      when 3
        set_hail
      end
    end
  end
end
    