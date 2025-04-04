import 'package:flutter/material.dart';
import 'package:gutbiss/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:gutbiss/screens/settings_screen.dart';
import '../models/user_profile.dart';
import '../screens/order_history_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        final user = profileProvider.user;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Profile Header
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: user.profilePicture != null
                                ? NetworkImage(user.profilePicture!)
                                : null,
                            child: user.profilePicture == null
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.grey,
                                  )
                                : null,
                          ),
                          // ... rest of the avatar stack
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(),

                // Profile Options
                _buildSection(
                  title: 'Orders',
                  icon: Icons.receipt_long,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderHistoryScreen(),
                      ),
                    );
                  },
                  trailing: const Text('View History'),
                ),

                _buildSection(
                  title: 'Addresses',
                  icon: Icons.location_on,
                  onTap: () {},
                  trailing: Text('${(profileProvider as ProfileProvider).savedAddresses.length} Saved'),
                ),

                _buildSection(
                  title: 'Payment Methods',
                  icon: Icons.payment,
                  onTap: () {},
                  trailing: Text('${profileProvider.paymentMethods.length} Saved'),
                ),

                _buildSection(
                  title: 'Recent Orders',
                  icon: Icons.receipt,
                  onTap: () {},
                  trailing: Text('${profileProvider.recentOrders.length} Recent'),
                ),

                const Divider(),

                // Settings
                _buildSection(
                  title: 'Settings',
                  icon: Icons.settings,
                  onTap: () {
                    //_showLanguageSelector();
                    // _showNotificationToggle();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => settings(),
                      ),
                    );
                  },
                ),

                const Divider(),

                // Logout Button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      _showLogoutConfirmation();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Logout'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepOrange),
      title: Text(title),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showNotificationToggle() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Enable Notifications'),
            Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
