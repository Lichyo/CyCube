# CyCube

## Installation
### Prerequisites
our system can use one of the following systems below: 
1. Python Flask Server
```bash
git clone git@github.com:ChenYi0725/senior_project.git
cd senior_project
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python pack_for_chiyu/predict_server.py
```
2. Docker Container
```bash
docker pull chiyu003/cycube-server:dev
docker run -d -p 5000:5000 --name cycube-server chiyu003/cycube-server:dev
```

### Flutter
```bash
git clone git@github.com:Lichyo/CyCube.git
cd CyCube
// update the server address in lib/config.dart with your own 
flutter pub get
flutter run
```