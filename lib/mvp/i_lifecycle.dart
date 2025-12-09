
abstract class ILifecycle {
  
  void initState();
  
  void didChangeDependencies();
  
  void didUpdateWidgets<W>(W oldWidget);
  
  void deactivate();//停用
  
  void dispose();
}
