require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


# - - - - - - - - - - - - - - - - - - - - #
#       V E R S I O N   2 . 0             #
# - - - - - - - - - - - - - - - - - - - - #

def starting_message
  system 'clear'
  puts "\n" + "="*80 + "\n\n"
  puts " T'en as marre d'être traité(e) comme un OBJET ? ".center(80)
  puts " Tu veux t'battre ? Peter la gueule à tout le monde ?\n\n".center(80)
  puts " Alors, bienvenue sur 'SAUVE TA POO' !".center(80)
  puts "                        ~~~~~~~~~~~~~  \n\n".center(80)
  puts " Le but du jeu est d'être le dernier survivant !\n\n".center(80)
  puts " Car...   un  seul  survivra  ! ".center(80)
  puts "\n" + "="*80 + "\n"
end

def ending_message(life_points)
  puts "\n" + "="*80 + "\n\n\n"
  puts "  L a   p a r t i e   e s t   t e r m i n é e  !  !  ! \n\n".center(80)
  if life_points > 0
    puts "    B R A V O   !   T U   A S   G A G N E   ! ".center(80)
  else
    puts "    L o s e r   !   T u   a s   p e r d u   !".center(80)
  end
  puts "\n\n" + "="*80 + "\n"
end

def human_choice(ennemies)
  puts "-=-=-=-=-=-=-=-=_=-=_=-=_=-=-=-=-".center(40)
  puts "Quelle action veux-tu effectuer ?".center(40)
  puts "- - - - - - - - - - - - - - - - -".center(40)
  puts "a - Chercher une meilleure arme ".center(40)
  puts "s - Chercher à se soigner ".center(40)
  puts " "
  puts "Attaquer un joueur en vue :".center(40)
  ennemies.each_with_index do | player, i |
  print "#{i} - ".rjust(8)
  player.show_state(20)
  end

  puts "_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_".center(40)
  print "your choice > "
  letter = STDIN.gets.chomp.to_s
  # puts "Lettre #{letter}"
  
  while true
    return letter if letter == "a" || letter == "s"
    if ( (letter == "0" && ennemies[0].life_points <= 0) || (letter == "1" && ennemies[1].life_points <= 0) )
      puts "\n\n"
      puts "Ce joueur est déjà mort ! Cessez de vous acharner sur celui-ci".center(80)
      puts "Merci d'en choisir un autre, ou de faire autre chose de votre vie !\n\n".center(80)
    end
    return letter if letter == "0" && ennemies[0].life_points > 0
    return letter if letter == "1" && ennemies[1].life_points > 0
    puts "Merci de donner un choix valide : une lettre : a, s, 0 ou 1 "
    print "your choice > "
    letter = STDIN.gets.chomp.to_s
    # puts "Lettre #{letter}"
  end
end


def get_user_name_from_stdin
  puts " "
  puts "Bonjour à toi, habitant de la terre !".center(80)
  puts "\nQuel est ton prénom ?"
  print "> "
  first_name = STDIN.gets.chomp.to_s
  first_name.length > 0 ? first_name : "Habitant_de_la_terre"
end


def perform

  starting_message

  username = get_user_name_from_stdin

  humanplayer = HumanPlayer.new(username)

  # Les ennemies : on les mets dans un tableau... car on risque de se faire beaucoup d'ennemies ;o)
  ennemies = Array.new

  ["José", "Josiane"].each { | name | ennemies << Player.new(name) }
  
  # ---------------------------------------------------------------------------------------------
  # COMBAT A MORT : Tant que l'humain reste vivant
  #                 et qu'il existe un ennemi vivant, on reste dans le game !
  # ---------------------------------------------------------------------------------------------
  while humanplayer.life_points > 0 && (ennemies[0].life_points > 0 || ennemies[1].life_points > 0) do

    #1/ On affiche l'état de santé :
    humanplayer.show_state

    choix = human_choice(ennemies)

    if choix == "a"
      humanplayer.search_weapon
    elsif choix == "s"
      humanplayer.search_health_pack
    elsif choix == "0"
      humanplayer.attacks(ennemies[0])
    elsif choix == "1"
      humanplayer.attacks(ennemies[1])
    end

    puts "\n\n"
    if (ennemies[0].life_points > 0 || ennemies[1].life_points > 0)
      puts "Les autres joueurs t'attaquent !".center(80)
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n".center(80)
    end
    
    # Chaque ennemi m'attaque successivement à condition qu'il soit encore vivant !
    ennemies.each { | player | player.attacks(humanplayer) if player.life_points > 0  }
  
  end

  ending_message(humanplayer.life_points)

end

# Only if the file is being executed directly, as a script
if __FILE__ == $0
  perform
end

# binding.pry 