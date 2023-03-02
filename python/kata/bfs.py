import unittest

Start = End = str
Weight = int
RawEdge = tuple[Start, End, Weight]


def bfs(raw_edges: list[RawEdge], start: Start, end: End) -> tuple[list[str], int]:
    # implement breadth first search here.
    return [], 0


class BFSTests(unittest.TestCase):
    def test_01(self):
        edges: list[RawEdge] = [
            ("A", "B", 5),
            ("A", "D", 5),
            ("B", "C", 8),
            ("B", "D", 9),
            ("B", "E", 7),
            ("C", "E", 5),
            ("D", "E", 15),
            ("D", "F", 6),
            ("E", "F", 8),
            ("E", "G", 9),
            ("F", "G", 11),
        ]
        result = bfs(edges, "A", "G")
        expected = (["A", "B", "E", "G"], 21)
        self.assertEqual(result, expected)

    def test_02(self):
        edges: list[RawEdge] = [
            ("A", "B", 5),
            ("A", "D", 5),
            ("B", "C", 8),
            ("B", "D", 9),
            ("B", "E", 7),
            ("C", "E", 5),
            ("D", "E", 15),
            ("D", "F", 6),
            ("E", "F", 8),
            ("E", "G", 9),
            ("F", "G", 11),
        ]
        result = bfs(edges, "F", "G")
        expected = (
            [
                "F",
                "G",
            ],
            11,
        )
        self.assertEqual(result, expected)


if __name__ == "__main__":
    unittest.main()
