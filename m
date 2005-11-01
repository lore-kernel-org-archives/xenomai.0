From: Romain Lenglet <rlenglet@domain.hid>
Date: Tue, 1 Nov 2005 20:28:09 +0900
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JF1ZDeZe8SqBHkL"
Message-Id: <200511012028.09476.rlenglet@domain.hid>
Subject: [Xenomai-help] klatency problem
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

--Boundary-00=_JF1ZDeZe8SqBHkL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have problems running the klatency test on kernel 2.6.14 + 
adeos-ipipe-2.6.14-1.0-09.
The cruncher, latency and switch tests run with no problem and 
good latencies. Only klatency has problems.

When starting (./run), I get the message:
insmod: error inserting 'latency_rt.ko': -1 Unknown symbol in 
module
ERROR: cannot load latency_rt.ko

I have MODVERSIONS enabled in the kernel, but I have compiled 
everything right with the sources of the running kernel.


I was wondering if latency_rt.ko required the xeno_rtai module to 
be loaded (who knows? ;))... so I have modified the .runinfo to 
load xeno_rtai in addition to xeno_native, i.e. the line 
in .runinfo becomes:
latency:native+rtai:push latency_rt;./latency;popall:control_c
All modules load well (xeno_hal, xeno_nucleus, xeno_native and 
xeno_rtai) and the klatency test runs well!!!

However, I get errors when it terminates, when it unloads the 
modules.

In fact, xeno_rtai can be rmmoded successfully, but not 
xeno_native:
$ lsmod | grep xeno
xeno_native           129968  0
xeno_nucleus          100680  1 xeno_native
xeno_hal               28128  2 xeno_native,xeno_nucleus
$ sudo rmmod xeno_native
ERROR: Removing 'xeno_native': Device or resource busy

Every time I run rmmod xeno_native as above, it provokes a kernel 
Oops. The kernel logs are attached in rmmod-oops.txt.


And the xeno_nucleus modules seems to be in a bad shape. For 
instance:
$ cat /proc/xenomai/sched
Segmentation fault
$ cat /proc/xenomai/stat
Segmentation fault

And those two commands provoke Oops also, cf. traces in attached 
sched-oops.txt and stat-oops.txt.

Outputing the content of any other pseudo-file in /proc/xenomai 
or in /proc/ipipe works and does not provoke any oops.



BTW, this behaviour is 100% reproducible here.

-- 
Romain Lenglet

--Boundary-00=_JF1ZDeZe8SqBHkL
Content-Type: text/plain;
  charset="us-ascii";
  name="rmmod-oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rmmod-oops.txt"

Xenomai: stopping RTAI emulator.
Xenomai: stopping native API services.
Unable to handle kernel paging request at virtual address f8943400
 printing eip:
f8b89831
*pde = 018db067
*pte = 00000000
Oops: 0000 [#1]
Modules linked in: xeno_native xeno_nucleus xeno_hal ipv6 af_packet de4x5 3c59x tulip mii snd_intel8x0 snd_ac97_codec snd_ac97_bus r8169 snd_pcm snd_timer i2c_i801 snd soundcore snd_page_alloc i2c_core uhci_hcd hw_random usbcore intel_agp ide_cd parport_pc parport pci_hotplug agpgart cdrom serio_raw unix ext3 jbd mbcache ide_disk ide_generic generic piix ide_core evdev mousedev psmouse
CPU:    0
EIP:    0060:[pg0+947742769/1069855744]    Not tainted VLI
EFLAGS: 00010086   (2.6.14-1-686-ipipe) 
EIP is at rt_task_delete+0x91/0xf0 [xeno_native]
eax: 00000000   ebx: 00000000   ecx: f8943400   edx: f8b2f340
esi: 00000000   edi: 00000000   ebp: f7b5e000   esp: f7b5ff34
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 4271, threadinfo=f7b5e000 task=c1b5a560)
Stack: f8b96d20 00000000 f8ba0200 f8b8928f f8943400 00000003 f8b8903a 00000880 
       f8b8917b 00000000 c0136afc f8ba0200 00000880 f7b5ffa8 6f6e6578 74616e5f 
       00657669 c030a0a0 00000021 00000246 00000021 c030a0a0 f7b5ffbc f7b5ffbc 
Call Trace:
 [pg0+947741327/1069855744] __task_pkg_cleanup+0x1f/0x50 [xeno_native]
 [pg0+947740730/1069855744] xeno_shutdown+0x3a/0x60 [xeno_native]
 [pg0+947741051/1069855744] cleanup_module+0x1b/0x20 [xeno_native]
 [sys_delete_module+332/400] sys_delete_module+0x14c/0x190
 [sysenter_past_esp+99/103] sysenter_past_esp+0x63/0x67
Code: 85 c0 74 0d 8d 48 c0 eb 08 90 8b 5a 40 85 db 78 af 0f ba 2d 28 63 9e f8 00 19 f6 81 3d ec 57 39 c0 20 63 9e f8 74 51 85 c9 74 08 <81> 39 01 01 55 55 74 27 bb ea ff ff ff 85 f6 74 2d 0f ba 2d 28 

