# mcedit-syntax-env
This repository contains a configuration file, that can be used to syntax
highlight ENV (.env) expressions in `mcedit`, the editor that comes with [Midnight Commander](https://midnight-commander.org).

## Installation
### Manually
You need to register new file type in your `Syntax` file, by adding following lines before `unknown` file `/usr/share/mc/syntax/Syntax` 

Insert text:

```
file ..\*\\.env$ ENV\sFile
include sh.syntax
```

#### b) User-specific configuration, ` ~/.config/mc/mcedit`

```bash
$ mkdir -p  ~/.config/mc/mcedit
```

You need to register new file type in your `Syntax` file.

Copy a global file `Syntax`

```bash
$ cp /usr/share/mc/syntax/Syntax ~/.config/mc/mcedit
$ chmod 644 ~/.config/mc/mcedit/Syntax
```

Insert text before the block `unknown`. Replace <user> with your user name.

```
file ..\*\\.env$ ENV\sFile
include sh.syntax
```

### Using a script
To install, run the script

```bash
$ sudo ./mc_syntax-install_global.sh
$ #OR
$ ./mc_syntax-install_user.sh
```

Now the syntax highlighting should work

# Preview
![2023-11-16_13-35-57](https://github.com/neosy/mcedit-syntax-env/assets/105918329/5c253801-47b9-4010-a853-f5d5f7eadba7)

# Other
If you want to get default black background color, edit `$HOME/.config/mc/ini` and change `basecolor` to

    base_color=editnormal=default,black:editwhitespace=default,red

## License
The contents of this package uses the same license as Midnight Commander, the [GPLv2](https://www.gnu.org/licenses/gpl-2.0.en.html) or higher.
