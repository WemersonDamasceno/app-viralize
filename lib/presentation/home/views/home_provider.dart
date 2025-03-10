import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viralize/presentation/home/bloc/post_bloc.dart';
import 'package:viralize/presentation/home/views/home_page.dart';
import 'package:viralize/service_locator.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostBloc>(create: (context) => sl()),
      ],
      child: HomePage(),
    );
  }
}
