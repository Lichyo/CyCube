# Installation
```bash
git clone git@github.com:Lichyo/CyCube.git
flutter pub get
flutter run
```

# Project Structure
lib/cube : all the cube related code, include controller, model, view, etc.
lib/service :
  -> auth_service : sign in, sign up, sign out (with google account)
  -> database_service : database related code, include get cube data from database, add cube to database in order to create course room.
  -> image_controller : get image from camera and parse it into image widget or the format that the model can read. (camera quality cannot change)
  -> realtime_metric : testing this project performance,
lib/view :
  -> course_page (run backend server first, if you connect to server successfully, it would pop out Connected)  : navigate to setup page (student) or join course room (teacher)
  -> course_setup_page_auto: after enter this page, our system would ask permission to access camera, and then wait for 3 seconds at least, pressing camera button to capture the image.
  -> home_page : a simple cube without rotation detection.
