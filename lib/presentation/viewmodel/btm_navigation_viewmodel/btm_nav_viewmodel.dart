import 'dart:async';

class BottomNavViewModel {
  final _controller = StreamController<int>.broadcast();
  int _currentIndex = 0;
  bool _isClosed = false;

  Stream<int> get indexStream => _controller.stream;

  void updateIndex(int index) {
    if (_isClosed) return;
    _currentIndex = index;
    _controller.sink.add(index);
  }

  void resetIndex() {
    updateIndex(0);
  }

  int get currentIndex => _currentIndex;

  void dispose() {
    _isClosed = true;
    _controller.close();
  }
}