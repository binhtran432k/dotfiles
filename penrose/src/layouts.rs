use penrose::{
    builtin::layout::{MainAndStack, Monocle},
    core::layout::LayoutStack,
    stack,
};

use crate::{MAX_MAIN, RATIO, RATIO_STEP};

pub fn layouts() -> LayoutStack {
    stack!(
        MainAndStack::side(MAX_MAIN, RATIO, RATIO_STEP),
        Monocle::boxed()
    )
}
