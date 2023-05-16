extends Node

signal player_stepped(player: Enums.PLAYERS, count: int)
signal player_shot(player: Enums.PLAYERS, new_count: int)
signal players_ready_to_shoot
