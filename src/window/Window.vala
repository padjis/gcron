using grid;
public class window.Window : Gtk.ApplicationWindow{
    public Window(Application application){
        Object(
            application:application
        );
    }
    
    construct{
        title="Cronera - 0.0.1";
        window_position = Gtk.WindowPosition.CENTER;
        //set_default_size (200, 50);
        set_border_width(10);

        Grid grid=new Grid();

        add(grid);

        show_all();
    }
}
