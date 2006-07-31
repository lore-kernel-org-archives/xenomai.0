Subject: Re: [Xenomai-core] Xenomai on PXA
From: Bart Jonkers <jonkersbart@domain.hid>
In-Reply-To: <44CDCB61.2DEDCBFF@vollmann.ch>
References: <200607071703.10700.vagninu@domain.hid>
	<17582.50372.830923.414981@domain.hid>
	<44B34343.9F56F13@domain.hid>
	<17595.47131.142881.132531@domain.hid>
	<1153153788.11603.2.camel@domain.hid>
	<17595.49478.157044.654500@domain.hid>
	<1154334859.9569.12.camel@domain.hid>
	<44CDCB61.2DEDCBFF@vollmann.ch>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 12:33:49 +0200
Message-Id: <1154342029.9569.27.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Detlef Vollmann <dv@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-07-31 at 11:20 +0200, Detlef Vollmann wrote:
> Hello,
> 
> Bart Jonkers wrote:
> > When I boot the kernel with ipipe enabled, linux receives no interrupts
> > anymore. Any idea to solve this?
> What are the symtomps?
This is what i see when the kernel boots:
Starting kernel ...

Uncompressing
Linux...................................................................................... done, booting the kernel.
Linux version 2.6.16 (bart@domain.hid) (gcc version 3.4.2) #7 Mon Jul 31
11:46:19 CEST 2006
CPU: XScale-PXA255 [69052d06] revision 6 (ARMv5TE)
Machine: Philips Xsilo Development Platform (aka Jobo Giga Vu Pro)
Memory policy: ECC disabled, Data cache writeback
Memory clock: 99.53MHz (*27)
Run Mode clock: 199.07MHz (*2)
Turbo Mode clock: 199.07MHz (*1.0, inactive)
CPU0: D VIVT undefined 5 cache
CPU0: I cache: 32768 bytes, associativity 32, 32 byte lines, 32 sets
CPU0: D cache: 32768 bytes, associativity 32, 32 byte lines, 32 sets
Built 1 zonelists
Kernel command line: root=/dev/nfs rw ip=bootp console=ttyS0,115200
mem=64M
PID hash table entries: 512 (order: 9, 8192 bytes)
I-pipe 1.3-04: pipeline enabled.
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 64MB = 64MB total
Memory: 62080KB available (2232K code, 441K data, 88K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
NetWinder Floating Point Emulator V0.97 (double precision)
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Console: switching to colour frame buffer device 30x40
pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq = 15) is a FFUART
pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 14) is a BTUART
pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 13) is a STUART
pxa2xx-uart.3: ttyS3 at MMIO 0x41600000 (irq = 0) is a HWUART
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@domain.hid>
eth0: SMC91C11xFD (rev 1) at c4862300 IRQ 36 DMA 8 [nowait]
eth0: Ethernet addr: 08:00:3e:26:0a:53
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with
idebus=xx
hda: probing with STATUS(0x50) instead of ALTSTATUS(0x0a)
hda: IC25N040ATMR04-0, ATA DISK drive
hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x0a)
hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x0a)
ide0 at 0xfb000000-0xfb000007,0xfb000020 on irq 35
hda: max request size: 512KiB
hda: lost interrupt
hda: lost interrupt
hda: Host Protected Area detected.
        current capacity is 78140160 sectors (40007 MB)
        native  capacity is 185074430006016 sectors (94758108163 MB)
hda: lost interrupt
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
ide: failed opcode was: 0x37
hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=16383/255/63
hda: lost interrupt
hda: cache flushes supported
hda:<4>hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda1
hda: lost interrupt
Probing Xsilo flash at physical address 0x00000000 (32-bit buswidth)
xsilo-0: Found 2 x16 devices at 0x0 in 32-bit bank
Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Registering xsilo-0 as whole device
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
08:57:20 2006 UTC).
input: Touchscreen panel as /class/input/input0
ALSA device list:
  #0: pxa2xx-ac97 (Philips UCB1400)
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
eth0: link down
Sending BOOTP requests ...... timed out!
IP-Config: Reopening network devices...
eth0: link down
Sending BOOTP requests ...... timed out!
IP-Config: Reopening network devices...
eth0: link down
Sending BOOTP requests ...... timed out!
IP-Config: Reopening network devices...
eth0: link down
Sending BOOTP requests ...... timed out!
IP-Config: Reopening network devices...
eth0: link down

The interrupt for the harddisk and the network chip are GPIO interrupts.

> Are you sure you get no interrupts (incl. timer) or e.g. just no GPIO
> interrupts?

I added a kernel timer to the a driver of me witch does a printk every
10 seconds. The printk shows up so I think that Linux still gets its
timer interrupts.

I also added an interrupt handler on a button which is connected to GPIO
pin. The interrupt handler should print something when it is executed.
When I push the button a couple of times nothing happens. So GPIO
interrupts doesn't seems to work.
> 
>  Detlef
> 
> BTW, could you try not to quote the full patch next time?
Sorry, my apologies.

Bart

> 


