import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker_codetest/Screens/splash.dart';
import 'package:price_tracker_codetest/cubit/binary_cubit.dart';
import 'package:price_tracker_codetest/model/symbol.dart';
import 'package:price_tracker_codetest/model/tick.dart';

class PriceTracker extends StatefulWidget {
  const PriceTracker({Key? key}) : super(key: key);

  @override
  State<PriceTracker> createState() => _PriceTrackerState();
}

class _PriceTrackerState extends State<PriceTracker> {
  bool showSplash = true;
  bool showLoading = true;
  final List<SymbolValue> _activeSymbol = [];
  String? selectedMarket;
  SymbolValue? selectedSymbol;
  Tick? _tick;
  Tick? _previousTick;
  MaterialColor _tickColor = Colors.grey;


  @override
  void initState() {
    BlocProvider.of<BinaryCubit>(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BinaryCubit, BinaryState>(
      bloc: context.read<BinaryCubit>(),
      listener: (context, state) {
        if (state is BinaryInitial) {
          showSplash = true;
        } else {
          showSplash = false;
        }

        if (state is BinaryShowLoading) {
          showLoading = true;
        }

        if (state is BinaryHideLoading) {
          showLoading = false;
        }

        if(state is BinaryDataSymbol){
          _activeSymbol.clear();
          _activeSymbol.addAll(state.symbol);
        }

        if(state is BinaryDataTicks){
          _previousTick = _tick;
          _tick = state.tick;
          if((_tick?.quote??0) > (_previousTick?.quote??0)){
            _tickColor = Colors.green;
          }else if((_tick?.quote??0) < (_previousTick?.quote??0)){
            _tickColor = Colors.red;
          }else if((_tick?.quote??0) == (_previousTick?.quote??0)){
            _tickColor = Colors.grey;
          }
        }
      },
      child: BlocBuilder<BinaryCubit, BinaryState>(
        bloc: context.read<BinaryCubit>(),
        builder: (context, state) {
          return (showSplash)?const SplashScreen() : Scaffold(
            appBar: AppBar(
              title: const Text(
                  'Price Tracker'
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        hint: const Text('Select Market'),
                        value: selectedMarket,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (newValue) {
                          ///assign value to selected market
                          setState(() {
                            selectedMarket = newValue;
                            selectedSymbol = null;
                          });

                          ///check tick has previous value
                          if(_tick != null){
                            ///unsubscribe to previous symbol
                            context.read<BinaryCubit>().unSubscribeForTicks(_tick!.id??"");

                            ///Clear tick previous values
                            setState(() {
                              _tick = null;
                            });
                          }
                        },
                        items: _activeSymbol.map((e) => e.market).toList().toSet().map((e) => DropdownMenuItem(value: e,child: Text(e??""),)).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<SymbolValue>(
                        hint: const Text('Select Asset'),
                        value: selectedSymbol,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (newValue) {
                          ///assign new value to selected symbol
                          setState(() {
                            selectedSymbol = newValue;
                          });

                          ///call to Binary data symbol by parsing symbol to it
                          ///subscribe to selected symbol
                          ///check if tick is null for subscribe as new symbol or not
                          if(_tick != null){
                            ///tick is not null
                            ///unsubscribe to previous symbol
                            context.read<BinaryCubit>().unSubscribeForTicks(_tick!.id??"");

                            ///Clear tick previous values
                            setState(() {
                              _tick = null;
                            });

                            ///subscribe to new symbol
                            context.read<BinaryCubit>().subscribeForTicks(
                                newValue?.symbol ?? "");

                          }else {
                            ///tick is null
                            ///subscribe to selected symbol
                            context.read<BinaryCubit>().subscribeForTicks(
                                newValue?.symbol ?? "");
                          }
                          },
                        items: _activeSymbol.where((element) => element.market==selectedMarket).map((e) => DropdownMenuItem(value: e,child: Text(e.displayName??""),),).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  if(selectedSymbol != null) showLoading? const Center(child: CircularProgressIndicator(),)  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     if(_tick!= null) Text("Price ${_tick?.quote}",style: TextStyle(
                        color: _tickColor,
                      ),),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
