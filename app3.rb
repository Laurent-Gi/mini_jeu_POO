require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# - - - - - - - - - - - - - - - - - - - - #
#       V E R S I O N   3 . 0             #
# - - - - - - - - - - - - - - - - - - - - #


def starting_message
  system 'clear'
  puts "\n" + "="*80 + "\n\n"
  puts " Cette fois-ci, on ne rigole plus ! ".center(80)
  puts " C'est un vrai GAME avec 4 ennemies ?\n\n".center(80)
  puts " Alors, 'SAUVE TA POO' Si tu le peux encore !\n\n".center(80)
  puts " Le but du jeu est d'être le dernier survivant !\n\n".center(80)
  puts " Car...    seul  toi  doit  survivre  ! ".center(80)
  puts "\n" + "="*80 + "\n\n"
end


def get_user_name_from_stdin
  puts "Bonjour à toi, habitant de la terre !"
  puts "Quel est ton prénom ?"
  print "> "
  first_name = STDIN.gets.chomp.to_s
  first_name.length > 0 ? first_name : "Habitant_de_la_terre"
end



def perform

  starting_message

  username = get_user_name_from_stdin

  # ------------------------------------------------------
  # 1 On initialise une partie : Création d'un objet Game
  # ------------------------------------------------------
  my_game = Game.new(username)

  # ---------------------------------------------------------------------------------------------
  # COMBAT A MORT : Tant que l'humain reste vivant
  #                 et qu'il existe un ennemi vivant, on reste dans le game !
  # ---------------------------------------------------------------------------------------------

  while my_game.is_still_ongoing? do

    # 1/ On affiche les états de santé :
    # ----------------------------------
    my_game.show_players

    # 2/ On affiche le menu, et on récupère le choix :
    # ------------------------------------------------
    choice = my_game.menu

    # 3/ On transmet le choix :
    # -------------------------
    my_game.menu_choice(choice)

    # 4/ Riposte des ennemies :
    # -------------------------
    my_game.ennemies_attacks

  end

# Fin de partie : Message de Fin !!!
# -----------------------------------
my_game.end

end

# Only if the file is being executed directly, as a script
if __FILE__ == $0
  perform
end