--Boundary-00=_JF1ZDeZe8SqBHkL
Content-Type: text/plain;
  charset="us-ascii";
  name="stat-oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="stat-oops.txt"

 <1>Unable to handle kernel paging request at virtual address f8945672
 printing eip:
f8b11c72
*pde = 018db067
*pte = 00000000
Oops: 0000 [#6]
Modules linked in: xeno_native xeno_nucleus xeno_hal ipv6 af_packet de4x5 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm parport_pc snd_timer snd soundcore snd_page_alloc parport i2c_i801 uhci_hcd i2c_core usbcore 3c59x tulip mii r8169 intel_agp agpgart hw_random pci_hotplug serio_raw ide_cd cdrom unix ext3 jbd mbcache ide_disk ide_generic generic piix ide_core evdev mousedev psmouse
CPU:    0
EIP:    0060:[pg0+947252338/1069855744]    Not tainted VLI
EFLAGS: 00010002   (2.6.14-1-686-ipipe) 
EIP is at stat_seq_open+0xe2/0x1c0 [xeno_nucleus]
eax: 00000020   ebx: 00000000   ecx: f8945440   edx: 00000001
esi: f89456a4   edi: f79a9980   ebp: 00000001   esp: f7a4bef8
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 5115, threadinfo=f7a4a000 task=f7c5f030)
Stack: c1bf0180 f8b26a4c ffffffff c1bf0180 c1b29da0 00008000 dfff3200 c0161ae4 
       c1b29da0 c1bf0180 00000000 c1bf0180 00008000 f7982000 c0161cb3 f7a72d50 
       dfff3200 00008000 c1bf0180 f7a72d50 dfff3200 4367234b 00000000 c1bd7580 
Call Trace:
 [__dentry_open+196/512] __dentry_open+0xc4/0x200
 [filp_open+147/176] filp_open+0x93/0xb0
 [get_unused_fd+91/192] get_unused_fd+0x5b/0xc0
 [do_sys_open+85/240] do_sys_open+0x55/0xf0
 [sysenter_past_esp+99/103] sysenter_past_esp+0x63/0x67
Code: 0f 44 f3 85 ed 0f 8e 9e 00 00 00 85 f6 0f 84 96 00 00 00 8b 17 31 db 8d 8e 9c fd ff ff 8d 42 01 89 07 89 d0 c1 e0 05 89 5c 38 04 <f6> 81 32 02 00 00 40 0f 85 ab 00 00 00 8b 81 10 02 00 00 85 c0 

--Boundary-00=_JF1ZDeZe8SqBHkL
Content-Type: text/plain;
  charset="us-ascii";
  name="sched-oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sched-oops.txt"

 <1>Unable to handle kernel paging request at virtual address f8945672
 printing eip:
f8b11806
*pde = 018db067
*pte = 00000000
Oops: 0000 [#5]
Modules linked in: xeno_native xeno_nucleus xeno_hal ipv6 af_packet de4x5 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm parport_pc snd_timer snd soundcore snd_page_alloc parport i2c_i801 uhci_hcd i2c_core usbcore 3c59x tulip mii r8169 intel_agp agpgart hw_random pci_hotplug serio_raw ide_cd cdrom unix ext3 jbd mbcache ide_disk ide_generic generic piix ide_core evdev mousedev psmouse
CPU:    0
EIP:    0060:[pg0+947251206/1069855744]    Not tainted VLI
EFLAGS: 00010012   (2.6.14-1-686-ipipe) 
EIP is at sched_seq_open+0x126/0x2a0 [xeno_nucleus]
eax: 0000001c   ebx: 00000001   ecx: f79a9880   edx: 00000004
esi: 00000000   edi: 00000000   ebp: f8945440   esp: f7a19ee4
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 5103, threadinfo=f7a18000 task=c1b3c560)
Stack: c1bf0e80 f8b269c0 f79a9880 f89456a4 00000001 ffffffff 367c5900 00000088 
       c1bf0e80 c1be2b78 00008000 dfff3200 c0161ae4 c1be2b78 c1bf0e80 00000000 
       c1bf0e80 00008000 f79df000 c0161cb3 f7a28118 dfff3200 00008000 c1bf0e80 
Call Trace:
 [__dentry_open+196/512] __dentry_open+0xc4/0x200
 [filp_open+147/176] filp_open+0x93/0xb0
 [get_unused_fd+91/192] get_unused_fd+0x5b/0xc0
 [do_sys_open+85/240] do_sys_open+0x55/0xf0
 [sysenter_past_esp+99/103] sysenter_past_esp+0x63/0x67
Code: 24 08 8b 6c 24 0c 8b 58 08 81 ed 64 02 00 00 8d 43 01 89 42 08 89 d8 8b 4c 24 08 c1 e0 05 8d 14 9d 00 00 00 00 29 d0 89 7c 08 0c <f6> 85 32 02 00 00 40 0f 85 fd 00 00 00 8b 85 10 02 00 00 85 c0 

--Boundary-00=_JF1ZDeZe8SqBHkL--

