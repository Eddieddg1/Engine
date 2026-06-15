package window

// Core imports
import "core:fmt"
import "base:runtime"

// Vendor imports
import "vendor:glfw"

// Structs
// Window information struct
winInfo :: struct {
  winWidth : i32,
  winHeight : i32,
  winTitle : cstring,
  winFullscreen : bool,
}

GLContext :: struct {
  winHandle: glfw.WindowHandle,
  glProcAddr: rawptr,
}

// Procs
errorCallback :: proc "c" (error: i32, description: cstring) {
    context = runtime.default_context()
    fmt.printfln("GLFW Error %i: %s", error, description)
}

winInit :: proc() {
  glfw.SetErrorCallback(errorCallback)

  if !glfw.Init() {
    fmt.println("GLFW failed to initialize")
  }
}

winCreate :: proc(setWinInfo: winInfo) -> GLContext {
  glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3)
  glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 1)
  glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_ANY_PROFILE)

  monitor: glfw.MonitorHandle = nil
  if setWinInfo.winFullscreen {
    monitor = glfw.GetPrimaryMonitor()
  }

  window := glfw.CreateWindow(setWinInfo.winWidth, setWinInfo.winHeight, setWinInfo.winTitle, monitor, nil)

  glfw.MakeContextCurrent(window)
  
  if window == nil {
    fmt.println("Could not create window")
  }

  return GLContext {
    winHandle  = window,
    glProcAddr = rawptr(glfw.gl_set_proc_address),
  }
}

winLoop :: proc(window: glfw.WindowHandle) {
  glfw.SwapBuffers(window)

  for !glfw.WindowShouldClose(window) {
    glfw.PollEvents()
  }
}

winTerminate :: proc(window: glfw.WindowHandle) {
  glfw.DestroyWindow(window)
  glfw.Terminate()
}
