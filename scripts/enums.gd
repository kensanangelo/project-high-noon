extends Node

enum Players { PLAYER_1, PLAYER_2 }

enum BattleResults { PLAYER_1_WINS, PLAYER_2_WINS, TIE }

#enum Directions { UP, DOWN, LEFT, RIGHT }

# gdlint: disable=constant-name
const Directions = {
	"UP": "up",
	"DOWN": "down",
	"LEFT": "left",
	"RIGHT": "right",
}
