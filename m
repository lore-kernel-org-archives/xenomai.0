MIME-Version: 1.0
Date: Sun, 22 Nov 2009 11:35:51 -0800
Message-ID: <4bed572e0911221135s64fc4726x1cd7235f116e11a4@domain.hid>
From: Ettore Pedretti <epedrett@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Help on analogy_ni_pcimio (Alexis Berlemont?)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I downloaded Xenomai 2.5-rc4 from the xenomai-head.git. I need to use
the comedi drivers for Xenomai for a NI PCI-6711 function generator
board.

When I try to use the test program cmd_write (or cmd-read) I obtain
the following:

fangorn:~# cmd_write -vcmd_write: device analogy0 opened (fd=0)
cmd_write: basic descriptor retrieved
	 subdevices count = 0
	 read subdevice index = 0
	 write subdevice index = 0
cmd_write: a4l_get_desc failed (ret=-22)
*** glibc detected *** cmd_write: free(): invalid next size (fast):
0x0804d008 ***
======= Backtrace: =========
/lib/i686/cmov/libc.so.6[0xb7e52624]
/lib/i686/cmov/libc.so.6(cfree+0x96)[0xb7e54826]
cmd_write[0x804927c]
/lib/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0xb7dfa455]
cmd_write[0x8048b01]
======= Memory map: ========
08048000-0804a000 r-xp 00000000 08:01 10855303   /usr/bin/cmd_write
0804a000-0804b000 rw-p 00002000 08:01 10855303   /usr/bin/cmd_write
0804b000-0806e000 rw-p 00000000 00:00 0          [heap]
b7c00000-b7c21000 rw-p 00000000 00:00 0
b7c21000-b7d00000 ---p 00000000 00:00 0
b7dce000-b7dda000 r-xp 00000000 08:01 6127619    /lib/libgcc_s.so.1
b7dda000-b7ddb000 rw-p 0000b000 08:01 6127619    /lib/libgcc_s.so.1
b7de0000-b7de3000 rw-s 00000000 00:0b 426        /dev/rtheap
b7de3000-b7de4000 rw-p 00000000 00:00 0
b7de4000-b7f39000 r-xp 00000000 08:01 6144250    /lib/i686/cmov/libc-2.7.so
b7f39000-b7f3a000 r--p 00155000 08:01 6144250    /lib/i686/cmov/libc-2.7.so
b7f3a000-b7f3c000 rw-p 00156000 08:01 6144250    /lib/i686/cmov/libc-2.7.so
b7f3c000-b7f3f000 rw-p 00000000 00:00 0
b7f3f000-b7f54000 r-xp 00000000 08:01 6144264
/lib/i686/cmov/libpthread-2.7.so
b7f54000-b7f56000 rw-p 00014000 08:01 6144264
/lib/i686/cmov/libpthread-2.7.so
b7f56000-b7f58000 rw-p 00000000 00:00 0
b7f58000-b7f5a000 r-xp 00000000 08:01 10808118   /usr/lib/librtdm.so.1.0.0
b7f5a000-b7f5b000 rw-p 00001000 08:01 10808118   /usr/lib/librtdm.so.1.0.0
b7f5b000-b7f5c000 rw-p 00000000 00:00 0
b7f5c000-b7f63000 r-xp 00000000 08:01 10808119   /usr/lib/libnative.so.3.0.0
b7f63000-b7f64000 rw-p 00006000 08:01 10808119   /usr/lib/libnative.so.3.0.0
b7f64000-b7f67000 r-xp 00000000 08:01 10808112   /usr/lib/libanalogy.so.1.0.0
b7f67000-b7f68000 rw-p 00002000 08:01 10808112   /usr/lib/libanalogy.so.1.0.0
b7f69000-b7f6a000 rw-p 00000000 00:00 0
b7f6a000-b7f6d000 rw-s 00000000 00:0b 426        /dev/rtheap
b7f6d000-b7f6f000 rw-p 00000000 00:00 0
b7f6f000-b7f89000 r-xp 00000000 08:01 6127618    /lib/ld-2.7.so
b7f89000-b7f8b000 rw-p 0001a000 08:01 6127618    /lib/ld-2.7.so
bfab1000-bfac6000 rw-p 00000000 00:00 0          [stack]
ffffe000-fffff000 r-xp 00000000 00:00 0          [vdso]
Aborted

This is probably because the device /dev/analogy0 does not exist.

This is the output of uname -a

Linux fangorn 2.6.31.1 #1 SMP PREEMPT Fri Nov 20 20:42:26 PST 2009
i686 GNU/Linux

And these are the relevant entries in dmesg

dmesg:

I-pipe 2.4-06: pipeline enabled.
I-pipe: Domain Xenomai registered.

