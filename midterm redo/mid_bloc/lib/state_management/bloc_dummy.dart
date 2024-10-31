import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mid_bloc/launch_model.dart';

abstract class LaunchEvent {}

class FetchLaunches extends LaunchEvent {}

//Bloc state

abstract class LaunchState {}

class LaunchInitial extends LaunchState {}

class LaunchLoading extends LaunchState {}

class LaunchLoaded extends LaunchState {
  final List<Launch> launches;
  LaunchLoaded(this.launches);
}

class LaunchError extends LaunchState {
  final String error;
  LaunchError(this.error);
}

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  LaunchBloc() : super(LaunchInitial()){
    on<FetchLaunches>(onFetchLaunches);
  }

  Future<void> onFetchLaunches( FetchLaunches event, Emitter<LaunchState> emit) async {
    emit(LaunchLoading());
    try {
      List<Launch> launches = await getProducts();
      emit(LaunchLoaded(launches));
    } catch (e) {
      emit(LaunchError(e.toString()));
    }
  }
}

Future<List<Launch>> getProducts() async {
  List<Launch> launches = [];

  Response apiResponse =
      await http.get(Uri.parse('https://api.spacexdata.com/v3/missions'));

  if (apiResponse.statusCode == 200) {
    List<dynamic> decoded = jsonDecode(apiResponse.body);
      //List jsonUsers = decoded['results'];

    launches = decoded.map((launch) => Launch.fromJson(launch)).toList();
  } else {
    launches = [];
  }

  return launches;
}
