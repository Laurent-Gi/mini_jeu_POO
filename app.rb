require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


# - - - - - - - - - - - - - - - - - - - - #
#       V E R S I O N   1 . 0             #
# - - - - - - - - - - - - - - - - - - - - #

# Affiche l'état des jouteurs
def fight_state(player1, player2)
  puts " "
  puts "Voici l'état de nos joueurs".center(80)
  puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~".center(80)
  player1.show_state
  player2.show_state
  puts "\n"
end

# Orchestration d'un combat entre Josiane et José
# ------------------------------------------------
system 'clear'
puts "\n\n" + "="*80 + "\n\n\n"
puts "Voici venue le temps du combat !".center(80)
puts "\n\n" + "="*80
player1 = Player.new("Josiane")
player2 = Player.new("José")

puts "\n"*2 + "="*80 + "\n"*2
puts "A ma droite : #{player1.name}".rjust(80)
puts "A ma gauche : #{player2.name}".ljust(80)
puts "\n\n"
puts "Juste avant le combat :".center(80)

fight_state(player1, player2)

puts "Le joueur #{player2.name} aura l'honneur d'attaquer en premier".center(80)
puts "\n"*2 + "="*80 + "\n"*2

# COMBAT A MORT : Tant que les deux sont en vie, on se bat !
while player2.life_points > 0 && player1.life_points > 0 do
  # FIGHT : 1er round : pif-paf
  # puts "Attaque du joueur #{player2.name}"
  player2.attacks(player1)
  # player1.show_state
  break if player1.life_points <= 0

  # puts "Le joueur #{player1.name} réplique malgré sa blessure"
  player1.attacks(player2)
  # player2.show_state

  fight_state(player1, player2)

end

# binding.pry