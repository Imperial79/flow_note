import 'package:flow_note/Essentials/Label.dart';
import 'package:flow_note/Repo/auth_repo.dart';
import 'package:flow_note/Resources/colors.dart';
import 'package:flow_note/Resources/commons.dart';
import 'package:flow_note/Resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login_UI extends ConsumerStatefulWidget {
  const Login_UI({super.key});

  @override
  ConsumerState<Login_UI> createState() => _Login_UIState();
}

class _Login_UIState extends ConsumerState<Login_UI> {
  final isLoading = ValueNotifier(false);

  loginWithGoogle() async {
    try {
      isLoading.value = true;
      final userdata = await AuthRepo.signIn();
      if (userdata == null) throw "User Null!";

      ref.read(userProvider.notifier).state = userdata;
    } catch (e) {
      KSnackbar(context, message: e, error: true);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("$kImagePath/logo.png", height: 70),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Label(
                                  "Flow Note",
                                  fontSize: 30,
                                  weight: 900,
                                  height: 1,
                                  color: Kolor.primary,
                                ).regular,
                                Label(
                                  "Where expenses meet clarity",
                                  fontSize: 17,
                                  weight: 500,
                                ).regular,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (context, loading, _) {
                  return ElevatedButton(
                    onPressed: !loading ? loginWithGoogle : null,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Kolor.scaffold,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Kolor.border),
                        borderRadius: kRadius(10),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                    ),
                    child:
                        loading
                            ? Row(
                              spacing: 20,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                kSmallLoading,
                                Label("Loading").regular,
                              ],
                            )
                            : Row(
                              spacing: 20,
                              children: [
                                Label("G", fontSize: 25, weight: 900).regular,
                                Label("Login With Google").regular,
                              ],
                            ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
