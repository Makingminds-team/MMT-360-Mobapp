import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makingmindstechnologies_360/common/Colors.dart';
import 'package:makingmindstechnologies_360/screens/dashboard/ui/Drawer.dart';
import 'package:makingmindstechnologies_360/screens/dashboard/widgets/DashboardWidgets.dart';
import 'package:makingmindstechnologies_360/utils/ApiCalls.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  final adminInfo = ref.watch(adminInfoProvider);
  final adminName = adminInfo.when(
    data: (adminInfo) => adminInfo?.data?.user?.adminName ?? "Employee Name",
    loading: () => "Loading...",
    error: (_, __) => "Employee Name",
  );


  final empoloyeeSummary = ref.watch(dasboardEmployeeSummary);
   
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[50],
     drawer: AppDrawer(
    onLogout: () => logoutPopup(context), 
  ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, size: 24),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Welcome,  ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      Text(
                          adminName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: mmColor,
                            ),
                          ),
                        
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.black),
                      onPressed: () {
                        logoutPopup(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                empoloyeeSummary.when(
                data: (data) {
                  if (data == null) return const Center(child: Text("No data found"));
                  
                  final List<Map<String, dynamic>> items = [
                    {"title": "Total Employees", "value": "${data.employeeCount ?? 0}", "icon": Icons.people_outline},
                    {"title": "Total Clients", "value": "${data.clientCount ?? 0}", "icon": Icons.person_add_alt_1_outlined},
                    {"title": "Total Projects", "value": "${data.projectsCount ?? 0}", "icon": Icons.folder_open_outlined},
                    {"title": "Ongoing Projects", "value": "${data.ongoingProjects ?? 0}", "icon": Icons.access_time},
                    {"title": "On-Hold Projects", "value": "${data.onholdProjects ?? 0}", "icon": Icons.pause_circle_outline},
                    {"title": "Testing Projects", "value": "${data.ontestingProjects ?? 0}", "icon": Icons.build_circle_outlined},
                    {"title": "Completed Projects", "value": "${data.completedProjects ?? 0}", "icon": Icons.check_circle_outline},
                  ];

                  return GridView.builder(
                    shrinkWrap: true, 
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, 
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20,
                      childAspectRatio: 2, 
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return buildSummaryCard(
                        title: items[index]['title'],
                        value: items[index]['value'],
                        icon: items[index]['icon'],
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text("Error: $err")),
              ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }

  

 





}

