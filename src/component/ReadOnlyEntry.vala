public class component.ReadOnlyEntry : Gtk.Entry{
    public string content { get; construct;}
    public ReadOnlyEntry(string content){
        Object(
            text:content,
            editable:false
        );
    }
}
