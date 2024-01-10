import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.bottomCenter,
                      child: Lottie.asset(kLoginBackgroundJson, width: 350))),
              Positioned.fill(child: Container(color: Colors.white.withOpacity(0.8))),
              Positioned.fill(child: Consumer<AuthState>(
                builder: (context, authState, _) {
                  return Padding(
                    padding: const EdgeInsets.all(48),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        SizedBox(
                          width: 250,
                          child: Image.asset(
                            k2019XPLogoWhitePng,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.email_outlined),
                            const SizedBox(width: 4),
                            Text(
                              getTranslatedValue(context, 'email_label').toUpperCase(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: Helper.validateEmail,
                          controller: authState.emailTextController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(fontSize: 16),
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colors.primary),
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          onChanged: (value) {
                            authState.emailTextController.text = value;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.lock_outlined),
                            const SizedBox(width: 4),
                            Text(
                              getTranslatedValue(context, 'password_label').toUpperCase(),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          validator: Helper.validatePassword,
                          controller: authState.passwordTextController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(fontSize: 16),
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: !authState.passwordVisible,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colors.primary),
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                authState.passwordVisible ? Icons.visibility_off : Icons.visibility,
                                color: Theme.of(context).colors.primary,
                              ),
                              onPressed: () {
                                authState.setPasswordVisible(!authState.passwordVisible);
                              },
                            ),
                          ),
                          onChanged: (value) {
                            authState.passwordTextController.text = value;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: authState.isSubmitEnabled ? Theme.of(context).colors.primary : null,
                            ),
                            onPressed: authState.isSubmitEnabled
                                ? () async {
                                    await authState.login();
                                    if (authState.state == AuthProviderState.success) {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            color: Colors.transparent,
                                            child: Container(
                                              height: 300,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                                              ),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.check_circle,
                                                      color: Theme.of(context).colors.primary,
                                                      size: 80,
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Text(
                                                      getTranslatedValue(context, 'successful_login_title'),
                                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Text(getTranslatedValue(context, 'successful_login__subtitle')),
                                                    const SizedBox(height: 16),
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: Theme.of(context).colors.primary,
                                                        ),
                                                        onPressed: () async {
                                                          Navigator.pop(context);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => const TaxScreen()),
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 24,
                                                          width: 250,
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            color: Theme.of(context).colors.primary,
                                                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                          ),
                                                          child: Text(
                                                            getTranslatedValue(context, 'got_it__action'),
                                                            style: const TextStyle(color: Colors.white, fontSize: 16),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }
                                : null,
                            child: Container(
                              height: 32,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                              child: authState.state == AuthProviderState.loading
                                  ? SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        color: Theme.of(context).colors.primary,
                                      ),
                                    )
                                  : Text(
                                      getTranslatedValue(context, 'login'),
                                      style: TextStyle(
                                          color: authState.isSubmitEnabled
                                              ? Colors.white
                                              : Theme.of(context).colors.primary,
                                          fontSize: 16),
                                    ),
                            )),
                      ],
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          final Uri url = Uri.parse('https://www.expatrio.com');
          await launchUrl(url);
        },
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(Icons.question_mark_outlined, color: Theme.of(context).colors.primary, size: 16),
            Text(
              getTranslatedValue(context, 'help'),
              style: TextStyle(fontSize: 12, color: Theme.of(context).colors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
