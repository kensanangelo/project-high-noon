extends Node

signal player_stepped(player: Enums.Players, count: int)
signal player_shot(player: Enums.Players, new_count: int)
signal players_ready_to_shoot
