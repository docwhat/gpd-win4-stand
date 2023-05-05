# GPD Win 4 stand

> A stand/dock for the GPD Win 4 handheld device. It can also work for other thick devices as well.

## Caveats :warning:

This is my first 3d printing project! Yay!

It has been prototyped on my wife's 3d printer (a FlashForge Finder v2).

I have not tested this on any other 3d printer, so I don't know if it will work on other printers.

## Requirements

You'll need [OpenSCAD](https://www.openscad.org/) to generate STL files from the source code.

## Usage

I work on the project using [VS Code](https://code.visualstudio.com/). I have saved the recommended settings in the `.vscode` folder.

## Updating scad-utils

The project uses the library [scad-utils](https://github.com/OskarLinde/scad-utils).

To update the library, run the following command:

```sh
git subtree pull --prefix scad-utils https://github.com/OskarLinde/scad-utils.git master --squash
```
