import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:price_tracker_codetest/constants/app_strings.dart';
import 'package:price_tracker_codetest/model/symbol.dart';
import 'package:price_tracker_codetest/model/tick.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

part 'binary_state.dart';

class BinaryCubit extends Cubit<BinaryState> {
    late IOWebSocketChannel channel;
    late StreamSubscription subscription;

  BinaryCubit() : super(BinaryInitial());

  ///Initialized the stream and get active symbols
  void init(){
    channel = IOWebSocketChannel.connect(Uri.parse(AppStrings.APP_API_HOST));
    subscription = channel.stream.listen((event) => _onMessage(event));

    emit(BinaryShowLoading());

    channel.sink.add(json.encode({
      "active_symbols": "brief",
      "product_type": "basic"
    }));
  }

  ///define active symbols and ticks
  void _onMessage(dynamic event){
    emit(BinaryHideLoading());
    Map<String, dynamic> data = json.decode(event as String);
    if(data.containsKey('msg_type') && data['msg_type'] == MessageType.ACTIVE_SYMBOL){
      emit(BinaryDataSymbol(ActiveSymbolResponse.fromJson(data).activeSymbols ?? []));
    }

    if(data.containsKey('msg_type') && data['msg_type'] == MessageType.TICK){
      Tick? tick = TickResponse.fromJson(data).tick;
      if(tick!=null){
        emit(BinaryDataTicks(tick));
      }
    }
  }

  ///get the price ticks for selected Asset
  void subscribeForTicks(String tick){
    emit(BinaryShowLoading());
    channel.sink.add(json.encode({
      "ticks": tick,
      "subscribe": 1
    }));
  }

  ///Unsubscribe previous selected asset
  void unSubscribeForTicks(String subscriptionId){
    emit(BinaryShowLoading());
    channel.sink.add(json.encode({
      "forget": subscriptionId
    }));
  }
}
