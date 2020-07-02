use std::rc::Rc;
use std::iter::FromIterator;
use std::iter::DoubleEndedIterator;

#[derive(Debug)]
struct Node<T> {
    value: T,
    next: Option<Rc<Node<T>>>,
}

#[derive(Debug)]
pub struct LinkedList<T> {
    root: Option<Rc<Node<T>>>
}

impl<T> LinkedList<T> {
    pub fn new() -> Self {
        LinkedList {
            root: None
        }
    }

    pub fn add(&mut self, value: T) -> Self {
        LinkedList {
            root: Some(Rc::new(Node {
                value: value,
                next: self.root.as_ref().map(|rc| rc.clone()),
            }
            ))
        }
    }

    pub fn head(&self) -> Option<&T> {
        self.root.as_ref().map(|node|&node.value)
    }

    pub fn tail(&self) -> Option<LinkedList<T>> {
        self.root.as_ref().map(|root| {
            LinkedList{
                root: root.next.clone()
            }
        })
    }
}


impl<T> FromIterator<T> for LinkedList<T> {
    // fn from_iter<I: IntoIterator<Item=T>>(iter: I) -> Self {
    fn from_iter<I: IntoIterator<Item=T>>(iter: I) -> Self {
        // we put everything in a vector so we can use rfold.
        // rfold is on DoubleEndedIterator
        Vec::from_iter(iter).into_iter().rfold(Self::new(), |mut acc, v| acc.add(v))
    }
}

impl<T> IntoIterator for LinkedList<T> {
    type Item = T;
    type IntoIter = std::vec::IntoIter<T>;

    // fn from_iter<I: IntoIterator<Item=T>>(iter: I) -> Self {
    fn into_iter(self) -> Self::IntoIter {
        // we put everything in a vector so we can use rfold.
        // rfold is on DoubleEndedIterator
        Vec::from(self).into_iter()
    }
}


// impl<T> From<Vec<T>> for LinkedList<T> {

//     fn from(vec: Vec<T>) -> Self {

//     }
// }


impl<T> From<LinkedList<T>> for Vec<T> {

    fn from(mut list: LinkedList<T>) ->  Vec<T> {
        let mut result = Vec::new();
        let mut root = list.root.take();
        while let Some(node) = root {
            if let Ok(mut node) = Rc::try_unwrap(node) {
                result.push(node.value);
                root = node.next.take();
            } else {
                break;
            }
        }
        result
    }
}

impl<T> Drop for LinkedList<T> {
    fn drop(&mut self) {
        let mut root = self.root.take();
        while let Some(node) = root {
            if let Ok(mut node) = Rc::try_unwrap(node) {
                root = node.next.take();
            } else {
                break;
            }
        }
    }
}

mod test {
    use super::LinkedList;
    use std::iter::FromIterator;

    #[test]
    fn head() {
        let list: LinkedList<i32> = LinkedList::from_iter((0..100).into_iter());
        // println!("{:?}", list);
        assert_eq!(list.head(), Some(&0));
    }

    #[test]
    fn tail() {
        let list: LinkedList<i32> = LinkedList::from_iter((0..100).into_iter());
        // println!("{:?}", list);
        assert_eq!(list.tail().unwrap().head(), Some(&1));
    }

    #[test]
    fn drop_test_big_list() {
        LinkedList::from_iter((0..100000).into_iter());
    }

    #[test]
    fn from_vec() {
        let list = Vec::from(LinkedList::from_iter((0..3).into_iter()));
        let target = vec![0, 1, 2];
        assert_eq!(list, target);
    }

    #[test]
    fn into_iter() {
        let mut result = Vec::new();
        let list = LinkedList::from_iter((0..3).into_iter());
        // for loop using into_iter();
        for i in  list.into_iter() {
            result.push(i);
        }
        assert_eq!(result, vec![0, 1, 2]);
    }

}
