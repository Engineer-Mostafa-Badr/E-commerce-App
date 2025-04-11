import 'package:ecommerce_app/features/home/ui/views/imports_home_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.userDataModel});
  final UserDataModel userDataModel;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    PaymentData.initialize(
      apiKey: PayMobIntegration.apikey,
      iframeId: PayMobIntegration.iframeId,
      integrationCardId: PayMobIntegration.integrationCardId,
      integrationMobileWalletId: PayMobIntegration.integrationMobileWalletId,

      userData: UserData(
        email: widget.userDataModel.email,
        name: widget.userDataModel.name,
      ),
      style: Style(
        primaryColor: AppColors.kPrimaryColor,
        scaffoldColor: AppColors.kScaffoldColor,
        appBarBackgroundColor: AppColors.kPrimaryColor,
        appBarForegroundColor: AppColors.kWhiteColor,
        buttonStyle: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          foregroundColor: AppColors.kWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        circleProgressColor: AppColors.kPrimaryColor,
        unselectedColor: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          AppText(
            textAlign: TextAlign.center,
            text: 'Welcome ${widget.userDataModel.name}',
            fontWeight: FontWeight.bold,
            color: AppColors.kGreyColor,
            fontSize: 20,
          ),
          SizedBox(height: 20),
          CustomSearchTextField(
            controller: _searchController,
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                navigateTo(context, SearchView(query: _searchController.text));
                _searchController.clear();
              } else {
                CustomMessageHandler.showSnackBar(
                  context: context,
                  message: Constans.searchText,
                  type: MessageType.error,
                );
              }
            },
          ),

          SizedBox(height: 20),

          Image.asset(AppImages.homeImage),

          SizedBox(height: 15),

          AppText(
            text: Constans.categoryAppText,
            color: AppColors.kBlackColor,
            fontSize: 20,
          ),
          SizedBox(height: 15),
          CustomCategoriesList(),
          SizedBox(height: 15),
          AppText(
            text: Constans.categoryDescriptionText,
            color: AppColors.kBlackColor,
            fontSize: 20,
          ),
          SizedBox(height: 15),
          ProductList(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
