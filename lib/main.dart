import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repro_lsp/bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyBlocProvider extends InheritedWidget {
  MyBlocProvider({super.key, required super.child}) : bloc = MyBloc();

  final MyBloc bloc;

  @override
  bool updateShouldNotify(covariant MyBlocProvider oldWidget) =>
      oldWidget != this;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyBlocProvider(
          child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter(MyBloc bloc) {
    setState(() {
      _counter++;
    });

    bloc.add(MyEvent.doSomething(value: _counter));
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.findAncestorWidgetOfExactType<MyBlocProvider>()!.bloc;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            BlocBuilder<MyBloc, MyState>(
              bloc: bloc,
              builder: (context, state) => state.when(
                unknown: () => const SizedBox.shrink(),
                empty: () => const SizedBox.shrink(),
                withValue: (v) {
                  return Text('$v');
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _incrementCounter(bloc),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
