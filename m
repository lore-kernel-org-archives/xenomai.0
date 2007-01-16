Message-ID: <25dd9bf10701160219w72c8e522l33f4eb9cec59b869@domain.hid>
Date: Tue, 16 Jan 2007 15:49:15 +0530
From: "Subramani Venkatesh" <subbu31mani@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_105325_6413183.1168942755931"
Subject: [Adeos-main] Porting IPIPE on MIPS Architecture,
	User Process running error, Kernel hangs.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

------=_Part_105325_6413183.1168942755931
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello All,
I am currently porting Adeos-ipipe on one of my MIPS architecture. I am
using I-Pipe 1.5-01, X86 as reference to my porting. So Far I did relevant
changes in
1.Interrupts handlers
2. System calls
3. Pagefault Handler
Except Exception handling, I mean critcial bug events.
With this changes I am able to Boot Linux kernel and also able to mount
Ramdisk successfully.

But the Issues is running user processes.
1. When it start executing user /sbin/Init Process I see few grep errors
which are given below, and these errors are not to be seen when IPIPE is
disabled.
2. I do get "#" Prompt on my console, but after few commands I see that
kernel hangs, and obvious it does not  take any input from serial console.
I also noticed that Ethernet interrupts getting disabled.


More Information of my Development Platform
Target board: MIPS Malta
Linux Kernel: 2.6.10
Timer: Up counter
PIC: i8259

Here is the LOG, I hope someone can help me.


