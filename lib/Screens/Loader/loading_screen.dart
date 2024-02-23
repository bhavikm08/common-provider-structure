
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'loading_provider.dart';


class Loading extends StatelessWidget {
  final Widget? child;

  const Loading({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProviders>(
      builder: (context, loadingProvider, _) {
        return IgnorePointer(
          ignoring: loadingProvider.isLoading,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              child!,
              if (loadingProvider.isLoading)
                 const Center(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child: SpinKitThreeBounce(
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
