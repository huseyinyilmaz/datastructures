from typing import List
from typing import Tuple

Start = End = str
Weight = int
RawEdge = Tuple[Start, End, Weight]


def dfs(raw_edges: List[RawEdge], start: Start, end: End):
    edges: dict[str, list[tuple[Weight, End]]] = {}
    for s, e, w in raw_edges:
        edges.setdefault(s, []).append((w, e))

    parents: dict[str, str | None] = {start: None}
    costs = {}
    frontier = [(0, start)]
    while frontier:
        next = []
        for current_weight, current_node in frontier:
            for next_weight, next_node in edges.get(current_node, []):
                if next_node not in parents:
                    parents[next_node] = current_node
                    costs[next_node] = current_weight + next_weight
                    next.append((costs[next_node], next_node))
        frontier = next
    print(f"edges = {edges}")
    print(f"parents = {parents}")
    print(f"costs = {costs}")
    path = []
    current = end
    while current:
        path.append(current)
        current = parents[current]
    path.reverse()
    return " -> ".join(path), costs[end]


if __name__ == "__main__":
    edges: List[RawEdge] = [
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
    print("=== Dijkstra ===")
    print(f"Raw edges = {edges}")
    print("=" * 80)
    print("A -> E:")
    print(dfs(edges, "A", "E"))
    print("=" * 80)
    print("F -> G:")
    print(dfs(edges, "F", "G"))
