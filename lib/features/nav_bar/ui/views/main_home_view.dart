import 'package:ecommerce_app/features/nav_bar/ui/views/imports_main_home.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key, required this.userDataModel});
  final UserDataModel userDataModel;

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  late List<Widget> views = <Widget>[];
  @override
  initState() {
    views = <Widget>[
      HomeView(userDataModel: widget.userDataModel),
      StoreView(),
      FavoriteView(),
      ProfileView(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          NavBarCubit cubit = context.read<NavBarCubit>();
          return Scaffold(
            body: SafeArea(child: Center(child: views[cubit.currentIndex])),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(color: AppColors.kWhiteColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: GNav(
                  onTabChange: (index) {
                    cubit.changeIndex(index);
                  },
                  rippleColor: AppColors.kPrimaryColor,
                  hoverColor: AppColors.kPrimaryColor,

                  duration: Duration(milliseconds: 400),
                  gap: 8,
                  color: AppColors.kGreyColor,
                  activeColor: AppColors.kWhiteColor,
                  iconSize: 24,
                  tabBackgroundColor: AppColors.kPrimaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  tabs: [
                    GButton(icon: Icons.home, text: Constans.homeText),
                    GButton(icon: Icons.store, text: Constans.storeText),
                    GButton(icon: Icons.favorite, text: Constans.favoriteText),
                    GButton(icon: Icons.person, text: Constans.profileText),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
