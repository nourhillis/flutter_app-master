import 'package:flutter/material.dart';
import '../models/people_also_like_model.dart';
import '../pages/details_page.dart';
import '../widget/realisable_text.dart';
import '../models/tab_bar_model.dart';
import '../widget/realisable_middle_app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController tabController;
  final EdgeInsetsGeometry padding =
      const EdgeInsets.symmetric(horizontal: 10.0);

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: _buildAppBar(size),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: padding,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: "Top Tours",
                    size: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  const AppText(
                    text: "For Your Request",
                    size: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    width: size.width,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        labelPadding: EdgeInsets.only(
                            left: size.width * 0.05, right: size.width * 0.05),
                        controller: tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,

                        tabs: const [
                          Tab(
                            text: "Places",
                          ),
                          Tab(text: "Inspiration"),
                          Tab(text: "Popular"),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.01),
                    width: size.width,
                    height: size.height * 0.4,
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                        TabViewChild(
                          list: places,
                        ),
                        TabViewChild(list: inspiration),
                        TabViewChild(list: popular),
                      ],
                    ),
                  ),
                  const MiddleAppText(text: "People Also Like"),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.01),
                    width: size.width,
                    height: size.height * 0.68,
                    child: ListView.builder(
                        itemCount: peopleAlsoLikeModel.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          PeopleAlsoLikeModel current =
                              peopleAlsoLikeModel[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  personData: current,
                                  tabData: null,
                                  isCameFromPersonSection: true,
                                ),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              width: size.width,
                              height: size.height * 0.15,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: current.day,
                                    child: Container(
                                      margin: const EdgeInsets.all(8.0),
                                      width: size.width * 0.28,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            current.image,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.02),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.035,
                                        ),
                                        AppText(
                                          text: current.title,
                                          size: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        SizedBox(
                                          height: size.height * 0.005,
                                        ),
                                        AppText(
                                          text: current.location,
                                          size: 14,
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w300,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.015),
                                          child: AppText(
                                            text: "${current.day} Day",
                                            size: 14,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize _buildAppBar(Size size) {
    return PreferredSize(
      preferredSize: Size.fromHeight(size.height * 0.09),
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(
                right: 5,
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/main.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TabViewChild extends StatelessWidget {
  const TabViewChild({
    required this.list,
    Key? key,
  }) : super(key: key);

  final List<TabBarModel> list;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: list.length,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        TabBarModel current = list[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(
                personData: null,
                tabData: current,
                isCameFromPersonSection: false,
              ),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Hero(
                tag: current.image,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(current.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: size.height * 0.2,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  width: size.width * 0.53,
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(153, 0, 0, 0),
                        Color.fromARGB(118, 29, 29, 29),
                        Color.fromARGB(54, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: size.width * 0.07,
                bottom: size.height * 0.045,
                child: AppText(
                  text: current.title,
                  size: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Positioned(
                left: size.width * 0.07,
                bottom: size.height * 0.025,
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    AppText(
                      text: current.location,
                      size: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
