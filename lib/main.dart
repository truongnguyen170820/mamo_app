import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mamo_app/api/services/task_repository.dart';
import 'package:mamo_app/api/services/user_repository.dart';
import 'package:mamo_app/bloc/account/account_bloc.dart';
import 'package:mamo_app/bloc/auth/authentication_bloc.dart';
import 'package:mamo_app/bloc/auth/authentication_event.dart';
import 'package:mamo_app/bloc/auth/authentication_state.dart';
import 'package:mamo_app/bloc/home/home_bloc.dart';
import 'package:mamo_app/bloc/login/login_bloc.dart';
import 'package:mamo_app/bloc/profile/profile_bloc.dart';
import 'package:mamo_app/bloc/profile/update_profile/update_profile_bloc.dart';
import 'package:mamo_app/bloc/readers/readers_bloc.dart';
import 'package:mamo_app/bloc/request_task/request_task_bloc.dart';
import 'package:mamo_app/bloc/simple_bloc_observer.dart';
import 'package:mamo_app/view/home/home_view_page.dart';
import 'package:mamo_app/view/login/LoginViewPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final UserRepository _userRepository = UserRepository();
  final TaskRepository _taskRepository = TaskRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc(_userRepository)),
        BlocProvider(
          create: (_) =>
          AuthenticationBloc()..add(AuthenticationEventStarted()),
        ),
        BlocProvider(create: (_) => HomeBloc(_userRepository)),
        BlocProvider(create: (_) => RequestTaskBloc(_taskRepository)),
        BlocProvider(create: (_) => ReadersBloc(_userRepository)),
        BlocProvider(create: (_) => ProfileBloc(_userRepository)),
        BlocProvider(create: (_) => AccountBloc(_userRepository)),
        BlocProvider(create: (_) => UpdateProfileBloc(_userRepository))
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 690),
        builder: ()=> MaterialApp(
          initialRoute: '/',
          routes: {
            '/login': (_) => LoginViewPage(),
          },
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (_, state){
              if(state is AuthenticationStateSuccess){
                return HomeViewPage();
              }else if(state is AuthenticationStateFailure){
                return LoginViewPage();
              }
              return LoginViewPage();
            },
          ),
        ),
      ),
    );
  }
}