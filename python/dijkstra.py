from typing import List
from typing import Tuple
from collections import defaultdict
import heapq

Start = End = str
Weight = int
RawEdge = Tuple[Start, End, Weight]


def dijkstra(raw_edges: List[RawEdge], start: Start, end: End):
    __import__('ipdb').set_trace()
    # create start -> [(weight, end)] mappings.
    edges = defaultdict(list)
    for s, e, w in raw_edges:
        edges[s].append((w, e))
    print(f"Edges = {edges}")
    seen = set()
    prev = {}
    frontier = [(0, start)]
    while frontier:
        (weight, edge) = heapq.heappop(frontier)
        if edge not in seen:
            seen.add(edge)
            for w, v in edges[edge]:
                if v not in seen:
                    heapq.heappush(frontier, (weight + w, v))
        print(f'seen = {seen}')
        print(f'frontier = {frontier}')


if __name__ == "__main__":
    edges = [
        ("A", "B", 7),
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
    print("A -> E:")
    print(dijkstra(edges, "A", "E"))
    '''
    print("F -> G:")
    print(dijkstra(edges, "F", "G"))
    '''
