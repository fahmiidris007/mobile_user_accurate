import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_user_accurate/common/constants.dart';
import 'package:mobile_user_accurate/presentation/bloc/get_city/get_city_bloc.dart';
import 'package:mobile_user_accurate/presentation/bloc/get_user/get_user_bloc.dart';
import 'package:mobile_user_accurate/presentation/widgets/list_city.dart';

import '../widgets/user_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  List<String> _selectedCities = [];

  @override
  void initState() {
    super.initState();
    context.read<GetUserBloc>().add(GetUser());
    context.read<GetCityBloc>().add(GetCity());
  }

  @override
  void dispose() {
    super.dispose();
    _onResetSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSilverLight,
      appBar: AppBar(
        title: Text(
          'List Users',
          style: kHeading5.copyWith(color: kRichBlack),
        ),
        backgroundColor: kSilverLight,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            iconSize: 35.0,
            onPressed: () {
              context.goNamed('add');
            },
            tooltip: 'Add New User',
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              onChanged: (value) {
                context.read<GetUserBloc>().add(SearchUser(value));
              },
              decoration: InputDecoration(
                hintText: 'Search name',
                hintStyle: kSubtitle.copyWith(color: kGrey),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: BlocBuilder<GetUserBloc, GetUserState>(
                builder: (context, state) {
                  if (state is GetUserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetUserSuccess) {
                    final bool isSorted = state.isNameSorted;
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<GetUserBloc>()
                                    .add(SortUsers(!isSorted));
                              },
                              child: Row(
                                children: [
                                  Icon(isSorted
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward),
                                  const Icon(Icons.sort_by_alpha),
                                ],
                              ),
                            ),
                            const Spacer(),
                            ListCityWidget(
                              selectedCities: _selectedCities,
                              onSelectCities: _onSelectedCitiesChanged,
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.users.length,
                            itemBuilder: (context, index) {
                              final user = state.users[index];
                              return UserItem(user: user);
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is GetUserError) {
                    return Center(child: Text(state.message));
                  } else if (state is GetUserEmpty) {
                    return Center(
                        child: Text('No Data Found', style: kSubtitle));
                  }
                  return Center(
                      child: Text('Please Check Your Connection!',
                          style: kSubtitle));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectedCitiesChanged(List<String> cities) {
    setState(() {
      _selectedCities = cities;
    });
    context.read<GetUserBloc>().add(FilterByCity(cities));
  }

  void _onResetSearch() {
    _searchController.clear();
    context.read<GetUserBloc>().add(GetUser());
  }
}
