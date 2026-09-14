# حقوقي (Huqouqi) — Flutter Legal Consultation Platform

A production-ready Flutter scaffold for **حقوقي**, a mobile app connecting Iraqi
citizens with licensed lawyers. Fully Arabic (RTL), themed in Deep Navy Blue +
Legal Gold, structured for Firebase and Google Play Store deployment.

## 1. What's included

```
lib/
├── main.dart                 # App entry point, theme + RTL wrapper
├── theme/app_theme.dart      # Navy/Gold light & dark ThemeData
├── core/
│   ├── constants.dart        # Governorates, specialties, disclaimer text
│   └── routes.dart           # Named routes
├── models/                   # UserModel, LawyerModel, ConsultationModel, CaseModel
├── services/                 # AuthService, FirestoreService, StorageService, MessagingService
├── widgets/                  # BottomNavBar, LawyerCard, EmptyState, DisclaimerBanner, RequestConsultationSheet
└── screens/
    ├── main_shell.dart       # Bottom-nav host (IndexedStack, 5 tabs)
    ├── home/                 # الرئيسية
    ├── lawyers/              # دليل المحامين + الملف المهني
    ├── consultations/        # المحادثات
    ├── cases/                # قضاياي (Active/Resolved tabs)
    └── profile/              # حسابي (settings, about, logout, delete account)
```

All screens are functional with local placeholder/sample data so you can
`flutter run` immediately. Firebase calls are stubbed with `// TODO` comments
showing exactly where to wire in real data.

## 2. Getting started

```bash
flutter create --org com.yourcompany --project-name huqouqi .   # only if starting fresh
flutter pub get
flutter run
```

> This scaffold assumes you'll run `flutter create .` in this folder first if
> you don't already have `android/`, `ios/`, and platform runner files — we've
> included the key `AndroidManifest.xml` overrides, but a fresh `flutter create`
> will generate the full platform folders (ios/, android/gradle wrappers, etc.)
> which you then merge with the provided `android/app/src/main/AndroidManifest.xml`.

## 3. Firebase Setup

1. Create a Firebase project at https://console.firebase.google.com.
2. Install the CLI tools:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
   This generates `lib/firebase_options.dart`. Then in `lib/main.dart`,
   uncomment:
   ```dart
   import 'firebase_options.dart';
   ...
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   ```
3. **Authentication** → Enable "Phone" sign-in provider (matches
   `AuthService.sendOtp` / `verifyOtp`).
4. **Firestore** → Create in production mode, then set up collections:
   - `users/{uid}`
   - `lawyers/{lawyerId}`
   - `users/{uid}/consultations/{id}/messages/{id}`
   - `users/{uid}/cases/{id}`
   - `posts/{id}` (public inquiries from "طلب استشارة")
   - `users/{uid}/blocked/{blockedUid}`
5. **Storage** → For profile photos (`profile_photos/{uid}.jpg`) and lawyer
   license documents (`lawyer_licenses/{lawyerId}.pdf`).
6. **Cloud Messaging** → No extra console config needed beyond enabling the
   API; `MessagingService.initialize()` requests permission and retrieves the
   device token — persist it on the user document to send targeted pushes
   (e.g. via a Cloud Function trigger on new chat messages).

### Recommended Firestore Security Rules (starting point)
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid} {
      allow read, write: if request.auth != null && request.auth.uid == uid;
      match /{subcollection=**} {
        allow read, write: if request.auth != null && request.auth.uid == uid;
      }
    }
    match /lawyers/{lawyerId} {
      allow read: if true;
      allow write: if false; // manage via admin/back-office only
    }
    match /posts/{postId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && request.resource.data.uid == request.auth.uid;
    }
  }
}
```

## 4. Wiring screens to real data (replace placeholders)

| Screen | Replace | With |
|---|---|---|
| `HomeScreen` → "طلب استشارة" | inline `Future.delayed` mock | `FirestoreService().publishInquiry(uid, name, text)` |
| `LawyersDirectoryScreen` | `_allLawyers` static list | `StreamBuilder` on `FirestoreService().streamLawyers(...)` |
| `ConsultationsScreen` | empty `_consultations` list | `StreamBuilder` on `FirestoreService().streamConsultations(uid)` |
| `MyCasesScreen` | empty `_activeCases`/`_resolvedCases` | `StreamBuilder` on `FirestoreService().streamCases(uid, status: ...)` |
| `ProfileScreen` | hardcoded name/phone | Load from `FirestoreService().getUser(uid)` via a `Provider`/state manager |

The app uses `provider` (already in `pubspec.yaml`) — wrap `MainShell` in a
`ChangeNotifierProvider<UserModel?>` once auth/login screens are built, so
every tab can read the signed-in user without prop-drilling.

## 5. Still to build (not in this scaffold, by design)

- **Login/OTP screens** (phone auth UI) — `AuthService` is ready; build the
  phone-entry + OTP-entry screens and route to `MainShell` on success.
- **Iraqi Laws** browser screen (linked from Home's quick service tile).
- **My Posts** screen (linked from Home; use `FirestoreService().streamMyPosts(uid)`).
- **Chat thread screen** (opened from a Consultation or Lawyer Profile "بدء محادثة").
- **Edit Profile**, **Blocked Users list**, **Terms & Conditions** detail screens
  — all have `// TODO: navigate to ...` markers ready in `ProfileScreen`.
- **Notifications screen** — icon is wired in `HomeScreen`'s AppBar.

## 6. App icon & branding

Replace `assets/images/app_icon.png` with your final logo (1024×1024 PNG,
no transparency for iOS), then run:
```bash
flutter pub run flutter_launcher_icons
```

## 7. Publishing to Google Play

1. Set `applicationId` in `android/app/build.gradle` to your reverse-domain
   package name (e.g. `com.yourcompany.huqouqi`).
2. Generate a signing keystore and configure `android/key.properties` +
   signing config in `build.gradle` per the
   [official Flutter deployment guide](https://docs.flutter.dev/deployment/android).
3. Build the release bundle:
   ```bash
   flutter build appbundle --release
   ```
4. Upload the `.aab` from `build/app/outputs/bundle/release/` to the
   Play Console, complete the store listing (app name **حقوقي**, Arabic
   description, screenshots), and submit for review.
5. Make sure your **Privacy Policy** and **Terms & Conditions** URLs are live
   before submitting — required by Play Console, and referenced in the
   in-app "عن حقوقي" section.

## 8. Design notes

- Colors: `AppColors.navy` (#0B1F3A) primary, `AppColors.gold` (#C9A227) accent.
- Font: Noto Kufi Arabic via `google_fonts` (auto-downloaded; for production/
  offline builds, consider bundling the font file locally instead).
- RTL is forced app-wide via a `Directionality` wrapper in `main.dart`, so no
  extra `textDirection` handling is needed inside most widgets.
