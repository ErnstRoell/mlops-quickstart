from setuptools import setup

with open("README.md", encoding='utf-8') as f:
    long_description = f.read()

with open("requirements.txt") as f:
    required = f.read().splitlines()

setup(
    name="mlops",
    version="1.0",
    packages=["mlops"],
    long_description=long_description,
    long_description_content_type='text/markdown',
    install_requires=required,
    entry_points = {
            'console_scripts': ['mlops=mlops.run:main_cli'],
        }
)
