# 安裝

```bash
git clone git@github.com:Lichyo/CyCube.git
flutter pub get
flutter run
```

# 專案結構
lib/
├── cube/
│   └── ... (所有與 Cube 相關的程式碼，包含 Controller、Model、View 等)
├── service/
│   ├── auth_service.dart: 登入、註冊、登出 (使用 Google 帳戶)
│   ├── database_service.dart: 資料庫相關程式碼，包含從資料庫取得 Cube 資料、新增 Cube 至資料庫以建立課程教室。
│   ├── image_controller.dart: 從相機取得圖片並解析為圖片 Widget 或 Model 可讀取的格式 (相機畫質無法調整)。
│   └── realtime_metric.dart: 測試專案效能。
└── view/
├── course_page.dart: (若成功連接後端伺服器，會跳出 "Connected" 訊息)
│   ├── 導航至設定頁面 (學生)
│   └── 加入課程教室 (老師)
├── course_setup_page_auto.dart: 進入此頁面後，系統會請求相機權限，並至少等待 3 秒，按下相機按鈕以拍攝圖片。
└── home_page.dart: 一個沒有旋轉偵測的簡單 Cube。
