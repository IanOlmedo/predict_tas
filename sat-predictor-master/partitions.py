from itertools import product
from pathlib import Path
import pickle
import numpy as np
import pandas as pd
from IPython import embed
from config import partitions, nominal_path, random_seed
from utils import make_partitions
from tqdm import tqdm


def main(args):

    for partition in partitions:
        df_nom = pd.read_csv(nominal_path, index_col=[0, 1])
        df_nom = df_nom[df_nom.index.get_level_values(0).isin(
            partition['años'])].copy()

        partidx = make_partitions(df_nom,
                                  partition['proportions'],
                                  partition['stratify_columns'],
                                  partition['independent_columns'],
                                  random_seed=random_seed)

        output = Path('partitions_datosfinal/partitions_{}.pkl'.format(
            partition['name']))
        with open(output, 'wb') as f:
            pickle.dump(partidx, f)


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description='Partitions')
    args = parser.parse_args()

    main(args)
