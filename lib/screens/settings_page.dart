import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Account'),
            onTap: () {
              // Navigate to Account Page (if you have it)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email Settings'),
            onTap: () {
              // Navigate to Email Settings Page (if you have it)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmailSettingsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Handle Logout Action
              // Ideally, you would clear user sessions or navigate to the login screen
              _showLogoutConfirmation(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform logout action
                // You can navigate back to a login screen or reset the app state
                Navigator.of(context).pop(); // Close the dialog
                // Here you might want to clear the user's session or navigate to a login page
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

// Placeholder for Account Page
class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Center(
        child: const Text('Account Details Here'),
      ),
    );
  }
}

// Placeholder for Email Settings Page
class EmailSettingsPage extends StatelessWidget {
  const EmailSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Settings'),
      ),
      body: Center(
        child: const Text('Email Settings Here'),
      ),
    );
  }
}