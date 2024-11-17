// All our Ticker class does is expose a tick function which takes the number of ticks (seconds) 
// we want and returns a stream which emits the remaining seconds every second.
// this is the data source: yahan say timer ki value arahi hai 
class Ticker {
  const Ticker();

  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
    /*
    Fires a value every second (due to Duration(seconds: 1)).
    The stream's value is calculated by (x) => ticks - x - 1, where x is the number of times the stream has emitted a value so far.
    For the first tick, x = 0, so it emits ticks - 0 - 1 = ticks - 1.
    For the second tick, x = 1, so it emits ticks - 1 - 1 = ticks - 2, and so on.
    This effectively counts down from ticks - 1 to 0.
    .take(ticks): This ensures the stream stops emitting values after ticks times. 
                  It caps the stream to emit only as many values as specified by ticks, so the countdown completes at zero.
    */
  }
}

// streams ki types broadcast 