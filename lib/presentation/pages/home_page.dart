import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_user_accurate/domain/entities/user.dart';
import 'package:mobile_user_accurate/presentation/bloc/get_user/get_user_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _filterCity = 'Semua';

  @override
  void initState() {
    super.initState();
    context.read<GetUserBloc>().add(GetUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pengguna'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigasi ke halaman tambah user baru
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search User',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (value) {
                // Trigger pencarian user
              },
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _filterCity,
              isExpanded: true,
              hint: const Text('Pilih Kota'),
              items: <String>['Semua', 'Jakarta', 'Bandung', 'Surabaya']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _filterCity = value!;
                  // Trigger filter user berdasarkan kota
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<GetUserBloc, GetUserState>(
                builder: (context, state) {
                  debugPrint('state: $state');
                  if (state is GetUserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetUserSuccess) {
                    return ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        User user = state.users[index];
                        return Card(
                          elevation: 4,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.deepPurple,
                              child: Text(user.name[0],
                                  style: const TextStyle(
                                      color: Colors
                                          .white)), // Ambil huruf pertama dari nama
                            ),
                            title: Text(user.name),
                            subtitle: Text(user.email),
                          ),
                        );
                      },
                    );
                  } else if (state is GetUserError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(
                      child: Text('Please Check Your Connection!'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
