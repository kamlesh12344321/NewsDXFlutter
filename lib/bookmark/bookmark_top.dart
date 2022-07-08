import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookMarkTopView extends StatefulWidget {
  const BookMarkTopView({Key? key}) : super(key: key);

  @override
  State<BookMarkTopView> createState() => _BookMarkTopViewState();
}

class _BookMarkTopViewState extends State<BookMarkTopView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/more.svg"),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Bookmark",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 32),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 7),
                child: Text(
                  "Delete",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black),
                ),
              ),
            ],
          )),
    );
  }
}
