# Student Task Manager

A complete Flutter application for managing student tasks with Google Sign-In authentication, Firebase integration, and a modern UI.

## Features

- **User Authentication**: Google Sign-In with Firebase Authentication.
- **Task Management**: Create, read, update, and delete tasks.
- **Task Features**:
    - Task title, description, and due date.
    - **Prioritization**: Mark tasks as low, medium, or high priority.
    - **Reminders**: Toggle reminders and set specific reminder times.
    - **Completion Tracking**: Mark tasks as complete and view completion history.
- **Notifications**: Local notifications for task reminders.
- **Theme Support**: Light and Dark theme toggle using `themeNotifier`.
- **User Profile**: View user profile with option to logout.
- **Navigation**: Bottom navigation bar for easy access to Home, Calendar, and Profile.
- **Data Persistence**: Tasks are stored in Firebase Firestore.

## Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.0.0 or higher)
- [Firebase Project](https://firebase.google.com/)
- Google Sign-In enabled in your Firebase project
- Android/iOS device or emulator

## Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd student_task_manager
```

### 2. Setup Firebase

1.  Go to the [Firebase Console](https://console.firebase.google.com/).
2.  Create a new project or select an existing one.
3.  Add your Android and/or iOS apps to the project.
    - **Android**: Download `google-services.json` and place it in `android/app/`.
    - **iOS**: Download `GoogleService-Info.plist` and place it in `ios/Runner/`.
4.  Enable **Google Sign-In** authentication:
    - Go to **Authentication** -> **Sign-in method**.
    - Enable **Google**.
    - Configure your project's SHA-1 fingerprint (required for Android).
5.  Enable **Firestore Database**:
    - Go to **Firestore Database** and create a database in test mode for development.
6.  Add your Firebase configuration to the Flutter app:

    ```bash
    flutterfire configure --project=your-project-id
    ```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the App

```bash
flutter run
```

## File Structure

```
lib/
├── main.dart             # Application entry point and theme setup
├── services/
│   ├── auth_service.dart   # Firebase Authentication services
│   └── database_service.dart # Firebase Firestore services
├── models/
│   └── task_model.dart     # Task data model
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart # Login screen with Google Sign-In
│   │   └── registration_screen.dart # (Optional) Registration screen
│   ├── home_screen.dart      # Home screen with task list
│   ├── task_form_screen.dart # Form for creating/editing tasks
│   ├── calendar_screen.dart  # Calendar view for tasks
│   └── profile_screen.dart   # User profile and settings
└── widgets/
    ├── task_card.dart        # Custom task card widget
    ├── app_theme.dart        # Theme configuration
    └── bottom_nav_bar.dart   # Bottom navigation
```

## Usage

### Logging In

1.  Launch the app.
2.  Click **Sign In with Google**.
3.  Select a Google account to sign in.

### Managing Tasks

- **Add Task**: Tap the '+' button on the Home screen.
- **Edit Task**: Tap on any task card to edit its details.
- **Delete Task**: Swipe left on a task card or use the delete button in the edit screen.
- **Complete Task**: Toggle the checkbox on the task card.

### Using Calendar

- Navigate to the **Calendar** tab to view tasks by date.
- Complete or edit tasks directly from the calendar view.

### Settings

- Navigate to the **Profile** tab to:
    - Toggle **Dark Theme**.
    - View your profile information.
    - **Logout** of the application.

## Technologies Used

- **Flutter**: UI framework.
- **Firebase Authentication**: User authentication.
- **Firebase Firestore**: Database for storing tasks.
- **Provider**: State management.
- **flutter_local_notifications**: Local notifications for reminders.

## Customization

- **Theme**: Modify `lib/widgets/app_theme.dart` to change colors and styles.
- **Models**: Update `lib/models/task_model.dart` to add or remove task properties.
- **Screens**: Extend the functionality of individual screens in the `screens/` directory.
- **Notifications**: Configure `lib/main.dart` to customize notification settings.
