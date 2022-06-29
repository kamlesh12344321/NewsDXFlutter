import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsdx/app_constants/string_constant.dart';
class BookMarkFilledContainer extends StatefulWidget {

  const BookMarkFilledContainer({Key? key,}) : super(key: key);

  @override
  State<BookMarkFilledContainer> createState() => _BookMarkFilledContainerState();
}

class _BookMarkFilledContainerState extends State<BookMarkFilledContainer> {
  TextEditingController myController = TextEditingController();
  String? email = "";
  bool rememberMe = false;

  @override
  void initState() {
    myController.addListener(() {
      email = myController.text;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
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
                    const Text("Bookmark",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 32
                      ),),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top:7),child: Text("Delete", style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                ),),),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 5.0, right: 16.0, bottom: 0.0),
            child: TextField(
              controller: myController,
              maxLines: 1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Search Articles"),
              ),
              onChanged: (text) {
                setState() {
                  email = text;
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(value: true, onChanged: _onRememberMeChanged(true)),
                  const Text("Select All", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                  ),),
                ],
              ),
               const Padding(padding: EdgeInsets.only(right: 16), child: Text("Cancel", style: TextStyle(
                   color: Colors.black,
                   fontWeight: FontWeight.w600
               ),),)
            ],
          )
        ],
    );
  }

   _onRememberMeChanged(bool newValue) => setState(() {
    rememberMe = newValue;

    if (rememberMe) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
  });

}
