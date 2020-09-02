#!/usr/bin/env python
import click
import logging
import subprocess
import os
dirname = os.path.dirname(__file__)

def run_cmd(cmd):
    print('b')
    popen = subprocess.Popen(cmd,stdout=subprocess.PIPE, text=True)
    for line in iter(popen.stdout.readline,""):
        yield line
    popen.stdout.close()
    return_code=popen.wait()
    if return_code:
        subprocess.CalledProcessError(return_code,cmd)

def execute(cmd):
    popen = subprocess.Popen(cmd,stdout=subprocess.PIPE, text=True)
    for line in iter(popen.stdout.readline,""):
        yield line
    popen.stdout.close()
    return_code=popen.wait()
    if return_code:
        subprocess.CalledProcessError(return_code,cmd)

def run_script(cmd):
    for el in execute(cmd):
        print(el,end='')


@click.command()
@click.option(
    "--suffix",
    type=int,
    help="Id to append to make resource names unique",
)
def new(suffix):
    if not suffix:
        suffix=7381

    scriptname = os.path.join(dirname, 'scripts/0_Install.sh')
    run_script(["bash",scriptname,dirname,str(suffix)])


@click.group()
def main_cli():
    pass

main_cli.add_command(new)

