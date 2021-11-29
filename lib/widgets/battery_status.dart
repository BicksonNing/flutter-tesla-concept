import 'package:flutter/material.dart';

class BatteryStatus extends StatelessWidget {
  const BatteryStatus({
    Key? key,
    required this.constrains,
  }) : super(key: key);

  final BoxConstraints constrains;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Column(
        children: [
          Text(
            '220 mi',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white),
          ),
          Text(
            '62%',
            style: TextStyle(fontSize: 20),
          ),
          Spacer(),
          Text(
            'CHARGING',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '18 min remaining',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.14,
          ),
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('22 mi/hr'),
                Text('232 v'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
