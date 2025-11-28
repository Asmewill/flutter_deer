
import 'package:fluro/fluro.dart';

/***
 * abstract关键字定义的抽象类来充当接口 (类似java中的interface)
 */
abstract class IRouterProvider  {
  
  void initRouter(FluroRouter router);
}
