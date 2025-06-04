import 'package:ecommerce_vnkp/app/dependency_injector.dart';
import 'package:ecommerce_vnkp/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ECommerceApp extends StatefulWidget {
  const ECommerceApp({super.key});

  @override
  State<ECommerceApp> createState() => _ECommerceAppState();
}

class _ECommerceAppState extends State<ECommerceApp> {
  late DependencyInjector di;

  @override
  void initState() {
    super.initState();
    di = DependencyInjector();
    di.initPref();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: di.inject(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ECommerce',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: Routes.splashRoute,
        onGenerateRoute: RouteGenerator.getRoute
        ),
    );
  }
}
