import 'package:flutter/material.dart';

class IntroductionScreen extends StatefulWidget {
  final List<String> images;
  final List<String> texts;
  final Color activeDotColor;
  final Color inactiveDotColor;
  final int itemCount;
  final bool isNetworkImage;
  final String? confirmMessage;
  final TextStyle? textStyle;
  final EdgeInsets? imagePadding;

  const IntroductionScreen({
    Key? key,
    required this.images,
    required this.texts,
    required this.activeDotColor,
    required this.inactiveDotColor,
    required this.itemCount,
    required this.isNetworkImage,
    this.confirmMessage,
    this.textStyle,
    this.imagePadding,
  })  : assert(itemCount == images.length && itemCount == texts.length),
        super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController ctrl = PageController();

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() {
      int pos = (ctrl.page ?? 0).round();
      if (currentPage != pos) {
        {
          setState(() {
            currentPage = pos;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: PageView.builder(
        onPageChanged: (int page) {
          DefaultTabController.of(context).index = page;
          setState(() {
            currentPage = page;
          });
        },
        controller: ctrl,
        itemCount: widget.itemCount,
        itemBuilder: (context, int index) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 40),
                child: Text(
                  widget.texts[index],
                  textAlign: TextAlign.center,
                  style: widget.textStyle ??
                      TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: widget.activeDotColor,
                      ),
                ),
              ),
              Padding(
                padding: widget.imagePadding ??
                    const EdgeInsets.only(top: 10, bottom: 10),
                child: widget.isNetworkImage
                    ? Image.network(
                        widget.images[index],
                        height: 270,
                      )
                    : Image.asset(
                        widget.images[index],
                        height: 270,
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  widget.images.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () {
                        ctrl.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: currentPage == index
                            ? widget.activeDotColor
                            : widget.inactiveDotColor,
                      ),
                    ),
                  ),
                ),
              ),
              if (currentPage == widget.itemCount - 1 &&
                  widget.confirmMessage != null)
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    widget.confirmMessage!,
                    style: TextStyle(
                      fontSize: 18,
                      color: widget.activeDotColor,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

Future<void> showIntroductionCarousel(
    {required BuildContext context,
    required List<String> images,
    required List<String> texts,
    required Color activeDotColor,
    required Color inactiveDotColor,
    required int itemCount,
    required bool isNetworkImage,
    String? confirmMessage,
    TextStyle? textStyle,
    EdgeInsets? imagePadding}) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: IntroductionScreen(
          texts: texts,
          itemCount: 5,
          activeDotColor: activeDotColor,
          inactiveDotColor: inactiveDotColor,
          images: images,
          confirmMessage: 'Got it!',
          isNetworkImage: false,
        ),
      );
    },
  );
}
