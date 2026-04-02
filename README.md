# 🍽️ Recipe App (Flutter + Dio)

A clean and scalable Flutter application that fetches recipe data from an API using Dio, displays it in a modern UI, and shows detailed recipe information with smooth animations.

---

## 🚀 Features

* 📡 API integration using Dio
* 📋 Recipe list screen
* 🔍 Recipe detail screen
* ✨ Hero animation (List → Detail transition)
* ⏳ Shimmer loading effect
* 🧱 Clean architecture (separation of concerns)
* 🔄 Reusable widgets
* 📱 Responsive UI

---

## 📂 Project Structure

```
lib/
│
├── core/                   # Constants, themes, helpers
├── api/                    # API & models
│   ├── models/
│   ├── services/
│
├── view/                   # UI layer
│   ├── screens/
│         ├── controller    # Business logic & state
│         ├── view          # UI Screen 
│         ├── binding       # binds controller to ui
│   ├── widgets/    
│
└── main.dart
```

---

## 🔗 API Used

Base URL:

```
https://dummyjson.com/recipes
```

Example Endpoint:

```
GET /recipes/1
```

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/Tejaskt/dio_api_call.git
cd dio_api_call
```

---

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

---

### 3️⃣ Run the App

```bash
flutter run
```

---

## 🧠 How It Works

### 🔹 App Flow

```
Home Screen (Recipe List)
        ↓
Click on Recipe
        ↓
Recipe Detail Screen
```

---

### 🔹 API Handling

* Dio is used for network requests
* API responses are converted into model classes
* Proper separation between UI and data layer

---

### 🔹 State Management

* Uses ChangeNotifier / Provider
* ViewModel handles logic
* UI reacts to state updates

---

### 🔹 UI Features

#### ⏳ Shimmer Loading

Displayed while fetching data from API

#### ✨ Hero Animation

Smooth transition of image from list → detail screen

---

## 🛠️ Dependencies

```yaml
dio: ^latest
provider: ^latest
shimmer: ^latest
```

---

## 📸 Screenshots

(screenshots will be added later)

---

## 📌 Customization Guide

### Change API Base URL

Go to:

```
lib/data/services/api_service.dart
```

Update:

```dart
baseUrl = "your_api_url";
```

---

### Modify UI

All UI code is located in:

```
lib/presentation/screens/
lib/presentation/widgets/
```

---

## 🧪 Future Improvements

* 🔍 Search functionality
* ❤️ Favorites feature
* 📥 Pagination (infinite scroll)
* 🌙 Dark mode

---

## 🤝 Contributing

Pull requests are welcome.
If you find any issues, feel free to open one.

---

## 👨‍💻 Author

**Tejas Kanazriya**
Mobile Application Developer

---

## ⭐ Support

If you like this project, give it a ⭐ on GitHub!
