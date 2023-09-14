import 'package:flutter/material.dart';

import '../common/constants/constants.dart';
import '../data/core/app_error.dart';

class AppErrorWidget extends StatelessWidget {
  final AppErrorType errorType;
  final Function() onPressed;

  const AppErrorWidget({
    Key? key,
    required this.errorType,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorType == AppErrorType.api
                ? Constants.somethingWentWrong
                : Constants.checkNetwork,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          TextButton(
            onPressed: onPressed,
            child: const Text(Constants.retry),
          ),
        ],
      ),
    );
  }
}
