import 'package:encryption_drift/domain/di/di.dart';
import 'package:encryption_drift/domain/entity/person.dart';
import 'package:encryption_drift/presentation/bloc/person_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonListScreen extends StatelessWidget {
  static const String routeName = '/personListScreen';

  const PersonListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PersonListBloc>(
          create: (_) => getIt<PersonListBloc>(),
          dispose: (context, personListBloc) {
            personListBloc.dispose();
          },
        )
      ],
      child: Consumer<PersonListBloc>(
        builder: (context, personListBloc, child) {
          return Scaffold(
            appBar: AppBar(
              title: TextField(controller: personListBloc.searchFieldController),
              actions: [
                IconButton(onPressed: personListBloc.update, icon: Icon(Icons.update)),
              ],
            ),
            body: StreamBuilder<List<Person>>(
              stream: personListBloc.personStream,
              builder: ((context, snapshot) {
                final List<Person> list = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(list[index].name),
                    );
                  },
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
