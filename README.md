![RuTui Logo](http://i.imgur.com/cu0yNM3.png "RuTui Logo")

# RuTui

RuTui is a lightweight, pure ruby alternative to known command line interfaces like nCurses. Most CLI/TUI Frameworks sit on an C like approach, are very limited or are just not beautiful enough to use. This lib aims to be different, to be easy, modular and just Ruby like to handle. There is built-in color support and input control which sits on top of Unix standards.

[**Take a look at the wiki**](https://github.com/b1nary/rutui/wiki)

## Features

-  Fully text based interfaces
-  No dependencies (except ruby)
-  255 Colors (at least in Unix)
-  FIGlet font support
-  Own dynamic image format
-  Sprites (with animation)
-  Basic theming
-  Prebuild Elements to draw
-  Tables
-  ...

You can use this in many different application purposes. You can create simple CLIs for your scripts, you can make awesome ASCII based data visualizations. Its also basically a small game engine.

## Installation

``` bash
sudo gem install rutui
```

If you are on windows please take a look at [Ansicon](https://github.com/adoxa/ansicon).

## Todo

* Test on windows/mac
* "Radio" object_
* "Selectbox" object_

## Changelog

* 0.7.2
  * Push version number because rubygems already took 7.1
* 0.7.1
  * Merge [pull request](https://github.com/b1nary/rutui/pull/6) by @lmc (improve draw performance by a lot!)
* 0.7
  * Merge [pull request](https://github.com/b1nary/rutui/pull/1) from @jaydg
* 0.6
  * Fixing transparency on multiple objects
  * Removing a flicker from slower devices
  * Fixing figlet problems
  * Added text style options (bold/italic/...)
  * Added multiline text support
  * Add focus pixel to textfield
  * Added "Checkbox" object
* 0.5
  * Fixed refactoring bugs
  * Added "Dot" object
  * Add color inheritance (trough -1) to objects
  * Added Timeout for Screenmanager for a minimal time per operation
* 0.4
  * Refactor structure
  * better printing (much less flicker)
  * New objects: [Tables](https://github.com/b1nary/rutui/wiki/Tables), [Textfields](https://github.com/b1nary/rutui/wiki/Textfields)
  * Adding cmd.exe support (colors only trough [Ansicon](https://github.com/adoxa/ansicon))
* 0.3
  * Fixes, fixes, fixes
* 0.2 (beta)
  * Rolling updates
* 0.1 (alpha)
  * Rolling updates

## License
This Project is licensed under the [MIT License](http://de.wikipedia.org/wiki/MIT-Lizenz)

> Copyright (c) 2012 Roman Pramberger
> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
