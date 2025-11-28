import 'package:flutter/widgets.dart';

/// @weilu https://github.com/simplezhli/flutter_deer
/// 
/// 便于管理ChangeNotifier，不用重复写模板代码。
/// 之前：
/// ```dart
/// class TestPageState extends State<TestPage> {
///   final TextEditingController _controller = TextEditingController();
///   final FocusNode _nodeText = FocusNode();
///   
///   @override
///   void initState() {
///     _controller.addListener(callback);
///     super.initState();
///   }
///
///   @override
///   void dispose() {
///     _controller.removeListener(callback);
///     _controller.dispose();
///     _nodeText.dispose();
///     super.dispose();
///   }
/// }
/// ```
/// 使用示例：
/// ```dart
/// class TestPageState extends State<TestPage> with ChangeNotifierMixin<TestPage> {
///   final TextEditingController _controller = TextEditingController();
///   final FocusNode _nodeText = FocusNode();
///
///   @override
///   Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
///     return {
///       _controller: [callback],
///       _nodeText: null,
///     };
///   }
/// }
/// ```
/// 通过 on关键字，可以限制ChangeNotifierMixin 这个Mixin 只能用于特定类State（或其子类）之上，这增强了代码的类型安全性
mixin ChangeNotifierMixin<T extends StatefulWidget> on State<T> {

  Map<ChangeNotifier?, List<VoidCallback>?>? _map;
  //1个 Mixin 包含了抽象方法（即没有实现的方法），那么任何使用（with）这个 Mixin 的类都必须实现这些抽象方法
   Map<ChangeNotifier?, List<VoidCallback>?>?  changeNotifier(); //抽象方法

  @override
  void initState() {
    _map = changeNotifier();
    /// 遍历数据，如果callbacks不为空则添加监听
    _map?.forEach((changeNotifier, callbacks) {
      if (callbacks != null && callbacks.isNotEmpty) {

        void addListener(VoidCallback callback) {
          changeNotifier?.addListener(callback);
        }
        callbacks.forEach(addListener);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _map?.forEach((changeNotifier, callbacks) {
      if (callbacks != null && callbacks.isNotEmpty) {
        void removeListener(VoidCallback callback) {
          changeNotifier?.removeListener(callback);
        }

        callbacks.forEach(removeListener);
      }
      changeNotifier?.dispose();
    });
    super.dispose();
  }
}
