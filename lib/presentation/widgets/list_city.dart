import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_user_accurate/common/constants.dart';
import 'package:mobile_user_accurate/presentation/bloc/get_city/get_city_bloc.dart';

class ListCityWidget extends StatelessWidget {
  final List<String> selectedCities;
  final void Function(List<String>) onSelectCities;
  const ListCityWidget(
      {super.key, required this.selectedCities, required this.onSelectCities});

  void _showModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ListCities(
            selectedCities: selectedCities,
            onSelectCities: onSelectCities,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showModal(context);
      },
      child: Row(
        children: [
          const Icon(Icons.filter_list),
          Text('City', style: kSubtitle.copyWith(color: kRichBlack)),
        ],
      ),
    );
  }
}

class ListCities extends StatefulWidget {
  final List<String> selectedCities;
  final void Function(List<String>) onSelectCities;
  const ListCities(
      {super.key, required this.selectedCities, required this.onSelectCities});

  @override
  State<ListCities> createState() => _ListCitiesState();
}

class _ListCitiesState extends State<ListCities> {
  late List<String> _selectedCities;
  @override
  void initState() {
    _selectedCities = List.from(widget.selectedCities);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text('Filter by city', style: kHeading6.copyWith(color: kRichBlack)),
      content: SizedBox(
        width: double.minPositive,
        child: BlocBuilder<GetCityBloc, GetCityState>(
          builder: (context, state) {
            if (state is GetCityLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetCitySuccess) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.cities.length,
                itemBuilder: (BuildContext context, int index) {
                  final city = state.cities[index];
                  return CheckboxListTile(
                    title: Text(city.name,
                        style: kBodyText.copyWith(color: kRichBlack)),
                    value: _selectedCities.contains(city.name),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value != null && value) {
                          _selectedCities.add(city.name);
                        } else {
                          _selectedCities.remove(city.name);
                        }
                      });
                    },
                  );
                },
              );
            } else if (state is GetCityError) {
              return Center(child: Text('No data found', style: kBodyText));
            } else {
              return Center(
                  child: Text('Failed to load cities', style: kBodyText));
            }
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Close',
            style: kSubtitle.copyWith(color: kRichBlack),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onSelectCities(_selectedCities);
            Navigator.pop(context);
          },
          child: Text('Apply', style: kSubtitle.copyWith(color: kRichBlack)),
        ),
      ],
    );
  }
}
