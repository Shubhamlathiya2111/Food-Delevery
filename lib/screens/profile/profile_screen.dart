import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = 'Arun';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Implement edit profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
            ),
            const SizedBox(height: 16),
            Text(
               'User Name',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'email@example.com',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            _buildProfileItem(
              icon: Icons.location_on,
              title: 'Delivery Address',
              subtitle: 'Add or change your delivery address',
              onTap: () {
                // TODO: Implement address management
              },
            ),
            _buildProfileItem(
              icon: Icons.payment,
              title: 'Payment Methods',
              subtitle: 'Add or change your payment methods',
              onTap: () {
                // TODO: Implement payment methods
              },
            ),
            _buildProfileItem(
              icon: Icons.notifications,
              title: 'Notifications',
              subtitle: 'Manage your notifications',
              onTap: () {
                // TODO: Implement notifications settings
              },
            ),
            _buildProfileItem(
              icon: Icons.help,
              title: 'Help Center',
              subtitle: 'Get help and support',
              onTap: () {
                // TODO: Implement help center
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().signOut();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
} 