Initial ramdisk at: 0x802c7000 (2379776 bytes)
Built 1 zonelists
Kernel command line: console=ttyS0,38400n8 rw
Primary instruction cache 16kB, physically tagged, 4-way, linesize 16 bytes.
Primary data cache 16kB, 4-way, linesize 16 bytes.
Synthesized TLB refill handler (20 instructions).
Synthesized TLB load handler fastpath (32 instructions).
Synthesized TLB store handler fastpath (32 instructions).
Synthesized TLB modify handler fastpath (31 instructions).
PID hash table entries: 512 (order: 9, 8192 bytes)
CPU frequency 10.00 MHz
Using 5.000 MHz high precision timer.
I-pipe 1.5-01: pipeline enabled.
Console: colour dummy device 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 59392k/60112k available (1519k kernel code, 632k reserved, 2632k
data, 152k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for 'wait' instruction...  available.
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
desched cpu_callback 2/00000000
checking if image is initramfs...desched thread 0 started up.
it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 2324k freed
Linux NoNET1.0 for Linux 2.6
Can't analyze prologue code at 8027a018
Initializing Cryptographic API
rtc: SRM (post-2000) epoch (2000) detected
Real Time Clock Driver v1.12a
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
?ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:0a.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2040-0x2047, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2048-0x204f, BIOS settings: hdc:pio, hdd:pio
physmap flash device: 400000 at 1e000000
phys_mapped_flash: Found 2 x16 devices at 0x0 in 32-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
___caller_usermodelhelper: Path = /sbin/modprobe
RedBoot partition parsing not available
Using physmap partition definition
Creating 3 MTD partitions on "phys_mapped_flash":
0x00000000-0x00100000 : "YAMON"
0x00100000-0x003e0000 : "User FS"
0x003e0000-0x00400000 : "Board Config"
atkbd.c: keyboard reset failed on isa0060/serio1
atkbd.c: keyboard reset failed on isa0060/serio0
RAMDISK: Compressed image found at block 0
RAMDISK: incomplete write (-28 != 32768) 8388608
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing prom memory: 956kb freed
Freeing unused kernel memory: 1108k freed
Opening console
Opening console is successfull and executing /sbin/init
Algorithmics/MIPS FPU Emulator v1.5
INIT: version 2.85 booting
grep: error while loading shared libraries: libc.so.6: failed to map segment
from shared object: Error 4090
0
/etc/rc.d/rcS.d/S03mountvirtfs: 211: mkdir: Unknown error 4011
udev requires hotplug support, not started.
grep: error while loading shared libraries: libc.so.6: cannot map zero-fill
pages: Error 4090
mkdir: error while loading shared libraries: libcrypt.so.1: cannot open
shared object file: Error 4005
mkdir: error while loading shared libraries: libc.so.6: cannot stat shared
object: Error 4215
mount: error while loading shared libraries: /lib/libgcc_s.so.1: invalid ELF
header
none on /var/run type tmpfs (rw)
none on /tmp type tmpfs (rw)
/bin/sh: error while loading shared libraries: libcrypt.so.1: cannot open
shared object file: Error 4005
Kernel hotplug support not enabled.
INIT: Entering runlevel: 3
/bin/sh: error while loading shared libraries: libc.so.6: cannot map
zero-fill pages: Error 4090





INIT: error reading initrequest




(none) login: root






login[69]: root login  on `console'


# cd /
?
-------------------HANG-----------------------


Regards
Subbu

------=_Part_105325_6413183.1168942755931
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello All,<br>I am currently porting Adeos-ipipe on one of my MIPS architec=
ture. I am using I-Pipe 1.5-01, X86 as reference to my porting. So Far I di=
d relevant changes in<br>1.Interrupts handlers<br>2. System calls<br>3. Pag=
efault Handler
<br>Except Exception handling, I mean critcial bug events.<br>With this cha=
nges I am able to Boot Linux kernel and also able to mount Ramdisk successf=
ully.<br><br>But the Issues is running user processes.<br>1. When it start =
executing user /sbin/Init Process I see few grep errors which are given bel=
ow, and these errors are not to be seen when IPIPE is disabled.
<br>2. I do get &quot;#&quot; Prompt on my console, but after few commands =
I see that kernel hangs, and obvious it does not&nbsp; take any input from =
serial console. <br>I also noticed that Ethernet interrupts getting disable=
d.=20
<br><br><br>More Information of my Development Platform<br>Target board: MI=
PS Malta<br>Linux Kernel: 2.6.10<br>Timer: Up counter<br>PIC: i8259<br><br>=
Here is the LOG, I hope someone can help me.<br><br><br>Initial ramdisk at:=
 0x802c7000 (2379776 bytes)
<br>Built 1 zonelists<br>Kernel command line: console=3DttyS0,38400n8 rw<br=
>Primary instruction cache 16kB, physically tagged, 4-way, linesize 16 byte=
s.<br>Primary data cache 16kB, 4-way, linesize 16 bytes.<br>Synthesized TLB=
 refill handler (20 instructions).
<br>Synthesized TLB load handler fastpath (32 instructions).<br>Synthesized=
 TLB store handler fastpath (32 instructions).<br>Synthesized TLB modify ha=
ndler fastpath (31 instructions).<br>PID hash table entries: 512 (order: 9,=
 8192 bytes)
<br>CPU frequency 10.00 MHz<br>Using 5.000 MHz high precision timer.<br><sp=
an><span style=3D"background-color: rgb(255, 0, 0);">I-pipe 1.5-01: pipelin=
e enabled</span>.</span><br>Console: colour dummy device 80x25<br>Dentry ca=
che hash table entries: 16384 (order: 4, 65536 bytes)
<br>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)<br>Memory:=
 59392k/60112k available (1519k kernel code, 632k reserved, 2632k data, 152=
k init, 0k highmem)<br>Mount-cache hash table entries: 512 (order: 0, 4096 =
bytes)
<br>Checking for &#39;wait&#39; instruction...&nbsp; available.<br>spawn_de=
sched_task(00000000)<br>desched cpu_callback 3/00000000<br>ksoftirqd starte=
d up.<br>desched cpu_callback 2/00000000<br>checking if image is initramfs.=
..desched thread 0 started up.
<br>it isn&#39;t (no cpio magic); looks like an initrd<br>Freeing initrd me=
mory: 2324k freed<br>Linux NoNET1.0 for Linux 2.6<br>Can&#39;t analyze prol=
ogue code at 8027a018<br>Initializing Cryptographic API<br>rtc: SRM (post-2=
000) epoch (2000) detected
<br>Real Time Clock Driver v1.12a<br>serio: i8042 AUX port at 0x60,0x64 irq=
 12<br>serio: i8042 KBD port at 0x60,0x64 irq 1<br>Serial: 8250/16550 drive=
r $Revision: 1.90 $ 8 ports, IRQ sharing disabled<br>?ttyS0 at I/O 0x3f8 (i=
rq =3D 4) is a 16550A
<br>ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A<br>io scheduler noop registe=
red<br>io scheduler anticipatory registered<br>io scheduler deadline regist=
ered<br>io scheduler cfq registered<br>elevator: using anticipatory as defa=
ult io scheduler
<br>Floppy drive(s): fd0 is 1.44M<br>FDC 0 is a post-1991 82077<br>RAMDISK =
driver initialized: 16 RAM disks of 8192K size 1024 blocksize<br>loop: load=
ed (max 8 devices)<br>Uniform Multi-Platform E-IDE driver Revision: 7.00alp=
ha2
<br>ide: Assuming 33MHz system bus speed for PIO modes; override with idebu=
s=3Dxx<br>PIIX4: IDE controller at PCI slot 0000:00:0a.1<br>PIIX4: chipset =
revision 1<br>PIIX4: not 100% native mode: will probe irqs later<br>&nbsp;&=
nbsp;&nbsp; ide0: BM-DMA at 0x2040-0x2047, BIOS settings: hda:pio, hdb:pio
<br>&nbsp;&nbsp;&nbsp; ide1: BM-DMA at 0x2048-0x204f, BIOS settings: hdc:pi=
o, hdd:pio<br>physmap flash device: 400000 at 1e000000<br>phys_mapped_flash=
: Found 2 x16 devices at 0x0 in 32-bit bank<br>&nbsp;Intel/Sharp Extended Q=
uery Table at 0x0031
<br>Using buffer write method<br>cfi_cmdset_0001: Erase suspend on write en=
abled<br>___caller_usermodelhelper: Path =3D /sbin/modprobe<br>RedBoot part=
ition parsing not available<br>Using physmap partition definition<br>Creati=
ng 3 MTD partitions on &quot;phys_mapped_flash&quot;:
<br>0x00000000-0x00100000 : &quot;YAMON&quot;<br>0x00100000-0x003e0000 : &q=
uot;User FS&quot;<br>0x003e0000-0x00400000 : &quot;Board Config&quot;<br>at=
kbd.c: keyboard reset failed on isa0060/serio1<br>atkbd.c: keyboard reset f=
ailed on isa0060/serio0
<br>RAMDISK: Compressed image found at block 0<br>RAMDISK: incomplete write=
 (-28 !=3D 32768) 8388608<br>EXT2-fs warning: checktime reached, running e2=
fsck is recommended<br>VFS: Mounted root (ext2 filesystem).<br>Freeing prom=
 memory: 956kb freed
<br>Freeing unused kernel memory: 1108k freed<br>Opening console<br>Opening=
 console is successfull and executing /sbin/init<br>Algorithmics/MIPS FPU E=
mulator v1.5<br>INIT: version 2.85 booting<br>grep: error while loading sha=
red libraries:=20
libc.so.6: failed to map segment from shared object: Error 4090<br>0<br>/et=
c/rc.d/rcS.d/S03mountvirtfs: 211: mkdir: Unknown error 4011<br>udev require=
s hotplug support, not started.<br>grep: error while loading shared librari=
es:=20
libc.so.6: cannot map zero-fill pages: Error 4090<br>mkdir: error while loa=
ding shared libraries: libcrypt.so.1: cannot open shared object file: Error=
 4005<br>mkdir: error while loading shared libraries: libc.so.6: cannot sta=
t shared object: Error 4215
<br>mount: error while loading shared libraries: /lib/libgcc_s.so.1: invali=
d ELF header<br>none on /var/run type tmpfs (rw)<br>none on /tmp type tmpfs=
 (rw)<br>/bin/sh: error while loading shared libraries: libcrypt.so.1: cann=
ot open shared object file: Error 4005
<br>Kernel hotplug support not enabled.<br>INIT: Entering runlevel: 3<br>/b=
in/sh: error while loading shared libraries: libc.so.6: cannot map zero-fil=
l pages: Error 4090<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;=20
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; <br>INIT: error reading initrequest<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <br>(n=
one) login: root<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;=20
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<br>login[69]: root login&nbsp; on `console&#39;<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br># cd /<br>?<br>---------=
----------HANG-----------------------
<br><br><br>Regards<br>Subbu<br><br><br><br><br><br><br>

------=_Part_105325_6413183.1168942755931--

