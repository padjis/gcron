public class window.Window : Gtk.ApplicationWindow{
    public Window(Application application){
        Object(
            application:application
        );
    }
    
    construct{
        title="Cronera - 0.0.1";
        window_position = Gtk.WindowPosition.CENTER;
        set_default_size (500, 200);
        
        show_all();
    }
}
