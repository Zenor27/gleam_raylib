-module(libnifraylib).
-export([init_window/2,
	 set_target_fps/1,
	 window_should_close/0,
	 begin_drawing/0,
	 end_drawing/0,
	 clear_background/1,
	 draw_rectangle/5]).
-on_load(init/0).

init() ->
	ok = erlang:load_nif("priv/libnifraylib", 0).
	
init_window(width, height) ->
	exit(erl_nif_not_loaded).

set_target_fps(fps) ->
	exit(erl_nif_not_loaded).

window_should_close() ->
	exit(erl_nif_not_loaded).

begin_drawing() ->
	exit(erl_nif_not_loaded).

end_drawing() ->
	exit(erl_nif_not_loaded).

clear_background(bg) ->
	exit(erl_nif_not_loaded).

draw_rectangle(posX, posY, width, height, color) ->
	exit(erl_nif_not_loaded).
