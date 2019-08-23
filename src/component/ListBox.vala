public class component.ListBox : Gtk.ListBox{

    public window.Window window { get; set;}

    public ListBox(window.Window window){
        Object(
            window:window
        );
    }

    private string getDate(){
        var now = new DateTime.now_local ();
        return now.to_string();
    }

    public void reset(){
        this.foreach ((element) => this.remove (element));
        //add_info_log("The system will display messages here");
        window.resize(1,1);
        window.show_all();
    }

    public void add_info_log(string text){
        Gtk.Box box=new Gtk.Box(Gtk.Orientation.HORIZONTAL,0);
        var entry = new ReadOnlyEntry(getDate()+" - [Info] "+text);
        box.pack_start (entry, true, true, 0);
        prepend(box);
        window.show_all();
    }

    public void add_error_log(string text){
        Gtk.Box box=new Gtk.Box(Gtk.Orientation.HORIZONTAL,0);
        var entry = new ReadOnlyEntry(getDate()+" - [Error] "+text);
        box.pack_start (entry, true, true, 0);
        prepend(box);
        window.show_all();
    }
}
