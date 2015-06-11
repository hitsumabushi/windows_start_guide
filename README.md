# windows_start_guide

[![Build Status](https://drone.io/github.com/hitsumabushi/windows_start_guide/status.png)](https://drone.io/github.com/hitsumabushi/windows_start_guide/latest)

Markdown -> reStructuredText への変換は、[mistymagich/sphinx-markdown](https://github.com/mistymagich/sphinx-markdown)。

## How To Build

### Requirements
- Pandoc >= 1.14.0
- Python 3.x
- Sphinx >= 1.3.x

### Build
```sh
pip install -r requirements.txt --use-mirrors
make html
```
