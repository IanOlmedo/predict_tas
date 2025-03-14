import argparse
import os
from nbconvert.preprocessors import ExecutePreprocessor
import nbformat
from traitlets.config import Config
from nbconvert import HTMLExporter


def main(args):

    c = Config()
    c.TemplateExporter.exclude_input_prompt = True
    c.TemplateExporter.exclude_input = True
    c.TemplateExporter.exclude_output_prompt = True

    html_exporter = HTMLExporter(config=c)

    os.environ["PREDICT_PATH"] = args.predict
    os.environ["JOIN_PATH"] = args.join
    output_dir = args.output_dir

    with open("visualization/visualization.ipynb", encoding='utf-8') as f:
        nb = nbformat.read(f, as_version=4)

    ep = ExecutePreprocessor(kernel_name="python3")

    print('Creando visualización')
    ep.preprocess(nb)

    (body, resources) = html_exporter.from_notebook_node(nb)

    print('Salva html')
    with open(f"{output_dir}/visualizations.html", "w", encoding='utf-8') as f:
        f.write(body)


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="Visualizations")

    parser.add_argument("--join", default=None)
    parser.add_argument("--predict", default=None)
    parser.add_argument("--output_dir", default=".")
    args = parser.parse_args()

    main(args)
