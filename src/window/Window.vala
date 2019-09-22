/*
 *  Copyright (C) 2019 Emmanuel Padjinou
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *  Authored by: Emmanuel Padjinou <emmanuel@padjinou.com>
 *
 */

using Gcron.Widgets;
using Gtk;
using Gcron.Util;

public class Gcron.Window : ApplicationWindow {

    private Gcron.Widgets.HeaderBar headerbar;

    public Window (Application application) {
        Object (
            application: application,
            resizable: false
        );
    }

    construct {
        title = "Gcron";
        window_position = WindowPosition.CENTER;
        set_default_size (575, 200);
        set_border_width (10);

        this.headerbar = new Gcron.Widgets.HeaderBar ();
        this.headerbar.cron_refresh.connect (reset);
        this.set_titlebar (this.headerbar);

        Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

        Gtk.Frame frame2 = new Gtk.Frame ("Message logs");

        Widgets.ListBox listBox = new Widgets.ListBox (this);
        listBox.add_info_log ("The system will display messages here");

        frame2.add (listBox);

        Cron cron=new Cron ();
        Array<Array<string>> result = cron.readCron ();
        Widgets.Grid grid = new Widgets.Grid (listBox, result.length,cron);

        for (int i = 0; i < result.length; i++) {
            grid.add_full_line (result.index (i).index (0), result.index (i).index (1));
        }

        if (result.length != 0) {
            grid.add_space ();
        }

        grid.add_empty_line ();

        Gtk.Frame frame1 = new Gtk.Frame (GLib.Environment.get_user_name ()+"'s cron setup");
        frame1.add (grid);

        Gtk.Button buttonClear = new Gtk.Button.with_label ("Clear the message logs");
        buttonClear.get_style_context ().add_class ("main-button");
        buttonClear.clicked.connect (listBox.reset);

        box.pack_start (frame1, false, false, 0);
        box.pack_start (new Gtk.Label (""), false, false, 0);
        box.pack_start (buttonClear, false, false, 0);
        box.pack_start (new Gtk.Label (""), false, false, 0);
        box.pack_start (frame2, false, false, 0);

        add (box);

        show_all ();
    }

    public void reset () {
        close ();
        application.activate ();
    }
}
