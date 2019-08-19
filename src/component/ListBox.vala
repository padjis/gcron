public class component.ListBox : Gtk.ListBox{

    public void add_info_log(string text){
        Gtk.Box box=new Gtk.Box(Gtk.Orientation.HORIZONTAL,0);
        var entry = new Gtk.Entry();
        entry.text="[Info] "+text;
        entry.editable=false;
        box.pack_start (entry, true, true, 0);
        prepend(box);
    }

    public void add_error_log(string text){
        Gtk.Box box=new Gtk.Box(Gtk.Orientation.HORIZONTAL,0);
        var label = new Gtk.Label("");
        label.set_markup("<b><i>[Error] "+text+"</i></b>");
        box.pack_start (label, false, false, 0);
        prepend(box);
    }
}
