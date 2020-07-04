use std::rc::Rc;

struct Node<T> {
    left: Option<Rc<Node<T>>>,
    value: T,
    right: Option<Rc<Node<T>>>,
}

struct Tree<T> {
    root: Option<Rc<Node<T>>>,
}

impl<T> Tree<T> {
    pub fn new() -> Self {
        Tree{ root: None }
    }
}

mod test {
    use super::Tree;
    // use std::iter::FromIterator;

    #[test]
    fn get_root() {
    }
}
