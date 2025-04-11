import 'package:ecommerce_app/features/auth/ui/views/imports_auth_views.dart';
import 'package:ecommerce_app/features/auth/ui/views/forgot_view.dart';
import '../../../../core/widgets/custom_message_handler.dart';
import '../../../../core/functions/navigate_to.dart';
import '../../../../core/resources/message_type.dart';
import 'sign_up_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginLoading || state is GoogleSignInLoading) {
          CustomCircularIndicator.showLoading();
          CustomMessageHandler.showSnackBar(
            context: context,
            message: 'Loading..., please wait',
            type: MessageType.info,
          );
        } else {
          CustomCircularIndicator.dismissLoading();
        }
        if (state is LoginSuccess || state is GoogleSignInSuccess) {
          UserDataModel userDataModel =
              context.read<AuthenticationCubit>().userDataModel!;
          navigateReplacement(
            context,
            MainHomeView(userDataModel: userDataModel),
          );
          CustomMessageHandler.showSnackBar(
            context: context,
            message: 'Login Successfully',
            type: MessageType.success,
          );
        } else if (state is GoogleSignInError || state is LoginError) {
          CustomMessageHandler.showSnackBar(
            context: context,
            message: 'Something went wrong, please try again',
            type: MessageType.error,
          );
        }
      },
      builder: (context, state) {
        AuthenticationCubit cubit = context.read<AuthenticationCubit>();
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                        right: 20,
                        left: 20,
                      ),
                      child: AppText(
                        text: Constans.appBarName,
                        textAlign: TextAlign.center,
                        fontSize: 22,
                        color: AppColors.kBlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      color: AppColors.kWhiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CustomTextFormField(
                              labelText: Constans.emailLabelText,
                              controller: _emailController,
                              suffIcon: Icon(Icons.email),
                              validator: Validator.validatorEmail,
                              kayboardTybe: TextInputType.emailAddress,
                              hintText: Constans.emailHintText,
                            ),
                            const SizedBox(height: 16),
                            CustomTextFormField(
                              isObscure: isObscure,
                              controller: _passwordController,
                              validator: Validator.validatorPassword,
                              labelText: Constans.passwordLabelText,
                              suffIcon: IconButton(
                                onPressed: () {
                                  setState(() => isObscure = !isObscure);
                                },
                                icon: Icon(
                                  isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              kayboardTybe: TextInputType.visiblePassword,
                              hintText: Constans.passwordHintText,
                            ),
                            const SizedBox(height: 16),

                            CustomTextBotton(
                              text: Constans.forgotPasswordText,
                              onTap: () => navigateTo(context, ForgotView()),
                            ),

                            const SizedBox(height: 20),

                            CustomRowWithArrowBtn(
                              hintText: Constans.loginText,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.signIn(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            CustomRowWithArrowBtn(
                              hintText: Constans.signInWithGoogleText,
                              onPressed: () => cubit.googleSignIn(),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  text: Constans.dontHaveAccountText,
                                  color: AppColors.kGreyColor,
                                ),
                                const SizedBox(width: 5),
                                CustomTextBotton(
                                  text: Constans.signUpText,
                                  onTap: () {
                                    navigateTo(context, SignUpView());
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
