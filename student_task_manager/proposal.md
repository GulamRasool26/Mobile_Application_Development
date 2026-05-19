# PROJECT PROPOSAL: STUDENT TASK MANAGER

**National Textile University**  
**Department of Computer Science**  
**Subject:** Mobile and App Development  

---

**Submitted to:** [Instructor Name]  
**Submitted by:** [Your Name]  
**Reg. number:** [Your Registration Number]  
**Project:** Student Task Manager App  
**Semester:** 6th (Spring 2026)  

---

## 1. Title of Project
**Student Task Manager**

## 2. Description of Project
The **Student Task Manager** is a high-performance, production-ready mobile productivity application developed using **Flutter (Dart)**. It is designed to help students organize their academic life through efficient task tracking, prioritization, and timely reminders. The app integrates **Firebase Authentication** for secure access, **Cloud Firestore** for real-time data synchronization across devices, and **Local Notifications** to ensure no deadline is missed.

The application features a premium, modern UI with a focus on usability. It supports dynamic theme switching (Light/Dark mode) and provides multiple views, including a list-based Home dashboard and a date-centric Calendar view, allowing students to manage their workload effectively.

## 3. Screen/Pages With Description

### 1. Login Screen
A secure entry point featuring **Google Sign-In** integration. It provides a frictionless onboarding experience, automatically handling session persistence and routing users to their personalized dashboard.

### 2. Home / Dashboard Screen
The central hub of the application. It displays an interactive list of all pending and completed tasks. Users can quickly filter tasks, search for specific items, and mark tasks as complete with a single tap.

### 3. Task Form Screen (Add/Edit)
A comprehensive form for defining task details. Users can set the task title, a detailed description, due date, and priority level (Low, Medium, High). It also includes a toggle for enabling reminders with specific time selection.

### 4. Calendar Screen
A date-oriented view that allows users to visualize their schedule. Tapping on a date filters the tasks due on that day, helping students plan their week ahead.

### 5. Profile Screen
Displays user account information retrieved from Google. It includes settings for toggling the application's theme (Dark/Light mode) and a secure logout functionality that clears active sessions.

## 4. System Requirements

### A. Functional Requirements
1. **Secure Authentication**: Users must authenticate via Google Sign-In to access their private task data.
2. **Task Management (CRUD)**: Users must be able to Create, Read, Update, and Delete tasks.
3. **Prioritization System**: Tasks must support different priority levels to help users focus on urgent work.
4. **Automated Reminders**: The system must schedule local notifications based on user-defined reminder times.
5. **Real-time Synchronization**: Task data must sync instantly to the cloud via Firebase Firestore.
6. **Theme Customization**: The UI must support both Light and Dark modes for better accessibility.

### B. Non-Functional Requirements
1. **Reactive UI**: The interface must update in real-time as data changes, utilizing the Provider pattern.
2. **Performance**: Smooth transitions and scrolling, even with a large number of tasks.
3. **Data Integrity**: User data must be securely stored and correctly mapped between local state and Firestore.
4. **Availability**: The app should provide a consistent experience across different Android and iOS devices.

## 5. Challenges Faced During Development

1. **OAuth Integration Complexity**: Configuring Google Sign-In and SHA-1 fingerprints for Firebase required precise setup across the Google Cloud Console and Firebase.
2. **Real-time State Synchronization**: Ensuring that the UI reflects Firestore changes instantly without unnecessary rebuilds or lag.
3. **Persistent Local Notifications**: Implementing a reliable notification system that remains scheduled even if the app is closed or the device is rebooted.
4. **Dynamic Theme Management**: Coordinating theme changes across all widgets and screens while maintaining a premium aesthetic.

## 6. Proposed & Implemented Solutions

1. **Centralized Auth Service**: Created a dedicated `AuthService` class to encapsulate Firebase and Google Sign-In logic, providing a clean API for the UI.
2. **Provider Pattern Implementation**: Used the `Provider` package for state management, ensuring a reactive data flow from the database to the view layer.
3. **Notification Scheduling Logic**: Utilized `flutter_local_notifications` with precise timezone handling to ensure reminders trigger exactly when requested.
4. **Unified Theme Notifier**: Implemented a `ThemeNotifier` using `ChangeNotifier` to broadcast theme updates across the entire application instantly.

## 7. Tools and Frameworks Summary

- **Core Framework**: Flutter (Dart)
- **Backend Services**: Firebase Authentication & Cloud Firestore
- **State Management**: Provider
- **Local Notifications**: `flutter_local_notifications`
- **Utility Libraries**: `intl` (date formatting), `google_fonts`
- **Design Pattern**: Service-Oriented Architecture with Clean UI separation
