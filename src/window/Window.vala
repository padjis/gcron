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

        grid.add_full_line("Hello","epojgpeorjgpoehrgpoehrpgoheropgh");
        grid.add_full_line("Heleferferglo","epojgpeegrgergergergergorjgpoehrgpoehrpgoheropgh");
        grid.add_full_line("rgt","grtg");
        grid.add_empty_line();

        grid.add_space();

        grid.add_info_log("info log");
        grid.add_error_log("info log regergergijeoirgj erigoeirugiuerbgireubgireougbierugbeiorugbierubgieorgbu");

        add(grid);

        show_all();
    }
}
