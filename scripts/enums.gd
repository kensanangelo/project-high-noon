extends Node

enum Players { PLAYER_1 = 1, PLAYER_2 = 2 }
# gdlint: disable=constant-name
const PlayerNodeNames = {
	1: "Player1",
	2: "Player2",
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
