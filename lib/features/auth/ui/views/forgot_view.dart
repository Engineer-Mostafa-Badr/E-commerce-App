import 'package:ecommerce_app/features/auth/ui/views/imports_auth_views.dart';
import 'package:ecommerce_app/core/widgets/custom_e_btn.dart';
import '../../../../core/widgets/custom_message_handler.dart';
import '../../../../core/resources/message_type.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthenticationCubit cubit = context.read<AuthenticationCubit>();

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is ResetPasswordLoading) {
          CustomCircularIndicator.showLoading();
          CustomMessageHandler.showSnackBar(
            context: context,
            message: 'Loading..., please wait',
            type: MessageType.info,
          );
        } else {
          CustomCircularIndicator.dismissLoading();
        }
        if (state is ResetPasswordSuccess) {
          CustomMessageHandler.showSnackBar(
            context: context,
            message: 'Password was send, check your email',
            type: MessageType.success,
          );
          Navigator.pop(context);
        } else if (state is ResetPasswordError) {
          CustomMessageHandler.showSnackBar(
            context: context,
            message: 'Something went wrong, please try again',
            type: MessageType.error,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      right: 20,
                      left: 20,
                    ),
                    child: AppText(
                      text: Constans.resetPasswordText,
                      textAlign: TextAlign.center,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kBlackColor,
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
                            validator: Validator.validatorEmail,
                            labelText: Constans.emailLabelText,
                            hintText: Constans.emailHintText,
                            controller: emailController,
                            suffIcon: const Icon(Icons.email),
                            kayboardTybe: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          CustomEBtn(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.resetPassword(
                                  email: emailController.text,
                                );
                              }
                            },
                            hintText: Constans.submitText,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
