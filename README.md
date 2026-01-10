# Gatekeeper Mobile

Gatekeeper Mobile is the mobile client of the **Gatekeeper Project**, designed to provide secure, scalable, and user-friendly access management on the go.  
This app integrates with the Gatekeeper backend to handle authentication and authorization

---

## 📱 Features
- 🔐 **Secure Authentication**: Login with JWT/session tokens, OAuth2, or API keys.
- 📊 **Dashboard Access**: View and manage gate entries, logs, and alerts.
- 🌐 **Cross-platform Support**: Runs on both Android and iOS.
- 🎨 **Modern UI/UX**: Clean, responsive design optimized for mobile.

---

## 🛠️ Tech Stack
- **Frontend Framework**: Flutter (Dart)  
- **State Management**: Provider
- **Networking**: REST APIs with secure headers (Bearer tokens)  
- **Storage**: Secure local storage for tokens and preferences 

---

## 🚀 Getting Started

### Prerequisites
- Install [Flutter SDK](https://docs.flutter.dev/get-started/install) 
- Android Studio / Xcode for emulators
- Access to Gatekeeper backend API (credentials required)

### Installation
```bash
# Clone the repository
git clone https://github.com/your-org/gatekeeper-mobile.git
cd gatekeeper-mobile

# Install dependencies
flutter pub get
