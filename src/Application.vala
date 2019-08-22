public class Application:Gtk.Application{
    
    public Application(){
        Object(
            application_id: "com.github.padjis.gcron",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }
    
    protected override void activate(){
        var window = new window.Window(this);
        add_window(window);
    }
}
