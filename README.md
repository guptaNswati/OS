**Simple OS**
--------------

Why?
-----

I have been always curious about how a computer works behind the scenes. Nothing could satisfy this curiosity than to learning about OS, the soul of the computer. From resource management, memory management, process management to security OS does everything to make the computer smart and efficient to use. But knowing something as simple as how an OS is loaded in memory is empowering. I got the perfect opportunity of learning about it via my end of year project at Holberton School. 

There are really good tutorials on web and in minutes you can have a simple boot loader and a kernel. Most of the code is from [cfenollosa's tutorial](https://github.com/cfenollosa/os-tutorial) and from [this doc](http://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf) with minor adaptations. 

Pre-requisites
--------------
- nasm
- qemu
- bin-utils
- cross-compiled gcc
- floppy disk image to run on vm from [mikeos](http://mikeos.sourceforge.net/write-your-own-os.html)
- genisoimage 
 
Process
--------
- Bootsector
- 16 bit mode
- 32 bit mode
- Kernel
- Printing to screen

Run
----
- to run with qemu create a bin image
- to run with vm, create a floppy disk image and copy boot sector code to it.