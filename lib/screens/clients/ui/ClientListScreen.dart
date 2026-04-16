import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makingmindstechnologies_360/common/Colors.dart';
import 'package:makingmindstechnologies_360/screens/clients/model/ClientListModel.dart';
import 'package:makingmindstechnologies_360/utils/ApiCalls.dart';

class ClientListScreen extends ConsumerStatefulWidget {
  const ClientListScreen({super.key});

  @override
  ConsumerState<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends ConsumerState<ClientListScreen> {
  
  String _formatDate(String? strDate) {
    if (strDate == null || strDate.isEmpty) return 'TBD';
    try {
      DateTime parsed = DateTime.parse(strDate);
      return "${parsed.day.toString().padLeft(2, '0')}-${parsed.month.toString().padLeft(2, '0')}-${parsed.year}";
    } catch(e) {
      return strDate.split(' ')[0].split('T')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientDataAsync = ref.watch(clientListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Clients", 
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 22, letterSpacing: -0.5)),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.black.withOpacity(0.04), height: 1.0),
        ),
      ),
      body: clientDataAsync.when(
        data: (clientModel) {
          if (clientModel == null || clientModel.rows == null || clientModel.rows!.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: clientModel.rows!.length,
            itemBuilder: (context, index) {
              final client = clientModel.rows![index];
              return _buildClientCard(client);
            },
          );
        },
        loading: () => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              height: 140,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(radius: 20, backgroundColor: Colors.grey[100]),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(width: 120, height: 16, color: Colors.grey[100]),
                            const SizedBox(height: 8),
                            Container(width: 80, height: 12, color: Colors.grey[100]),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Container(width: 100, height: 12, color: Colors.grey[100]),
                        const SizedBox(width: 20),
                        Container(width: 80, height: 12, color: Colors.grey[100]),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        error: (err, stack) => Center(child: Text("Error fetching clients: $err")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: defaultColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.person_add_alt_1_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildClientCard(Rows client) {
    bool isActive = client.isActive ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: defaultColor.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.05), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: defaultColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          client.name != null && client.name!.isNotEmpty 
                              ? client.name![0].toUpperCase() 
                              : "?",
                          style: const TextStyle(color: defaultColor, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              client.name ?? "Unknown Client",
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.black87),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              client.companyName ?? "No Company Provider",
                              style: TextStyle(color: Colors.grey[500], fontSize: 13, fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green.withOpacity(0.12) : Colors.red.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: isActive ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2)),
                  ),
                  child: Text(
                    isActive ? "ACTIVE" : "INACTIVE",
                    style: TextStyle(
                      color: isActive ? Colors.green[700] : Colors.red[700],
                      fontSize: 10,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            Container(height: 1, color: Colors.grey.withOpacity(0.1)),
            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoColumn(Icons.phone_rounded, "${client.mobCode ?? ''} ${client.mobileNo ?? 'N/A'}", Colors.blue),
                const SizedBox(width: 16),
                _buildInfoColumn(Icons.domain_verification_rounded, client.gstNumber ?? 'No GST', Colors.purple),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoColumn(Icons.account_balance_wallet_rounded, "Est: ${client.projectEstimation?.toString() ?? '0'}", Colors.orange),
                const SizedBox(width: 16),
                _buildInfoColumn(Icons.calendar_month_rounded, _formatDate(client.startDate), Colors.teal),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String text, MaterialColor color) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 14, color: color[600]),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
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
              color: defaultColor.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.people_outline_rounded, size: 48, color: defaultColor.withOpacity(0.5)),
          ),
          const SizedBox(height: 16),
          const Text(
            "No Clients Found",
            style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Tap the + button to add your first client.",
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }
}