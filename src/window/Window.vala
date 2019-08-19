using component;
using Gtk;
public class window.Window : ApplicationWindow{
    public Window(Application application){
        Object(
            application:application
        );
    }
    
    construct{
        title="Cronera";
        window_position = WindowPosition.CENTER;
        //set_default_size (200, 50);
        set_border_width(10);

        Gtk.Box box=new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

        Gtk.Frame frame2=new Gtk.Frame("Message logs");

        component.ListBox listBox=new component.ListBox(this);
        listBox.add_info_log("The system will display messages here !");
        
        frame2.add(listBox);

        component.Grid grid=new component.Grid(listBox);

        grid.add_full_line("Hello","epojgpeorjgpoehrgpoehrpgoheropgh");
        grid.add_full_line("Heleferferglo","epojgpeegrgergergergergorjgpoehrgpoehrpgoheropgh");
        grid.add_full_line("rgt","grtg");

        grid.add_space();

        grid.add_empty_line();

        Gtk.Frame frame1=new Gtk.Frame("Current user cron setup");
        frame1.add(grid);

        Gtk.Button button= new Gtk.Button.with_label ("Clear logs ...");
        button.clicked.connect (listBox.reset);

        box.pack_start (frame1, false, false, 0);
        box.pack_start (new Gtk.Label(""), false, false, 0);
        box.pack_start (button, false, false, 0);
        box.pack_start (new Gtk.Label(""), false, false, 0);
        box.pack_start (frame2, false, false, 0);

        add(box);

        show_all();
    }
}
