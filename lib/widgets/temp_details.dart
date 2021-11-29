import 'package:flutter/material.dart';

import '../constants.dart';
import '../home_controller.dart';
import 'temp_btn.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    Key? key,
    required HomeController controller,
  })  : _controller = controller,
        super(key: key);

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                TempBtn(
                  isActive: _controller.isCoolSelected,
                  title: 'Cool',
                  svgSrc: 'assets/icons/coolShape.svg',
                  press: _controller.updateCoolSelectedTab,
                ),
                const SizedBox(width: defaultPadding),
                TempBtn(
                  isActive: !_controller.isCoolSelected,
                  title: 'Heat',
                  svgSrc: 'assets/icons/heatShape.svg',
                  press: _controller.updateCoolSelectedTab,
                  color: redColor,
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_drop_up,
                  size: 48,
                ),
              ),
              Text(
                '30' + '\u2103',
                style: TextStyle(fontSize: 86),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 48,
                ),
              ),
            ],
          ),
          Spacer(),
          Text('CURRENT TEMPERATURE'),
          const SizedBox(height: defaultPadding),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inside'.toUpperCase(),
                    style: TextStyle(color: Colors.white54),
                  ),
                  Text(
                    '20' + '\u2103',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white54),
                  )
                ],
              ),
              const SizedBox(width: defaultPadding / 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Outside'.toUpperCase(),
                    style: TextStyle(color: Colors.white54),
                  ),
                  Text(
                    '35' + '\u2103',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white54),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
