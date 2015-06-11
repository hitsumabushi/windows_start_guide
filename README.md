# Windows Server 2012 R2 入門ガイド

[![Build Status](https://drone.io/github.com/hitsumabushi/windows_start_guide/status.png)](https://drone.io/github.com/hitsumabushi/windows_start_guide/latest)

## How To Build
Markdown -> reStructuredText への変換は、[mistymagich/sphinx-markdown](https://github.com/mistymagich/sphinx-markdown)。

### Requirements
- Python 3.x
- Sphinx >= 1.3.x
- Pandoc >= 1.14.0

### Build
```sh
pip install -r requirements.txt --use-mirrors
make html
```
