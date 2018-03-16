
class MyPane implements IPane{
  IPane parent;
  
  MyPane(IPane parent){
    this.parent = parent;
  }
  
 boolean  contains(int x, int y) {
   return parent.contains(x, y);
 }
           
 void  draw(IGraphics g) {
   parent.draw(g);
 }
           
 void  focus() {
   parent.focus();
 }
 
 void  focus(ArrayList<IObject> e) {
   parent.focus(e);
 }
 
 int  getBorderColor() {
   return parent.getBorderColor();
 }
           
 float  getBorderWidth() {
   return parent.getBorderWidth();
 }
           
 int  getHeight() {
   return parent.getHeight();
 }
           
 IPanelI  getPanel() {
   return parent.getPanel();
 }
           
 IView  getView() {
   return parent.getView();
 }
           
 int  getWidth() {
   return parent.getWidth();
 }
           
 float  getX() {
   return parent.getX();
 }
           
 float  getY() {
   return parent.getY();
 }
           
 boolean  isVisible() {
   return parent.isVisible();
 }
           
 void  keyPressed(IKeyEvent e) {
   parent.keyPressed(e);
 }
           
 void  keyReleased(IKeyEvent e) {
   parent.keyReleased(e);
 }
 
 void  keyTyped(IKeyEvent e) {
   parent.keyTyped(e);
 }
           
 void  mouseClicked(IMouseEvent e) {
   println(e);
   parent.mouseClicked(e);
 }
           
 void  mouseDragged(IMouseEvent e) {
   parent.mouseDragged(e);
 }
           
 void  mouseEntered(IMouseEvent e) {
   parent.mouseEntered(e);
 }
           
 void  mouseExited(IMouseEvent e) {
   parent.mouseExited(e);
 }
           
 void  mouseMoved(IMouseEvent e) {
   parent.mouseMoved(e);
 }
           
 void  mousePressed(IMouseEvent e) {
   parent.mousePressed(e);
 }
           
 void  mouseReleased(IMouseEvent e) {
   parent.mouseReleased(e);
 }
           
 void  mouseWheelMoved(IMouseWheelEvent e) {
   parent.mouseWheelMoved(e);
 }
           
 INavigator  navigator() {
   return parent.navigator();
 }
           
 void  setBorderColor(int r, int g, int b, int a) {
   parent.setBorderColor(r, g, b, a);
 }
           
 void  setBorderWidth(float b) {
   parent.setBorderWidth(b);
 }
           
 void  setBounds(int x, int y, int w, int h) {
   parent.setBounds(x, y, w, h);
 }
           
 void  setLocation(int x, int y) {
   parent.setLocation(x, y);
 }
           
 void  setPanel(IPanelI p) {
   parent.setPanel(p);
 }
           
 void  setSize(int width, int height) {
   parent.setSize(width, height);
 }
           
 void  setView(IView view){
   parent.setView(view);
 }
           
 void  setVisible(boolean v){
   parent.setVisible(v);
 }
}
