## Programme développé en Ruby 
    --------------------------- 
 
 > Date     : 21/07/2020
 > Auteur   : Laurent Saives
 > Contexte : THP

 Les gem utiles pour ce programme se trouvent dans le fichier Gemfile
 

 Il suffit d'executer la commande :
             -  bundle install
                                pour que l'environnement soit prêt.
 
 
mini_jeu_POO
├── lib
│   ├── player.rb
│   └── game.rb
├── app.rb
├── README.md
├── Gemfile
├── Gemfile.lock
└── Autres fichiers (.env, .gitignore)


Execute : *app.rb*, *app2.rb*, & *app3* : 3 programs to run for the V1.0 V2.0 and V3.0 versions.

## Content

- **lib/** : Classes `Game` et `Player`.
- **app** : execution files.
- **Gemfile, Gemfile.lock** : Gem and dependencies. See below.


## Classes

### Game

Provides methods and variables to organize game process and its different phases.

- \# initialize
- \# kill_player
- \# is_still_ongoing?
- \# show_players
- \# menu
- \# menu_choice
- \# ennemies_attacks
- \# end


### Player

Provides methods and variable to manage players actions and status.

- \# initialize
- \# show_state
- \# gets_damage
- \# attacks
- \# compute_damage


### HumanPlayer

*Inherits from Player* - Provides specific methods for Player played by real user.

- \# initialize
- \# show_state
- \# compute_damage
- \# search_weapon
- \# add_life_points
- \# search_health_pack

## Gemfile

```
ruby '2.7.1'
source 'https://rubygems.org'
gem 'rubocop', '~> 0.88.0', require: false
gem 'pry'
gem 'rspec'
