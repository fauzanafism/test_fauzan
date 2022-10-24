import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_fauzan/provider/home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String route = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Stack(
        children: [
          Container(
              constraints: const BoxConstraints.expand(),
              child: const Image(
                image: AssetImage('assets/images/base_login_home.png'),
                fit: BoxFit.cover,
              )),
          Consumer<HomeProvider>(
            builder: (context, state, _) {
              if (state.userListState == UserListState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: state.list.data.length,
                  itemBuilder: (context, index) {
                    var list = state.list.data[index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Card(
                        child: ListTile(
                          leading: ClipRRect(
                            child: Image(
                              image: NetworkImage(list.profilepicture),
                            ),
                          ),
                          title: Text(
                            list.name,
                            style: GoogleFonts.mulish(),
                          ),
                          subtitle: Text(
                            list.location,
                            style: GoogleFonts.mulish(),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}
