#include <stdio.h>
#include <raylib.h>
#include <erl_nif.h>

static ERL_NIF_TERM InitWindow_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    int width, height;
    if (!enif_get_int(env, argv[0], &width)) {
        return enif_make_badarg(env);
    }
    if (!enif_get_int(env, argv[1], &height)) {
        return enif_make_badarg(env);
    }
    InitWindow(width, height, "Hello from Gleam");
    return enif_make_int(env, 0);
}

static ERL_NIF_TERM SetTargetFPS_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    int fps;
    if (!enif_get_int(env, argv[0], &fps)) {
        return enif_make_badarg(env);
    }
    SetTargetFPS(fps);
    return enif_make_int(env, 0);
}

static ERL_NIF_TERM WindowShouldClose_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    int ret = WindowShouldClose();
    return enif_make_int(env, ret);
}

static ERL_NIF_TERM BeginDrawing_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    BeginDrawing();
    return enif_make_int(env, 0);
}

static ERL_NIF_TERM EndDrawing_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    EndDrawing();
    return enif_make_int(env, 0);
}

static ERL_NIF_TERM ClearBackground_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    const long unsigned int *color = {0};
    int arity = 0;
    if (!enif_get_tuple(env, argv[0], &arity, &color)) {
        return enif_make_badarg(env);
    }
    Color c = {
        .r = color[0],
        .g = color[1],
        .b = color[2],
        .a = color[3],
    };
    ClearBackground(c);
    return enif_make_int(env, 0);
}

static ERL_NIF_TERM DrawRectangle_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    int posX, posY, width, height;

    if (!enif_get_int(env, argv[0], &posX)) {
        return enif_make_badarg(env);
    }
    if (!enif_get_int(env, argv[1], &posY)) {
        return enif_make_badarg(env);
    }
    if (!enif_get_int(env, argv[2], &width)) {
        return enif_make_badarg(env);
    }
    if (!enif_get_int(env, argv[3], &height)) {
        return enif_make_badarg(env);
    }

    const long unsigned int *color = {0};
    int arity = 0;
    if (!enif_get_tuple(env, argv[4], &arity, &color)) {
        return enif_make_badarg(env);
    }
    Color c = {
        .r = color[0],
        .g = color[1],
        .b = color[2],
        .a = color[3],
    };
    DrawRectangle(posX, posY, width, height, c);
    return enif_make_int(env, 0);
}

static ErlNifFunc nif_funcs[] = {
    {"init_window", 2, InitWindow_nif},
    {"set_target_fps", 1, SetTargetFPS_nif},
    {"window_should_close", 0, WindowShouldClose_nif},
    {"begin_drawing", 0, BeginDrawing_nif},
    {"end_drawing", 0, EndDrawing_nif},
    {"clear_background", 1, ClearBackground_nif},
    {"draw_rectangle", 5, DrawRectangle_nif},
};

ERL_NIF_INIT(libnifraylib, nif_funcs, NULL, NULL, NULL, NULL)