Xenomai: hal/i386 started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.5-rc4 (Flying In A Blue Dream) loaded.
Xenomai: SMI-enabled chipset found
Xenomai: SMI workaround enabled
Xenomai: starting RTDM services.
Xenomai: starting native API services.
Analogy: MITE: Available NI device IDs: 0x1880

result of lspci for the relevant board:

04:01.0 Class ff00: National Instruments PCI-6711

And lsmod:

Module                  Size  Used by
xeno_native           105088  0
analogy_ni_pcimio      15644  0
analogy_ni_mio         44860  1 analogy_ni_pcimio
analogy_ni_tio         24956  1 analogy_ni_mio
analogy_8255            3900  1 analogy_ni_mio
analogy_ni_mite        10140  3 analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio
xeno_analogy           40220  5
analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio,analogy_8255,analogy_ni_mite
xeno_rtdm              28436  2 analogy_ni_mio,xeno_analogy
astropci               10944  0
ext3                  109636  1
jbd                    43920  1 ext3
mbcache                 6272  1 ext3
ide_pci_generic         3712  0
ide_core               74204  1 ide_pci_generic
ata_piix               15748  2
sata_mv                26448  0
e1000                 114208  0
libata                142156  2 ata_piix,sata_mv
unix                   22992  10


According to this post:
http://www.mail-archive.com/xenomai@xenomai.org

>The analogy driver "a4l_pcimio" will be registered with your last
>insmod (analogy_ni_pcimio). You can check that by typing "cat
>/proc/analogy/drivers", you will see only one entry: a4l_pcimio.

fangorn:~# cat /proc/analogy/drivers
--  Analogy drivers --

| idx | driver name
|  00 | analogy_ni_pcimio
|  01 | analogy_8255

There are two entries and the drivers are not attached:

fangorn:~# cat /proc/analogy/devices
--  Analogy devices --

| idx | status | driver
|  00 | Unused | No driver
|  01 | Unused | No driver
|  02 | Unused | No driver
|  03 | Unused | No driver
|  04 | Unused | No driver
|  05 | Unused | No driver
|  06 | Unused | No driver
|  07 | Unused | No driver
|  08 | Unused | No driver
|  09 | Unused | No driver

I'm aware of the name change of the drivers:
http://www.mail-archive.com/xenomai-git@xenomai.org

>- a4l_pcimio becomes analogy_ni_pcimio
>- 8255 becomes analogy_8255.
>Consequently, the command line to attach these drivers has
>changed. Starting from now, we have to type:
>- analogy_config analogyX analogy_ni_pcimio (instead of a4l_pcimio)

This is what happens when I try to attach the driver to de device:

fangorn:~# analogy_config analogy0 analogy_ni_pcimio

