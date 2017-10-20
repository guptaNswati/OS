#!/bin/bash

# installs
# sudo apt-get install -y gcc genisoimage lib32gcc-4.8-dev libmpc nasm qemu 

# binutils and cross-compiled gcc for system indepedent compilation on x86 arch
#export CC=$(which gcc-4.9)
#export LD=$(which gcc-4.9)

#export PREFIX="/usr/local/i386elfgcc"
#export TARGET=i386-elf
#export PATH="$PREFIX/bin:$PATH"

# binutils
#mkdir /tmp/src && cd /tmp/src
#curl -O http://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.gz # If the link 404's, look for a more recent version
#tar xf binutils-2.24.tar.gz
#mkdir binutils-build && cd binutils-build
#../binutils-2.24/configure --target=$TARGET --enable-interwork --enable-multilib --disable-nls --disable-werror --prefix=$PREFIX 2>&1 | tee configure.log
#sudo make all install 2>&1 | tee make.log

# to deal with space errors
#SWAP=/tmp/swap
#dd if=/dev/zero of=$SWAP bs=1M count=500
#mkswap $SWAP
#sudo swapon $SWAP

# cross-compiled gcc
#cd /tmp/src
#curl -O https://ftp.gnu.org/gnu/gcc/gcc-4.9.1/gcc-4.9.1.tar.bz2
#tar xvfj gcc-4.9.1.tar.bz2
#mkdir gcc-build && cd gcc-buildc
#../gcc-4.9.1/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --disable-libssp --enable-languages=c --without-headers
#sudo make all-gcc 
#sudo make all-target-libgcc 
#sudo make install-gcc 
#sudo make install-target-libgcc 

# check GNU binutils and the compiler
# ls /usr/local/i386elfgcc/bin, prefixed by i386-elf-

# compile system independent kernel.c 
i386-elf-gcc -ffreestanding -c kernel.c -o kernel.o

# compile kernel_start
nasm kernel_start.asm -f elf -o kernel_start.o

# link both obj files to make a binary and place kernel at 0x1000 location
i386-elf-ld -o kernel.bin -Ttext 0x1000 kernel_start.o kernel.o --oformat binary

# compile bootsect
nasm bootsector.asm -f bin -o bootsector.bin

# create one kernel image joining both bin with bootsect at head
cat bootsector.bin kernel.bin > kernel-image.bin

# to run on vm, create a flp image
# directly copy kernel.bin to the first sector of the floppy disk image
# cp disk.flp 
# dd status=noxfer conv=notrunc if=kernel-image.bin of=disk.flp

# generate a CD-ROM ISO image with bootable floppy disk emulation
#mkdir cdromiso && mv disk.flp cdromiso
#mkisofs -o kernel.iso -b disk.flp cdromiso/
# boot vm from kernel.iso
#cp kernel.iso /vagrant

# run and use -curses to bypass sdl restrictions
qemu-system-i386 -curses -fda kernel-image.bin

# to exit
# alt+2, enter quit

# cleanup
rm *.bin *.o *.img *.flp *.iso
#rm -rf cdromiso
