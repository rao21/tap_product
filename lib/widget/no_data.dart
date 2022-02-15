import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
                height: 240,
                width: 240,
                child: Image.asset('assets/nodata.jpeg')),
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            "Opp's Seems Like Nothing added now. Let's add new product",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          )
        ],
      ),
    );
  }
}
