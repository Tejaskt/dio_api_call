import 'package:dio_api_call/core/routes/route_name.dart';
import 'package:dio_api_call/core/storage/secure_storage.dart';
import 'package:dio_api_call/data/model/response/login_response.dart';
import 'package:dio_api_call/res/app_colors.dart';
import 'package:dio_api_call/res/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoginResponse? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await SecureStorage.getUser();
    setState(() {
      user = userData;
      isLoading = false;
    });
  }

  void _logout() async {
    await SecureStorage.clear();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.splash,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: AppColors.orangePrimary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : user == null
              ? const Center(child: Text('User not found'))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.orangePrimary,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 12.w,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(user!.image),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              '${user!.firstName} ${user!.lastName}',
                              style: AppFonts.latoRegular.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '@${user!.username}',
                              style: AppFonts.latoRegular.copyWith(
                                fontSize: 16.sp,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.w),
                        child: Column(
                          children: [
                            _buildInfoTile(Icons.email, 'Email', user!.email),
                            _buildInfoTile(Icons.person, 'Gender', user!.gender),
                            _buildInfoTile(Icons.perm_identity, 'User ID', user!.id.toString()),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: ElevatedButton(
                          onPressed: _logout,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            minimumSize: Size(double.infinity, 6.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Text(
                            'Logout',
                            style: AppFonts.latoRegular.copyWith(
                              fontSize: 17.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: AppColors.orangePrimary),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
