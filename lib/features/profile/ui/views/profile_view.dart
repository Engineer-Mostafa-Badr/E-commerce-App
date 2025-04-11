import 'package:ecommerce_app/features/profile/ui/views/imports_views.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit()..getUserData(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is LogOutLoading || state is GetUserDataLoading) {
            CustomCircularIndicator.showLoading();
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'Loading..., please wait',
              type: MessageType.info,
            );
          } else {
            CustomCircularIndicator.dismissLoading();
          }
          if (state is LogOutSuccess) {
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'LogOut Successfully',
              type: MessageType.success,
            );
            navigateReplacement(context, SignInView());
          } else if (state is LogOutError) {
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'LogOut Error, please try again',
              type: MessageType.error,
            );
          } else if (state is GetUserDataError) {
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'Something went wrong, please try again',
              type: MessageType.error,
            );
          } else if (state is GetUserDataSuccess) {
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'Get User Data Successfully',
              type: MessageType.success,
            );
          }
        },
        builder: (context, state) {
          AuthenticationCubit cubit = context.read<AuthenticationCubit>();
          UserDataModel? user =
              context.read<AuthenticationCubit>().userDataModel;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Card(
                  color: AppColors.kWhiteColor,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.kPrimaryColor,
                        radius: 45,
                        child: Icon(
                          Icons.person,
                          size: 45,
                          color: AppColors.kWhiteColor,
                        ),
                      ),
                      SizedBox(height: 10),

                      AppText(
                        text: user?.name ?? Constans.userNameText,
                        color: AppColors.kBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 10),
                      AppText(
                        text: user?.email ?? Constans.userEmailText,
                        color: AppColors.kBlackColor,
                        fontSize: 16,
                      ),
                      SizedBox(height: 20),

                      CardProfileName(
                        text: Constans.editNameText,
                        icon: Icons.person,
                        onTap: () {
                          navigateTo(context, EditNameView());
                        },
                      ),
                      SizedBox(height: 10),

                      CardProfileName(
                        text: Constans.myOrdersText,
                        icon: Icons.shopping_basket,
                        onTap: () {
                          navigateTo(context, MyOrderView());
                        },
                      ),
                      SizedBox(height: 10),

                      CardProfileName(
                        text: Constans.logoutText,
                        icon: Icons.logout,
                        onTap: () async {
                          await cubit.logOut();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
