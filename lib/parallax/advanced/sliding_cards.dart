import 'package:flutter/material.dart';
import 'dart:math' as math;

class SlidingCardsView extends StatefulWidget {
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8); //// 80% view
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromHeight(MediaQuery.of(context).size.height * 0.55),
//      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {},
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
//              if (controller.position.haveDimensions) {
//                value = controller.page - index;
//                value = (1 - (value.abs() * .4)).clamp(0.0, 1.0);
//              }
              double pageOffset = 0.0;
              if (pageController.position.haveDimensions) {
                pageOffset = pageController.page;
              }
              print('BUILDER: PAGE OFFSET - $pageOffset');
              print('BUILDER: INDEX - $index');
              return index % 2 == 0
                  ? SlidingCard(
                      name: 'Shenzhen GLOBAL DESIGN AWARD 2018',
                      date: '4.20-30',
                      imgUrl: 'assets/steve-johnson.jpeg',
                      offset: pageOffset - index,
                    )
                  : SlidingCard(
                      name: 'Dawan District, Guangdong Hong Kong and Macao',
                      date: '4.28-31',
                      imgUrl: 'assets/rodion-kutsaev.jpeg',
                      offset: pageOffset - index,
                    );
            },
          );
        },
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name;
  final String date;
  final String imgUrl;
  final double offset;

  const SlidingCard({Key key, this.name, this.date, this.imgUrl, this.offset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gaussOffset = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
//    final gauss = math.sin(offset.abs() * math.pi);
    print('GAUSS: $gaussOffset');
    final transformOffset = Offset(-32 * gaussOffset * offset.sign, 0);


    return Transform.translate(
      offset: transformOffset,
//      transform: Matrix4.translationValues(offsetTransform.dx, 0, 0),
      child: Card(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                imgUrl,
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment(-offset.abs(), 0), // magic
                fit: BoxFit.none,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: CardContent(
                name: name,
                date: date,
                offset: gaussOffset, // pass the gauss as offset
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final double offset;

  const CardContent({Key key, this.name, this.date, this.offset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(24 * offset, 0), //translate the name label
            child: Text(
              name,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0),
            child: Text(
              date,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Transform.translate(
                offset: Offset(32 * offset, 0),
                child: RaisedButton(
                  color: Color(0xFF162A49),
                  child: Transform.translate(
                    offset: Offset(8 * offset, 0),
                    child: const Text('Reserve'),
                  ),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onPressed: () {},
                ),
              ),
              Spacer(),
              Transform.translate(
                offset: Offset(24 * offset, 0),
                child: Text(
                  '0.00 \$',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}
