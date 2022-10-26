// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_fauzan/provider/connection_provider.dart';
import 'package:test_fauzan/provider/home_provider.dart';
import 'package:test_fauzan/ui/pages/register_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String route = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, state, _) {
      return WillPopScope(
        onWillPop: () async {
          if (state.page > 1) {
            state.page -= 1;
            state.getList();
            return false;
          } else {
            Navigator.popUntil(
                context, ModalRoute.withName(RegisterPage.route));
            return true;
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                  constraints: const BoxConstraints.expand(),
                  child: const Image(
                    image: AssetImage('assets/images/base_home.png'),
                    fit: BoxFit.cover,
                  )),
              Consumer<ConnectionProvider>(builder: (context, connection, _) {
                if (connection.connectionState == DataState.hasConnection) {
                  if (state.userListState == UserListState.loading) {
                    return Stack(
                      children: [
                        SafeArea(child: homeAppBar(state)),
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  } else if (state.userListState == UserListState.success) {
                    return SafeArea(
                      child: Column(
                        children: [
                          homeAppBar(state),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 20),
                              child: ListView.builder(
                                itemCount: state.list.data.length,
                                itemBuilder: (context, index) {
                                  var list = state.list.data[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Card(
                                      child: ListTile(
                                        leading: ClipRRect(
                                          child: Image.network(
                                            list.profilepicture,
                                            width: 50,
                                          ),
                                        ),
                                        title: Text(
                                          list.name,
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        subtitle: Text(
                                          list.location,
                                          style: GoogleFonts.mulish(),
                                        ),
                                        onTap: () {
                                          AwesomeDialog(
                                              context: context,
                                              title:
                                                  '${list.name} - ${list.location}',
                                              titleTextStyle:
                                                  GoogleFonts.mulish(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w600),
                                              width: 300,
                                              desc: list.email,
                                              descTextStyle:
                                                  GoogleFonts.mulish(),
                                              customHeader: ClipRRect(
                                                child: Image.network(
                                                  list.profilepicture,
                                                  width: 100,
                                                ),
                                              ))
                                            ..show();
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                } else {
                  return const Center(
                    child: Text('No internet connection'),
                  );
                }
              }),
              Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Consumer<HomeProvider>(builder: (context, state, _) {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: (state.page == 1) ? false : true,
                            child: FloatingActionButton(
                              backgroundColor: Colors.green,
                              onPressed: () {
                                state.page -= 1;
                                state.getList();
                              },
                              child: const Icon(Icons.navigate_before),
                            ),
                          ),
                          FloatingActionButton(
                            backgroundColor: Colors.green,
                            onPressed: () {
                              state.page += 1;
                              state.getList();
                            },
                            child: const Icon(Icons.navigate_next),
                          ),
                        ],
                      );
                    }),
                  ))
            ],
          ),
        ),
      );
    });
  }

  Padding homeAppBar(HomeProvider state) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 18, right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'List of Users',
            style: GoogleFonts.mulish(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            state.page.toString(),
            style: GoogleFonts.mulish(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