Message from syslogd@domain.hid at Nov 21 23:22:37 ...
 kernel:Oops: 0000 [#1] PREEMPT SMP

Message from syslogd@domain.hid at Nov 21 23:22:37 ...
 kernel:last sysfs file: /sys/devices/pci0000:00/0000:00:1e.0/0000:06:02.0/class

Message from syslogd@domain.hid at Nov 21 23:22:37 ...
 kernel:Process analogy_config (pid: 3409, ti=f64cc000 task=f79013b0
task.ti=f64cc000)

Message from syslogd@domain.hid at Nov 21 23:22:37 ...
 kernel:I-pipe domain Linux

Message from syslogd@domain.hid at Nov 21 23:22:37 ...
 kernel:Stack:

Message from syslogd@domain.hid at Nov 21 23:22:37 ...
 kernel:Call Trace:

Message from syslogd@domain.hid at Nov 21 23:22:37 ...
 kernel:Code: 8b 45 9c e8 f2 f1 fa ff 89 c2 83 f8 01 0f 85 d4 fe ff ff
8b 55 9c 8b 82 74 01 00 00 8b 00 f6 40 3c 06 0f 84 22 01 00 00 8b 42
18 <8b> 40 04 89 45 b0 8b 40 14 8b 40 04 85 c0 0f 84 0b 01 00 00 31

Message from syslogd@domain.hid at Nov 21 23:22:37 ...
 kernel:EIP: [<f8c7d029>] ni_E_init+0x267/0xff1 [analogy_ni_mio]
SS:ESP 0068:f64cddc8

Message from syslogd@domain.hid at Nov 21 23:22:37 ...
 kernel:CR2: 0000000000000004


relevant dmeg:

a4l: analogy_ni_pcimio: pcimio_attach: found pci-6711 board
mite 0000:04:01.0: PCI->APIC IRQ transform: INT A -> IRQ 48
mite 0000:04:01.0: setting latency timer to 64
a4l: MITE: 0xd0801000 mapped to f8e26000
a4l: DAQ: 0xd0800000 mapped to f8e2a000
a4l: MITE: version = 1, type = 1, mite mode = 1, interface mode = 3
a4l: MITE: num channels = 3, write post fifo depth = 1, wins = 0, iowins = 2
a4l: analogy_ni_pcimio: pcimio_attach: found irq 48
BUG: unable to handle kernel NULL pointer dereference at 00000004
IP: [<f8c7d029>] ni_E_init+0x267/0xff1 [analogy_ni_mio]
*pde = 00000000
Oops: 0000 [#1] PREEMPT SMP
last sysfs file: /sys/devices/pci0000:00/0000:00:1e.0/0000:06:02.0/class
Modules linked in: xeno_native analogy_ni_pcimio analogy_ni_mio
analogy_ni_tio analogy_8255 analogy_ni_mite xeno_analogy xeno_rtdm
astropci ext3 jbd mbcache ide_pci_generic ide_core ata_piix sata_mv
e1000 libata unix [last unloaded: scsi_wait_scan]

Pid: 3409, comm: analogy_config Not tainted (2.6.31.1 #1) X6DA8
EIP: 0060:[<f8c7d029>] EFLAGS: 00010202 CPU: 1
EIP is at ni_E_init+0x267/0xff1 [analogy_ni_mio]
EAX: 00000000 EBX: f8a22280 ECX: f8c31e6c EDX: f8c31e60
ESI: 00000000 EDI: f8c31e60 EBP: f64cde38 ESP: f64cddc8
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process analogy_config (pid: 3409, ti=f64cc000 task=f79013b0 task.ti=f64cc000)
I-pipe domain Linux
Stack:
 f64cddd0 c10142b6 f64cddd8 f8c31e60 f64cdde0 c105abf7 f64cddfc f8a0ea5d
<0> f8c2be00 00000000 00000001 f8c31e94 fffffff0 f64cde14 f8c2c118 00000001
<0> f8c2ed0d f8c31e88 f8c31e60 f64cde38 f8c2cccf 00000001 f8c31e60 00000030
Call Trace:
 [<c10142b6>] ? unmask_IO_APIC_irq+0xd/0xf
 [<c105abf7>] ? xnintr_enable+0xb/0xd
 [<f8a0ea5d>] ? rtdm_irq_request+0x48/0x5e [xeno_rtdm]
 [<f8c2be00>] ? a4l_handle_irq+0x0/0x1a [xeno_analogy]
 [<f8c2c118>] ? __a4l_request_irq+0x33/0x39 [xeno_analogy]
 [<f8c2cccf>] ? a4l_request_irq+0x98/0xaf [xeno_analogy]
 [<f8c8bd8a>] ? pcimio_attach+0x54d/0x664 [analogy_ni_pcimio]
 [<f8c2afef>] ? a4l_assign_driver+0x61/0x134 [xeno_analogy]
 [<f8c2b2ba>] ? a4l_device_attach+0x54/0x6d [xeno_analogy]
 [<c10662ea>] ? xnshadow_ppd_get+0x4f/0x58
 [<f8c2b54f>] ? a4l_ioctl_devcfg+0x57/0x104 [xeno_analogy]
 [<f8c2d36f>] ? a4l_rt_ioctl+0x33/0x3a [xeno_analogy]
 [<f8a0d3e6>] ? __rt_dev_ioctl+0xd1/0xd8 [xeno_rtdm]
 [<f8a0fe77>] ? sys_rtdm_open+0x5c/0x64 [xeno_rtdm]
 [<f8a0fdde>] ? sys_rtdm_ioctl+0x29/0x2b [xeno_rtdm]
 [<c10699ae>] ? losyscall_event+0xa9/0x190
 [<c10566ce>] ? __ipipe_dispatch_event+0xdf/0x201
 [<c1069905>] ? losyscall_event+0x0/0x190
 [<c10166a1>] ? __ipipe_syscall_root+0x3b/0xc4
 [<c1002cfd>] ? system_call+0x2d/0x4f
Code: 8b 45 9c e8 f2 f1 fa ff 89 c2 83 f8 01 0f 85 d4 fe ff ff 8b 55
9c 8b 82 74 01 00 00 8b 00 f6 40 3c 06 0f 84 22 01 00 00 8b 42 18 <8b>
40 04 89 45 b0 8b 40 14 8b 40 04 85 c0 0f 84 0b 01 00 00 31
EIP: [<f8c7d029>] ni_E_init+0x267/0xff1 [analogy_ni_mio] SS:ESP 0068:f64cddc8
CR2: 0000000000000004
---[ end trace c887d49bb5e86cf4 ]---

Can anyone help?

Best regards
Ettore Pedretti

