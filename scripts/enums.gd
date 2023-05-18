extends Node

enum Players { PLAYER_1, PLAYER_2 }
# gdlint: disable=constant-name
const PlayerNodeNames = {
	0: "Player1",
	1: "Player2",
}

# gdlint: disable=class-definitions-order
enum BattleResults { PLAYER_1_WINS, PLAYER_2_WINS, TIE }

#enum Directions { UP, DOWN, LEFT, RIGHT }

# gdlint: disable=constant-name
const Directions = {
	"UP": "up",
	"DOWN": "down",
	"LEFT": "left",
	"RIGHT": "right",
}
