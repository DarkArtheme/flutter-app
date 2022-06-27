import 'package:flutter/material.dart';
import 'package:notes_app_flutter/api/app-state.dart';
import 'package:notes_app_flutter/constants.dart';
import 'package:notes_app_flutter/pages/online-sync.dart';
import 'package:notes_app_flutter/api/note-search-class.dart';
import 'package:provider/provider.dart';

class FloatingSearchBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  const FloatingSearchBar({Key? key, 
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(6),
      child: Consumer<AppState>(
          builder: (context, appState, child) => Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.search, size: kIconSize),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showSearch(
                                context: context, delegate: NoteSearchClass());
                          },
                          child: const Text(
                            "Введите запрос",
                            style:
                                TextStyle(fontSize: 16, color: kGreyTextColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (builder) => OnlineSyncScreen(),
                            ),
                          );
                        },
                        child: const Icon(Icons.cloud_upload_rounded,
                            color: kPurpleColor, size: kIconSize),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
