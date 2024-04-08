use std::process::exit;

use penrose::{
    builtin::actions::key_handler,
    core::bindings::KeyEventHandler,
    extensions::util::dmenu::{DMenu, DMenuConfig, MenuMatch},
    util::spawn,
    x11rb::RustConn,
};

pub fn power_menu() -> Box<dyn KeyEventHandler<RustConn>> {
    key_handler(|state, _| {
        let options = vec!["lock", "suspend", "logout", "restart-wm", "shutdown", "reboot"];
        let screen_index = state.client_set.current_screen().index();
        let menu = DMenu::new(&DMenuConfig::with_prompt(">>> "), screen_index);

        if let Ok(MenuMatch::Line(_, choice)) = menu.build_menu(options) {
            match choice.as_ref() {
                "lock" => spawn("xflock4"),
                "suspend" => spawn("systemctl suspend"),
                "logout" => spawn("loginctl kill-session self"),
                "shutdown" => spawn("shutdown -h now"),
                "reboot" => spawn("reboot"),
                "restart-wm" => exit(0), // Wrapper script then handles restarting us
                _ => unimplemented!(),
            }
        } else {
            Ok(())
        }
    })
}
