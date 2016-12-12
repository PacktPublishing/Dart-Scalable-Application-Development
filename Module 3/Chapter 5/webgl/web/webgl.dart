import 'dart:html';
import 'dart:web_gl';

// Vertex shader program
var VSHADER_SOURCE = '''attribute vec4 a_Position;\n
                     void main() {\n 
                     gl_Position = a_Position;\n
                     gl_PointSize = 10.0;\n 
                     }\n''';

// Fragment shader program
var FSHADER_SOURCE = '''void main() {\n
                     gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);\n // Set the point color
                     }\n''';

// The array for the position of a mouse press
List<num> g_points = new List<num>();

void main() {
  // Retrieve <canvas> element
  var canvas = querySelector("#webgl");
  if (canvas == null) {
    print('Failed to retrieve the <canvas> element');
  }
  // Get the rendering context for WebGL
  RenderingContext gl = canvas.getContext3d();
  if (gl == null) {
    print('Failed to get the rendering context for WebGL');
    return;
  }
  // compiling the GPU code
  Shader fragShader = gl.createShader(FRAGMENT_SHADER);
  gl.shaderSource(fragShader, FSHADER_SOURCE);
  gl.compileShader(fragShader);

  Shader vertShader = gl.createShader(VERTEX_SHADER);
  gl.shaderSource(vertShader, VSHADER_SOURCE);
  gl.compileShader(vertShader);

  Program program = gl.createProgram();
  gl.attachShader(program, vertShader);
  gl.attachShader(program, fragShader);
  gl.linkProgram(program);

  if (!gl.getProgramParameter(program, LINK_STATUS)) {
    print("Could not initialise shaders");
    return;
  }
  gl.useProgram(program);

  // Get the storage location of a_Position
  var a_Position = gl.getAttribLocation(program, 'a_Position');
  if (a_Position < 0) {
    print('Failed to get the storage location of a_Position');
    return;
  }
  // Register function (event handler) to be called on a mouse press
  //canvas.onmousedown = function(ev){ click(ev, gl, canvas, a_Position); };
  canvas.onMouseDown.listen((ev) => click(ev, gl, canvas, a_Position));
  // Specify the color for clearing <canvas>
  gl.clearColor(0.0, 0.0, 0.0, 1.0);
  // Clear <canvas>
  gl.clear(COLOR_BUFFER_BIT);
  // Draw a point
  gl.drawArrays(POINTS, 0, 1);
}

void click(ev, RenderingContext gl, canvas, a_Position) {
   var x = ev.clientX; // x coordinate of a mouse pointer
   var y = ev.clientY; // y coordinate of a mouse pointer
   var rect = ev.target.getBoundingClientRect();

   x = ((x - rect.left) - canvas.width / 2) / (canvas.width / 2);
   y = (canvas.height / 2 - (y - rect.top)) / (canvas.height / 2);
   // Store the coordinates to g_points array
   g_points.add(x);
   g_points.add(y);

   // Clear <canvas>
   gl.clear(COLOR_BUFFER_BIT);

   var len = g_points.length;
   for (var i = 0; i < len; i += 2) {
     // Pass the position of a point to a_Position variable
     gl.vertexAttrib3f(a_Position, g_points[i], g_points[i + 1], 0.0);

     // Draw
     gl.drawArrays(POINTS, 0, 1);
   }
}

