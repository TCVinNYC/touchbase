import 'package:flutter/material.dart';

class InfoBody extends StatelessWidget {
  const InfoBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height, // / 2.4,
      // decoration: const BoxDecoration(
      //   color: Colors.grey,
      // ),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 40, right: 40),
            height: MediaQuery.of(context).size.height * 0.36,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/profile_bg.jpg'),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                )),
            child: Row(
              children: [
                // THIS IS FOR EDIT ICON ON THE BOTTOM
                // Stack(
                //   clipBehavior: Clip.none,
                //   children: [
                // change how to get image obvio
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/originals/94/25/93/9425933cef85981844778fe55327f5da.jpg'),
                  radius: 65, //change to 60 if u want edit icon on the bottom
                ),
                //     Positioned(
                //         bottom: -10,
                //         right: -15,
                //         child: ElevatedButton(
                //           onPressed: () {
                //             //function to change image
                //           },
                //           child: const Icon(
                //             Icons.create_rounded,
                //             color: Colors.blue,
                //           ),
                //           style: ElevatedButton.styleFrom(
                //             shape: const CircleBorder(),
                //             primary: Colors.white,
                //           ),
                //         )),
                //   ],
                // ),

                //change how to get name
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 40, bottom: 15),
                        child: Text(
                          'Stevenson Chittumuri',
                          maxLines: 3,
                          style: TextStyle(
                              fontFamily: 'Frutiger',
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      //change how to get pronouns
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Text(
                          'He/Him',
                          style: TextStyle(
                            fontFamily: 'Frutiger',
                            fontSize: 20,
                            color: Colors.white,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ]))
              ],
            ),
          ),

          // info card
          Positioned(
              top: 225,
              right: 0,
              left: 0,
              child: SizedBox(
                height: 100,
                child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    elevation: 3,

                    //info on the card
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            // redirect to list of connections page
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 13),
                                child: const Text(
                                  'Connections',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 20,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              //find a way to get connections amount
                              const Text(
                                '16',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // redirect to upload page.. i think ?
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 13),
                                  child: const Text(
                                    'Posts',
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 20,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                //find a way to get events amount
                                const Text(
                                  '14',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                )
                              ]),
                        ),
                        TextButton(
                            onPressed: () {
                              // redirect to my events page
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 13),
                                  child: const Text(
                                    'Events',
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 20,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Text(
                                  '4',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ))
                      ],
                    )),
              )),
        ],
      ),
    );
  }
}
