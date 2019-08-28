using component;
using Gtk;
using util;
public class window.Window : ApplicationWindow{
    public Window(Application application){
        Object(
            application:application,
            resizable:false
        );
    }
    
    construct{
        title="Gcron";
        window_position = WindowPosition.CENTER; 
        set_default_size(575,200);
        set_border_width(10);

        Gtk.Box box=new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

        Gtk.Frame frame2=new Gtk.Frame("Message logs");

        component.ListBox listBox=new component.ListBox(this);
        listBox.add_info_log("The system will display messages here");
        
        frame2.add(listBox);

        Cron cron=new Cron();
        Array<Array<string>> result=cron.readCron();
        component.Grid grid=new component.Grid(listBox,result.length,cron);
        for (int i = 0; i < result.length ; i++) {
            grid.add_full_line(result.index(i).index(0),result.index(i).index(1));
        }

        if(result.length!=0){
            grid.add_space();
        }

        grid.add_empty_line();

        Gtk.Frame frame1=new Gtk.Frame("Current user cron setup");
        frame1.add(grid);

        Gtk.Button buttonReload= new Gtk.Button.with_label ("Reload config ...");
        buttonReload.clicked.connect (reset);

        Gtk.Button buttonClear= new Gtk.Button.with_label ("Clear logs ...");
        buttonClear.clicked.connect (listBox.reset);

        box.pack_start (buttonReload, false, false, 0);
        box.pack_start (new Gtk.Label(""), false, false, 0);
        box.pack_start (frame1, false, false, 0);
        box.pack_start (new Gtk.Label(""), false, false, 0);
        box.pack_start (buttonClear, false, false, 0);
        box.pack_start (new Gtk.Label(""), false, false, 0);
        box.pack_start (frame2, false, false, 0);

        add(box);

        show_all();
    }

    void reset(){
        close();
        application.activate();
    }
}
