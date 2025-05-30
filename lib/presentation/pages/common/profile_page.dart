import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/l10n/app_localizations.dart';
import 'package:gipms/presentation/pages/common/app_drawer.dart';
import 'package:gipms/presentation/pages/home/bloc/user_display_cubit.dart'; // Import UserDisplayCubit
import 'package:gipms/presentation/pages/home/bloc/user_display_state.dart'; // Import UserDisplayState

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile),
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<UserDisplayCubit, UserDisplayState>(
        // Wrap the body in a BlocBuilder
        builder: (context, state) {
          if (state is UserLoaded) {
            // Check if the user data is loaded
            final user = state.userEntity; // Get the user data
            return Column(
              children: [
                const Expanded(flex: 2, child: _TopPortion()),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          user.username, // Display the username
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user.rolename,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user.gatenamear,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     FloatingActionButton.extended(
                        //       onPressed: () {},
                        //       heroTag: 'follow',
                        //       elevation: 0,
                        //       label: const Text("Follow"),
                        //       icon: const Icon(Icons.person_add_alt_1),
                        //     ),
                        //     const SizedBox(width: 16.0),
                        //     FloatingActionButton.extended(
                        //       onPressed: () {},
                        //       heroTag: 'mesage',
                        //       elevation: 0,
                        //       backgroundColor: Colors.red,
                        //       label: const Text("Message"),
                        //       icon: const Icon(Icons.message_rounded),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 16),
                        // const _ProfileInfoRow(),
                        //Text(context.watch<Example>().toString()),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is UserLoading) {
            return const Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (state is LoadUserFailure) {
            return Center(
                child: Text('Error: ${state.errorMessage}')); // show error
          } else {
            return const Center(
                child: Text('No user data available.')); // Default message
          }
        },
      ),
    );
  }
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/nopic.png'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

// class _ProfileInfoRow extends StatelessWidget {
//   const _ProfileInfoRow({super.key});

//   final List<ProfileInfoItem> _items = const [
//     ProfileInfoItem("Posts", 900),
//     ProfileInfoItem("Followers", 120),
//     ProfileInfoItem("Following", 200),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       constraints: const BoxConstraints(maxWidth: 400),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: _items
//             .map((item) => Expanded(
//                     child: Row(
//                   children: [
//                     if (_items.indexOf(item) != 0) const VerticalDivider(),
//                     Expanded(child: _singleItem(context, item)),
//                   ],
//                 )))
//             .toList(),
//       ),
//     );
//   }

//   Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               item.value.toString(),
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//           ),
//           Text(
//             item.title,
//             style: Theme.of(context).textTheme.labelLarge,
//           )
//         ],
//       );
// }
