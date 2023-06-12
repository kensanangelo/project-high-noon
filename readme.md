# Project High Noon (Working Title)

## About

This is a game in progress built in Godot 4 using GDScript. The concept is simply that two players compete in an old west cowboy duel on one keyboard (for now). I am open to suggestions and thoughts, so feel free to reach out!

## How to play

### Rules

-  Each player has 6 bullets to shoot the opponent.
-  Both players must take 5 steps before turning to shoot.
-  If either player shoots before both players have taken 5 steps, they lose.
-  If a player gets hit, they lose.
-  If both players run out of bullets and neither gets hit, the game is a tie.

### Controls

The controls are very simple, and designed so that both players can play on the same keyboard. Therefore, player 1 has their keys on the left of the keyboard, and player 2 has theirs on the right.

Player 1:

-  Press `A` key to take a step
-  Hold `S` key to take aim
-  Release `S` key to turn and shoot
   -  Note that once a play has turned to shoot, they cannot take any more steps

Player 2:

-  Press `L` key to take a step
-  Hold `K` key to take aim
-  Release `K` key to turn and shoot
   -  Note that once a play has turned to shoot, they cannot take any more steps

## Development

To install, simply open the folder in Godot (must use version 4 or above). Current thoughts and todo items are listed in `todos.md`.
