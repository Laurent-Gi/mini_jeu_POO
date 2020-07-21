class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  def show_state
    if @life_points <= 0 
      puts "le joueur #{@name} a été tué !".center(80)
    else
      puts "#{@name} a #{@life_points} points de vie.".center(80)
    end
  end

  def gets_damage(injury_level)
    
    @life_points -= injury_level

    puts "le joueur #{@name} a été tué !".center(80) if @life_points <= 0 
  end

  def attacks(player)
    puts "le joueur #{@name} attaque le joueur #{player.name}".center(80)
    damage = compute_damage
    puts "il lui inflige #{damage} points de dommages".center(80)
    player.gets_damage(damage)
  end

  def compute_damage
    return rand(1..6)
  end

end

# Autre classe : autre fichier... sauf pour cette fois !

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    @weapon_level = 1
    @life_points  = 100
    @name         = name
    # super (name)
  end

  def show_state
    if @life_points <=0
      puts "le joueur #{@name} a été tué !".center(80)
    else
      puts "\n\n#{@name} a #{@life_points} points de vie, et une arme de niveau #{@weapon_level}.\n\n".center(80)
    end
  end

  def compute_damage
    rand(1..6)*@weapon_level
  end

  def search_weapon
    # Ramasse l'arme trouvée...de niveau aléatoire
    new_weapon_level = rand(1..6)
    puts "Tu viens de trouver une arme de niveau #{new_weapon_level}.".center(80)
    if @weapon_level < new_weapon_level
      puts "YES ! elle est meilleure que ton arme actuelle : tu la prends \"direct\" !".center(80)
      @weapon_level = new_weapon_level
    else
      puts "Pffff ! elle n'est pas meilleure que ton arme actuelle... tu la laisses pour les plus faibles !".center(80)
    end
  end

  def add_life_points(nb)
    (@life_points + nb > 100) ? @life_points = 100 : @life_points += nb
  end

  def search_health_pack
    # Recherche un pack de points de vie : de façon aléatoire
    puts "Tu recherches des points de vie !\nTon niveau de chance est de #{pack_chance = rand(1..6)}".center(80)
  
    if pack_chance ==1
      puts "Tu n'as donc rien trouvé... dommage !".center(80)
    elsif pack_chance < 6
      puts "Bravo, tu as trouvé un pack de +50 points de vie !".center(80)
      # (@life_points + 50 > 100) ? @life_points = 100 : @life_points += 50
      add_life_points(50)
    else
      puts "Waow, tu as trouvé un pack de +80 points de vie !".center(80)
      # (@life_points + 80 > 100) ? @life_points = 100 : @life_points += 80
      add_life_points(80)
    end

  end

end
