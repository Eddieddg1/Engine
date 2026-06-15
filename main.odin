package main

// Core imports
import "core:fmt"

// Vendor imports
import gl "vendor:OpenGL"

// Odin file imports
import glfw "./glfw"

// Main fucntion
main :: proc() {
  // Calls winInit to initialize glfw
  glfw.winInit()

  // Struct parsing desired window info to glfw
  setWinInfo := glfw.winInfo {
    winWidth = 1280,
    winHeight = 720,
    winTitle = "Test",
    winFullscreen = false,
  }

  // Calls winCreate to create window and OpenGL context
  getGLContext := glfw.winCreate(setWinInfo)

  // Assign OpenGL context of window to OpenGL
  gl.load_up_to(3, 1, cast(gl.Set_Proc_Address_Type)getGLContext.glProcAddr)

  // Set the desired viewport to cover the entire window
  gl.Viewport(0, 0, setWinInfo.winWidth, setWinInfo.winHeight)
  // Changes the color of the window to pink
  gl.ClearColor(1.0, 0.3, 0.97, 1.0)
  // Changes the color of the back buffer to gl.ClearColor
  gl.Clear(gl.COLOR_BUFFER_BIT)

  // Main window rendering loop
  glfw.winLoop(getGLContext.winHandle)

  // Termination call
  glfw.winTerminate(getGLContext.winHandle)
}
