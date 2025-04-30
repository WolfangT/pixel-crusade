extends Node

# id: {
#     'name': '...',
#     'models': [
#         {
#             name: "...",
#             activated_this_turn: bool,
#         },
#     ],
# }
## List of current players.
var Players := {}

## Number turns to play.
@export var max_turns := 0

## Number of the current turn.
@export var current_turn_number := 0

## ID of the current Player to play.
@export var current_activation_player := 0

## Array of players id to cycle forplay order.
@export var players_activation_order := []
@export var players_activation_order_index = 0

func set_up_game() -> void:
    print("Start of game")
    current_turn_number = 0
    start_turn()

func start_turn() -> void:
    current_turn_number += 1
    print("Start of turn %s of %s" % [current_turn_number, max_turns])
    # Set Players activation order.
    players_activation_order_index = 0
    players_activation_order = []
    for id in Players:
        players_activation_order.append(id)
    players_activation_order.sort_custom(_sort_players_by_units_left)

func next_activation() -> void:
    # Check that there are players with not activated models
    var successfuly_activated := false
    for _i in range(len(Players)):
        var player = _alternate_over_players()
        for model in player.models:
            if not model.activated_this_turn:
                successfuly_activated = true
                break
        if successfuly_activated:
            break
    if not successfuly_activated:
        end_turn()


func end_turn() -> void:
    print("End of turn %s of %s" % [current_turn_number, max_turns])
    if current_turn_number >= max_turns:
        end_game()

func end_game() -> void:
    print("End of game")
    pass

# Utility functions

func _sort_players_by_units_left(a, b) -> bool:
    var player_a_models := 0
    for model in Players[a].models:
        if model.in_action:
            player_a_models += 1
    var player_b_models := 0
    for model in Players[b].models:
        if model.in_action:
            player_b_models += 1
    return player_a_models < player_b_models

func _alternate_over_players() -> Dictionary:
    players_activation_order_index += 1
    if players_activation_order_index >= len(players_activation_order):
        players_activation_order_index = 0
    return Players[players_activation_order[players_activation_order_index]]