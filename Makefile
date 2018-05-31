boot.bin:boot.S boot.inc
	nasm -o $@ $?
dd:
	dd if=boot.bin of=/home/wenix/bin/bochs/test.img bs=512 count=1 conv=notrunc
clean:
	rm boot.bin
