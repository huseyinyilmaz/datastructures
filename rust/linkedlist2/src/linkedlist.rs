use std::rc::Rc;

#[derive(Debug, Eq, PartialEq)]
pub enum LinkedList<T> {
    Empty,
    Node {
        value: T,
        next: Option<Rc<LinkedList<T>>>
    }
}

impl<T> LinkedList<T> {
    pub fn new() -> Self {
        Self::Empty
    }

    pub fn add(self, value: T) -> Self {
        Self::Node {
            value: value,
            next: Some(Rc::new(self)),
        }
    }

    pub fn head(&self) -> Option<&T> {
        match self {
            Self::Empty => None,
            Self::Node{ value , ..} => Some(&value),
        }
    }
}

impl<T> Drop for LinkedList<T> {
    fn drop(&mut self) {
        let mut root = Some(Rc::new(self));
        while let Some(node) = root {
            if let Ok(LinkedList::Node{next, ..}) = Rc::try_unwrap(node) {
                root = next.take();
            } else {
                break;
            }
        }
    }
}


mod test {
    use super::LinkedList;

    #[test]
    fn new() {
        let list: LinkedList<i32> = LinkedList::new();
        assert_eq!(list, LinkedList::Empty);
    }

    #[test]
    fn head() {
        let mut list = LinkedList::new();
        for i in 0..10 {
            list = list.add(i);
        }
        assert_eq!(list.head(), Some(&9));
    }


    #[test]
    fn long_list() {
        let mut list = LinkedList::new();
        for i in 0..100000 {
            list = list.add(i);
        }
    }

}
