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
    // Tabs matching your web columns: Approval, Approved, Assigned, Ongoing, Hold
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final projectsAsync = ref.watch(projectListProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text("Project List", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_rounded, color: defaultColor, size: 28),
            onPressed: () {}, // New Project logic
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: defaultColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: defaultColor,
          tabs: const [
            Tab(text: "PENDING"),
            Tab(text: "APPROVED"),
            Tab(text: "ASSIGNED"),
            Tab(text: "ON GOING"),
            Tab(text: "ON HOLD"),
          ],
        ),
      ),
      body: projectsAsync.when(
        data: (projects) {
          if (projects == null || projects.isEmpty) return _buildEmptyState();
          
          return TabBarView(
  controller: _tabController,
  children: [
    _buildProjectListView(projects, 1), // Pending (Approval Pending)
    _buildProjectListView(projects, 2), // Approved (you don't have this status in data)
    _buildProjectListView(projects, 3), // Assigned (you don't have this status in data)
    _buildProjectListView(projects, 4), // On Going
    _buildProjectListView(projects, 5), // On Hold
  ],
);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }

  Widget _buildProjectListView(List<ProjectModel> allProjects, int statusCode) {
    // Filtering projects based on status (assuming projectStatus matches the tab)
    final filteredList = allProjects.where((p) => p.projectStatus == statusCode).toList();

    if (filteredList.isEmpty) return _buildEmptyState();

    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final project = filteredList[index];
        return _buildProjectCard(project);
      },
    );
  }

  Widget _buildProjectCard(ProjectModel project) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top section: Category & Status
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: defaultColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text(project.typeLabel ?? "General", 
                    style: const TextStyle(color: defaultColor, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
                _statusChip(project.projectStatusLabel ?? "Unknown"),
              ],
            ),
          ),
          
          // Project Name & Short Code
          ListTile(
            title: Text(project.projectName ?? "Unnamed Project", 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            subtitle: Text("ID: ${project.shortCode ?? 'N/A'}", style: const TextStyle(fontSize: 12)),
          ),

          const Divider(height: 1),

          // Bottom section: Members & Date
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Overlapping Avatars for Employees
                SizedBox(
                  width: 100,
                  height: 30,
                  child: Stack(
                    children: List.generate(
                      (project.employee?.length ?? 0) > 3 ? 3 : (project.employee?.length ?? 0),
                      (index) => Positioned(
                        left: index * 20.0,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.indigo[100 * (index + 1)],
                            child: Text(project.employee![index].firstname?[0] ?? "?", 
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(project.projectDate ?? "No date", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20),
        color: Colors.orange[50],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info_outline, size: 12, color: Colors.orange),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_off_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 10),
          const Text("- No Projects -", style: TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }
}