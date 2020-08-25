import click
import logging
# from test.source.run import main as source_main
# from test.preprocess.run import main as preprocess_main
# from test.model.train_eval import main as train_main
# from test.model.predict import main as predict_main

def source():
    print('Ran source!')

def test():
    print('Ran test!')

def train():
    print('Ran train!')

tasks = {
    "source": source,
    "test": test,
    "train": train
    }
# logger = logging.getLogger(__name__)


def main(task):
    try:
        tasks[task]()
    except:
        logger.error(f"Task {task} failed")
        raise


@click.command()
@click.option(
    "--task",
    type=click.Choice(tasks.keys()),
    required=True,
    help="Name of task to execute",
)
def main_cli(task):
    main(task)
