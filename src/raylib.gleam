import gleam/erlang/process
import gleam/list

@external(erlang, "libnifraylib", "init_window")
pub fn init_window(width: Int, height: Int) -> Int

@external(erlang, "libnifraylib", "set_target_fps")
pub fn set_target_fps(fps: Int) -> Int

@external(erlang, "libnifraylib", "window_should_close")
pub fn window_should_close() -> Int

@external(erlang, "libnifraylib", "begin_drawing")
pub fn begin_drawing() -> Int

@external(erlang, "libnifraylib", "end_drawing")
pub fn end_drawing() -> Int

// RGBA
pub type Color =
  #(Int, Int, Int, Int)

@external(erlang, "libnifraylib", "clear_background")
pub fn clear_background(bg: Color) -> Int

@external(erlang, "libnifraylib", "draw_rectangle")
pub fn draw_rectangle(
  pos_x: Int,
  pos_y: Int,
  width: Int,
  height: Int,
  color: Color,
) -> Int

const width = 900

const height = 600

const square_size = 10

fn draw_left(pos_x: Int, pos_y: Int) -> Nil {
  case pos_x >= width / 2 {
    True -> {
      case pos_y > height {
        True -> Nil
        False -> {
          draw_left(0, pos_y + square_size * 2)
        }
      }
    }
    False -> {
      draw_rectangle(pos_x, pos_y, square_size, square_size, #(255, 0, 0, 255))
      draw_left(pos_x + square_size * 2, pos_y)
    }
  }
}

fn draw_right(pos_x: Int, pos_y: Int) -> Nil {
  case pos_x >= width {
    True -> {
      case pos_y > height {
        True -> Nil
        False -> {
          draw_right(width / 2, pos_y + square_size * 2)
        }
      }
    }
    False -> {
      draw_rectangle(pos_x, pos_y, square_size, square_size, #(0, 0, 255, 255))
      draw_right(pos_x + square_size * 2, pos_y)
    }
  }
  Nil
}

fn wait_not_alive(pids: List(process.Pid)) -> Nil {
  let alive_count =
    pids |> list.filter(fn(pid) { process.is_alive(pid) }) |> list.length()
  case alive_count {
    0 -> Nil
    _ -> wait_not_alive(pids)
  }
}

fn loop() -> Nil {
  case window_should_close() {
    1 -> Nil
    _ -> {
      begin_drawing()
      clear_background(#(0, 0, 0, 255))
      // Let's play with processes
      let l_pid = process.spawn(fn() { draw_left(0, 0) })
      let r_pid = process.spawn(fn() { draw_right(width / 2, 0) })
      // we need to wait the process to finish drawing, otherwise we will clear before the process even finish
      wait_not_alive([l_pid, r_pid])
      end_drawing()
      loop()
    }
  }
}

pub fn main() -> Nil {
  let _ = init_window(width, height)
  let _ = set_target_fps(60)
  let _ = loop()
  Nil
}
