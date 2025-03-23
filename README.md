# 📱 NutriTrack - Flutter App

NutriTrack is a Flutter-based mobile application that allows users to **scan QR codes**, retrieve **nutritional information**, and store the data locally.

---

## 🚀 Features

✅ **QR Code Scanning** - Scan food product QR codes using your camera.  
✅ **Nutritional Information** - Display detailed nutritional values after scanning.  
✅ **Data Storage** - Save scanned information using SharedPreferences for later use.  
✅ **Personal Info Section** - View stored nutritional data in a user-friendly format.

---

## 📸 App Screenshots

| Splash Screen | Scan Screen | Info Screen | Personal Info |
|--------------|------------|-------------|--------------|
| ![Splash](./screenshots/splash.png) | ![Scan](./screenshots/scan.png) | ![Info](./screenshots/info.png) | ![Personal](./screenshots/personal.png) |

---

## 🛠 Installation

1. **Clone the Repository**
```bash
 git clone https://github.com/your-username/nutritrack.git
 cd nutritrack
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Run the App**
```bash
flutter run
```

---

## 📦 Dependencies

Ensure you have the following dependencies in `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  qr_code_scanner: ^1.0.1
  shared_preferences: ^2.2.0
```

---

## 📜 Code Structure
```
lib/
│── main.dart           # Entry point of the app
│── screens/
│   ├── home_screen.dart
│   ├── scan_screen.dart
│   ├── info_screen.dart
│   ├── personal_info_screen.dart
│── widgets/
│   ├── custom_button.dart
│── utils/
│   ├── storage_service.dart
```

---

## 📖 Usage

1. Open the app and navigate to **Scan**.
2. Scan a **QR code** containing food data.
3. View **nutritional information**.
4. Click **Save** to store the scanned data.
5. Visit **Personal Info** to see stored nutrition details.

---

## 💡 Next Steps

- [ ] Integrate Firebase for real-time storage
- [ ] Improve UI/UX with animations
- [ ] Add barcode scanning feature

---

## 👨‍💻 Author

Developed by **Ali** 👨‍💻

🔗 Connect: [LinkedIn](https://linkedin.com/in/your-profile) | [GitHub](https://github.com/your-username)

---

## 🌟 Contributing

Want to contribute? Fork the repo, make changes, and submit a pull request!

```bash
git checkout -b feature-branch
git commit -m "Your feature"
git push origin feature-branch
```
