##This script is used to send signals only globally, between different windows, not in the same window
extends Node
@warning_ignore_start("unused_signal")

#Timer
signal timeout
signal add_time(float)

#Game
signal game_started
signal game_ended

#Tasks
signal task_spawned(Array)
signal task_removed(Array)
