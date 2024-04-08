//! My personal penrose configuration
use binhtran432k::{
    bar::status_bar, bindings::raw_key_bindings, layouts::layouts, BAR_HEIGHT_PX, INNER_PX,
    OUTER_PX,
};
use penrose::{
    builtin::hooks::SpacingHook,
    core::{bindings::parse_keybindings_with_xmodmap, Config, WindowManager},
    extensions::hooks::{add_ewmh_hooks, manage::SetWorkspace, SpawnOnStartup},
    manage_hooks,
    x::query::ClassName,
    x11rb::RustConn,
    Result,
};
use std::collections::HashMap;
use tracing_subscriber::prelude::*;

fn main() -> Result<()> {
    let tracing_builder = tracing_subscriber::fmt()
        .with_env_filter("info")
        .with_filter_reloading();

    let reload_handle = tracing_builder.reload_handle();
    tracing_builder.finish().init();

    let startup_hook = SpawnOnStartup::boxed("xset r rate 300 50");

    let manage_hook = manage_hooks![
        ClassName("brave") => SetWorkspace("2"),
        ClassName("thunderbird") => SetWorkspace("3"),
    ];

    let layout_hook = SpacingHook {
        inner_px: INNER_PX,
        outer_px: OUTER_PX,
        top_px: BAR_HEIGHT_PX,
        bottom_px: 0,
    };

    let config = add_ewmh_hooks(Config {
        default_layouts: layouts(),
        manage_hook: Some(manage_hook),
        startup_hook: Some(startup_hook),
        layout_hook: Some(Box::new(layout_hook)),
        ..Config::default()
    });

    let conn = RustConn::new()?;
    let raw_bindings = raw_key_bindings(reload_handle);
    let key_bindings = parse_keybindings_with_xmodmap(raw_bindings)?;
    let wm = WindowManager::new(config, key_bindings, HashMap::new(), conn)?;

    let bar = status_bar().expect("Cannot setup status bar");
    let wm = bar.add_to(wm);

    wm.run()
}
