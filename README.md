# CY-Cube
CY-Cube is an interactive 3D Rubik's Cube model application that allows users to manipulate and solve the Rubik's Cube with basic rotations and different view orientations. The project also features an educational mode for teaching and learning purposes.

# Features
## 3D Model
- Complete 3D model of the Rubik's Cube.
- Basic rotations and ability to view the cube from different angles.

## Cube Setup
- Manual input: Users can manually input colors to set up the cube.
- Automatic setup: Using OpenCV for color recognition to automatically set up the cube (lower accuracy).

## Model Extension
- A button at the bottom displays the unfolded 2D view of the cube.
- Clicking elsewhere returns to the main view.

## Educational Mode
1. Students can manually input colors to set up the cube.
2. Button to create a room at the bottom.
3. Room ID is displayed in the AppBar for teachers to join.
4. Students can only operate the cube using preset buttons now.
5. Room Icon in the top right corner to enter a room ID.
6. Real-time updates of the student's cube state when the teacher joins the room.
7. finally, Teachers can view the student's cube state.

# Future Plans (Priority Order)
- Integrate gesture model on the client side (metadata required).
- Improve accuracy of cube color setup.
- Change the educational mode database to real-time.
- Add teaching animations.
- Generate solution sequences for teaching.

# Installation
1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Run `flutter run` to start the application.

# Contributors
- [Chi-Yu Li](https://github.com/Lichyo)

# License
This project is licensed under the BSD 3-Clause License. See the LICENSE file for more details.