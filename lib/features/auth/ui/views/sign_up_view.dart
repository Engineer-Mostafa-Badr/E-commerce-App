import 'package:ecommerce_app/features/auth/ui/views/imports_auth_views.dart';
import '../../../../core/widgets/custom_message_handler.dart';
import '../../../../core/resources/message_type.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          CustomCircularIndicator.showLoading();
          CustomMessageHandler.showSnackBar(
            context: context,
            message: 'Loading..., please wait',
            type: MessageType.info,
          );
        } else {
          CustomCircularIndicator.dismissLoading();
        }
        if (state is SignUpSuccess || state is GoogleSignInSuccess) {
          UserDataModel userDataModel =
              context.read<AuthenticationCubit>().userDataModel!;
          navigateReplacement(
            context,
            MainHomeView(userDataModel: userDataModel),
          );
          CustomMessageHandler.showSnackBar(
            context: context,
            message: 'Sign Up Successfully',
            type: MessageType.success,
          );
        } else if (state is GoogleSignInError || state is SignUpError) {
          CustomMessageHandler.showSnackBar(
            context: context,
            message: 'Something went wrong, please try again',
            type: MessageType.error,
          );
        }
      },
      builder: (context, state) {
        AuthenticationCubit cubit = context.read<AuthenticationCubit>();
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
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
                              labelText: Constans.nameLabelText,
                              validator: Validator.validatorFullName,
                              suffIcon: Icon(Icons.person),
                              controller: _nameController,
                              kayboardTybe: TextInputType.name,
                              hintText: Constans.nameHintText,
                            ),

                            const SizedBox(height: 16),

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
                              labelText: Constans.passwordLabelText,
                              validator: Validator.validatorPassword,
                              controller: _passwordController,
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

                            CustomTextFormField(
                              labelText: Constans.phoneLabelText,
                              validator: Validator.validatorPhoneNumber,
                              controller: _phoneController,
                              suffIcon: Icon(Icons.phone),
                              kayboardTybe: TextInputType.phone,
                              hintText: Constans.phoneHintText,
                            ),

                            const SizedBox(height: 20),

                            CustomRowWithArrowBtn(
                              hintText: Constans.signUpText,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.signUp(
                                    name: _nameController.text.trim(),
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    phone: _phoneController.text.trim(),
                                  );
                                }
                              },
                            ),

                            const SizedBox(height: 16),

                            CustomRowWithArrowBtn(
                              hintText: Constans.signUpWithGoogleText,
                              onPressed: () => cubit.googleSignIn(),
                            ),

                            const SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  text: Constans.alreadyHaveAccountText,
                                  color: AppColors.kGreyColor,
                                  fontSize: 16,
                                ),
                                const SizedBox(width: 5),
                                CustomTextBotton(
                                  text: Constans.loginText,
                                  onTap: () {
                                    Navigator.pop(context);
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
