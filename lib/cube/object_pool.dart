class ObjectPool<T> {
  final List<T> _available = [];
  final List<T> _inUse = [];
  final T Function() _create;

  ObjectPool(this._create);

  T borrowObject() {
    if (_available.isEmpty) {
      _available.add(_create());
    }
    final obj = _available.removeLast();
    _inUse.add(obj);
    return obj;
  }

  void returnObject(T obj) {
    _inUse.remove(obj);
    _available.add(obj);
  }
}