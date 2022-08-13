class TickResponse {
  EchoReq? echoReq;
  String? msgType;
  SubscriptionId? subscription;
  Tick? tick;

  TickResponse({this.echoReq, this.msgType, this.subscription, this.tick});

  TickResponse.fromJson(Map<String, dynamic> json) {
    echoReq = json['echo_req'] != null
        ? EchoReq.fromJson(json['echo_req'])
        : null;
    msgType = json['msg_type'];
    subscription = json['subscription'] != null
        ? SubscriptionId.fromJson(json['subscription'])
        : null;
    tick = json['tick'] != null ? Tick.fromJson(json['tick']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (echoReq != null) {
      data['echo_req'] = echoReq!.toJson();
    }
    data['msg_type'] = msgType;
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
    if (tick != null) {
      data['tick'] = tick!.toJson();
    }
    return data;
  }
}

class EchoReq {
  int? subscribe;
  String? ticks;

  EchoReq({this.subscribe, this.ticks});

  EchoReq.fromJson(Map<String, dynamic> json) {
    subscribe = json['subscribe'];
    ticks = json['ticks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subscribe'] = subscribe;
    data['ticks'] = ticks;
    return data;
  }
}

class SubscriptionId {
  String? id;

  SubscriptionId({this.id});

  SubscriptionId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class Tick {
  double? ask;
  double? bid;
  int? epoch;
  String? id;
  int? pipSize;
  double? quote;
  String? symbol;

  Tick(
      {this.ask,
        this.bid,
        this.epoch,
        this.id,
        this.pipSize,
        this.quote,
        this.symbol});

  Tick.fromJson(Map<String, dynamic> json) {
    ask = json['ask'];
    bid = json['bid'];
    epoch = json['epoch'];
    id = json['id'];
    pipSize = json['pip_size'];
    quote = json['quote'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ask'] = ask;
    data['bid'] = bid;
    data['epoch'] = epoch;
    data['id'] = id;
    data['pip_size'] = pipSize;
    data['quote'] = quote;
    data['symbol'] = symbol;
    return data;
  }
}
