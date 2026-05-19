import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import '../main.dart';
import 'auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final AuthService authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
              child: user?.photoURL == null ? const Icon(Icons.person, size: 80) : null,
            ),
            const SizedBox(height: 24),
            Text(
              user?.displayName ?? 'User',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              user?.email ?? 'Unknown User',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 48),
            
            // Theme Toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Card(
                child: ValueListenableBuilder<ThemeMode>(
                  valueListenable: themeNotifier,
                  builder: (context, ThemeMode currentMode, child) {
                    final isDark = currentMode == ThemeMode.dark;
                    return SwitchListTile(
                      title: const Text('Dark Theme'),
                      secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                      value: isDark,
                      onChanged: (val) async {
                        themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isDarkTheme', val);
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Logout', style: TextStyle(color: Colors.red)),
                  onTap: () async {
                    await authService.signOut();
                    if (!context.mounted) return;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
