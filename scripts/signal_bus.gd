extends Node

signal player_stepped(player: Enums.Players, count: int)
signal player_shot(player: Enums.Players, new_count: int)
signal players_ready_to_shoot
signal player_died(player: Enums.Players)
signal players_disabled

signal bullet_fired(pos: Vector2, angle_degrees: float, from: Enums.Players)
signal bullets_collided(pos: Vector2, involved_bullet1: String, involved_bullet2: String)
signal bullet_ends
