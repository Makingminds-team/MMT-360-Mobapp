import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makingmindstechnologies_360/common/Colors.dart';
import 'package:makingmindstechnologies_360/screens/projects/model/ProjectModel.dart';
import 'package:makingmindstechnologies_360/utils/ApiCalls.dart';

class ProjectListScreen extends ConsumerStatefulWidget {
  const ProjectListScreen({super.key});

  @override
  ConsumerState<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends ConsumerState<ProjectListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Tabs matching your web columns: Approval, Approved, Assigned, Ongoing, Hold, Deployed
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final projectsAsync = ref.watch(projectListProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Projects", 
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 24, letterSpacing: -0.5)),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 12.0),
        //     child: IconButton(
        //       icon: Container(
        //         padding: const EdgeInsets.all(8),
        //         decoration: BoxDecoration(
        //           color: defaultColor.withOpacity(0.1),
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //         child: const Icon(Icons.add_rounded, color: defaultColor, size: 24),
        //       ),
        //       onPressed: () {}, // New Project logic
        //     ),
        //   ),
        // ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
            ),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(22),
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                padding: const EdgeInsets.all(4),
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 2)),
                  ],
                ),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                labelColor: defaultColor,
                unselectedLabelColor: Colors.grey[600],
                dividerColor: Colors.transparent,
                tabAlignment: TabAlignment.start,
                tabs: const [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Tab(text: "PENDING")),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Tab(text: "APPROVED")),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Tab(text: "ASSIGNED")),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Tab(text: "ON GOING")),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Tab(text: "ON HOLD")),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Tab(text: "DEPLOYED")),
                ],
              ),
            ),
          ),
        ),
      ),
      body: projectsAsync.when(
        data: (projects) {
          if (projects == null || projects.isEmpty) return _buildEmptyState();
          
          return TabBarView(
            controller: _tabController,
            children: [
              _buildProjectListView(projects, 1),
              _buildProjectListView(projects, 2),
              _buildProjectListView(projects, 3),
              _buildProjectListView(projects, 4),
              _buildProjectListView(projects, 5),
              _buildProjectListView(projects, 6),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator(color: defaultColor)),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }

  Widget _buildProjectListView(List<ProjectModel> allProjects, int statusCode) {
    final filteredList = allProjects.where((p) {
      // For Deployed tab, also check the label in case the status code varies
      if (statusCode == 6) {
        return p.projectStatus == 6 || (p.projectStatusLabel?.toLowerCase().contains('deployed') ?? false);
      }
      return p.projectStatus == statusCode;
    }).toList();

    if (filteredList.isEmpty) return _buildEmptyState();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: filteredList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _buildProjectCard(filteredList[index]);
      },
    );
  }

  Widget _buildProjectCard(ProjectModel project) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 0,
      child: InkWell(
        onTap: () {
          // Navigate to details
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey[200]!, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02), 
                blurRadius: 15, 
                offset: const Offset(0, 5)
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section: Header with Icon and Title
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: defaultColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.dashboard_customize_rounded, color: defaultColor, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  project.projectName ?? "Unnamed Project",
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black87),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              _statusChip(project.projectStatusLabel ?? "Unknown", project.projectStatus ?? 0),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "ID: ${project.shortCode ?? 'N/A'}",
                                  style: TextStyle(color: Colors.grey[700], fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "• ${project.typeLabel ?? 'General'}",
                                  style: TextStyle(color: Colors.grey[500], fontSize: 13, fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF0F0F0)),

              // Bottom section: Date and Members
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month_rounded, size: 16, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(
                          project.projectDate ?? "No date specified",
                          style: TextStyle(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    _buildAvatarStack(project.employee),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarStack(List<Employee>? employees) {
    if (employees == null || employees.isEmpty) {
      return Text(
        "No members", 
        style: TextStyle(color: Colors.grey[400], fontSize: 12, fontStyle: FontStyle.italic)
      );
    }
    
    final int maxDisplay = 3;
    final int extraCount = employees.length > maxDisplay ? employees.length - maxDisplay : 0;
    final displayCount = employees.length > maxDisplay ? maxDisplay : employees.length;

    return SizedBox(
      height: 32,
      width: (displayCount * 22.0) + (extraCount > 0 ? 22.0 : 0) + 10.0,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          for (int i = 0; i < displayCount; i++)
            Positioned(
              right: (displayCount - 1 - i) * 22.0 + (extraCount > 0 ? 22.0 : 0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.primaries[i % Colors.primaries.length].withOpacity(0.2),
                  child: Text(
                    employees[i].firstname?[0].toUpperCase() ?? "?",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.primaries[i % Colors.primaries.length].shade800,
                    ),
                  ),
                ),
              ),
            ),
          if (extraCount > 0)
            Positioned(
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.grey[200],
                  child: Text(
                    "+$extraCount",
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _statusChip(String label, int statusCode) {
    Color chipColor;
    Color textColor;

    if (statusCode == 6 || label.toLowerCase().contains('deployed')) {
      chipColor = Colors.teal.shade50;
      textColor = Colors.teal.shade700;
    } else {
      switch (statusCode) {
        case 1: // Pending
          chipColor = Colors.orange.shade50;
          textColor = Colors.orange.shade700;
          break;
        case 2: // Approved
          chipColor = Colors.blue.shade50;
          textColor = Colors.blue.shade700;
          break;
        case 3: // Assigned
          chipColor = Colors.indigo.shade50;
          textColor = Colors.indigo.shade700;
          break;
        case 4: // On Going
          chipColor = Colors.green.shade50;
          textColor = Colors.green.shade700;
          break;
        case 5: // On Hold
          chipColor = Colors.red.shade50;
          textColor = Colors.red.shade700;
          break;
        default:
          chipColor = Colors.grey.shade100;
          textColor = Colors.grey.shade700;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label, 
        style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.3)
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
              ],
            ),
            child: Icon(Icons.folder_open_rounded, size: 64, color: Colors.grey[300]),
          ),
          const SizedBox(height: 24),
          const Text(
            "No Projects Found", 
            style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 8),
          Text(
            "There are no projects matching this status.", 
            style: TextStyle(color: Colors.grey[500], fontSize: 14)
          ),
        ],
      ),
    );
  }
}