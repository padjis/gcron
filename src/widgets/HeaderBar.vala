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

public class Gcron.Widgets.HeaderBar : Gtk.HeaderBar {
    public signal void cron_refresh ();

    public HeaderBar () {
        Object (
            has_subtitle: false,
            show_close_button: true,
            title: "Gcron"
        );
    }

    construct {
        var refresh_button = new Gtk.Button.from_icon_name ("view-refresh", Gtk.IconSize.BUTTON);
        refresh_button.tooltip_text = "Reload cron config";
        refresh_button.clicked.connect (() => {
            cron_refresh ();
        });

        pack_start (refresh_button);
    }
}
