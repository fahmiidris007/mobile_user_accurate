import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_user_accurate/common/constants.dart';
import 'package:mobile_user_accurate/presentation/bloc/add_user/add_user_bloc.dart';
import 'package:mobile_user_accurate/domain/entities/user.dart';
import 'package:mobile_user_accurate/presentation/bloc/get_user/get_user_bloc.dart';

import '../widgets/form_item.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSilverLight,
      appBar: AppBar(
        title: Text(
          'Add New User',
          style: kHeading5.copyWith(color: kRichBlack),
        ),
        backgroundColor: kSilverLight,
      ),
      body: BlocConsumer<AddUserBloc, AddUserState>(
        listener: (context, state) {
          if (state is AddUserSuccess) {
            context.read<GetUserBloc>().add(GetUser());
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Center(child: Text('User added successfully')),
              ),
            );
            context.pop();
          } else if (state is AddUserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text(state.message)),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormItem(
                    nameController: _nameController,
                    label: 'Name',
                  ),
                  const SizedBox(height: 20),
                  FormItem(nameController: _emailController, label: 'Email'),
                  const SizedBox(height: 20),
                  FormItem(
                      nameController: _addressController, label: 'Address'),
                  const SizedBox(height: 20),
                  FormItem(
                      nameController: _phoneNumberController,
                      label: 'Phone Number'),
                  const SizedBox(height: 20),
                  FormItem(nameController: _cityController, label: 'City'),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kOrange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                      ),
                      onPressed: () {
                        final user = User(
                          name: _nameController.text,
                          email: _emailController.text,
                          address: _addressController.text,
                          phoneNumber: _phoneNumberController.text,
                          city: _cityController.text,
                        );
                        context.read<AddUserBloc>().add(PostUser(user: user));
                      },
                      child: state is AddUserInitial ||
                              state is AddUserSuccess ||
                              state is AddUserError
                          ? Text(
                              "Create User",
                              style: kSubtitle.copyWith(color: kWhite),
                            )
                          : const CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
