class Game
  attr_accessor :human_player, :ennemies

  def initialize(name)
    # Toi et tes ennemies
    @human_player = HumanPlayer.new(name)
    @ennemies = Array.new
    ["José", "Josiane", "Romuald", "Stefany"].each { | name | @ennemies << Player.new(name) }

  end


  def kill_player(index)
    #retirer un ennemi mort d'un tableau
    @ennemies.delete_at(index)
  end


  def is_still_ongoing?

    return ( @human_player.life_points > 0 && @ennemies.size > 0 )
    # Le jeu continue tant que le @human_player a encore des points de vie
    # et qu'il reste des Player à combattre dans l’array @enemies.
  end


  def show_players
    @human_player.show_state
    puts "Il reste #{@ennemies.size} ennemi(s)".center(80)
    puts "~~~~~~~~~~~~~~~~~~~~".center(80)
    @ennemies.each { |player| player.show_state } 
  end


  def menu
    puts " "
    puts "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    puts "Quelle action veux-tu effectuer ?"
    puts " "
    puts "a - Chercher une meilleure arme "
    puts "s - Chercher à se soigner "
    puts " "
    puts "Attaquer un joueur en vue :"
    @ennemies.each_with_index do | player, i |
    print "#{i} - "
    player.show_state(20)
    end

    puts "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    print "your choice > "
    letter = STDIN.gets.chomp.to_s
    # puts "Lettre #{letter}"

    # La réponse
    while true
      return letter if letter == "a" || letter == "s"
      return letter if letter == "0" && @ennemies.size > 0
      return letter if letter == "1" && @ennemies.size > 1
      return letter if letter == "2" && @ennemies.size > 2
      return letter if letter == "3" && @ennemies.size > 3
      puts "Merci de donner un choix valide : une lettre"
      puts "'a', 's' ou le chiffre proposé pour l'ennemi - s'il est encore parmi nous (0,1,2,3)-"
      print "your choice > "
      letter = STDIN.gets.chomp.to_s
    end
  end


  def menu_choice(choix)

    system 'clear'
    puts "\n\n"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n\n".center(80)
    if choix == "a"
      @human_player.search_weapon
    elsif choix == "s"
      @human_player.search_health_pack
    elsif choix == "0" || choix == "1" || choix == "2" || choix == "3"
      indice = choix.to_i
      return if indice > @ennemies.size-1 # impossible en principe

      @human_player.attacks(@ennemies[indice])
      kill_player(indice) if @ennemies[indice].life_points <= 0
      # if @ennemies[indice].life_points <= 0 kill_player(@ennemies[indice])
    end

  end

  def ennemies_attacks
    # Chaque ennemi m'attaque successivement à condition qu'il soit encore vivant !
    puts "\n\n"
    puts "/!\\ Tes ennemis t'attaquent !\n\n".center(80) if @ennemies.size > 0
    @ennemies.each { | player | player.attacks(@human_player) if @human_player.life_points > 0  }
  end


  def end
    puts "\n" + "="*80 + "\n\n"
    puts "  L a   p a r t i e   e s t   t e r m i n é e  !  !  ! \n\n".center(80)
    if @human_player.life_points > 0
      puts "    B R A V O   !   T U   A S   G A G N E   ! ".center(80)
    else
      puts "    L o s e r   !   T u   a s   p e r d u   !".center(80)
    end
    puts "\n\n" + "="*80 + "\n"
  end

end