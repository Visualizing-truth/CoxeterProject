
load("classification2.sage")
import pickle
from multiprocessing import Pool, cpu_count
from tqdm import tqdm

def get_lvl5_n_from_keys(lvl5_n):
    for k in lvl5_n:
        g=get_graph_from_key(k)
        yield g


def check_level(g):
    if not level_bound(coxeter_matrix_from_graph(g), -1, 5):
        return get_graph_key(g)
    return None

def filtering_nxt_rank(nxt_rank, total):
    lvl5_6=set()
    with Pool(4) as pool:
        for key in tqdm(
            pool.imap_unordered(check_level, nxt_rank, chunksize=2000),
            total=int(total),
            desc="Filtering Level 5",
            unit="graphs"):
            if key is not None:
                lvl5_6.add(key)
    return lvl5_6
    save(lvl5_6, "lvl5_6.sobj")


def norm_filter(nxt_rank, total):
    lvl5_n = set()
    for g in tqdm(
        nxt_rank,
        total=int(total),
        desc="Filtering Level 5",
        unit="graphs"
    ):
        if not level_bound(coxeter_matrix_from_graph(g), -1, 5):
            lvl5_n.add(get_graph_key(g))
    return lvl5_n

def continue_classify(lvl5_i, seenSoFar):
    lvl5_n=lvl5_i
    seen=seenSoFar
    count=1
    while len(lvl5_n)!=0:
        lvl5_n_g=get_lvl5_n_from_keys(lvl5_n)
        initial_lvl5_n=set()
        nxt_rank=get_next_label_rank(lvl5_n_g)
        print(f"Processing lvl5_{13+count}")
        for g in tqdm(nxt_rank, total=len(nxt_rank), desc= "Finishing classifcation for level 5", unit='graphs'):
            if not level_bound(coxeter_matrix_from_graph(g), -1, 5):
                initial_lvl5_n.add(get_graph_key(g))
        lvl5_n=set()
        for k in initial_lvl5_n:
            if k not in seen:
                lvl5_n.add(k)
        seen.update(lvl5_n)
        save(lvl5_n, f"lvl5_{13+count}.sobj")
        count+=1
    return seen




