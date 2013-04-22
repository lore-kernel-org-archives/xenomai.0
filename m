Message-ID: <51757858.6040604@bollue.de>
Date: Mon, 22 Apr 2013 19:50:16 +0200
From: Kai Bollue <mlist1@bollue.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] Sporadic freeze using RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

after having used Xenomai with RTnet for quite some time, we switched to =

new hardware and now experience sporadic freezes when communicating over =

RTnet. (To trigger the problem, it is sufficient to call rtping in a =

loop.) After several minutes (up to about an hour), the system stops =

responding. Output over a serial console while this happens is

- Either nothing at all, or

-
[  481.189349] INFO: rcu_bh detected stalls on CPUs/tasks: { 2} =

(detected by 0, t=3D60042 jiffies)
[  481.291572] INFO: Stall ended before state dump start
[  541.224383] INFO: rcu_preempt detected stalls on CPUs/tasks: { 2} =

(detected by 0, t=3D60002 jiffies)
[  541.331818] INFO: Stall ended before state dump start
(repeated), or

-
[ 2333.757994] Xenomai: Unbalanced lock/unlock
[ 2333.805884]
[ 2333.805884]  CPU  PID    PRI      TIMEOUT  STAT      NAME
[ 2333.860478] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2333.860478]    waiter =3D kernel/xenomai/nucleus/intr.c:109 =

(xnintr_clock_handler(), CPU #7)
[ 2333.860478]    owner  =3D kernel/xenomai/nucleus/pod.c:2194 =

(__xnpod_schedule(), CPU #3)
[ 2333.878344] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2333.878344]    waiter =3D kernel/xenomai/nucleus/intr.c:109 =

(xnintr_clock_handler(), CPU #5)
[ 2333.878344]    owner  =3D kernel/xenomai/nucleus/pod.c:2194 =

(__xnpod_schedule(), CPU #3)
[ 2333.878348] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2333.878348]    waiter =3D kernel/xenomai/nucleus/pod.c:2194 =

(__xnpod_schedule(), CPU #4)
[ 2333.878348]    owner  =3D kernel/xenomai/nucleus/pod.c:2194 =

(__xnpod_schedule(), CPU #3)
[ 2333.971209] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2333.971209]    waiter =3D kernel/xenomai/nucleus/intr.c:109 =

(xnintr_clock_handler(), CPU #1)
[ 2333.971209]    owner  =3D kernel/xenomai/nucleus/pod.c:2194 =

(__xnpod_schedule(), CPU #3)
[ 2334.266170] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2334.266170]    waiter =3D kernel/xenomai/nucleus/intr.c:109 =

(xnintr_clock_handler(), CPU #2)
[ 2334.266170]    owner  =3D kernel/xenomai/nucleus/pod.c:2194 =

(__xnpod_schedule(), CPU #3)
[ 2334.310045] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2334.310045]    waiter =3D kernel/xenomai/nucleus/intr.c:109 =

(xnintr_clock_handler(), CPU #0)
[ 2334.310045]    owner  =3D kernel/xenomai/nucleus/pod.c:2194 =

(__xnpod_schedule(), CPU #3)
[ 2334.877848] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2334.877848]    waiter =3D kernel/xenomai/nucleus/intr.c:109 =

(xnintr_clock_handler(), CPU #6)
[ 2334.877848]    owner  =3D kernel/xenomai/nucleus/pod.c:2194 =

(__xnpod_schedule(), CPU #3)
[ 2335.702856] >  0  0       -1      0        00500080  ROOT/0
[ 2335.769366] >  1  0       -1      0        00500080  ROOT/1
[ 2335.835898] >  2  0       -1      0        00500080  ROOT/2
[ 2335.902409] >  3  0       -1      0        00500080  ROOT/3
[ 2335.968931]    3  0       98      0        00000082  rtnet-stack
[ 2336.040642] >  4  0       -1      0        00500080  ROOT/4
[ 2336.107164]    4  0        1      1        00000084  rttcp timerwheel
[ 2336.184063] >  5  0       -1      0        00500080  ROOT/5
[ 2336.250585] >  6  0       -1      0        00500080  ROOT/6
[ 2336.317107] >  7  0       -1      0        00500080  ROOT/7
[ 2336.383629] Master time base: clock=3D9431140993874
[ 2336.439773] Current CPU: #3
[ 2386.496221] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2386.496221]    waiter =3D kernel/xenomai/nucleus/intr.c:109 =

(xnintr_clock_handler(), CPU #7)
[ 2386.496221]    owner  =3D kernel/xenomai/nucleus/pod.c:2194 =

(__xnpod_schedule(), CPU #3)
[ 2386.739258] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2386.739258]    waiter =3D kernel/xenomai/nucleus/intr.c:109 =

(xnintr_clock_handler(), CPU #5)
[ 2386.739258]    owner  =3D kernel/xenomai/nucleus/pod.c:2194 =

(__xnpod_schedule(), CPU #3)
[ 2386.739302] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2386.739302]    waiter =3D kernel/xenomai/nucleus/pod.c:2194 =

(__xnpod_schedule(), CPU #4)
[ 2386.739302]    owner  =3D kernel/xenomai/nucleus/pod.c:2194 =

(__xnpod_schedule(), CPU #3)
[ 2386.943853] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2386.943853]    waiter =3D kernel/xenomai/nucleus/intr.c:109 =

(xnintr_clock_handler(), CPU #1)
[ 2386.943853]    owner  =3D kernel/xenomai/nucleus/pod.c:2194 =

(__xnpod_schedule(), CPU #3)
[ 2387.326542] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2387.326542]    waiter =3D kernel/xenomai/nucleus/intr.c:109 =

(xnintr_clock_handler(), CPU #0)
[ 2387.326542]    owner  =3D kernel/xenomai/nucleus/pod.c:2194 =

(__xnpod_schedule(), CPU #3)
(going on).

We used:
- a newly installed system (Debian 6.0, Kernel 3.5.7 and Xenomai 2.6.2.1)
- an old system (Debian 6.0, Kernel 2.6.38.8, Xenomai 2.6.0) which ran a =

long time on older hardware (AMD dual core with NVIDIA chipset) without =

any problems.
Both show freezes on the new hardware and run fine on the old.

The new hardware:
- AMD AM3 FX-8350
- ASRock 970 Extreme4
- Intel PRO/100 for realtime communication (same as in the old system)

What we tried:
- Turn MSI off (both by disabling it in the kernel configuration and =

giving pci=3Dnomsi as boot parameter)
- Reducing the number of used CPU cores to 1 and 2, respectively =

(maxcpus=3D1 / 2)
- Combinations thereof.
All with the same result(s).

We could not reproduce the problem without using RTnet, i.e. by just =

running xeno-test for several hours. (Under heavy load, worst case =

latency stayed under about 65 us.)

Attachements:
- Kernel configuration
- Complete console output
- Content of /proc/interrupts (the Intel PRO/100 is eth3 before =

unloading the normal driver module)
- /var/syslog

We would appreciate any help on further debugging.


Best regards,
Kai

-------------- next part --------------
Loading, please wait...
INIT: version 2.88 booting
Using makefile-style concurrent boot in runlevel S.
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...[    3.390002] sp5100_tco: mmio ad=
dress 0xbafe00 already in use
[    3.636085] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    3.722575] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    3.809144] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    3.896178] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    3.982752] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    4.069234] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    4.155718] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    4.242313] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    4.615946] r600_cp: Failed to load firmware "radeon/CEDAR_pfp.bin"
[    4.690780] [drm:evergreen_startup] *ERROR* Failed to load firmware!
[    4.766641] radeon 0000:01:00.0: disabling GPU acceleration
done.
Setting parameters of disc: (none).
Setting preliminary keymap...done.
Activating swap...done.
Checking root file system...fsck from util-linux-ng 2.17.2
/dev/sda1: clean, 272019/7331840 files, 3065789/29296640 blocks
done.
Cleaning up ifupdown....
Loading kernel modules...done.
Activating lvm and md swap...done.
Checking file systems...fsck from util-linux-ng 2.17.2
/dev/sda3: clean, 5427/52510720 files, 3481115/210010880 blocks
done.
Setting up networking....
Mounting local filesystems...done.
Activating swapfile swap...done.
Cleaning up temporary files....
Setting kernel variables ...done.
Configuring network interfaces...Internet Systems Consortium DHCP Client 4.=
1.1-P1
Copyright 2004-2010 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth0/bc:5f:f4:8b:f4:94
Sending on   LPF/eth0/bc:5f:f4:8b:f4:94
Sending on   Socket/fallback
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 7
DHCPOFFER from [...]
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPACK from [...]
bound to [...] -- renewal in 36343 seconds.
SIOCSIFADDR: No such device
eth2: ERROR while getting interface flags: No such device
SIOCSIFNETMASK: No such device
eth2: ERROR while getting interface flags: No such device
Failed to bring up eth2.
done.
Starting portmap daemon....
Starting NFS common utilities: statd.
Cleaning up temporary files....
Setting up ALSA...done.
Setting console screen modes.
Rcannot (un)set powersave mode
Skipping font and keymap setup (handled by console-setup).
Setting up console font and keymap...done.
Setting sensors limits.
INIT: Entering runlevel: 2
Using makefile-style concurrent boot in runlevel 2.
Starting portmap daemon...Already running..
Starting NFS common utilities: statd.
Starting enhanced syslogd: rsyslogd.
Enabling additional executable binary formats: binfmt-support.
Starting ACPI services....
Starting system message bus: dbus.
Starting virtual private network daemon:.
Not starting GNOME Display Manager; it is not the default display manager.
Starting Hardware abstraction layer: hald.
Starting deferred execution scheduler: atd.
Loading cpufreq kernel modules...done (none).
Starting periodic command scheduler: cron.
Starting anac(h)ronistic cron: anacron.
Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon.
Starting kerneloops:
Starting bluetooth: bluetoothd.
Starting OpenBSD Secure Shell server: sshd.
Starting K Display Manager: kdm.
Starting MTA: exim4.
CPUFreq Utilities: Setting ondemand CPUFreq governor...disabled, governor n=
ot available...done.
Starting Common Unix Printing System: cupsd.
saned disabled; edit /etc/default/saned
Starting ISC DHCP server: dhcpd.
[ 2333.757994] Xenomai: Unbalanced lock/unlock
[ 2333.805884] =

[ 2333.805884]  CPU  PID    PRI      TIMEOUT  STAT      NAME
[ 2333.860478] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2333.860478] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #7)
[ 2333.860478] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2333.878344] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2333.878344] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #5)
[ 2333.878344] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2333.878348] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2333.878348] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #4)
[ 2333.878348] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2333.971209] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2333.971209] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #1)
[ 2333.971209] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2334.266170] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2334.266170] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #2)
[ 2334.266170] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2334.310045] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2334.310045] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #0)
[ 2334.310045] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2334.877848] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2334.877848] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #6)
[ 2334.877848] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2335.702856] >  0  0       -1      0        00500080  ROOT/0
[ 2335.769366] >  1  0       -1      0        00500080  ROOT/1
[ 2335.835898] >  2  0       -1      0        00500080  ROOT/2
[ 2335.902409] >  3  0       -1      0        00500080  ROOT/3
[ 2335.968931]    3  0       98      0        00000082  rtnet-stack
[ 2336.040642] >  4  0       -1      0        00500080  ROOT/4
[ 2336.107164]    4  0        1      1        00000084  rttcp timerwheel
[ 2336.184063] >  5  0       -1      0        00500080  ROOT/5
[ 2336.250585] >  6  0       -1      0        00500080  ROOT/6
[ 2336.317107] >  7  0       -1      0        00500080  ROOT/7
[ 2336.383629] Master time base: clock=3D9431140993874
[ 2336.439773] Current CPU: #3
[ 2386.496221] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2386.496221] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #7)
[ 2386.496221] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2386.739258] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2386.739258] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #5)
[ 2386.739258] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2386.739302] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2386.739302] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #4)
[ 2386.739302] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2386.943853] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2386.943853] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #1)
[ 2386.943853] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2387.326542] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2387.326542] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #0)
[ 2387.326542] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2387.627598] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2387.627598] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #2)
[ 2387.627598] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2388.570668] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2388.570668] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #6)
[ 2388.570668] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2439.626854] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2439.626854] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #5)
[ 2439.626854] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2439.627087] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2439.627087] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #4)
[ 2439.627087] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2439.729845] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2439.729845] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #2)
[ 2439.729845] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2439.993476] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2439.993476] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #1)
[ 2439.993476] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2440.375569] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2440.375569] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #0)
[ 2440.375569] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2441.019158] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2441.019158] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #7)
[ 2441.019158] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2441.801965] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2441.801965] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #6)
[ 2441.801965] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2491.825720] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2491.825720] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #2)
[ 2491.825720] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2493.043880] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2493.043880] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #1)
[ 2493.043880] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2493.243496] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2493.243496] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #4)
[ 2493.243496] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2493.714913] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2493.714913] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #0)
[ 2493.714913] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2493.810361] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2493.810361] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #5)
[ 2493.810361] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2494.249599] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2494.249599] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #7)
[ 2494.249599] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[ 2495.035520] Xenomai: stuck on nucleus lock ffffffff8162d700
[ 2495.035520] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #6)
[ 2495.035520] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
-------------- next part --------------
            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5    =
   CPU6       CPU7       =

   0:        122          0          0          0          0          0    =
      0          0   IO-APIC-edge      timer
   1:          1          0          0          0          1          0    =
      1          0   IO-APIC-edge      i8042
   4:         37         23         31         33         26         29    =
     29         40   IO-APIC-edge    =

   7:          1          0          0          0          0          0    =
      0          0   IO-APIC-edge    =

   8:          0          0          0          0          0          1    =
      0          0   IO-APIC-edge      rtc0
   9:          0          0          0          0          0          0    =
      0          0   IO-APIC-fasteoi   acpi
  12:          1          1          1          0          0          0    =
      1          0   IO-APIC-edge      i8042
  16:        149        145        143        134        153        143    =
    154        158   IO-APIC-fasteoi   snd_hda_intel
  17:          1          1          0          1          0          0    =
      0          0   IO-APIC-fasteoi   ehci_hcd:usb1, ehci_hcd:usb2, ehci_h=
cd:usb3
  18:        516        520        510        498        488        507    =
    506        515   IO-APIC-fasteoi   ohci_hcd:usb4, firewire_ohci, ohci_h=
cd:usb5, ohci_hcd:usb6, ohci_hcd:usb7
  19:       1640       1664       1653       1654       1649       1649    =
   1655       1700   IO-APIC-fasteoi   ahci
  21:         56         46         50         48         51         56    =
     52         75   IO-APIC-fasteoi   eth3
  72:         15         16         26         20         26         29    =
     26         24   PCI-MSI-edge      eth1
  73:       1154       1153       1148       1182       1181       1163    =
   1156       1225   PCI-MSI-edge      eth0
  74:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  75:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  76:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  77:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  78:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  79:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  80:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  81:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  82:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  83:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  84:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  85:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  86:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  87:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  88:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  89:          0          0          0          0          0          0    =
      0          0   PCI-MSI-edge      xhci_hcd
  90:          4          4          5          4          4          4    =
      4          5   PCI-MSI-edge      snd_hda_intel
 NMI:          0          0          0          0          0          0    =
      0          0   Non-maskable interrupts
 LOC:     179222      47292     176813      29243     183607      34864    =
 182804      51604   Local timer interrupts
 SPU:          0          0          0          0          0          0    =
      0          0   Spurious interrupts
 PMI:          0          0          0          0          0          0    =
      0          0   Performance monitoring interrupts
 IWI:          0          0          0          0          0          0    =
      0          0   IRQ work interrupts
 RTR:          0          0          0          0          0          0    =
      0          0   APIC ICR read retries
 RES:      71463       5541      66693       3182      68122       2826    =
  64629       2061   Rescheduling interrupts
 CAL:         58         65         48         67         68         74    =
     72         69   Function call interrupts
 TLB:       2393       1288       2615       1523       2686       1547    =
   2273       1431   TLB shootdowns
 TRM:          0          0          0          0          0          0    =
      0          0   Thermal event interrupts
 THR:          0          0          0          0          0          0    =
      0          0   Threshold APIC interrupts
 MCE:          0          0          0          0          0          0    =
      0          0   Machine check exceptions
 MCP:          3          3          3          3          3          3    =
      3          3   Machine check polls
 ERR:          1
 MIS:          0
-------------- next part --------------
#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 3.5.7-xenomai-2.6.2.1 Kernel Configuration
#
CONFIG_64BIT=3Dy
# CONFIG_X86_32 is not set
CONFIG_X86_64=3Dy
CONFIG_X86=3Dy
CONFIG_INSTRUCTION_DECODER=3Dy
CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
CONFIG_ARCH_DEFCONFIG=3D"arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
CONFIG_MMU=3Dy
CONFIG_NEED_DMA_MAP_STATE=3Dy
CONFIG_NEED_SG_DMA_LENGTH=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_BUG=3Dy
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_GPIO=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_ARCH_HAS_CPU_RELAX=3Dy
CONFIG_ARCH_HAS_DEFAULT_IDLE=3Dy
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
CONFIG_ARCH_HAS_CPU_AUTOPROBE=3Dy
CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
CONFIG_ZONE_DMA32=3Dy
CONFIG_AUDIT_ARCH=3Dy
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=3Dy
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
CONFIG_X86_64_SMP=3Dy
CONFIG_X86_HT=3Dy
CONFIG_ARCH_HWEIGHT_CFLAGS=3D"-fcall-saved-rdi -fcall-saved-rsi -fcall-save=
d-rdx -fcall-saved-rcx -fcall-saved-r8 -fcall-saved-r9 -fcall-saved-r10 -fc=
all-saved-r11"
CONFIG_ARCH_CPU_PROBE_RELEASE=3Dy
CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
CONFIG_HAVE_IRQ_WORK=3Dy
CONFIG_IRQ_WORK=3Dy
CONFIG_BUILDTIME_EXTABLE_SORT=3Dy

#
# General setup
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32
CONFIG_CROSS_COMPILE=3D""
CONFIG_LOCALVERSION=3D""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_HAVE_KERNEL_GZIP=3Dy
CONFIG_HAVE_KERNEL_BZIP2=3Dy
CONFIG_HAVE_KERNEL_LZMA=3Dy
CONFIG_HAVE_KERNEL_XZ=3Dy
CONFIG_HAVE_KERNEL_LZO=3Dy
CONFIG_KERNEL_GZIP=3Dy
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_DEFAULT_HOSTNAME=3D"(none)"
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_BSD_PROCESS_ACCT_V3=3Dy
# CONFIG_FHANDLE is not set
CONFIG_TASKSTATS=3Dy
CONFIG_TASK_DELAY_ACCT=3Dy
CONFIG_TASK_XACCT=3Dy
CONFIG_TASK_IO_ACCOUNTING=3Dy
CONFIG_AUDIT=3Dy
CONFIG_AUDITSYSCALL=3Dy
CONFIG_AUDIT_WATCH=3Dy
CONFIG_AUDIT_TREE=3Dy
# CONFIG_AUDIT_LOGINUID_IMMUTABLE is not set
CONFIG_HAVE_GENERIC_HARDIRQS=3Dy

#
# IRQ subsystem
#
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_GENERIC_IRQ_SHOW=3Dy
CONFIG_GENERIC_PENDING_IRQ=3Dy
CONFIG_IRQ_FORCED_THREADING=3Dy
CONFIG_SPARSE_IRQ=3Dy
CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
CONFIG_ARCH_CLOCKSOURCE_DATA=3Dy
CONFIG_GENERIC_TIME_VSYSCALL=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy
CONFIG_GENERIC_CMOS_UPDATE=3Dy

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy

#
# RCU Subsystem
#
CONFIG_TREE_PREEMPT_RCU=3Dy
CONFIG_PREEMPT_RCU=3Dy
CONFIG_RCU_FANOUT=3D64
CONFIG_RCU_FANOUT_LEAF=3D16
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_RCU_FAST_NO_HZ is not set
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_RCU_BOOST is not set
CONFIG_IKCONFIG=3Dm
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_LOG_BUF_SHIFT=3D17
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
CONFIG_CGROUPS=3Dy
# CONFIG_CGROUP_DEBUG is not set
CONFIG_CGROUP_FREEZER=3Dy
CONFIG_CGROUP_DEVICE=3Dy
CONFIG_CPUSETS=3Dy
CONFIG_PROC_PID_CPUSET=3Dy
CONFIG_CGROUP_CPUACCT=3Dy
# CONFIG_RESOURCE_COUNTERS is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_SCHED=3Dy
CONFIG_FAIR_GROUP_SCHED=3Dy
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=3Dy
CONFIG_UTS_NS=3Dy
CONFIG_IPC_NS=3Dy
CONFIG_PID_NS=3Dy
CONFIG_NET_NS=3Dy
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=3Dy
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_RD_GZIP=3Dy
CONFIG_RD_BZIP2=3Dy
CONFIG_RD_LZMA=3Dy
CONFIG_RD_XZ=3Dy
CONFIG_RD_LZO=3Dy
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_ANON_INODES=3Dy
# CONFIG_EXPERT is not set
CONFIG_UID16=3Dy
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_ALL is not set
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_PCSPKR_PLATFORM=3Dy
CONFIG_HAVE_PCSPKR_PLATFORM=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
CONFIG_SHMEM=3Dy
CONFIG_AIO=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=3Dy

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=3Dy
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_PCI_QUIRKS=3Dy
CONFIG_SLUB_DEBUG=3Dy
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=3Dy
CONFIG_PROFILING=3Dy
CONFIG_TRACEPOINTS=3Dy
CONFIG_OPROFILE=3Dm
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=3Dy
CONFIG_OPROFILE_NMI_TIMER=3Dy
CONFIG_KPROBES=3Dy
# CONFIG_JUMP_LABEL is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
CONFIG_KRETPROBES=3Dy
CONFIG_USER_RETURN_NOTIFIER=3Dy
CONFIG_HAVE_IOREMAP_PROT=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
CONFIG_HAVE_OPTPROBES=3Dy
CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
CONFIG_HAVE_DMA_ATTRS=3Dy
CONFIG_USE_GENERIC_SMP_HELPERS=3Dy
CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
CONFIG_HAVE_DMA_API_DEBUG=3Dy
CONFIG_HAVE_HW_BREAKPOINT=3Dy
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy
CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
CONFIG_HAVE_PERF_EVENTS_NMI=3Dy
CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=3Dy
CONFIG_HAVE_CMPXCHG_LOCAL=3Dy
CONFIG_HAVE_CMPXCHG_DOUBLE=3Dy
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
CONFIG_SECCOMP_FILTER=3Dy

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=3Dy
CONFIG_RT_MUTEXES=3Dy
CONFIG_BASE_SMALL=3D0
CONFIG_MODULES=3Dy
CONFIG_MODULE_FORCE_LOAD=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_MODVERSIONS=3Dy
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_STOP_MACHINE=3Dy
CONFIG_BLOCK=3Dy
CONFIG_BLK_DEV_BSG=3Dy
CONFIG_BLK_DEV_BSGLIB=3Dy
CONFIG_BLK_DEV_INTEGRITY=3Dy

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
CONFIG_ACORN_PARTITION=3Dy
# CONFIG_ACORN_PARTITION_CUMANA is not set
# CONFIG_ACORN_PARTITION_EESOX is not set
CONFIG_ACORN_PARTITION_ICS=3Dy
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
CONFIG_ACORN_PARTITION_RISCIX=3Dy
CONFIG_OSF_PARTITION=3Dy
CONFIG_AMIGA_PARTITION=3Dy
CONFIG_ATARI_PARTITION=3Dy
CONFIG_MAC_PARTITION=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
CONFIG_MINIX_SUBPARTITION=3Dy
CONFIG_SOLARIS_X86_PARTITION=3Dy
CONFIG_UNIXWARE_DISKLABEL=3Dy
CONFIG_LDM_PARTITION=3Dy
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=3Dy
CONFIG_ULTRIX_PARTITION=3Dy
CONFIG_SUN_PARTITION=3Dy
CONFIG_KARMA_PARTITION=3Dy
CONFIG_EFI_PARTITION=3Dy
# CONFIG_SYSV68_PARTITION is not set
CONFIG_BLOCK_COMPAT=3Dy

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"
CONFIG_PREEMPT_NOTIFIERS=3Dy
# CONFIG_INLINE_SPIN_TRYLOCK is not set
# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK is not set
# CONFIG_INLINE_SPIN_LOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
CONFIG_UNINLINE_SPIN_UNLOCK=3Dy
# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_READ_TRYLOCK is not set
# CONFIG_INLINE_READ_LOCK is not set
# CONFIG_INLINE_READ_LOCK_BH is not set
# CONFIG_INLINE_READ_LOCK_IRQ is not set
# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
# CONFIG_INLINE_READ_UNLOCK is not set
# CONFIG_INLINE_READ_UNLOCK_BH is not set
# CONFIG_INLINE_READ_UNLOCK_IRQ is not set
# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_WRITE_TRYLOCK is not set
# CONFIG_INLINE_WRITE_LOCK is not set
# CONFIG_INLINE_WRITE_LOCK_BH is not set
# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
# CONFIG_INLINE_WRITE_UNLOCK is not set
# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
CONFIG_MUTEX_SPIN_ON_OWNER=3Dy

#
# Real-time sub-system
#
CONFIG_XENOMAI=3Dy
CONFIG_XENO_GENERIC_STACKPOOL=3Dy
CONFIG_XENO_FASTSYNCH=3Dy
CONFIG_XENO_OPT_NUCLEUS=3Dy
CONFIG_XENO_OPT_PERVASIVE=3Dy
# CONFIG_XENO_OPT_PRIOCPL is not set
CONFIG_XENO_OPT_PIPELINE_HEAD=3Dy
# CONFIG_XENO_OPT_SCHED_CLASSES is not set
CONFIG_XENO_OPT_PIPE=3Dy
CONFIG_XENO_OPT_VFILE=3Dy
CONFIG_XENO_OPT_PIPE_NRDEV=3D32
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D1024
CONFIG_XENO_OPT_SYS_HEAPSZ=3D2048
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=3D1024
CONFIG_XENO_OPT_SEM_HEAPSZ=3D96
CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=3D96
CONFIG_XENO_OPT_STATS=3Dy
CONFIG_XENO_OPT_DEBUG=3Dy
CONFIG_XENO_OPT_DEBUG_NUCLEUS=3Dy
CONFIG_XENO_OPT_DEBUG_XNLOCK=3Dy
CONFIG_XENO_OPT_DEBUG_QUEUES=3Dy
# CONFIG_XENO_OPT_DEBUG_REGISTRY is not set
# CONFIG_XENO_OPT_DEBUG_TIMERS is not set
CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX=3Dy
CONFIG_XENO_OPT_WATCHDOG=3Dy
CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=3D4
CONFIG_XENO_OPT_SHIRQ=3Dy
CONFIG_XENO_OPT_SELECT=3Dy
CONFIG_XENO_OPT_HOSTRT=3Dy

#
# Timing
#
# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
CONFIG_XENO_OPT_TIMING_VIRTICK=3D1000
CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0

#
# Scalability
#
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=3Dy
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set

#
# Machine
#
CONFIG_XENO_HW_FPU=3Dy

#
# SMI workaround
#
# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
CONFIG_XENO_HW_SMI_DETECT=3Dy
CONFIG_XENO_HW_SMI_WORKAROUND=3Dy
CONFIG_XENO_HW_SMI_ALL=3Dy

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=3Dy
CONFIG_XENO_OPT_NATIVE_PERIOD=3D0
CONFIG_XENO_OPT_NATIVE_PIPE=3Dy
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D1024
CONFIG_XENO_OPT_NATIVE_SEM=3Dy
CONFIG_XENO_OPT_NATIVE_EVENT=3Dy
CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy
CONFIG_XENO_OPT_NATIVE_COND=3Dy
CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy
CONFIG_XENO_OPT_NATIVE_BUFFER=3Dy
CONFIG_XENO_OPT_NATIVE_HEAP=3Dy
CONFIG_XENO_OPT_NATIVE_ALARM=3Dy
CONFIG_XENO_OPT_NATIVE_MPS=3Dy
CONFIG_XENO_OPT_NATIVE_INTR=3Dy
CONFIG_XENO_OPT_DEBUG_NATIVE=3Dy
CONFIG_XENO_SKIN_POSIX=3Dy
CONFIG_XENO_OPT_POSIX_PERIOD=3D0
# CONFIG_XENO_OPT_POSIX_SHM is not set
CONFIG_XENO_OPT_POSIX_INTR=3Dy
CONFIG_XENO_OPT_POSIX_SELECT=3Dy
CONFIG_XENO_OPT_DEBUG_POSIX=3Dy
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set
CONFIG_XENO_SKIN_RTDM=3Dy
CONFIG_XENO_OPT_RTDM_PERIOD=3D0
CONFIG_XENO_OPT_RTDM_FILDES=3D128
CONFIG_XENO_OPT_RTDM_SELECT=3Dy
# CONFIG_XENO_OPT_DEBUG_RTDM is not set
CONFIG_XENO_OPT_DEBUG_RTDM_APPL=3Dy

#
# Drivers
#

#
# Serial drivers
#
CONFIG_XENO_DRIVERS_16550A=3Dy
CONFIG_XENO_DRIVERS_16550A_PIO=3Dy
# CONFIG_XENO_DRIVERS_16550A_MMIO is not set
# CONFIG_XENO_DRIVERS_16550A_ANY is not set
# CONFIG_XENO_DRIVERS_16550A_PCI is not set

#
# Testing drivers
#
CONFIG_XENO_DRIVERS_TIMERBENCH=3Dy
# CONFIG_XENO_DRIVERS_KLATENCY is not set
CONFIG_XENO_DRIVERS_IRQBENCH=3Dy
CONFIG_XENO_DRIVERS_SWITCHTEST=3Dy
# CONFIG_XENO_DRIVERS_RTDMTEST is not set

#
# CAN drivers
#
CONFIG_XENO_DRIVERS_CAN=3Dy
CONFIG_XENO_DRIVERS_CAN_DEBUG=3Dy
# CONFIG_XENO_DRIVERS_CAN_LOOPBACK is not set
CONFIG_XENO_DRIVERS_CAN_RXBUF_SIZE=3D1024
CONFIG_XENO_DRIVERS_CAN_MAX_DEVICES=3D4
CONFIG_XENO_DRIVERS_CAN_MAX_RECEIVERS=3D16
CONFIG_XENO_DRIVERS_CAN_BUS_ERR=3Dy
# CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD is not set
CONFIG_XENO_DRIVERS_CAN_VIRT=3Dy
CONFIG_XENO_DRIVERS_CAN_SJA1000=3Dm
CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA=3Dm
CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM=3Dm
CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_PCI=3Dm
CONFIG_XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI=3Dm
CONFIG_XENO_DRIVERS_CAN_SJA1000_ADV_PCI=3Dm
CONFIG_XENO_DRIVERS_CAN_SJA1000_PLX_PCI=3Dm
CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI=3Dm
CONFIG_XENO_DRIVERS_CAN_SJA1000_ESD_PCI=3Dm
CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_DNG=3Dm

#
# ANALOGY drivers
#
CONFIG_XENO_DRIVERS_ANALOGY=3Dy
CONFIG_XENO_DRIVERS_ANALOGY_DEBUG=3Dy
CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_LEVEL=3D0
CONFIG_XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL=3D0
# CONFIG_XENO_DRIVERS_ANALOGY_FAKE is not set
CONFIG_XENO_DRIVERS_ANALOGY_8255=3Dm
CONFIG_XENO_DRIVERS_ANALOGY_PARPORT=3Dm
CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE=3Dm
CONFIG_XENO_DRIVERS_ANALOGY_NI_TIO=3Dm
CONFIG_XENO_DRIVERS_ANALOGY_NI_MIO=3Dm
CONFIG_XENO_DRIVERS_ANALOGY_NI_PCIMIO=3Dm
CONFIG_XENO_DRIVERS_ANALOGY_NI_670x=3Dm
CONFIG_XENO_DRIVERS_ANALOGY_NI_660x=3Dm
CONFIG_XENO_DRIVERS_ANALOGY_S526=3Dm

#
# Real-time IPC drivers
#
# CONFIG_XENO_DRIVERS_RTIPC is not set
CONFIG_FREEZER=3Dy

#
# Processor type and features
#
CONFIG_ZONE_DMA=3Dy
CONFIG_SMP=3Dy
CONFIG_X86_MPPARSE=3Dy
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy
CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
CONFIG_NO_BOOTMEM=3Dy
# CONFIG_MEMTEST is not set
CONFIG_MK8=3Dy
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_X86_XADD=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_CMPXCHG64=3Dy
CONFIG_X86_CMOV=3Dy
CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
CONFIG_X86_DEBUGCTLMSR=3Dy
CONFIG_CPU_SUP_INTEL=3Dy
CONFIG_CPU_SUP_AMD=3Dy
CONFIG_CPU_SUP_CENTAUR=3Dy
CONFIG_HPET_TIMER=3Dy
CONFIG_HPET_EMULATE_RTC=3Dy
CONFIG_DMI=3Dy
CONFIG_GART_IOMMU=3Dy
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=3Dy
CONFIG_IOMMU_HELPER=3Dy
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS=3D512
CONFIG_SCHED_SMT=3Dy
CONFIG_SCHED_MC=3Dy
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
CONFIG_PREEMPT_COUNT=3Dy
CONFIG_IPIPE=3Dy
CONFIG_IPIPE_CORE=3Dy
CONFIG_IPIPE_CORE_APIREV=3D2
CONFIG_IPIPE_WANT_APIREV_2=3Dy
CONFIG_IPIPE_TARGET_APIREV=3D2
CONFIG_IPIPE_LEGACY=3Dy
CONFIG_IPIPE_HAVE_HOSTRT=3Dy
CONFIG_IPIPE_DELAYED_ATOMICSW=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_INTEL=3Dy
CONFIG_X86_MCE_AMD=3Dy
CONFIG_X86_MCE_THRESHOLD=3Dy
CONFIG_X86_MCE_INJECT=3Dm
CONFIG_X86_THERMAL_VECTOR=3Dy
# CONFIG_I8K is not set
CONFIG_MICROCODE=3Dm
CONFIG_MICROCODE_INTEL=3Dy
CONFIG_MICROCODE_AMD=3Dy
CONFIG_MICROCODE_OLD_INTERFACE=3Dy
CONFIG_X86_MSR=3Dm
CONFIG_X86_CPUID=3Dm
CONFIG_ARCH_PHYS_ADDR_T_64BIT=3Dy
CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
CONFIG_DIRECT_GBPAGES=3Dy
CONFIG_NUMA=3Dy
CONFIG_AMD_NUMA=3Dy
CONFIG_X86_64_ACPI_NUMA=3Dy
CONFIG_NODES_SPAN_OTHER_NODES=3Dy
CONFIG_NUMA_EMU=3Dy
CONFIG_NODES_SHIFT=3D6
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
CONFIG_ARCH_MEMORY_PROBE=3Dy
CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_SPARSEMEM_MANUAL=3Dy
CONFIG_SPARSEMEM=3Dy
CONFIG_NEED_MULTIPLE_NODES=3Dy
CONFIG_HAVE_MEMORY_PRESENT=3Dy
CONFIG_SPARSEMEM_EXTREME=3Dy
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=3Dy
CONFIG_SPARSEMEM_VMEMMAP=3Dy
CONFIG_HAVE_MEMBLOCK=3Dy
CONFIG_HAVE_MEMBLOCK_NODE_MAP=3Dy
CONFIG_ARCH_DISCARD_MEMBLOCK=3Dy
CONFIG_MEMORY_HOTPLUG=3Dy
CONFIG_MEMORY_HOTPLUG_SPARSE=3Dy
CONFIG_MEMORY_HOTREMOVE=3Dy
CONFIG_PAGEFLAGS_EXTENDED=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=3Dy
CONFIG_PHYS_ADDR_T_64BIT=3Dy
CONFIG_ZONE_DMA_FLAG=3D1
CONFIG_BOUNCE=3Dy
CONFIG_VIRT_TO_BUS=3Dy
CONFIG_MMU_NOTIFIER=3Dy
CONFIG_KSM=3Dy
CONFIG_DEFAULT_MMAP_MIN_ADDR=3D65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
CONFIG_MEMORY_FAILURE=3Dy
CONFIG_HWPOISON_INJECT=3Dm
CONFIG_CROSS_MEMORY_ATTACH=3Dy
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=3D64
CONFIG_MTRR=3Dy
CONFIG_MTRR_SANITIZER=3Dy
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1
CONFIG_X86_PAT=3Dy
CONFIG_ARCH_USES_PG_UNCACHED=3Dy
CONFIG_ARCH_RANDOM=3Dy
CONFIG_EFI=3Dy
# CONFIG_EFI_STUB is not set
CONFIG_SECCOMP=3Dy
CONFIG_CC_STACKPROTECTOR=3Dy
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=3Dy
CONFIG_HZ=3D1000
CONFIG_SCHED_HRTICK=3Dy
CONFIG_KEXEC=3Dy
# CONFIG_CRASH_DUMP is not set
# CONFIG_KEXEC_JUMP is not set
CONFIG_PHYSICAL_START=3D0x1000000
CONFIG_RELOCATABLE=3Dy
CONFIG_PHYSICAL_ALIGN=3D0x1000000
CONFIG_HOTPLUG_CPU=3Dy
# CONFIG_COMPAT_VDSO is not set
CONFIG_CMDLINE_BOOL=3Dy
CONFIG_CMDLINE=3D""
# CONFIG_CMDLINE_OVERRIDE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=3Dy
CONFIG_SUSPEND=3Dy
CONFIG_SUSPEND_FREEZER=3Dy
CONFIG_HIBERNATE_CALLBACKS=3Dy
CONFIG_HIBERNATION=3Dy
CONFIG_PM_STD_PARTITION=3D""
CONFIG_PM_SLEEP=3Dy
CONFIG_PM_SLEEP_SMP=3Dy
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM_RUNTIME=3Dy
CONFIG_PM=3Dy
CONFIG_PM_DEBUG=3Dy
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_CAN_PM_TRACE=3Dy
# CONFIG_PM_TRACE_RTC is not set
CONFIG_ACPI=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_PROCFS=3Dy
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
# CONFIG_ACPI_PROC_EVENT is not set
CONFIG_ACPI_AC=3Dm
CONFIG_ACPI_BATTERY=3Dm
CONFIG_ACPI_BUTTON=3Dm
CONFIG_ACPI_VIDEO=3Dm
CONFIG_ACPI_FAN=3Dm
CONFIG_ACPI_DOCK=3Dy
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_NUMA=3Dy
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=3D0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=3Dm
CONFIG_X86_PM_TIMER=3Dy
CONFIG_ACPI_CONTAINER=3Dm
CONFIG_ACPI_HOTPLUG_MEMORY=3Dm
CONFIG_ACPI_SBS=3Dm
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=3Dm
# CONFIG_ACPI_APEI is not set
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
CONFIG_CPU_IDLE=3Dy
CONFIG_CPU_IDLE_GOV_LADDER=3Dy
CONFIG_CPU_IDLE_GOV_MENU=3Dy
# CONFIG_INTEL_IDLE is not set

#
# Memory power savings
#
# CONFIG_I7300_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
CONFIG_PCI_DOMAINS=3Dy
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=3Dy
CONFIG_PCIEAER=3Dy
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEAER_INJECT=3Dm
CONFIG_PCIEASPM=3Dy
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=3Dy
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=3Dy
CONFIG_ARCH_SUPPORTS_MSI=3Dy
CONFIG_PCI_MSI=3Dy
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=3Dm
CONFIG_HT_IRQ=3Dy
CONFIG_PCI_ATS=3Dy
CONFIG_PCI_IOV=3Dy
CONFIG_PCI_PRI=3Dy
CONFIG_PCI_PASID=3Dy
# CONFIG_PCI_IOAPIC is not set
CONFIG_PCI_LABEL=3Dy
CONFIG_ISA_DMA_API=3Dy
CONFIG_AMD_NB=3Dy
CONFIG_PCCARD=3Dm
CONFIG_PCMCIA=3Dm
CONFIG_PCMCIA_LOAD_CIS=3Dy
CONFIG_CARDBUS=3Dy

#
# PC-card bridges
#
CONFIG_YENTA=3Dm
CONFIG_YENTA_O2=3Dy
CONFIG_YENTA_RICOH=3Dy
CONFIG_YENTA_TI=3Dy
CONFIG_YENTA_ENE_TUNE=3Dy
CONFIG_YENTA_TOSHIBA=3Dy
CONFIG_PD6729=3Dm
CONFIG_I82092=3Dm
CONFIG_PCCARD_NONSTATIC=3Dy
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_RAPIDIO is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_COMPAT_BINFMT_ELF=3Dy
CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE=3Dy
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=3Dm
CONFIG_IA32_EMULATION=3Dy
CONFIG_IA32_AOUT=3Dy
# CONFIG_X86_X32 is not set
CONFIG_COMPAT=3Dy
CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
CONFIG_SYSVIPC_COMPAT=3Dy
CONFIG_KEYS_COMPAT=3Dy
CONFIG_HAVE_TEXT_POKE_SMP=3Dy
CONFIG_X86_DEV_DMA_OPS=3Dy
CONFIG_NET=3Dy
CONFIG_COMPAT_NETLINK_MESSAGES=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_UNIX=3Dy
# CONFIG_UNIX_DIAG is not set
CONFIG_XFRM=3Dy
CONFIG_XFRM_ALGO=3Dm
CONFIG_XFRM_USER=3Dm
CONFIG_XFRM_SUB_POLICY=3Dy
CONFIG_XFRM_MIGRATE=3Dy
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=3Dm
CONFIG_NET_KEY=3Dm
CONFIG_NET_KEY_MIGRATE=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
CONFIG_IP_ROUTE_CLASSID=3Dy
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_IP_MROUTE=3Dy
# CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=3Dy
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm
CONFIG_INET_XFRM_TUNNEL=3Dm
CONFIG_INET_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_TRANSPORT=3Dm
CONFIG_INET_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_BEET=3Dm
CONFIG_INET_LRO=3Dm
CONFIG_INET_DIAG=3Dm
CONFIG_INET_TCP_DIAG=3Dm
# CONFIG_INET_UDP_DIAG is not set
CONFIG_TCP_CONG_ADVANCED=3Dy
CONFIG_TCP_CONG_BIC=3Dm
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_TCP_CONG_WESTWOOD=3Dm
CONFIG_TCP_CONG_HTCP=3Dm
CONFIG_TCP_CONG_HSTCP=3Dm
CONFIG_TCP_CONG_HYBLA=3Dm
CONFIG_TCP_CONG_VEGAS=3Dm
CONFIG_TCP_CONG_SCALABLE=3Dm
CONFIG_TCP_CONG_LP=3Dm
CONFIG_TCP_CONG_VENO=3Dm
CONFIG_TCP_CONG_YEAH=3Dm
CONFIG_TCP_CONG_ILLINOIS=3Dm
CONFIG_DEFAULT_CUBIC=3Dy
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
CONFIG_TCP_MD5SIG=3Dy
CONFIG_IPV6=3Dy
CONFIG_IPV6_PRIVACY=3Dy
CONFIG_IPV6_ROUTER_PREF=3Dy
CONFIG_IPV6_ROUTE_INFO=3Dy
CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
CONFIG_INET6_AH=3Dm
CONFIG_INET6_ESP=3Dm
CONFIG_INET6_IPCOMP=3Dm
CONFIG_IPV6_MIP6=3Dy
CONFIG_INET6_XFRM_TUNNEL=3Dm
CONFIG_INET6_TUNNEL=3Dm
CONFIG_INET6_XFRM_MODE_TRANSPORT=3Dm
CONFIG_INET6_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET6_XFRM_MODE_BEET=3Dm
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=3Dm
CONFIG_IPV6_SIT=3Dm
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=3Dy
CONFIG_IPV6_TUNNEL=3Dm
CONFIG_IPV6_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_SUBTREES=3Dy
CONFIG_IPV6_MROUTE=3Dy
# CONFIG_IPV6_MROUTE_MULTIPLE_TABLES is not set
CONFIG_IPV6_PIMSM_V2=3Dy
# CONFIG_NETLABEL is not set
CONFIG_NETWORK_SECMARK=3Dy
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=3Dy
CONFIG_BRIDGE_NETFILTER=3Dy

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=3Dm
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
CONFIG_NETFILTER_NETLINK_LOG=3Dm
CONFIG_NF_CONNTRACK=3Dm
CONFIG_NF_CONNTRACK_MARK=3Dy
CONFIG_NF_CONNTRACK_SECMARK=3Dy
CONFIG_NF_CONNTRACK_PROCFS=3Dy
CONFIG_NF_CONNTRACK_EVENTS=3Dy
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
CONFIG_NF_CT_PROTO_DCCP=3Dm
CONFIG_NF_CT_PROTO_GRE=3Dm
CONFIG_NF_CT_PROTO_SCTP=3Dm
CONFIG_NF_CT_PROTO_UDPLITE=3Dm
CONFIG_NF_CONNTRACK_AMANDA=3Dm
CONFIG_NF_CONNTRACK_FTP=3Dm
CONFIG_NF_CONNTRACK_H323=3Dm
CONFIG_NF_CONNTRACK_IRC=3Dm
CONFIG_NF_CONNTRACK_BROADCAST=3Dm
CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
# CONFIG_NF_CONNTRACK_SNMP is not set
CONFIG_NF_CONNTRACK_PPTP=3Dm
CONFIG_NF_CONNTRACK_SANE=3Dm
CONFIG_NF_CONNTRACK_SIP=3Dm
CONFIG_NF_CONNTRACK_TFTP=3Dm
CONFIG_NF_CT_NETLINK=3Dm
# CONFIG_NF_CT_NETLINK_TIMEOUT is not set
CONFIG_NETFILTER_TPROXY=3Dm
CONFIG_NETFILTER_XTABLES=3Dm

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=3Dm
CONFIG_NETFILTER_XT_CONNMARK=3Dm

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
# CONFIG_NETFILTER_XT_TARGET_CHECKSUM is not set
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm
# CONFIG_NETFILTER_XT_TARGET_CT is not set
CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
CONFIG_NETFILTER_XT_TARGET_HL=3Dm
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
CONFIG_NETFILTER_XT_TARGET_LED=3Dm
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm
CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
# CONFIG_NETFILTER_XT_TARGET_TEE is not set
CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
CONFIG_NETFILTER_XT_TARGET_TRACE=3Dm
CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm

#
# Xtables matches
#
# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dm
CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
CONFIG_NETFILTER_XT_MATCH_ECN=3Dm
CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
CONFIG_NETFILTER_XT_MATCH_HL=3Dm
CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=3Dm
CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dm
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dm
CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
CONFIG_NETFILTER_XT_MATCH_TIME=3Dm
CONFIG_NETFILTER_XT_MATCH_U32=3Dm
# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=3Dm
CONFIG_NF_CONNTRACK_IPV4=3Dm
CONFIG_NF_CONNTRACK_PROC_COMPAT=3Dy
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_AH=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
# CONFIG_IP_NF_MATCH_RPFILTER is not set
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_NF_NAT=3Dm
CONFIG_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_NETMAP=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_NF_NAT_PROTO_DCCP=3Dm
CONFIG_NF_NAT_PROTO_GRE=3Dm
CONFIG_NF_NAT_PROTO_UDPLITE=3Dm
CONFIG_NF_NAT_PROTO_SCTP=3Dm
CONFIG_NF_NAT_FTP=3Dm
CONFIG_NF_NAT_IRC=3Dm
CONFIG_NF_NAT_TFTP=3Dm
CONFIG_NF_NAT_AMANDA=3Dm
CONFIG_NF_NAT_PPTP=3Dm
CONFIG_NF_NAT_H323=3Dm
CONFIG_NF_NAT_SIP=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_TTL=3Dm
CONFIG_IP_NF_RAW=3Dm
CONFIG_IP_NF_SECURITY=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=3Dm
CONFIG_NF_CONNTRACK_IPV6=3Dm
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_AH=3Dm
CONFIG_IP6_NF_MATCH_EUI64=3Dm
CONFIG_IP6_NF_MATCH_FRAG=3Dm
CONFIG_IP6_NF_MATCH_OPTS=3Dm
CONFIG_IP6_NF_MATCH_HL=3Dm
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_MH=3Dm
# CONFIG_IP6_NF_MATCH_RPFILTER is not set
CONFIG_IP6_NF_MATCH_RT=3Dm
CONFIG_IP6_NF_TARGET_HL=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_TARGET_REJECT=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_RAW=3Dm
CONFIG_IP6_NF_SECURITY=3Dm

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=3Dm
CONFIG_BRIDGE_NF_EBTABLES=3Dm
CONFIG_BRIDGE_EBT_BROUTE=3Dm
CONFIG_BRIDGE_EBT_T_FILTER=3Dm
CONFIG_BRIDGE_EBT_T_NAT=3Dm
CONFIG_BRIDGE_EBT_802_3=3Dm
CONFIG_BRIDGE_EBT_AMONG=3Dm
CONFIG_BRIDGE_EBT_ARP=3Dm
CONFIG_BRIDGE_EBT_IP=3Dm
CONFIG_BRIDGE_EBT_IP6=3Dm
CONFIG_BRIDGE_EBT_LIMIT=3Dm
CONFIG_BRIDGE_EBT_MARK=3Dm
CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
CONFIG_BRIDGE_EBT_STP=3Dm
CONFIG_BRIDGE_EBT_VLAN=3Dm
CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
CONFIG_BRIDGE_EBT_DNAT=3Dm
CONFIG_BRIDGE_EBT_MARK_T=3Dm
CONFIG_BRIDGE_EBT_REDIRECT=3Dm
CONFIG_BRIDGE_EBT_SNAT=3Dm
CONFIG_BRIDGE_EBT_LOG=3Dm
CONFIG_BRIDGE_EBT_ULOG=3Dm
CONFIG_BRIDGE_EBT_NFLOG=3Dm
CONFIG_IP_DCCP=3Dm
CONFIG_INET_DCCP_DIAG=3Dm

#
# DCCP CCIDs Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=3Dy
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=3Dy

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# CONFIG_NET_DCCPPROBE is not set
CONFIG_IP_SCTP=3Dm
# CONFIG_NET_SCTPPROBE is not set
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=3Dy
CONFIG_RDS=3Dm
CONFIG_RDS_TCP=3Dm
# CONFIG_RDS_DEBUG is not set
CONFIG_TIPC=3Dm
CONFIG_TIPC_ADVANCED=3Dy
CONFIG_TIPC_PORTS=3D8191
CONFIG_TIPC_LOG=3D0
# CONFIG_TIPC_DEBUG is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=3Dm
CONFIG_GARP=3Dm
CONFIG_BRIDGE=3Dm
CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=3Dm
CONFIG_VLAN_8021Q_GVRP=3Dy
CONFIG_DECNET=3Dm
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=3Dm
CONFIG_LLC2=3Dm
CONFIG_IPX=3Dm
# CONFIG_IPX_INTERN is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_PHONET is not set
CONFIG_IEEE802154=3Dm
# CONFIG_IEEE802154_6LOWPAN is not set
# CONFIG_MAC802154 is not set
CONFIG_NET_SCHED=3Dy

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_HFSC=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_MULTIQ=3Dm
CONFIG_NET_SCH_RED=3Dm
# CONFIG_NET_SCH_SFB is not set
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_NETEM=3Dm
CONFIG_NET_SCH_DRR=3Dm
# CONFIG_NET_SCH_MQPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
# CONFIG_NET_SCH_QFQ is not set
# CONFIG_NET_SCH_CODEL is not set
# CONFIG_NET_SCH_FQ_CODEL is not set
CONFIG_NET_SCH_INGRESS=3Dm
# CONFIG_NET_SCH_PLUG is not set

#
# Classification
#
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_BASIC=3Dm
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_CLS_U32_PERF=3Dy
CONFIG_CLS_U32_MARK=3Dy
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_FLOW=3Dm
CONFIG_NET_CLS_CGROUP=3Dy
CONFIG_NET_EMATCH=3Dy
CONFIG_NET_EMATCH_STACK=3D32
CONFIG_NET_EMATCH_CMP=3Dm
CONFIG_NET_EMATCH_NBYTE=3Dm
CONFIG_NET_EMATCH_U32=3Dm
CONFIG_NET_EMATCH_META=3Dm
CONFIG_NET_EMATCH_TEXT=3Dm
CONFIG_NET_CLS_ACT=3Dy
CONFIG_NET_ACT_POLICE=3Dm
CONFIG_NET_ACT_GACT=3Dm
CONFIG_GACT_PROB=3Dy
CONFIG_NET_ACT_MIRRED=3Dm
CONFIG_NET_ACT_IPT=3Dm
CONFIG_NET_ACT_NAT=3Dm
CONFIG_NET_ACT_PEDIT=3Dm
CONFIG_NET_ACT_SIMP=3Dm
CONFIG_NET_ACT_SKBEDIT=3Dm
# CONFIG_NET_ACT_CSUM is not set
CONFIG_NET_CLS_IND=3Dy
CONFIG_NET_SCH_FIFO=3Dy
CONFIG_DCB=3Dy
CONFIG_DNS_RESOLVER=3Dy
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_RPS=3Dy
CONFIG_RFS_ACCEL=3Dy
CONFIG_XPS=3Dy
# CONFIG_NETPRIO_CGROUP is not set
CONFIG_BQL=3Dy
# CONFIG_BPF_JIT is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_TCPPROBE is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
CONFIG_CAN=3Dm
CONFIG_CAN_RAW=3Dm
CONFIG_CAN_BCM=3Dm
CONFIG_CAN_GW=3Dm

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=3Dm
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=3Dm
CONFIG_CAN_CALC_BITTIMING=3Dy
# CONFIG_CAN_MCP251X is not set
CONFIG_PCH_CAN=3Dm
CONFIG_CAN_SJA1000=3Dm
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=3Dm
# CONFIG_CAN_EMS_PCMCIA is not set
CONFIG_CAN_EMS_PCI=3Dm
# CONFIG_CAN_PEAK_PCMCIA is not set
# CONFIG_CAN_PEAK_PCI is not set
CONFIG_CAN_KVASER_PCI=3Dm
# CONFIG_CAN_PLX_PCI is not set
CONFIG_CAN_C_CAN=3Dm
# CONFIG_CAN_C_CAN_PLATFORM is not set
CONFIG_CAN_CC770=3Dm
# CONFIG_CAN_CC770_ISA is not set
# CONFIG_CAN_CC770_PLATFORM is not set

#
# CAN USB interfaces
#
CONFIG_CAN_EMS_USB=3Dm
CONFIG_CAN_ESD_USB2=3Dm
CONFIG_CAN_PEAK_USB=3Dm
CONFIG_CAN_SOFTING=3Dm
CONFIG_CAN_SOFTING_CS=3Dm
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_IRDA is not set
CONFIG_BT=3Dm
CONFIG_BT_RFCOMM=3Dm
CONFIG_BT_RFCOMM_TTY=3Dy
CONFIG_BT_BNEP=3Dm
CONFIG_BT_BNEP_MC_FILTER=3Dy
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
CONFIG_BT_HIDP=3Dm

#
# Bluetooth device drivers
#
CONFIG_BT_HCIBTUSB=3Dm
CONFIG_BT_HCIBTSDIO=3Dm
CONFIG_BT_HCIUART=3Dm
CONFIG_BT_HCIUART_H4=3Dy
CONFIG_BT_HCIUART_BCSP=3Dy
# CONFIG_BT_HCIUART_ATH3K is not set
CONFIG_BT_HCIUART_LL=3Dy
CONFIG_BT_HCIBCM203X=3Dm
CONFIG_BT_HCIBPA10X=3Dm
CONFIG_BT_HCIBFUSB=3Dm
CONFIG_BT_HCIDTL1=3Dm
CONFIG_BT_HCIBT3C=3Dm
CONFIG_BT_HCIBLUECARD=3Dm
CONFIG_BT_HCIBTUART=3Dm
CONFIG_BT_HCIVHCI=3Dm
CONFIG_BT_MRVL=3Dm
CONFIG_BT_MRVL_SDIO=3Dm
# CONFIG_BT_ATH3K is not set
CONFIG_AF_RXRPC=3Dm
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=3Dm
CONFIG_FIB_RULES=3Dy
CONFIG_WIRELESS=3Dy
CONFIG_WIRELESS_EXT=3Dy
CONFIG_WEXT_CORE=3Dy
CONFIG_WEXT_PROC=3Dy
CONFIG_WEXT_SPY=3Dy
CONFIG_WEXT_PRIV=3Dy
CONFIG_CFG80211=3Dm
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_REG_DEBUG is not set
CONFIG_CFG80211_DEFAULT_PS=3Dy
# CONFIG_CFG80211_DEBUGFS is not set
# CONFIG_CFG80211_INTERNAL_REGDB is not set
CONFIG_CFG80211_WEXT=3Dy
# CONFIG_WIRELESS_EXT_SYSFS is not set
CONFIG_LIB80211=3Dm
CONFIG_LIB80211_CRYPT_WEP=3Dm
CONFIG_LIB80211_CRYPT_CCMP=3Dm
CONFIG_LIB80211_CRYPT_TKIP=3Dm
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=3Dm
CONFIG_MAC80211_HAS_RC=3Dy
CONFIG_MAC80211_RC_MINSTREL=3Dy
CONFIG_MAC80211_RC_MINSTREL_HT=3Dy
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
CONFIG_MAC80211_MESH=3Dy
CONFIG_MAC80211_LEDS=3Dy
# CONFIG_MAC80211_DEBUGFS is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
# CONFIG_WIMAX is not set
CONFIG_RFKILL=3Dm
CONFIG_RFKILL_LEDS=3Dy
CONFIG_RFKILL_INPUT=3Dy
CONFIG_RFKILL_REGULATOR=3Dm
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_HAVE_BPF_JIT=3Dy

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH=3D""
CONFIG_DEVTMPFS=3Dy
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dy
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=3D""
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_REGMAP=3Dy
CONFIG_REGMAP_I2C=3Dm
CONFIG_REGMAP_SPI=3Dm
CONFIG_DMA_SHARED_BUFFER=3Dy
CONFIG_CONNECTOR=3Dm
CONFIG_MTD=3Dm
# CONFIG_MTD_TESTS is not set
CONFIG_MTD_REDBOOT_PARTS=3Dm
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=3D-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_AR7_PARTS=3Dm

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=3Dm
CONFIG_MTD_BLKDEVS=3Dm
CONFIG_MTD_BLOCK=3Dm
CONFIG_MTD_BLOCK_RO=3Dm
CONFIG_FTL=3Dm
CONFIG_NFTL=3Dm
CONFIG_NFTL_RW=3Dy
CONFIG_INFTL=3Dm
CONFIG_RFD_FTL=3Dm
CONFIG_SSFDC=3Dm
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=3Dm
# CONFIG_MTD_SWAP is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=3Dm
CONFIG_MTD_JEDECPROBE=3Dm
CONFIG_MTD_GEN_PROBE=3Dm
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=3Dy
CONFIG_MTD_CFI_I2=3Dy
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=3Dm
CONFIG_MTD_CFI_AMDSTD=3Dm
CONFIG_MTD_CFI_STAA=3Dm
CONFIG_MTD_CFI_UTIL=3Dm
CONFIG_MTD_RAM=3Dm
CONFIG_MTD_ROM=3Dm
CONFIG_MTD_ABSENT=3Dm

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=3Dy
CONFIG_MTD_PHYSMAP=3Dm
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_SC520CDP=3Dm
CONFIG_MTD_NETSC520=3Dm
CONFIG_MTD_TS5500=3Dm
CONFIG_MTD_SBC_GXX=3Dm
# CONFIG_MTD_AMD76XROM is not set
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
CONFIG_MTD_NETtel=3Dm
# CONFIG_MTD_L440GX is not set
CONFIG_MTD_PCI=3Dm
# CONFIG_MTD_PCMCIA is not set
# CONFIG_MTD_GPIO_ADDR is not set
CONFIG_MTD_INTEL_VR_NOR=3Dm
CONFIG_MTD_PLATRAM=3Dm
# CONFIG_MTD_LATCH_ADDR is not set

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=3Dm
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_DATAFLASH=3Dm
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_M25P80=3Dm
CONFIG_M25PXX_USE_FAST_READ=3Dy
CONFIG_MTD_SST25L=3Dm
CONFIG_MTD_SLRAM=3Dm
CONFIG_MTD_PHRAM=3Dm
CONFIG_MTD_MTDRAM=3Dm
CONFIG_MTDRAM_TOTAL_SIZE=3D4096
CONFIG_MTDRAM_ERASE_SIZE=3D128
CONFIG_MTD_BLOCK2MTD=3Dm

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOC2000=3Dm
CONFIG_MTD_DOC2001=3Dm
CONFIG_MTD_DOC2001PLUS=3Dm
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_DOCPROBE=3Dm
CONFIG_MTD_DOCECC=3Dm
# CONFIG_MTD_DOCPROBE_ADVANCED is not set
CONFIG_MTD_DOCPROBE_ADDRESS=3D0x0
CONFIG_MTD_NAND_ECC=3Dm
# CONFIG_MTD_NAND_ECC_SMC is not set
CONFIG_MTD_NAND=3Dm
# CONFIG_MTD_NAND_VERIFY_WRITE is not set
# CONFIG_MTD_NAND_ECC_BCH is not set
# CONFIG_MTD_SM_COMMON is not set
# CONFIG_MTD_NAND_MUSEUM_IDS is not set
# CONFIG_MTD_NAND_DENALI is not set
CONFIG_MTD_NAND_IDS=3Dm
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=3Dm
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=3D0
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
# CONFIG_MTD_NAND_DOCG4 is not set
CONFIG_MTD_NAND_CAFE=3Dm
CONFIG_MTD_NAND_NANDSIM=3Dm
CONFIG_MTD_NAND_PLATFORM=3Dm
CONFIG_MTD_ALAUDA=3Dm
CONFIG_MTD_ONENAND=3Dm
CONFIG_MTD_ONENAND_VERIFY_WRITE=3Dy
CONFIG_MTD_ONENAND_GENERIC=3Dm
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=3Dy
CONFIG_MTD_ONENAND_SIM=3Dm

#
# LPDDR flash memory drivers
#
CONFIG_MTD_LPDDR=3Dm
CONFIG_MTD_QINFO_PROBE=3Dm
CONFIG_MTD_UBI=3Dm
CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
CONFIG_MTD_UBI_BEB_RESERVE=3D1
# CONFIG_MTD_UBI_GLUEBI is not set
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_SERIAL=3Dm
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=3Dm
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=3Dm
CONFIG_PARPORT_1284=3Dy
CONFIG_PARPORT_NOT_PC=3Dy
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=3Dy
CONFIG_BLK_DEV=3Dy
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_UMEM=3Dm
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=3Dm
# CONFIG_BLK_DEV_NVME is not set
CONFIG_BLK_DEV_OSD=3Dm
CONFIG_BLK_DEV_SX8=3Dm
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D65536
# CONFIG_BLK_DEV_XIP is not set
CONFIG_CDROM_PKTCDVD=3Dm
CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=3Dm
CONFIG_VIRTIO_BLK=3Dm
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_RBD is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
# CONFIG_AD525X_DPOT is not set
CONFIG_IBM_ASM=3Dm
CONFIG_PHANTOM=3Dm
# CONFIG_INTEL_MID_PTI is not set
CONFIG_SGI_IOC4=3Dm
CONFIG_TIFM_CORE=3Dm
CONFIG_TIFM_7XX1=3Dm
CONFIG_ICS932S401=3Dm
CONFIG_ENCLOSURE_SERVICES=3Dm
CONFIG_HP_ILO=3Dm
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=3Dm
CONFIG_ISL29020=3Dm
CONFIG_SENSORS_TSL2550=3Dm
CONFIG_SENSORS_BH1780=3Dm
CONFIG_SENSORS_BH1770=3Dm
CONFIG_SENSORS_APDS990X=3Dm
CONFIG_HMC6352=3Dm
CONFIG_DS1682=3Dm
CONFIG_TI_DAC7512=3Dm
CONFIG_VMWARE_BALLOON=3Dm
CONFIG_BMP085=3Dy
CONFIG_BMP085_I2C=3Dm
CONFIG_BMP085_SPI=3Dm
CONFIG_PCH_PHUB=3Dm
CONFIG_USB_SWITCH_FSA9480=3Dm
CONFIG_C2PORT=3Dm
CONFIG_C2PORT_DURAMAR_2150=3Dm

#
# EEPROM support
#
CONFIG_EEPROM_AT24=3Dm
CONFIG_EEPROM_AT25=3Dm
CONFIG_EEPROM_LEGACY=3Dm
CONFIG_EEPROM_MAX6875=3Dm
CONFIG_EEPROM_93CX6=3Dm
# CONFIG_EEPROM_93XX46 is not set
CONFIG_CB710_CORE=3Dm
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=3Dy
CONFIG_IWMC3200TOP=3Dm
# CONFIG_IWMC3200TOP_DEBUG is not set
# CONFIG_IWMC3200TOP_DEBUGFS is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
CONFIG_HAVE_IDE=3Dy
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=3Dm
CONFIG_RAID_ATTRS=3Dm
CONFIG_SCSI=3Dm
CONFIG_SCSI_DMA=3Dy
CONFIG_SCSI_TGT=3Dm
CONFIG_SCSI_NETLINK=3Dy
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
CONFIG_CHR_DEV_ST=3Dm
CONFIG_CHR_DEV_OSST=3Dm
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dm
CONFIG_CHR_DEV_SCH=3Dm
CONFIG_SCSI_ENCLOSURE=3Dm
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy
CONFIG_SCSI_SCAN_ASYNC=3Dy
CONFIG_SCSI_WAIT_SCAN=3Dm

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=3Dm
CONFIG_SCSI_FC_ATTRS=3Dm
CONFIG_SCSI_FC_TGT_ATTRS=3Dy
CONFIG_SCSI_ISCSI_ATTRS=3Dm
CONFIG_SCSI_SAS_ATTRS=3Dm
CONFIG_SCSI_SAS_LIBSAS=3Dm
CONFIG_SCSI_SAS_ATA=3Dy
CONFIG_SCSI_SAS_HOST_SMP=3Dy
CONFIG_SCSI_SRP_ATTRS=3Dm
CONFIG_SCSI_SRP_TGT_ATTRS=3Dy
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
CONFIG_SCSI_DH=3Dm
CONFIG_SCSI_DH_RDAC=3Dm
CONFIG_SCSI_DH_HP_SW=3Dm
CONFIG_SCSI_DH_EMC=3Dm
CONFIG_SCSI_DH_ALUA=3Dm
CONFIG_SCSI_OSD_INITIATOR=3Dm
CONFIG_SCSI_OSD_ULD=3Dm
CONFIG_SCSI_OSD_DPRINT_SENSE=3D1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=3Dm
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=3Dy
CONFIG_ATA_ACPI=3Dy
CONFIG_SATA_PMP=3Dy

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=3Dm
CONFIG_SATA_AHCI_PLATFORM=3Dm
CONFIG_SATA_INIC162X=3Dm
# CONFIG_SATA_ACARD_AHCI is not set
CONFIG_SATA_SIL24=3Dm
CONFIG_ATA_SFF=3Dy

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=3Dm
CONFIG_SATA_QSTOR=3Dm
CONFIG_SATA_SX4=3Dm
CONFIG_ATA_BMDMA=3Dy

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=3Dm
CONFIG_SATA_MV=3Dm
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
CONFIG_SATA_SIL=3Dm
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
CONFIG_PATA_AMD=3Dm
# CONFIG_PATA_ARASAN_CF is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CS5536 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
CONFIG_PATA_SIS=3Dm
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PCMCIA is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=3Dm
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dm
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID10=3Dm
CONFIG_MD_RAID456=3Dm
# CONFIG_MULTICORE_RAID456 is not set
CONFIG_MD_MULTIPATH=3Dm
CONFIG_MD_FAULTY=3Dm
CONFIG_BLK_DEV_DM=3Dm
# CONFIG_DM_DEBUG is not set
CONFIG_DM_CRYPT=3Dm
CONFIG_DM_SNAPSHOT=3Dm
# CONFIG_DM_THIN_PROVISIONING is not set
CONFIG_DM_MIRROR=3Dm
# CONFIG_DM_RAID is not set
CONFIG_DM_LOG_USERSPACE=3Dm
CONFIG_DM_ZERO=3Dm
CONFIG_DM_MULTIPATH=3Dm
CONFIG_DM_MULTIPATH_QL=3Dm
CONFIG_DM_MULTIPATH_ST=3Dm
CONFIG_DM_DELAY=3Dm
CONFIG_DM_UEVENT=3Dy
# CONFIG_DM_FLAKEY is not set
# CONFIG_DM_VERITY is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=3Dm
CONFIG_FIREWIRE_OHCI=3Dm
CONFIG_FIREWIRE_SBP2=3Dm
CONFIG_FIREWIRE_NET=3Dm
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_I2O=3Dm
CONFIG_I2O_LCT_NOTIFY_ON_CHANGES=3Dy
CONFIG_I2O_EXT_ADAPTEC=3Dy
CONFIG_I2O_EXT_ADAPTEC_DMA64=3Dy
CONFIG_I2O_CONFIG=3Dm
CONFIG_I2O_CONFIG_OLD_IOCTL=3Dy
CONFIG_I2O_BUS=3Dm
CONFIG_I2O_BLOCK=3Dm
CONFIG_I2O_SCSI=3Dm
CONFIG_I2O_PROC=3Dm
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=3Dy
CONFIG_NET_CORE=3Dy
CONFIG_BONDING=3Dm
CONFIG_DUMMY=3Dm
CONFIG_EQUALIZER=3Dm
# CONFIG_NET_FC is not set
CONFIG_MII=3Dm
CONFIG_IEEE802154_DRIVERS=3Dm
CONFIG_IEEE802154_FAKEHARD=3Dm
CONFIG_IFB=3Dm
# CONFIG_NET_TEAM is not set
CONFIG_MACVLAN=3Dm
CONFIG_MACVTAP=3Dm
CONFIG_NETCONSOLE=3Dm
CONFIG_NETCONSOLE_DYNAMIC=3Dy
CONFIG_NETPOLL=3Dy
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=3Dy
CONFIG_TUN=3Dm
CONFIG_VETH=3Dm
CONFIG_VIRTIO_NET=3Dm
CONFIG_SUNGEM_PHY=3Dm
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#
CONFIG_ETHERNET=3Dy
CONFIG_MDIO=3Dm
CONFIG_NET_VENDOR_3COM=3Dy
CONFIG_PCMCIA_3C574=3Dm
CONFIG_PCMCIA_3C589=3Dm
CONFIG_VORTEX=3Dm
CONFIG_TYPHOON=3Dm
CONFIG_NET_VENDOR_ADAPTEC=3Dy
CONFIG_ADAPTEC_STARFIRE=3Dm
CONFIG_NET_VENDOR_ALTEON=3Dy
CONFIG_ACENIC=3Dm
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_NET_VENDOR_AMD=3Dy
CONFIG_AMD8111_ETH=3Dm
CONFIG_PCNET32=3Dm
CONFIG_PCMCIA_NMCLAN=3Dm
CONFIG_NET_VENDOR_ATHEROS=3Dy
CONFIG_ATL2=3Dm
CONFIG_ATL1=3Dm
CONFIG_ATL1E=3Dm
CONFIG_ATL1C=3Dm
CONFIG_NET_VENDOR_BROADCOM=3Dy
CONFIG_B44=3Dm
CONFIG_B44_PCI_AUTOSELECT=3Dy
CONFIG_B44_PCICORE_AUTOSELECT=3Dy
CONFIG_B44_PCI=3Dy
CONFIG_BNX2=3Dm
CONFIG_CNIC=3Dm
CONFIG_TIGON3=3Dm
CONFIG_BNX2X=3Dm
CONFIG_NET_VENDOR_BROCADE=3Dy
CONFIG_BNA=3Dm
# CONFIG_NET_CALXEDA_XGMAC is not set
CONFIG_NET_VENDOR_CHELSIO=3Dy
CONFIG_CHELSIO_T1=3Dm
CONFIG_CHELSIO_T1_1G=3Dy
CONFIG_CHELSIO_T3=3Dm
CONFIG_CHELSIO_T4=3Dm
CONFIG_CHELSIO_T4VF=3Dm
CONFIG_NET_VENDOR_CISCO=3Dy
CONFIG_ENIC=3Dm
CONFIG_DNET=3Dm
CONFIG_NET_VENDOR_DEC=3Dy
CONFIG_NET_TULIP=3Dy
CONFIG_DE2104X=3Dm
CONFIG_DE2104X_DSL=3D0
CONFIG_TULIP=3Dm
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
CONFIG_TULIP_NAPI=3Dy
CONFIG_TULIP_NAPI_HW_MITIGATION=3Dy
CONFIG_DE4X5=3Dm
CONFIG_WINBOND_840=3Dm
CONFIG_DM9102=3Dm
CONFIG_ULI526X=3Dm
CONFIG_PCMCIA_XIRCOM=3Dm
CONFIG_NET_VENDOR_DLINK=3Dy
CONFIG_DE600=3Dm
CONFIG_DE620=3Dm
CONFIG_DL2K=3Dm
CONFIG_SUNDANCE=3Dm
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_NET_VENDOR_EMULEX=3Dy
# CONFIG_BE2NET is not set
# CONFIG_NET_VENDOR_EXAR is not set
CONFIG_NET_VENDOR_FUJITSU=3Dy
CONFIG_PCMCIA_FMVJ18X=3Dm
CONFIG_NET_VENDOR_HP=3Dy
CONFIG_HP100=3Dm
CONFIG_NET_VENDOR_INTEL=3Dy
CONFIG_E100=3Dm
CONFIG_E1000=3Dm
CONFIG_E1000E=3Dm
CONFIG_IGB=3Dm
CONFIG_IGB_DCA=3Dy
# CONFIG_IGB_PTP is not set
CONFIG_IGBVF=3Dm
CONFIG_IXGB=3Dm
CONFIG_IXGBE=3Dm
CONFIG_IXGBE_HWMON=3Dy
CONFIG_IXGBE_DCA=3Dy
CONFIG_IXGBE_DCB=3Dy
# CONFIG_IXGBE_PTP is not set
# CONFIG_IXGBEVF is not set
CONFIG_NET_VENDOR_I825XX=3Dy
# CONFIG_ZNET is not set
CONFIG_IP1000=3Dm
CONFIG_JME=3Dm
CONFIG_NET_VENDOR_MARVELL=3Dy
CONFIG_SKGE=3Dm
# CONFIG_SKGE_DEBUG is not set
# CONFIG_SKGE_GENESIS is not set
CONFIG_SKY2=3Dm
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=3Dy
CONFIG_MLX4_EN=3Dm
CONFIG_MLX4_EN_DCB=3Dy
CONFIG_MLX4_CORE=3Dm
CONFIG_MLX4_DEBUG=3Dy
CONFIG_NET_VENDOR_MICREL=3Dy
CONFIG_KS8842=3Dm
CONFIG_KS8851=3Dm
CONFIG_KS8851_MLL=3Dm
CONFIG_KSZ884X_PCI=3Dm
CONFIG_NET_VENDOR_MICROCHIP=3Dy
CONFIG_ENC28J60=3Dm
# CONFIG_ENC28J60_WRITEVERIFY is not set
CONFIG_NET_VENDOR_MYRI=3Dy
CONFIG_MYRI10GE=3Dm
CONFIG_MYRI10GE_DCA=3Dy
CONFIG_FEALNX=3Dm
CONFIG_NET_VENDOR_NATSEMI=3Dy
CONFIG_NATSEMI=3Dm
CONFIG_NS83820=3Dm
CONFIG_NET_VENDOR_8390=3Dy
CONFIG_PCMCIA_AXNET=3Dm
CONFIG_NE2K_PCI=3Dm
CONFIG_PCMCIA_PCNET=3Dm
CONFIG_NET_VENDOR_NVIDIA=3Dy
CONFIG_FORCEDETH=3Dm
CONFIG_NET_VENDOR_OKI=3Dy
# CONFIG_PCH_GBE is not set
CONFIG_ETHOC=3Dm
CONFIG_NET_PACKET_ENGINE=3Dy
CONFIG_HAMACHI=3Dm
CONFIG_YELLOWFIN=3Dm
CONFIG_NET_VENDOR_QLOGIC=3Dy
CONFIG_QLA3XXX=3Dm
CONFIG_QLCNIC=3Dm
CONFIG_QLGE=3Dm
CONFIG_NETXEN_NIC=3Dm
CONFIG_NET_VENDOR_REALTEK=3Dy
CONFIG_ATP=3Dm
CONFIG_8139CP=3Dm
CONFIG_8139TOO=3Dm
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=3Dy
CONFIG_8139TOO_8129=3Dy
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=3Dm
CONFIG_NET_VENDOR_RDC=3Dy
CONFIG_R6040=3Dm
CONFIG_NET_VENDOR_SEEQ=3Dy
# CONFIG_SEEQ8005 is not set
CONFIG_NET_VENDOR_SILAN=3Dy
CONFIG_SC92031=3Dm
CONFIG_NET_VENDOR_SIS=3Dy
CONFIG_SIS900=3Dm
CONFIG_SIS190=3Dm
CONFIG_SFC=3Dm
CONFIG_SFC_MTD=3Dy
CONFIG_SFC_MCDI_MON=3Dy
CONFIG_SFC_SRIOV=3Dy
CONFIG_NET_VENDOR_SMSC=3Dy
CONFIG_PCMCIA_SMC91C92=3Dm
CONFIG_EPIC100=3Dm
CONFIG_SMSC9420=3Dm
CONFIG_NET_VENDOR_STMICRO=3Dy
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=3Dy
CONFIG_HAPPYMEAL=3Dm
CONFIG_SUNGEM=3Dm
CONFIG_CASSINI=3Dm
CONFIG_NIU=3Dm
CONFIG_NET_VENDOR_TEHUTI=3Dy
CONFIG_TEHUTI=3Dm
CONFIG_NET_VENDOR_TI=3Dy
CONFIG_TLAN=3Dm
CONFIG_NET_VENDOR_VIA=3Dy
CONFIG_VIA_RHINE=3Dm
# CONFIG_VIA_RHINE_MMIO is not set
CONFIG_VIA_VELOCITY=3Dm
CONFIG_NET_VENDOR_WIZNET=3Dy
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=3Dy
CONFIG_PCMCIA_XIRC2PS=3Dm
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=3Dy
CONFIG_PHYLIB=3Dm

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=3Dm
CONFIG_MARVELL_PHY=3Dm
CONFIG_DAVICOM_PHY=3Dm
CONFIG_QSEMI_PHY=3Dm
CONFIG_LXT_PHY=3Dm
CONFIG_CICADA_PHY=3Dm
CONFIG_VITESSE_PHY=3Dm
CONFIG_SMSC_PHY=3Dm
CONFIG_BROADCOM_PHY=3Dm
CONFIG_ICPLUS_PHY=3Dm
CONFIG_REALTEK_PHY=3Dm
CONFIG_NATIONAL_PHY=3Dm
CONFIG_STE10XP=3Dm
CONFIG_LSI_ET1011C_PHY=3Dm
CONFIG_MICREL_PHY=3Dm
CONFIG_MDIO_BITBANG=3Dm
# CONFIG_MDIO_GPIO is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_MPPE=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPPOE=3Dm
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
# CONFIG_SLIP is not set
CONFIG_SLHC=3Dm

#
# USB Network Adapters
#
CONFIG_USB_CATC=3Dm
CONFIG_USB_KAWETH=3Dm
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_USBNET=3Dm
CONFIG_USB_NET_AX8817X=3Dm
CONFIG_USB_NET_CDCETHER=3Dm
CONFIG_USB_NET_CDC_EEM=3Dm
CONFIG_USB_NET_CDC_NCM=3Dm
CONFIG_USB_NET_DM9601=3Dm
CONFIG_USB_NET_SMSC75XX=3Dm
CONFIG_USB_NET_SMSC95XX=3Dm
CONFIG_USB_NET_GL620A=3Dm
CONFIG_USB_NET_NET1080=3Dm
CONFIG_USB_NET_PLUSB=3Dm
CONFIG_USB_NET_MCS7830=3Dm
CONFIG_USB_NET_RNDIS_HOST=3Dm
CONFIG_USB_NET_CDC_SUBSET=3Dm
CONFIG_USB_ALI_M5632=3Dy
CONFIG_USB_AN2720=3Dy
CONFIG_USB_BELKIN=3Dy
CONFIG_USB_ARMLINUX=3Dy
CONFIG_USB_EPSON2888=3Dy
CONFIG_USB_KC2190=3Dy
CONFIG_USB_NET_ZAURUS=3Dm
CONFIG_USB_NET_CX82310_ETH=3Dm
CONFIG_USB_NET_KALMIA=3Dm
CONFIG_USB_NET_QMI_WWAN=3Dm
CONFIG_USB_HSO=3Dm
CONFIG_USB_NET_INT51X1=3Dm
CONFIG_USB_IPHETH=3Dm
CONFIG_USB_SIERRA_NET=3Dm
CONFIG_USB_VL600=3Dm
CONFIG_WLAN=3Dy
CONFIG_PCMCIA_RAYCS=3Dm
CONFIG_LIBERTAS_THINFIRM=3Dm
# CONFIG_LIBERTAS_THINFIRM_DEBUG is not set
CONFIG_LIBERTAS_THINFIRM_USB=3Dm
CONFIG_AIRO=3Dm
CONFIG_ATMEL=3Dm
CONFIG_PCI_ATMEL=3Dm
CONFIG_PCMCIA_ATMEL=3Dm
CONFIG_AT76C50X_USB=3Dm
CONFIG_AIRO_CS=3Dm
CONFIG_PCMCIA_WL3501=3Dm
# CONFIG_PRISM54 is not set
CONFIG_USB_ZD1201=3Dm
CONFIG_USB_NET_RNDIS_WLAN=3Dm
CONFIG_RTL8180=3Dm
CONFIG_RTL8187=3Dm
CONFIG_RTL8187_LEDS=3Dy
CONFIG_ADM8211=3Dm
CONFIG_MAC80211_HWSIM=3Dm
CONFIG_MWL8K=3Dm
CONFIG_ATH_COMMON=3Dm
# CONFIG_ATH_DEBUG is not set
CONFIG_ATH5K=3Dm
# CONFIG_ATH5K_DEBUG is not set
# CONFIG_ATH5K_TRACER is not set
CONFIG_ATH5K_PCI=3Dy
CONFIG_ATH9K_HW=3Dm
CONFIG_ATH9K_COMMON=3Dm
CONFIG_ATH9K_BTCOEX_SUPPORT=3Dy
CONFIG_ATH9K=3Dm
CONFIG_ATH9K_PCI=3Dy
# CONFIG_ATH9K_AHB is not set
# CONFIG_ATH9K_DEBUGFS is not set
CONFIG_ATH9K_RATE_CONTROL=3Dy
CONFIG_ATH9K_HTC=3Dm
# CONFIG_ATH9K_HTC_DEBUGFS is not set
CONFIG_CARL9170=3Dm
CONFIG_CARL9170_LEDS=3Dy
CONFIG_CARL9170_WPC=3Dy
# CONFIG_CARL9170_HWRNG is not set
CONFIG_ATH6KL=3Dm
# CONFIG_ATH6KL_SDIO is not set
# CONFIG_ATH6KL_USB is not set
# CONFIG_ATH6KL_DEBUG is not set
CONFIG_B43=3Dm
CONFIG_B43_SSB=3Dy
CONFIG_B43_PCI_AUTOSELECT=3Dy
CONFIG_B43_PCICORE_AUTOSELECT=3Dy
CONFIG_B43_PCMCIA=3Dy
CONFIG_B43_SDIO=3Dy
CONFIG_B43_PIO=3Dy
# CONFIG_B43_PHY_N is not set
CONFIG_B43_PHY_LP=3Dy
# CONFIG_B43_PHY_HT is not set
CONFIG_B43_LEDS=3Dy
CONFIG_B43_HWRNG=3Dy
# CONFIG_B43_DEBUG is not set
CONFIG_B43LEGACY=3Dm
CONFIG_B43LEGACY_PCI_AUTOSELECT=3Dy
CONFIG_B43LEGACY_PCICORE_AUTOSELECT=3Dy
CONFIG_B43LEGACY_LEDS=3Dy
CONFIG_B43LEGACY_HWRNG=3Dy
CONFIG_B43LEGACY_DEBUG=3Dy
CONFIG_B43LEGACY_DMA=3Dy
CONFIG_B43LEGACY_PIO=3Dy
CONFIG_B43LEGACY_DMA_AND_PIO_MODE=3Dy
# CONFIG_B43LEGACY_DMA_MODE is not set
# CONFIG_B43LEGACY_PIO_MODE is not set
# CONFIG_BRCMFMAC is not set
CONFIG_HOSTAP=3Dm
CONFIG_HOSTAP_FIRMWARE=3Dy
# CONFIG_HOSTAP_FIRMWARE_NVRAM is not set
CONFIG_HOSTAP_PLX=3Dm
CONFIG_HOSTAP_PCI=3Dm
CONFIG_HOSTAP_CS=3Dm
CONFIG_IPW2100=3Dm
# CONFIG_IPW2100_MONITOR is not set
# CONFIG_IPW2100_DEBUG is not set
CONFIG_IPW2200=3Dm
CONFIG_IPW2200_MONITOR=3Dy
CONFIG_IPW2200_RADIOTAP=3Dy
CONFIG_IPW2200_PROMISCUOUS=3Dy
CONFIG_IPW2200_QOS=3Dy
# CONFIG_IPW2200_DEBUG is not set
CONFIG_LIBIPW=3Dm
# CONFIG_LIBIPW_DEBUG is not set
CONFIG_IWLWIFI=3Dm

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
CONFIG_IWLWIFI_P2P=3Dy
# CONFIG_IWLWIFI_EXPERIMENTAL_MFP is not set
CONFIG_IWLEGACY=3Dm
CONFIG_IWL4965=3Dm
CONFIG_IWL3945=3Dm

#
# iwl3945 / iwl4965 Debugging Options
#
# CONFIG_IWLEGACY_DEBUG is not set
CONFIG_IWM=3Dm
# CONFIG_IWM_DEBUG is not set
# CONFIG_IWM_TRACING is not set
CONFIG_LIBERTAS=3Dm
CONFIG_LIBERTAS_USB=3Dm
CONFIG_LIBERTAS_CS=3Dm
CONFIG_LIBERTAS_SDIO=3Dm
CONFIG_LIBERTAS_SPI=3Dm
# CONFIG_LIBERTAS_DEBUG is not set
# CONFIG_LIBERTAS_MESH is not set
CONFIG_HERMES=3Dm
# CONFIG_HERMES_PRISM is not set
CONFIG_HERMES_CACHE_FW_ON_INIT=3Dy
CONFIG_PLX_HERMES=3Dm
CONFIG_TMD_HERMES=3Dm
CONFIG_NORTEL_HERMES=3Dm
CONFIG_PCMCIA_HERMES=3Dm
CONFIG_PCMCIA_SPECTRUM=3Dm
CONFIG_ORINOCO_USB=3Dm
CONFIG_P54_COMMON=3Dm
CONFIG_P54_USB=3Dm
CONFIG_P54_PCI=3Dm
CONFIG_P54_SPI=3Dm
# CONFIG_P54_SPI_DEFAULT_EEPROM is not set
CONFIG_P54_LEDS=3Dy
CONFIG_RT2X00=3Dm
CONFIG_RT2400PCI=3Dm
CONFIG_RT2500PCI=3Dm
CONFIG_RT61PCI=3Dm
CONFIG_RT2800PCI=3Dm
CONFIG_RT2800PCI_RT33XX=3Dy
CONFIG_RT2800PCI_RT35XX=3Dy
CONFIG_RT2800PCI_RT53XX=3Dy
CONFIG_RT2500USB=3Dm
CONFIG_RT73USB=3Dm
CONFIG_RT2800USB=3Dm
CONFIG_RT2800USB_RT33XX=3Dy
CONFIG_RT2800USB_RT35XX=3Dy
# CONFIG_RT2800USB_RT53XX is not set
# CONFIG_RT2800USB_UNKNOWN is not set
CONFIG_RT2800_LIB=3Dm
CONFIG_RT2X00_LIB_PCI=3Dm
CONFIG_RT2X00_LIB_USB=3Dm
CONFIG_RT2X00_LIB=3Dm
CONFIG_RT2X00_LIB_FIRMWARE=3Dy
CONFIG_RT2X00_LIB_CRYPTO=3Dy
CONFIG_RT2X00_LIB_LEDS=3Dy
# CONFIG_RT2X00_DEBUG is not set
CONFIG_RTL8192CE=3Dm
CONFIG_RTL8192SE=3Dm
CONFIG_RTL8192DE=3Dm
CONFIG_RTL8192CU=3Dm
CONFIG_RTLWIFI=3Dm
CONFIG_RTLWIFI_DEBUG=3Dy
CONFIG_RTL8192C_COMMON=3Dm
CONFIG_WL_TI=3Dy
CONFIG_WL1251=3Dm
CONFIG_WL1251_SPI=3Dm
CONFIG_WL1251_SDIO=3Dm
CONFIG_WL12XX=3Dm
CONFIG_WLCORE=3Dm
CONFIG_WLCORE_SPI=3Dm
CONFIG_WLCORE_SDIO=3Dm
CONFIG_WL12XX_PLATFORM_DATA=3Dy
CONFIG_ZD1211RW=3Dm
# CONFIG_ZD1211RW_DEBUG is not set
CONFIG_MWIFIEX=3Dm
CONFIG_MWIFIEX_SDIO=3Dm
CONFIG_MWIFIEX_PCIE=3Dm
CONFIG_MWIFIEX_USB=3Dm

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
CONFIG_VMXNET3=3Dm
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
CONFIG_INPUT_FF_MEMLESS=3Dm
CONFIG_INPUT_POLLDEV=3Dm
CONFIG_INPUT_SPARSEKMAP=3Dm
CONFIG_INPUT_MATRIXKMAP=3Dm

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_EVDEV=3Dm
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ADP5588=3Dm
CONFIG_KEYBOARD_ADP5589=3Dm
CONFIG_KEYBOARD_ATKBD=3Dy
CONFIG_KEYBOARD_QT1070=3Dm
CONFIG_KEYBOARD_QT2160=3Dm
CONFIG_KEYBOARD_LKKBD=3Dm
CONFIG_KEYBOARD_GPIO=3Dm
CONFIG_KEYBOARD_GPIO_POLLED=3Dm
CONFIG_KEYBOARD_TCA6416=3Dm
CONFIG_KEYBOARD_TCA8418=3Dm
CONFIG_KEYBOARD_MATRIX=3Dm
CONFIG_KEYBOARD_LM8323=3Dm
CONFIG_KEYBOARD_LM8333=3Dm
CONFIG_KEYBOARD_MAX7359=3Dm
CONFIG_KEYBOARD_MCS=3Dm
CONFIG_KEYBOARD_MPR121=3Dm
CONFIG_KEYBOARD_NEWTON=3Dm
CONFIG_KEYBOARD_OPENCORES=3Dm
CONFIG_KEYBOARD_STOWAWAY=3Dm
CONFIG_KEYBOARD_SUNKBD=3Dm
CONFIG_KEYBOARD_OMAP4=3Dm
CONFIG_KEYBOARD_XTKBD=3Dm
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dm
CONFIG_MOUSE_PS2_ALPS=3Dy
CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
CONFIG_MOUSE_PS2_ELANTECH=3Dy
CONFIG_MOUSE_PS2_SENTELIC=3Dy
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_SERIAL=3Dm
CONFIG_MOUSE_APPLETOUCH=3Dm
CONFIG_MOUSE_BCM5974=3Dm
CONFIG_MOUSE_VSXXXAA=3Dm
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=3Dm
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=3Dy
CONFIG_JOYSTICK_ANALOG=3Dm
CONFIG_JOYSTICK_A3D=3Dm
CONFIG_JOYSTICK_ADI=3Dm
CONFIG_JOYSTICK_COBRA=3Dm
CONFIG_JOYSTICK_GF2K=3Dm
CONFIG_JOYSTICK_GRIP=3Dm
CONFIG_JOYSTICK_GRIP_MP=3Dm
CONFIG_JOYSTICK_GUILLEMOT=3Dm
CONFIG_JOYSTICK_INTERACT=3Dm
CONFIG_JOYSTICK_SIDEWINDER=3Dm
CONFIG_JOYSTICK_TMDC=3Dm
CONFIG_JOYSTICK_IFORCE=3Dm
CONFIG_JOYSTICK_IFORCE_USB=3Dy
CONFIG_JOYSTICK_IFORCE_232=3Dy
CONFIG_JOYSTICK_WARRIOR=3Dm
CONFIG_JOYSTICK_MAGELLAN=3Dm
CONFIG_JOYSTICK_SPACEORB=3Dm
CONFIG_JOYSTICK_SPACEBALL=3Dm
CONFIG_JOYSTICK_STINGER=3Dm
CONFIG_JOYSTICK_TWIDJOY=3Dm
CONFIG_JOYSTICK_ZHENHUA=3Dm
CONFIG_JOYSTICK_DB9=3Dm
CONFIG_JOYSTICK_GAMECON=3Dm
CONFIG_JOYSTICK_TURBOGRAFX=3Dm
CONFIG_JOYSTICK_AS5011=3Dm
CONFIG_JOYSTICK_JOYDUMP=3Dm
CONFIG_JOYSTICK_XPAD=3Dm
CONFIG_JOYSTICK_XPAD_FF=3Dy
CONFIG_JOYSTICK_XPAD_LEDS=3Dy
CONFIG_JOYSTICK_WALKERA0701=3Dm
CONFIG_INPUT_TABLET=3Dy
CONFIG_TABLET_USB_ACECAD=3Dm
CONFIG_TABLET_USB_AIPTEK=3Dm
CONFIG_TABLET_USB_GTCO=3Dm
CONFIG_TABLET_USB_HANWANG=3Dm
CONFIG_TABLET_USB_KBTAB=3Dm
CONFIG_TABLET_USB_WACOM=3Dm
CONFIG_INPUT_TOUCHSCREEN=3Dy
CONFIG_TOUCHSCREEN_ADS7846=3Dm
CONFIG_TOUCHSCREEN_AD7877=3Dm
CONFIG_TOUCHSCREEN_AD7879=3Dm
CONFIG_TOUCHSCREEN_AD7879_I2C=3Dm
CONFIG_TOUCHSCREEN_AD7879_SPI=3Dm
CONFIG_TOUCHSCREEN_ATMEL_MXT=3Dm
CONFIG_TOUCHSCREEN_AUO_PIXCIR=3Dm
CONFIG_TOUCHSCREEN_BU21013=3Dm
CONFIG_TOUCHSCREEN_CY8CTMG110=3Dm
CONFIG_TOUCHSCREEN_CYTTSP_CORE=3Dm
CONFIG_TOUCHSCREEN_CYTTSP_I2C=3Dm
CONFIG_TOUCHSCREEN_CYTTSP_SPI=3Dm
CONFIG_TOUCHSCREEN_DYNAPRO=3Dm
CONFIG_TOUCHSCREEN_HAMPSHIRE=3Dm
CONFIG_TOUCHSCREEN_EETI=3Dm
CONFIG_TOUCHSCREEN_EGALAX=3Dm
CONFIG_TOUCHSCREEN_FUJITSU=3Dm
CONFIG_TOUCHSCREEN_ILI210X=3Dm
CONFIG_TOUCHSCREEN_GUNZE=3Dm
CONFIG_TOUCHSCREEN_ELO=3Dm
CONFIG_TOUCHSCREEN_WACOM_W8001=3Dm
CONFIG_TOUCHSCREEN_WACOM_I2C=3Dm
CONFIG_TOUCHSCREEN_MAX11801=3Dm
CONFIG_TOUCHSCREEN_MCS5000=3Dm
CONFIG_TOUCHSCREEN_MTOUCH=3Dm
CONFIG_TOUCHSCREEN_INEXIO=3Dm
CONFIG_TOUCHSCREEN_MK712=3Dm
CONFIG_TOUCHSCREEN_PENMOUNT=3Dm
CONFIG_TOUCHSCREEN_TOUCHRIGHT=3Dm
CONFIG_TOUCHSCREEN_TOUCHWIN=3Dm
CONFIG_TOUCHSCREEN_PIXCIR=3Dm
CONFIG_TOUCHSCREEN_WM97XX=3Dm
CONFIG_TOUCHSCREEN_WM9705=3Dy
CONFIG_TOUCHSCREEN_WM9712=3Dy
CONFIG_TOUCHSCREEN_WM9713=3Dy
CONFIG_TOUCHSCREEN_USB_COMPOSITE=3Dm
CONFIG_TOUCHSCREEN_USB_EGALAX=3Dy
CONFIG_TOUCHSCREEN_USB_PANJIT=3Dy
CONFIG_TOUCHSCREEN_USB_3M=3Dy
CONFIG_TOUCHSCREEN_USB_ITM=3Dy
CONFIG_TOUCHSCREEN_USB_ETURBO=3Dy
CONFIG_TOUCHSCREEN_USB_GUNZE=3Dy
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=3Dy
CONFIG_TOUCHSCREEN_USB_IRTOUCH=3Dy
CONFIG_TOUCHSCREEN_USB_IDEALTEK=3Dy
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=3Dy
CONFIG_TOUCHSCREEN_USB_GOTOP=3Dy
CONFIG_TOUCHSCREEN_USB_JASTEC=3Dy
CONFIG_TOUCHSCREEN_USB_ELO=3Dy
CONFIG_TOUCHSCREEN_USB_E2I=3Dy
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=3Dy
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=3Dy
CONFIG_TOUCHSCREEN_USB_NEXIO=3Dy
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=3Dy
CONFIG_TOUCHSCREEN_TOUCHIT213=3Dm
CONFIG_TOUCHSCREEN_TSC_SERIO=3Dm
CONFIG_TOUCHSCREEN_TSC2005=3Dm
CONFIG_TOUCHSCREEN_TSC2007=3Dm
CONFIG_TOUCHSCREEN_ST1232=3Dm
CONFIG_TOUCHSCREEN_TPS6507X=3Dm
CONFIG_INPUT_MISC=3Dy
CONFIG_INPUT_AD714X=3Dm
CONFIG_INPUT_AD714X_I2C=3Dm
CONFIG_INPUT_AD714X_SPI=3Dm
CONFIG_INPUT_BMA150=3Dm
CONFIG_INPUT_PCSPKR=3Dm
CONFIG_INPUT_MMA8450=3Dm
CONFIG_INPUT_MPU3050=3Dm
CONFIG_INPUT_APANEL=3Dm
CONFIG_INPUT_GP2A=3Dm
CONFIG_INPUT_GPIO_TILT_POLLED=3Dm
CONFIG_INPUT_ATLAS_BTNS=3Dm
CONFIG_INPUT_ATI_REMOTE2=3Dm
CONFIG_INPUT_KEYSPAN_REMOTE=3Dm
CONFIG_INPUT_KXTJ9=3Dm
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
CONFIG_INPUT_POWERMATE=3Dm
CONFIG_INPUT_YEALINK=3Dm
CONFIG_INPUT_CM109=3Dm
CONFIG_INPUT_UINPUT=3Dm
CONFIG_INPUT_PCF50633_PMU=3Dm
CONFIG_INPUT_PCF8574=3Dm
CONFIG_INPUT_GPIO_ROTARY_ENCODER=3Dm
CONFIG_INPUT_ADXL34X=3Dm
CONFIG_INPUT_ADXL34X_I2C=3Dm
CONFIG_INPUT_ADXL34X_SPI=3Dm
CONFIG_INPUT_CMA3000=3Dm
CONFIG_INPUT_CMA3000_I2C=3Dm

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dm
CONFIG_SERIO_CT82C710=3Dm
CONFIG_SERIO_PARKBD=3Dm
CONFIG_SERIO_PCIPS2=3Dm
CONFIG_SERIO_LIBPS2=3Dy
CONFIG_SERIO_RAW=3Dm
CONFIG_SERIO_ALTERA_PS2=3Dm
CONFIG_SERIO_PS2MULT=3Dm
CONFIG_GAMEPORT=3Dm
CONFIG_GAMEPORT_NS558=3Dm
CONFIG_GAMEPORT_L4=3Dm
CONFIG_GAMEPORT_EMU10K1=3Dm
CONFIG_GAMEPORT_FM801=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_CONSOLE_TRANSLATIONS=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_VT_CONSOLE_SLEEP=3Dy
CONFIG_HW_CONSOLE=3Dy
CONFIG_VT_HW_CONSOLE_BINDING=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_DEVPTS_MULTIPLE_INSTANCES=3Dy
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=3Dy
CONFIG_ROCKETPORT=3Dm
CONFIG_CYCLADES=3Dm
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=3Dm
CONFIG_MOXA_SMARTIO=3Dm
CONFIG_SYNCLINK=3Dm
CONFIG_SYNCLINKMP=3Dm
CONFIG_SYNCLINK_GT=3Dm
CONFIG_NOZOMI=3Dm
CONFIG_ISI=3Dm
CONFIG_N_HDLC=3Dm
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_DEVKMEM is not set
CONFIG_STALDRV=3Dy

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_FIX_EARLYCON_MEM=3Dy
CONFIG_SERIAL_8250_PCI=3Dy
CONFIG_SERIAL_8250_PNP=3Dy
CONFIG_SERIAL_8250_CS=3Dm
CONFIG_SERIAL_8250_NR_UARTS=3D32
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
CONFIG_SERIAL_8250_EXTENDED=3Dy
CONFIG_SERIAL_8250_MANY_PORTS=3Dy
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=3Dy

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=3Dm
# CONFIG_SERIAL_MAX3107 is not set
# CONFIG_SERIAL_MFD_HSU is not set
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_SERIAL_JSM=3Dm
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=3Dm
CONFIG_HVC_DRIVER=3Dy
CONFIG_VIRTIO_CONSOLE=3Dm
CONFIG_IPMI_HANDLER=3Dm
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=3Dm
CONFIG_IPMI_SI=3Dm
CONFIG_IPMI_WATCHDOG=3Dm
CONFIG_IPMI_POWEROFF=3Dm
CONFIG_HW_RANDOM=3Dm
CONFIG_HW_RANDOM_TIMERIOMEM=3Dm
CONFIG_HW_RANDOM_INTEL=3Dm
CONFIG_HW_RANDOM_AMD=3Dm
CONFIG_HW_RANDOM_VIA=3Dm
CONFIG_HW_RANDOM_VIRTIO=3Dm
CONFIG_NVRAM=3Dm
CONFIG_R3964=3Dm
CONFIG_APPLICOM=3Dm

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=3Dm
CONFIG_CARDMAN_4000=3Dm
CONFIG_CARDMAN_4040=3Dm
CONFIG_IPWIRELESS=3Dm
CONFIG_MWAVE=3Dm
CONFIG_RAW_DRIVER=3Dm
CONFIG_MAX_RAW_DEVS=3D256
CONFIG_HPET=3Dy
CONFIG_HPET_MMAP=3Dy
CONFIG_HANGCHECK_TIMER=3Dm
CONFIG_TCG_TPM=3Dm
CONFIG_TCG_TIS=3Dm
CONFIG_TCG_NSC=3Dm
CONFIG_TCG_ATMEL=3Dm
CONFIG_TCG_INFINEON=3Dm
CONFIG_TELCLOCK=3Dm
CONFIG_DEVPORT=3Dy
CONFIG_I2C=3Dm
CONFIG_I2C_BOARDINFO=3Dy
CONFIG_I2C_COMPAT=3Dy
CONFIG_I2C_CHARDEV=3Dm
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=3Dy
CONFIG_I2C_SMBUS=3Dm
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_ALGOPCA=3Dm

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=3Dm
CONFIG_I2C_ALI1563=3Dm
CONFIG_I2C_ALI15X3=3Dm
CONFIG_I2C_AMD756=3Dm
CONFIG_I2C_AMD756_S4882=3Dm
CONFIG_I2C_AMD8111=3Dm
CONFIG_I2C_I801=3Dm
CONFIG_I2C_ISCH=3Dm
CONFIG_I2C_PIIX4=3Dm
CONFIG_I2C_NFORCE2=3Dm
CONFIG_I2C_NFORCE2_S4985=3Dm
CONFIG_I2C_SIS5595=3Dm
CONFIG_I2C_SIS630=3Dm
CONFIG_I2C_SIS96X=3Dm
CONFIG_I2C_VIA=3Dm
CONFIG_I2C_VIAPRO=3Dm

#
# ACPI drivers
#
CONFIG_I2C_SCMI=3Dm

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_INTEL_MID is not set
CONFIG_I2C_OCORES=3Dm
CONFIG_I2C_PCA_PLATFORM=3Dm
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=3Dm
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=3Dm
CONFIG_I2C_PARPORT_LIGHT=3Dm
CONFIG_I2C_TAOS_EVM=3Dm
CONFIG_I2C_TINY_USB=3Dm

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_STUB=3Dm
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=3Dy
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=3Dy

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_BITBANG=3Dm
CONFIG_SPI_BUTTERFLY=3Dm
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_LM70_LLP=3Dm
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX_PCI is not set
# CONFIG_SPI_TOPCLIFF_PCH is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_DESIGNWARE is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_TLE62X0=3Dm
# CONFIG_HSI is not set

#
# PPS support
#
CONFIG_PPS=3Dm
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=3Dm

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy
CONFIG_GPIOLIB=3Dy
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set

#
# Memory mapped GPIO drivers:
#
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_IT8761E is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_VX855 is not set

#
# I2C GPIO expanders:
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_ADP5588 is not set

#
# PCI GPIO expanders:
#
# CONFIG_GPIO_LANGWELL is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders:
#
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MCP23S08 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_74X164 is not set

#
# AC97 GPIO expanders:
#

#
# MODULbus GPIO expanders:
#
CONFIG_W1=3Dm
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=3Dm
CONFIG_W1_MASTER_DS2490=3Dm
CONFIG_W1_MASTER_DS2482=3Dm
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=3Dm
CONFIG_W1_SLAVE_SMEM=3Dm
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2431=3Dm
CONFIG_W1_SLAVE_DS2433=3Dm
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2760=3Dm
CONFIG_W1_SLAVE_DS2780=3Dm
CONFIG_W1_SLAVE_DS2781=3Dm
CONFIG_W1_SLAVE_BQ27000=3Dm
CONFIG_POWER_SUPPLY=3Dy
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=3Dm
CONFIG_TEST_POWER=3Dm
CONFIG_BATTERY_DS2760=3Dm
CONFIG_BATTERY_DS2780=3Dm
CONFIG_BATTERY_DS2781=3Dm
CONFIG_BATTERY_DS2782=3Dm
CONFIG_BATTERY_SBS=3Dm
CONFIG_BATTERY_BQ27x00=3Dm
CONFIG_BATTERY_BQ27X00_I2C=3Dy
CONFIG_BATTERY_BQ27X00_PLATFORM=3Dy
CONFIG_BATTERY_MAX17040=3Dm
CONFIG_BATTERY_MAX17042=3Dm
CONFIG_CHARGER_PCF50633=3Dm
CONFIG_CHARGER_ISP1704=3Dm
CONFIG_CHARGER_MAX8903=3Dm
CONFIG_CHARGER_LP8727=3Dm
CONFIG_CHARGER_GPIO=3Dm
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_SMB347=3Dm
CONFIG_HWMON=3Dy
CONFIG_HWMON_VID=3Dm
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=3Dm
CONFIG_SENSORS_ABITUGURU3=3Dm
CONFIG_SENSORS_AD7314=3Dm
CONFIG_SENSORS_AD7414=3Dm
CONFIG_SENSORS_AD7418=3Dm
CONFIG_SENSORS_ADCXX=3Dm
CONFIG_SENSORS_ADM1021=3Dm
CONFIG_SENSORS_ADM1025=3Dm
CONFIG_SENSORS_ADM1026=3Dm
CONFIG_SENSORS_ADM1029=3Dm
CONFIG_SENSORS_ADM1031=3Dm
CONFIG_SENSORS_ADM9240=3Dm
CONFIG_SENSORS_ADT7411=3Dm
CONFIG_SENSORS_ADT7462=3Dm
CONFIG_SENSORS_ADT7470=3Dm
CONFIG_SENSORS_ADT7475=3Dm
CONFIG_SENSORS_ASC7621=3Dm
CONFIG_SENSORS_K8TEMP=3Dm
CONFIG_SENSORS_K10TEMP=3Dm
CONFIG_SENSORS_FAM15H_POWER=3Dm
CONFIG_SENSORS_ASB100=3Dm
CONFIG_SENSORS_ATXP1=3Dm
CONFIG_SENSORS_DS620=3Dm
CONFIG_SENSORS_DS1621=3Dm
CONFIG_SENSORS_I5K_AMB=3Dm
CONFIG_SENSORS_F71805F=3Dm
CONFIG_SENSORS_F71882FG=3Dm
CONFIG_SENSORS_F75375S=3Dm
CONFIG_SENSORS_FSCHMD=3Dm
CONFIG_SENSORS_G760A=3Dm
CONFIG_SENSORS_GL518SM=3Dm
CONFIG_SENSORS_GL520SM=3Dm
CONFIG_SENSORS_GPIO_FAN=3Dm
CONFIG_SENSORS_CORETEMP=3Dm
CONFIG_SENSORS_IBMAEM=3Dm
CONFIG_SENSORS_IBMPEX=3Dm
CONFIG_SENSORS_IT87=3Dm
CONFIG_SENSORS_JC42=3Dm
CONFIG_SENSORS_LINEAGE=3Dm
CONFIG_SENSORS_LM63=3Dm
CONFIG_SENSORS_LM70=3Dm
CONFIG_SENSORS_LM73=3Dm
CONFIG_SENSORS_LM75=3Dm
CONFIG_SENSORS_LM77=3Dm
CONFIG_SENSORS_LM78=3Dm
CONFIG_SENSORS_LM80=3Dm
CONFIG_SENSORS_LM83=3Dm
CONFIG_SENSORS_LM85=3Dm
CONFIG_SENSORS_LM87=3Dm
CONFIG_SENSORS_LM90=3Dm
CONFIG_SENSORS_LM92=3Dm
CONFIG_SENSORS_LM93=3Dm
CONFIG_SENSORS_LTC4151=3Dm
CONFIG_SENSORS_LTC4215=3Dm
CONFIG_SENSORS_LTC4245=3Dm
CONFIG_SENSORS_LTC4261=3Dm
CONFIG_SENSORS_LM95241=3Dm
CONFIG_SENSORS_LM95245=3Dm
CONFIG_SENSORS_MAX1111=3Dm
CONFIG_SENSORS_MAX16065=3Dm
CONFIG_SENSORS_MAX1619=3Dm
CONFIG_SENSORS_MAX1668=3Dm
CONFIG_SENSORS_MAX6639=3Dm
CONFIG_SENSORS_MAX6642=3Dm
CONFIG_SENSORS_MAX6650=3Dm
CONFIG_SENSORS_MCP3021=3Dm
CONFIG_SENSORS_NTC_THERMISTOR=3Dm
CONFIG_SENSORS_PC87360=3Dm
CONFIG_SENSORS_PC87427=3Dm
CONFIG_SENSORS_PCF8591=3Dm
CONFIG_PMBUS=3Dm
CONFIG_SENSORS_PMBUS=3Dm
CONFIG_SENSORS_ADM1275=3Dm
CONFIG_SENSORS_LM25066=3Dm
CONFIG_SENSORS_LTC2978=3Dm
CONFIG_SENSORS_MAX16064=3Dm
CONFIG_SENSORS_MAX34440=3Dm
CONFIG_SENSORS_MAX8688=3Dm
CONFIG_SENSORS_UCD9000=3Dm
CONFIG_SENSORS_UCD9200=3Dm
CONFIG_SENSORS_ZL6100=3Dm
CONFIG_SENSORS_SHT15=3Dm
CONFIG_SENSORS_SHT21=3Dm
CONFIG_SENSORS_SIS5595=3Dm
CONFIG_SENSORS_SMM665=3Dm
CONFIG_SENSORS_DME1737=3Dm
CONFIG_SENSORS_EMC1403=3Dm
CONFIG_SENSORS_EMC2103=3Dm
CONFIG_SENSORS_EMC6W201=3Dm
CONFIG_SENSORS_SMSC47M1=3Dm
CONFIG_SENSORS_SMSC47M192=3Dm
CONFIG_SENSORS_SMSC47B397=3Dm
CONFIG_SENSORS_SCH56XX_COMMON=3Dm
CONFIG_SENSORS_SCH5627=3Dm
CONFIG_SENSORS_SCH5636=3Dm
CONFIG_SENSORS_ADS1015=3Dm
CONFIG_SENSORS_ADS7828=3Dm
CONFIG_SENSORS_ADS7871=3Dm
CONFIG_SENSORS_AMC6821=3Dm
CONFIG_SENSORS_INA2XX=3Dm
CONFIG_SENSORS_THMC50=3Dm
CONFIG_SENSORS_TMP102=3Dm
CONFIG_SENSORS_TMP401=3Dm
CONFIG_SENSORS_TMP421=3Dm
CONFIG_SENSORS_VIA_CPUTEMP=3Dm
CONFIG_SENSORS_VIA686A=3Dm
CONFIG_SENSORS_VT1211=3Dm
CONFIG_SENSORS_VT8231=3Dm
CONFIG_SENSORS_W83781D=3Dm
CONFIG_SENSORS_W83791D=3Dm
CONFIG_SENSORS_W83792D=3Dm
CONFIG_SENSORS_W83793=3Dm
CONFIG_SENSORS_W83795=3Dm
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=3Dm
CONFIG_SENSORS_W83L786NG=3Dm
CONFIG_SENSORS_W83627HF=3Dm
CONFIG_SENSORS_W83627EHF=3Dm
CONFIG_SENSORS_APPLESMC=3Dm

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=3Dm
CONFIG_SENSORS_ATK0110=3Dm
CONFIG_THERMAL=3Dm
CONFIG_THERMAL_HWMON=3Dy
CONFIG_WATCHDOG=3Dy
CONFIG_WATCHDOG_CORE=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=3Dm
CONFIG_ACQUIRE_WDT=3Dm
CONFIG_ADVANTECH_WDT=3Dm
CONFIG_ALIM1535_WDT=3Dm
CONFIG_ALIM7101_WDT=3Dm
CONFIG_F71808E_WDT=3Dm
CONFIG_SP5100_TCO=3Dm
CONFIG_SC520_WDT=3Dm
CONFIG_SBC_FITPC2_WATCHDOG=3Dm
CONFIG_EUROTECH_WDT=3Dm
CONFIG_IB700_WDT=3Dm
CONFIG_IBMASR=3Dm
CONFIG_WAFER_WDT=3Dm
CONFIG_I6300ESB_WDT=3Dm
# CONFIG_IE6XX_WDT is not set
CONFIG_ITCO_WDT=3Dm
CONFIG_ITCO_VENDOR_SUPPORT=3Dy
CONFIG_IT8712F_WDT=3Dm
CONFIG_IT87_WDT=3Dm
CONFIG_HP_WATCHDOG=3Dm
CONFIG_HPWDT_NMI_DECODING=3Dy
CONFIG_SC1200_WDT=3Dm
CONFIG_PC87413_WDT=3Dm
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=3Dm
CONFIG_SBC8360_WDT=3Dm
CONFIG_CPU5_WDT=3Dm
CONFIG_SMSC_SCH311X_WDT=3Dm
CONFIG_SMSC37B787_WDT=3Dm
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=3Dm
CONFIG_W83697HF_WDT=3Dm
CONFIG_W83697UG_WDT=3Dm
CONFIG_W83877F_WDT=3Dm
CONFIG_W83977F_WDT=3Dm
CONFIG_MACHZ_WDT=3Dm
CONFIG_SBC_EPX_C3_WATCHDOG=3Dm

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=3Dm
CONFIG_WDTPCI=3Dm

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=3Dm
CONFIG_SSB_POSSIBLE=3Dy

#
# Sonics Silicon Backplane
#
CONFIG_SSB=3Dm
CONFIG_SSB_SPROM=3Dy
CONFIG_SSB_BLOCKIO=3Dy
CONFIG_SSB_PCIHOST_POSSIBLE=3Dy
CONFIG_SSB_PCIHOST=3Dy
CONFIG_SSB_B43_PCI_BRIDGE=3Dy
CONFIG_SSB_PCMCIAHOST_POSSIBLE=3Dy
CONFIG_SSB_PCMCIAHOST=3Dy
CONFIG_SSB_SDIOHOST_POSSIBLE=3Dy
CONFIG_SSB_SDIOHOST=3Dy
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=3Dy
CONFIG_SSB_DRIVER_PCICORE=3Dy
CONFIG_BCMA_POSSIBLE=3Dy

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=3Dm
CONFIG_MFD_SM501=3Dm
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_HTC_PASIC3=3Dm
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_PCF50633=3Dm
CONFIG_PCF50633_ADC=3Dm
CONFIG_PCF50633_GPIO=3Dm
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_LPC_SCH=3Dm
CONFIG_LPC_ICH=3Dm
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_REGULATOR=3Dy
# CONFIG_REGULATOR_DEBUG is not set
# CONFIG_REGULATOR_DUMMY is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=3Dm
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=3Dm
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_MAX1586=3Dm
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_LP3971=3Dm
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_PCF50633=3Dm
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=3Dm
CONFIG_REGULATOR_TPS6507X=3Dm
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_MEDIA_SUPPORT=3Dm

#
# Multimedia core support
#
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=3Dm
CONFIG_VIDEO_V4L2_COMMON=3Dm
# CONFIG_DVB_CORE is not set
CONFIG_VIDEO_MEDIA=3Dm

#
# Multimedia drivers
#
CONFIG_VIDEO_SAA7146=3Dm
CONFIG_VIDEO_SAA7146_VV=3Dm
CONFIG_RC_CORE=3Dm
CONFIG_LIRC=3Dm
CONFIG_RC_MAP=3Dm
CONFIG_IR_NEC_DECODER=3Dm
CONFIG_IR_RC5_DECODER=3Dm
CONFIG_IR_RC6_DECODER=3Dm
CONFIG_IR_JVC_DECODER=3Dm
CONFIG_IR_SONY_DECODER=3Dm
CONFIG_IR_RC5_SZ_DECODER=3Dm
CONFIG_IR_SANYO_DECODER=3Dm
CONFIG_IR_MCE_KBD_DECODER=3Dm
CONFIG_IR_LIRC_CODEC=3Dm
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_IR_ENE is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_IR_GPIO_CIR is not set
CONFIG_MEDIA_ATTACH=3Dy
CONFIG_MEDIA_TUNER=3Dm
# CONFIG_MEDIA_TUNER_CUSTOMISE is not set
CONFIG_MEDIA_TUNER_SIMPLE=3Dm
CONFIG_MEDIA_TUNER_TDA8290=3Dm
CONFIG_MEDIA_TUNER_TDA827X=3Dm
CONFIG_MEDIA_TUNER_TDA18271=3Dm
CONFIG_MEDIA_TUNER_TDA9887=3Dm
CONFIG_MEDIA_TUNER_TEA5761=3Dm
CONFIG_MEDIA_TUNER_TEA5767=3Dm
CONFIG_MEDIA_TUNER_MT20XX=3Dm
CONFIG_MEDIA_TUNER_XC2028=3Dm
CONFIG_MEDIA_TUNER_XC5000=3Dm
CONFIG_MEDIA_TUNER_XC4000=3Dm
CONFIG_MEDIA_TUNER_MC44S803=3Dm
CONFIG_VIDEO_V4L2=3Dm
CONFIG_VIDEOBUF_GEN=3Dm
CONFIG_VIDEOBUF_DMA_SG=3Dm
CONFIG_VIDEOBUF_VMALLOC=3Dm
CONFIG_VIDEOBUF_DMA_CONTIG=3Dm
CONFIG_VIDEO_BTCX=3Dm
CONFIG_VIDEO_TVEEPROM=3Dm
CONFIG_VIDEO_TUNER=3Dm
CONFIG_VIDEOBUF2_CORE=3Dm
CONFIG_VIDEOBUF2_MEMOPS=3Dm
CONFIG_VIDEOBUF2_DMA_CONTIG=3Dm
CONFIG_VIDEOBUF2_VMALLOC=3Dm
CONFIG_VIDEO_CAPTURE_DRIVERS=3Dy
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_HELPER_CHIPS_AUTO=3Dy
CONFIG_VIDEO_IR_I2C=3Dm

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=3Dm
CONFIG_VIDEO_TDA7432=3Dm
CONFIG_VIDEO_TDA9840=3Dm
CONFIG_VIDEO_TEA6415C=3Dm
CONFIG_VIDEO_TEA6420=3Dm
CONFIG_VIDEO_MSP3400=3Dm
CONFIG_VIDEO_CS53L32A=3Dm
CONFIG_VIDEO_WM8775=3Dm
CONFIG_VIDEO_WM8739=3Dm
CONFIG_VIDEO_VP27SMPX=3Dm

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=3Dm

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=3Dm
CONFIG_VIDEO_BT819=3Dm
CONFIG_VIDEO_BT856=3Dm
CONFIG_VIDEO_BT866=3Dm
CONFIG_VIDEO_KS0127=3Dm
CONFIG_VIDEO_SAA7110=3Dm
CONFIG_VIDEO_SAA711X=3Dm
CONFIG_VIDEO_TVP5150=3Dm
CONFIG_VIDEO_VPX3220=3Dm

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=3Dm
CONFIG_VIDEO_CX25840=3Dm

#
# MPEG video encoders
#
CONFIG_VIDEO_CX2341X=3Dm

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=3Dm
CONFIG_VIDEO_SAA7185=3Dm
CONFIG_VIDEO_ADV7170=3Dm
CONFIG_VIDEO_ADV7175=3Dm

#
# Camera sensor devices
#
CONFIG_VIDEO_OV7670=3Dm
CONFIG_VIDEO_MT9V011=3Dm

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=3Dm
CONFIG_VIDEO_UPD64083=3Dm

#
# Miscelaneous helper chips
#
CONFIG_VIDEO_M52790=3Dm
CONFIG_VIDEO_VIVI=3Dm
CONFIG_V4L_USB_DRIVERS=3Dy
CONFIG_USB_VIDEO_CLASS=3Dm
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=3Dy
CONFIG_USB_GSPCA=3Dm
CONFIG_USB_M5602=3Dm
CONFIG_USB_STV06XX=3Dm
CONFIG_USB_GL860=3Dm
# CONFIG_USB_GSPCA_BENQ is not set
CONFIG_USB_GSPCA_CONEX=3Dm
# CONFIG_USB_GSPCA_CPIA1 is not set
CONFIG_USB_GSPCA_ETOMS=3Dm
CONFIG_USB_GSPCA_FINEPIX=3Dm
CONFIG_USB_GSPCA_JEILINJ=3Dm
# CONFIG_USB_GSPCA_JL2005BCD is not set
# CONFIG_USB_GSPCA_KINECT is not set
# CONFIG_USB_GSPCA_KONICA is not set
CONFIG_USB_GSPCA_MARS=3Dm
CONFIG_USB_GSPCA_MR97310A=3Dm
# CONFIG_USB_GSPCA_NW80X is not set
CONFIG_USB_GSPCA_OV519=3Dm
CONFIG_USB_GSPCA_OV534=3Dm
# CONFIG_USB_GSPCA_OV534_9 is not set
CONFIG_USB_GSPCA_PAC207=3Dm
# CONFIG_USB_GSPCA_PAC7302 is not set
CONFIG_USB_GSPCA_PAC7311=3Dm
# CONFIG_USB_GSPCA_SE401 is not set
# CONFIG_USB_GSPCA_SN9C2028 is not set
CONFIG_USB_GSPCA_SN9C20X=3Dm
CONFIG_USB_GSPCA_SONIXB=3Dm
CONFIG_USB_GSPCA_SONIXJ=3Dm
CONFIG_USB_GSPCA_SPCA500=3Dm
CONFIG_USB_GSPCA_SPCA501=3Dm
CONFIG_USB_GSPCA_SPCA505=3Dm
CONFIG_USB_GSPCA_SPCA506=3Dm
CONFIG_USB_GSPCA_SPCA508=3Dm
CONFIG_USB_GSPCA_SPCA561=3Dm
# CONFIG_USB_GSPCA_SPCA1528 is not set
CONFIG_USB_GSPCA_SQ905=3Dm
CONFIG_USB_GSPCA_SQ905C=3Dm
# CONFIG_USB_GSPCA_SQ930X is not set
CONFIG_USB_GSPCA_STK014=3Dm
# CONFIG_USB_GSPCA_STV0680 is not set
CONFIG_USB_GSPCA_SUNPLUS=3Dm
CONFIG_USB_GSPCA_T613=3Dm
# CONFIG_USB_GSPCA_TOPRO is not set
CONFIG_USB_GSPCA_TV8532=3Dm
CONFIG_USB_GSPCA_VC032X=3Dm
# CONFIG_USB_GSPCA_VICAM is not set
# CONFIG_USB_GSPCA_XIRLINK_CIT is not set
CONFIG_USB_GSPCA_ZC3XX=3Dm
CONFIG_VIDEO_PVRUSB2=3Dm
CONFIG_VIDEO_PVRUSB2_SYSFS=3Dy
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=3Dm
CONFIG_VIDEO_EM28XX=3Dm
CONFIG_VIDEO_EM28XX_ALSA=3Dm
CONFIG_VIDEO_EM28XX_RC=3Dm
CONFIG_VIDEO_CX231XX=3Dm
CONFIG_VIDEO_CX231XX_RC=3Dy
CONFIG_VIDEO_CX231XX_ALSA=3Dm
CONFIG_VIDEO_TM6000=3Dm
CONFIG_VIDEO_TM6000_ALSA=3Dm
CONFIG_VIDEO_USBVISION=3Dm
CONFIG_USB_SN9C102=3Dm
CONFIG_USB_PWC=3Dm
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=3Dy
CONFIG_VIDEO_CPIA2=3Dm
CONFIG_USB_ZR364XX=3Dm
CONFIG_USB_STKWEBCAM=3Dm
CONFIG_USB_S2255=3Dm
CONFIG_V4L_PCI_DRIVERS=3Dy
CONFIG_VIDEO_BT848=3Dm
CONFIG_VIDEO_CX88=3Dm
CONFIG_VIDEO_CX88_ALSA=3Dm
CONFIG_VIDEO_CX88_BLACKBIRD=3Dm
CONFIG_VIDEO_CX88_MPEG=3Dm
CONFIG_VIDEO_HEXIUM_GEMINI=3Dm
CONFIG_VIDEO_HEXIUM_ORION=3Dm
CONFIG_VIDEO_IVTV=3Dm
CONFIG_VIDEO_FB_IVTV=3Dm
CONFIG_VIDEO_MEYE=3Dm
CONFIG_VIDEO_MXB=3Dm
CONFIG_VIDEO_SAA7134=3Dm
CONFIG_VIDEO_SAA7134_ALSA=3Dm
CONFIG_VIDEO_SAA7134_RC=3Dy
CONFIG_VIDEO_ZORAN=3Dm
CONFIG_VIDEO_ZORAN_DC30=3Dm
CONFIG_VIDEO_ZORAN_ZR36060=3Dm
CONFIG_VIDEO_ZORAN_BUZ=3Dm
CONFIG_VIDEO_ZORAN_DC10=3Dm
CONFIG_VIDEO_ZORAN_LML33=3Dm
CONFIG_VIDEO_ZORAN_LML33R10=3Dm
CONFIG_VIDEO_ZORAN_AVS6EYES=3Dm
# CONFIG_V4L_ISA_PARPORT_DRIVERS is not set
CONFIG_V4L_PLATFORM_DRIVERS=3Dy
CONFIG_VIDEO_CAFE_CCIC=3Dm
CONFIG_VIDEO_VIA_CAMERA=3Dm
CONFIG_VIDEO_TIMBERDALE=3Dm
CONFIG_SOC_CAMERA=3Dm
CONFIG_SOC_CAMERA_IMX074=3Dm
CONFIG_SOC_CAMERA_MT9M001=3Dm
CONFIG_SOC_CAMERA_MT9M111=3Dm
CONFIG_SOC_CAMERA_MT9T031=3Dm
CONFIG_SOC_CAMERA_MT9T112=3Dm
CONFIG_SOC_CAMERA_MT9V022=3Dm
CONFIG_SOC_CAMERA_RJ54N1=3Dm
CONFIG_SOC_CAMERA_TW9910=3Dm
CONFIG_SOC_CAMERA_PLATFORM=3Dm
CONFIG_SOC_CAMERA_OV2640=3Dm
CONFIG_SOC_CAMERA_OV5642=3Dm
CONFIG_SOC_CAMERA_OV6650=3Dm
CONFIG_SOC_CAMERA_OV772X=3Dm
CONFIG_SOC_CAMERA_OV9640=3Dm
CONFIG_SOC_CAMERA_OV9740=3Dm
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_RADIO_ADAPTERS is not set

#
# Graphics support
#
CONFIG_AGP=3Dy
CONFIG_AGP_AMD64=3Dy
CONFIG_AGP_INTEL=3Dy
CONFIG_AGP_SIS=3Dy
CONFIG_AGP_VIA=3Dy
CONFIG_VGA_ARB=3Dy
CONFIG_VGA_ARB_MAX_GPUS=3D16
CONFIG_VGA_SWITCHEROO=3Dy
CONFIG_DRM=3Dm
CONFIG_DRM_KMS_HELPER=3Dm
CONFIG_DRM_LOAD_EDID_FIRMWARE=3Dy
CONFIG_DRM_TTM=3Dm
CONFIG_DRM_TDFX=3Dm
CONFIG_DRM_R128=3Dm
CONFIG_DRM_RADEON=3Dm
CONFIG_DRM_RADEON_KMS=3Dy
CONFIG_DRM_NOUVEAU=3Dm
CONFIG_DRM_NOUVEAU_BACKLIGHT=3Dy
# CONFIG_DRM_NOUVEAU_DEBUG is not set

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=3Dm
CONFIG_DRM_I2C_SIL164=3Dm
CONFIG_DRM_I915=3Dm
# CONFIG_DRM_I915_KMS is not set
CONFIG_DRM_MGA=3Dm
CONFIG_DRM_SIS=3Dm
CONFIG_DRM_VIA=3Dm
CONFIG_DRM_SAVAGE=3Dm
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_STUB_POULSBO=3Dm
CONFIG_VGASTATE=3Dm
CONFIG_VIDEO_OUTPUT_CONTROL=3Dm
CONFIG_FB=3Dy
CONFIG_FIRMWARE_EDID=3Dy
CONFIG_FB_DDC=3Dm
CONFIG_FB_BOOT_VESA_SUPPORT=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=3Dm
CONFIG_FB_SYS_COPYAREA=3Dm
CONFIG_FB_SYS_IMAGEBLIT=3Dm
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=3Dm
# CONFIG_FB_WMT_GE_ROPS is not set
CONFIG_FB_DEFERRED_IO=3Dy
CONFIG_FB_HECUBA=3Dm
CONFIG_FB_SVGALIB=3Dm
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
CONFIG_FB_TILEBLITTING=3Dy

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=3Dm
CONFIG_FB_PM2=3Dm
CONFIG_FB_PM2_FIFO_DISCONNECT=3Dy
CONFIG_FB_CYBER2000=3Dm
CONFIG_FB_CYBER2000_DDC=3Dy
CONFIG_FB_ARC=3Dm
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=3Dm
CONFIG_FB_UVESA=3Dm
CONFIG_FB_VESA=3Dy
CONFIG_FB_EFI=3Dy
CONFIG_FB_N411=3Dm
CONFIG_FB_HGA=3Dm
CONFIG_FB_S1D13XXX=3Dm
CONFIG_FB_NVIDIA=3Dm
# CONFIG_FB_NVIDIA_I2C is not set
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=3Dy
# CONFIG_FB_RIVA is not set
CONFIG_FB_I740=3Dm
CONFIG_FB_LE80578=3Dm
CONFIG_FB_CARILLO_RANCH=3Dm
CONFIG_FB_MATROX=3Dm
CONFIG_FB_MATROX_MILLENIUM=3Dy
CONFIG_FB_MATROX_MYSTIQUE=3Dy
CONFIG_FB_MATROX_G=3Dy
CONFIG_FB_MATROX_I2C=3Dm
CONFIG_FB_MATROX_MAVEN=3Dm
CONFIG_FB_RADEON=3Dm
CONFIG_FB_RADEON_I2C=3Dy
CONFIG_FB_RADEON_BACKLIGHT=3Dy
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=3Dm
CONFIG_FB_ATY128_BACKLIGHT=3Dy
CONFIG_FB_ATY=3Dm
CONFIG_FB_ATY_CT=3Dy
# CONFIG_FB_ATY_GENERIC_LCD is not set
CONFIG_FB_ATY_GX=3Dy
CONFIG_FB_ATY_BACKLIGHT=3Dy
CONFIG_FB_S3=3Dm
CONFIG_FB_S3_DDC=3Dy
CONFIG_FB_SAVAGE=3Dm
# CONFIG_FB_SAVAGE_I2C is not set
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=3Dm
CONFIG_FB_SIS_300=3Dy
CONFIG_FB_SIS_315=3Dy
CONFIG_FB_VIA=3Dm
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=3Dm
CONFIG_FB_KYRO=3Dm
CONFIG_FB_3DFX=3Dm
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_3DFX_I2C=3Dy
CONFIG_FB_VOODOO1=3Dm
CONFIG_FB_VT8623=3Dm
CONFIG_FB_TRIDENT=3Dm
CONFIG_FB_ARK=3Dm
CONFIG_FB_PM3=3Dm
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_TMIO is not set
CONFIG_FB_SM501=3Dm
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
CONFIG_FB_VIRTUAL=3Dm
CONFIG_FB_METRONOME=3Dm
CONFIG_FB_MB862XX=3Dm
CONFIG_FB_MB862XX_PCI_GDC=3Dy
CONFIG_FB_MB862XX_I2C=3Dy
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
# CONFIG_EXYNOS_VIDEO is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_PROGEAR=3Dm
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_LP855X is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
# CONFIG_LOGO is not set
CONFIG_SOUND=3Dm
CONFIG_SOUND_OSS_CORE=3Dy
CONFIG_SOUND_OSS_CORE_PRECLAIM=3Dy
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_JACK=3Dy
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_PCM_OSS_PLUGINS=3Dy
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_HRTIMER=3Dm
CONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy
CONFIG_SND_DYNAMIC_MINORS=3Dy
CONFIG_SND_SUPPORT_OLD_API=3Dy
CONFIG_SND_VERBOSE_PROCFS=3Dy
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=3Dy
CONFIG_SND_KCTL_JACK=3Dy
CONFIG_SND_DMA_SGBUF=3Dy
CONFIG_SND_RAWMIDI_SEQ=3Dm
CONFIG_SND_OPL3_LIB_SEQ=3Dm
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
CONFIG_SND_EMU10K1_SEQ=3Dm
CONFIG_SND_MPU401_UART=3Dm
CONFIG_SND_OPL3_LIB=3Dm
CONFIG_SND_VX_LIB=3Dm
CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_DRIVERS=3Dy
CONFIG_SND_PCSP=3Dm
CONFIG_SND_DUMMY=3Dm
# CONFIG_SND_ALOOP is not set
CONFIG_SND_VIRMIDI=3Dm
CONFIG_SND_MTPAV=3Dm
CONFIG_SND_MTS64=3Dm
CONFIG_SND_SERIAL_U16550=3Dm
CONFIG_SND_MPU401=3Dm
CONFIG_SND_PORTMAN2X4=3Dm
CONFIG_SND_AC97_POWER_SAVE=3Dy
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=3D0
CONFIG_SND_SB_COMMON=3Dm
CONFIG_SND_SB16_DSP=3Dm
CONFIG_SND_TEA575X=3Dm
CONFIG_SND_PCI=3Dy
CONFIG_SND_AD1889=3Dm
CONFIG_SND_ALS300=3Dm
CONFIG_SND_ALS4000=3Dm
CONFIG_SND_ALI5451=3Dm
CONFIG_SND_ASIHPI=3Dm
CONFIG_SND_ATIIXP=3Dm
CONFIG_SND_ATIIXP_MODEM=3Dm
CONFIG_SND_AU8810=3Dm
CONFIG_SND_AU8820=3Dm
CONFIG_SND_AU8830=3Dm
CONFIG_SND_AW2=3Dm
CONFIG_SND_AZT3328=3Dm
CONFIG_SND_BT87X=3Dm
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=3Dm
CONFIG_SND_CMIPCI=3Dm
CONFIG_SND_OXYGEN_LIB=3Dm
CONFIG_SND_OXYGEN=3Dm
CONFIG_SND_CS4281=3Dm
CONFIG_SND_CS46XX=3Dm
CONFIG_SND_CS46XX_NEW_DSP=3Dy
CONFIG_SND_CS5530=3Dm
CONFIG_SND_CS5535AUDIO=3Dm
CONFIG_SND_CTXFI=3Dm
CONFIG_SND_DARLA20=3Dm
CONFIG_SND_GINA20=3Dm
CONFIG_SND_LAYLA20=3Dm
CONFIG_SND_DARLA24=3Dm
CONFIG_SND_GINA24=3Dm
CONFIG_SND_LAYLA24=3Dm
CONFIG_SND_MONA=3Dm
CONFIG_SND_MIA=3Dm
CONFIG_SND_ECHO3G=3Dm
CONFIG_SND_INDIGO=3Dm
CONFIG_SND_INDIGOIO=3Dm
CONFIG_SND_INDIGODJ=3Dm
CONFIG_SND_INDIGOIOX=3Dm
CONFIG_SND_INDIGODJX=3Dm
CONFIG_SND_EMU10K1=3Dm
CONFIG_SND_EMU10K1X=3Dm
CONFIG_SND_ENS1370=3Dm
CONFIG_SND_ENS1371=3Dm
CONFIG_SND_ES1938=3Dm
CONFIG_SND_ES1968=3Dm
# CONFIG_SND_ES1968_INPUT is not set
# CONFIG_SND_ES1968_RADIO is not set
CONFIG_SND_FM801=3Dm
CONFIG_SND_FM801_TEA575X_BOOL=3Dy
CONFIG_SND_HDA_INTEL=3Dm
CONFIG_SND_HDA_PREALLOC_SIZE=3D64
CONFIG_SND_HDA_HWDEP=3Dy
CONFIG_SND_HDA_RECONFIG=3Dy
CONFIG_SND_HDA_INPUT_BEEP=3Dy
CONFIG_SND_HDA_INPUT_BEEP_MODE=3D1
CONFIG_SND_HDA_INPUT_JACK=3Dy
CONFIG_SND_HDA_PATCH_LOADER=3Dy
CONFIG_SND_HDA_CODEC_REALTEK=3Dy
CONFIG_SND_HDA_CODEC_ANALOG=3Dy
CONFIG_SND_HDA_CODEC_SIGMATEL=3Dy
CONFIG_SND_HDA_CODEC_VIA=3Dy
CONFIG_SND_HDA_CODEC_HDMI=3Dy
CONFIG_SND_HDA_CODEC_CIRRUS=3Dy
CONFIG_SND_HDA_CODEC_CONEXANT=3Dy
CONFIG_SND_HDA_CODEC_CA0110=3Dy
CONFIG_SND_HDA_CODEC_CA0132=3Dy
CONFIG_SND_HDA_CODEC_CMEDIA=3Dy
CONFIG_SND_HDA_CODEC_SI3054=3Dy
CONFIG_SND_HDA_GENERIC=3Dy
CONFIG_SND_HDA_POWER_SAVE=3Dy
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=3D0
CONFIG_SND_HDSP=3Dm
CONFIG_SND_HDSPM=3Dm
CONFIG_SND_ICE1712=3Dm
CONFIG_SND_ICE1724=3Dm
CONFIG_SND_INTEL8X0=3Dm
CONFIG_SND_INTEL8X0M=3Dm
CONFIG_SND_KORG1212=3Dm
# CONFIG_SND_LOLA is not set
CONFIG_SND_LX6464ES=3Dm
CONFIG_SND_MAESTRO3=3Dm
# CONFIG_SND_MAESTRO3_INPUT is not set
CONFIG_SND_MIXART=3Dm
CONFIG_SND_NM256=3Dm
CONFIG_SND_PCXHR=3Dm
CONFIG_SND_RIPTIDE=3Dm
CONFIG_SND_RME32=3Dm
CONFIG_SND_RME96=3Dm
CONFIG_SND_RME9652=3Dm
CONFIG_SND_SONICVIBES=3Dm
CONFIG_SND_TRIDENT=3Dm
CONFIG_SND_VIA82XX=3Dm
CONFIG_SND_VIA82XX_MODEM=3Dm
CONFIG_SND_VIRTUOSO=3Dm
CONFIG_SND_VX222=3Dm
CONFIG_SND_YMFPCI=3Dm
CONFIG_SND_SPI=3Dy
CONFIG_SND_USB=3Dy
CONFIG_SND_USB_AUDIO=3Dm
CONFIG_SND_USB_UA101=3Dm
CONFIG_SND_USB_USX2Y=3Dm
CONFIG_SND_USB_CAIAQ=3Dm
CONFIG_SND_USB_CAIAQ_INPUT=3Dy
CONFIG_SND_USB_US122L=3Dm
CONFIG_SND_USB_6FIRE=3Dm
CONFIG_SND_FIREWIRE=3Dy
# CONFIG_SND_FIREWIRE_SPEAKERS is not set
# CONFIG_SND_ISIGHT is not set
CONFIG_SND_PCMCIA=3Dy
CONFIG_SND_VXPOCKET=3Dm
CONFIG_SND_PDAUDIOCF=3Dm
# CONFIG_SND_SOC is not set
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=3Dm

#
# HID support
#
CONFIG_HID=3Dm
CONFIG_HIDRAW=3Dy
CONFIG_HID_GENERIC=3Dm

#
# Special HID drivers
#
CONFIG_HID_A4TECH=3Dm
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=3Dm
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=3Dm
CONFIG_HID_CHERRY=3Dm
CONFIG_HID_CHICONY=3Dm
# CONFIG_HID_PRODIKEYS is not set
CONFIG_HID_CYPRESS=3Dm
CONFIG_HID_DRAGONRISE=3Dm
CONFIG_DRAGONRISE_FF=3Dy
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=3Dm
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=3Dm
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=3Dm
CONFIG_HID_TWINHAN=3Dm
CONFIG_HID_KENSINGTON=3Dm
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LOGITECH=3Dm
CONFIG_HID_LOGITECH_DJ=3Dm
CONFIG_LOGITECH_FF=3Dy
CONFIG_LOGIRUMBLEPAD2_FF=3Dy
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=3Dy
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MICROSOFT=3Dm
CONFIG_HID_MONTEREY=3Dm
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTRIG=3Dm
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=3Dm
CONFIG_PANTHERLORD_FF=3Dy
CONFIG_HID_PETALYNX=3Dm
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=3Dm
CONFIG_HID_SONY=3Dm
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_SUNPLUS=3Dm
CONFIG_HID_GREENASIA=3Dm
CONFIG_GREENASIA_FF=3Dy
CONFIG_HID_SMARTJOYPLUS=3Dm
CONFIG_SMARTJOYPLUS_FF=3Dy
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=3Dm
CONFIG_HID_THRUSTMASTER=3Dm
CONFIG_THRUSTMASTER_FF=3Dy
CONFIG_HID_WACOM=3Dm
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_ZEROPLUS=3Dm
CONFIG_ZEROPLUS_FF=3Dy
# CONFIG_HID_ZYDACRON is not set

#
# USB HID support
#
CONFIG_USB_HID=3Dm
CONFIG_HID_PID=3Dy
CONFIG_USB_HIDDEV=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB_ARCH_HAS_EHCI=3Dy
CONFIG_USB_ARCH_HAS_XHCI=3Dy
CONFIG_USB_SUPPORT=3Dy
CONFIG_USB_COMMON=3Dm
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB=3Dm
# CONFIG_USB_DEBUG is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DYNAMIC_MINORS=3Dy
CONFIG_USB_SUSPEND=3Dy
# CONFIG_USB_OTG is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_MON=3Dm
CONFIG_USB_WUSB_CBAF=3Dm
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=3Dm
CONFIG_USB_XHCI_HCD=3Dm
# CONFIG_USB_XHCI_HCD_DEBUGGING is not set
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
# CONFIG_USB_OXU210HP_HCD is not set
CONFIG_USB_ISP116X_HCD=3Dm
# CONFIG_USB_ISP1760_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_OHCI_HCD=3Dm
# CONFIG_USB_OHCI_HCD_SSB is not set
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_UHCI_HCD=3Dm
CONFIG_USB_U132_HCD=3Dm
CONFIG_USB_SL811_HCD=3Dm
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_SL811_CS=3Dm
CONFIG_USB_R8A66597_HCD=3Dm
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_RENESAS_USBHS is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_WDM=3Dm
CONFIG_USB_TMC=3Dm

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=3Dm
CONFIG_REALTEK_AUTOPM=3Dy
CONFIG_USB_STORAGE_DATAFAB=3Dm
CONFIG_USB_STORAGE_FREECOM=3Dm
CONFIG_USB_STORAGE_ISD200=3Dm
CONFIG_USB_STORAGE_USBAT=3Dm
CONFIG_USB_STORAGE_SDDR09=3Dm
CONFIG_USB_STORAGE_SDDR55=3Dm
CONFIG_USB_STORAGE_JUMPSHOT=3Dm
CONFIG_USB_STORAGE_ALAUDA=3Dm
CONFIG_USB_STORAGE_ONETOUCH=3Dm
CONFIG_USB_STORAGE_KARMA=3Dm
CONFIG_USB_STORAGE_CYPRESS_ATACB=3Dm
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=3Dm
CONFIG_USB_MICROTEK=3Dm

#
# USB port drivers
#
CONFIG_USB_USS720=3Dm
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_EZUSB=3Dy
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_AIRCABLE=3Dm
CONFIG_USB_SERIAL_ARK3116=3Dm
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_CH341=3Dm
CONFIG_USB_SERIAL_WHITEHEAT=3Dm
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_CP210X=3Dm
CONFIG_USB_SERIAL_CYPRESS_M8=3Dm
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_FUNSOFT=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
CONFIG_USB_SERIAL_F81232=3Dm
CONFIG_USB_SERIAL_GARMIN=3Dm
CONFIG_USB_SERIAL_IPW=3Dm
CONFIG_USB_SERIAL_IUU=3Dm
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
CONFIG_USB_SERIAL_KEYSPAN=3Dm
CONFIG_USB_SERIAL_KLSI=3Dm
CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
CONFIG_USB_SERIAL_MCT_U232=3Dm
CONFIG_USB_SERIAL_METRO=3Dm
CONFIG_USB_SERIAL_MOS7720=3Dm
# CONFIG_USB_SERIAL_MOS7715_PARPORT is not set
CONFIG_USB_SERIAL_MOS7840=3Dm
CONFIG_USB_SERIAL_MOTOROLA=3Dm
CONFIG_USB_SERIAL_NAVMAN=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
CONFIG_USB_SERIAL_OTI6858=3Dm
CONFIG_USB_SERIAL_QCAUX=3Dm
CONFIG_USB_SERIAL_QUALCOMM=3Dm
CONFIG_USB_SERIAL_SPCP8X5=3Dm
CONFIG_USB_SERIAL_HP4X=3Dm
CONFIG_USB_SERIAL_SAFE=3Dm
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_SIEMENS_MPI=3Dm
CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dm
CONFIG_USB_SERIAL_SYMBOL=3Dm
CONFIG_USB_SERIAL_TI=3Dm
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_WWAN=3Dm
CONFIG_USB_SERIAL_OPTION=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_SERIAL_OPTICON=3Dm
CONFIG_USB_SERIAL_VIVOPAY_SERIAL=3Dm
CONFIG_USB_SERIAL_ZIO=3Dm
CONFIG_USB_SERIAL_SSU100=3Dm
CONFIG_USB_SERIAL_QT2=3Dm
CONFIG_USB_SERIAL_DEBUG=3Dm

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=3Dm
CONFIG_USB_EMI26=3Dm
CONFIG_USB_ADUTUX=3Dm
CONFIG_USB_SEVSEG=3Dm
CONFIG_USB_RIO500=3Dm
CONFIG_USB_LEGOTOWER=3Dm
CONFIG_USB_LCD=3Dm
CONFIG_USB_LED=3Dm
CONFIG_USB_CYPRESS_CY7C63=3Dm
CONFIG_USB_CYTHERM=3Dm
CONFIG_USB_IDMOUSE=3Dm
CONFIG_USB_FTDI_ELAN=3Dm
CONFIG_USB_APPLEDISPLAY=3Dm
CONFIG_USB_SISUSBVGA=3Dm
CONFIG_USB_SISUSBVGA_CON=3Dy
CONFIG_USB_LD=3Dm
CONFIG_USB_TRANCEVIBRATOR=3Dm
CONFIG_USB_IOWARRIOR=3Dm
CONFIG_USB_TEST=3Dm
CONFIG_USB_ISIGHTFW=3Dm
# CONFIG_USB_YUREX is not set

#
# USB Physical Layer drivers
#
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_GADGET=3Dm
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=3D2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=3D2

#
# USB Peripheral Controller
#
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_DUMMY_HCD is not set
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_FILE_STORAGE is not set
# CONFIG_USB_MASS_STORAGE is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set

#
# OTG and related infrastructure
#
CONFIG_USB_OTG_UTILS=3Dy
# CONFIG_USB_GPIO_VBUS is not set
CONFIG_NOP_USB_XCEIV=3Dm
# CONFIG_UWB is not set
CONFIG_MMC=3Dm
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_UNSAFE_RESUME is not set
# CONFIG_MMC_CLKGATE is not set

#
# MMC/SD/SDIO Card Drivers
#
CONFIG_MMC_BLOCK=3Dm
CONFIG_MMC_BLOCK_MINORS=3D8
CONFIG_MMC_BLOCK_BOUNCE=3Dy
CONFIG_SDIO_UART=3Dm
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=3Dm
CONFIG_MMC_SDHCI_PCI=3Dm
# CONFIG_MMC_RICOH_MMC is not set
CONFIG_MMC_SDHCI_PLTFM=3Dm
CONFIG_MMC_WBSD=3Dm
CONFIG_MMC_TIFM_SD=3Dm
CONFIG_MMC_SPI=3Dm
CONFIG_MMC_SDRICOH_CS=3Dm
CONFIG_MMC_CB710=3Dm
CONFIG_MMC_VIA_SDMMC=3Dm
CONFIG_MMC_VUB300=3Dm
CONFIG_MMC_USHC=3Dm
CONFIG_MEMSTICK=3Dm
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=3Dm

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=3Dm
CONFIG_MEMSTICK_JMICRON_38X=3Dm
CONFIG_MEMSTICK_R592=3Dm
CONFIG_NEW_LEDS=3Dy
CONFIG_LEDS_CLASS=3Dm

#
# LED drivers
#
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_PCA9532=3Dm
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=3Dm
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_CLEVO_MAIL=3Dm
CONFIG_LEDS_PCA955X=3Dm
# CONFIG_LEDS_PCA9633 is not set
CONFIG_LEDS_DAC124S085=3Dm
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=3Dm
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_DELL_NETBOOKS is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_TRIGGERS=3Dy

#
# LED Triggers
#
CONFIG_LEDS_TRIGGER_TIMER=3Dm
CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm
CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dm
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC=3Dy

#
# Reporting subsystems
#
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=3Dm
# CONFIG_EDAC_MCE_INJ is not set
CONFIG_EDAC_MM_EDAC=3Dm
CONFIG_EDAC_AMD64=3Dm
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=3Dm
CONFIG_EDAC_I82975X=3Dm
CONFIG_EDAC_I3000=3Dm
CONFIG_EDAC_I3200=3Dm
CONFIG_EDAC_X38=3Dm
CONFIG_EDAC_I5400=3Dm
# CONFIG_EDAC_I7CORE is not set
CONFIG_EDAC_I5000=3Dm
CONFIG_EDAC_I5100=3Dm
# CONFIG_EDAC_I7300 is not set
# CONFIG_EDAC_SBRIDGE is not set
CONFIG_RTC_LIB=3Dy
CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_HCTOSYS=3Dy
CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=3Dy
CONFIG_RTC_INTF_PROC=3Dy
CONFIG_RTC_INTF_DEV=3Dy
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_DS1307=3Dm
CONFIG_RTC_DRV_DS1374=3Dm
CONFIG_RTC_DRV_DS1672=3Dm
CONFIG_RTC_DRV_DS3232=3Dm
CONFIG_RTC_DRV_MAX6900=3Dm
CONFIG_RTC_DRV_RS5C372=3Dm
CONFIG_RTC_DRV_ISL1208=3Dm
CONFIG_RTC_DRV_ISL12022=3Dm
CONFIG_RTC_DRV_X1205=3Dm
CONFIG_RTC_DRV_PCF8563=3Dm
CONFIG_RTC_DRV_PCF8583=3Dm
CONFIG_RTC_DRV_M41T80=3Dm
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=3Dm
CONFIG_RTC_DRV_S35390A=3Dm
CONFIG_RTC_DRV_FM3130=3Dm
CONFIG_RTC_DRV_RX8581=3Dm
CONFIG_RTC_DRV_RX8025=3Dm
CONFIG_RTC_DRV_EM3027=3Dm
CONFIG_RTC_DRV_RV3029C2=3Dm

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=3Dm
CONFIG_RTC_DRV_M41T94=3Dm
CONFIG_RTC_DRV_DS1305=3Dm
CONFIG_RTC_DRV_DS1390=3Dm
CONFIG_RTC_DRV_MAX6902=3Dm
CONFIG_RTC_DRV_R9701=3Dm
CONFIG_RTC_DRV_RS5C348=3Dm
CONFIG_RTC_DRV_DS3234=3Dm
CONFIG_RTC_DRV_PCF2123=3Dm

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=3Dy
CONFIG_RTC_DRV_DS1286=3Dm
CONFIG_RTC_DRV_DS1511=3Dm
CONFIG_RTC_DRV_DS1553=3Dm
CONFIG_RTC_DRV_DS1742=3Dm
CONFIG_RTC_DRV_STK17TA8=3Dm
CONFIG_RTC_DRV_M48T86=3Dm
CONFIG_RTC_DRV_M48T35=3Dm
CONFIG_RTC_DRV_M48T59=3Dm
CONFIG_RTC_DRV_MSM6242=3Dm
CONFIG_RTC_DRV_BQ4802=3Dm
CONFIG_RTC_DRV_RP5C01=3Dm
CONFIG_RTC_DRV_V3020=3Dm
CONFIG_RTC_DRV_PCF50633=3Dm

#
# on-CPU RTC drivers
#
CONFIG_DMADEVICES=3Dy
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
# CONFIG_INTEL_MID_DMAC is not set
CONFIG_INTEL_IOATDMA=3Dm
CONFIG_TIMB_DMA=3Dm
# CONFIG_PCH_DMA is not set
CONFIG_DMA_ENGINE=3Dy

#
# DMA Clients
#
CONFIG_NET_DMA=3Dy
CONFIG_ASYNC_TX_DMA=3Dy
# CONFIG_DMATEST is not set
CONFIG_DCA=3Dm
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=3Dm
CONFIG_UIO_CIF=3Dm
CONFIG_UIO_PDRV=3Dm
CONFIG_UIO_PDRV_GENIRQ=3Dm
CONFIG_UIO_AEC=3Dm
CONFIG_UIO_SERCOS3=3Dm
CONFIG_UIO_PCI_GENERIC=3Dm
CONFIG_UIO_NETX=3Dm
CONFIG_VIRTIO=3Dm
CONFIG_VIRTIO_RING=3Dm

#
# Virtio drivers
#
CONFIG_VIRTIO_PCI=3Dm
CONFIG_VIRTIO_BALLOON=3Dm
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=3Dy
CONFIG_ET131X=3Dm
CONFIG_SLICOSS=3Dm
CONFIG_USBIP_CORE=3Dm
CONFIG_USBIP_VHCI_HCD=3Dm
CONFIG_USBIP_HOST=3Dm
# CONFIG_USBIP_DEBUG is not set
CONFIG_W35UND=3Dm
CONFIG_PRISM2_USB=3Dm
# CONFIG_ECHO is not set
CONFIG_COMEDI=3Dm
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=3D2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=3D20480
CONFIG_COMEDI_MISC_DRIVERS=3Dm
# CONFIG_COMEDI_KCOMEDILIB is not set
CONFIG_COMEDI_TEST=3Dm
CONFIG_COMEDI_PARPORT=3Dm
CONFIG_COMEDI_SERIAL2002=3Dm
CONFIG_COMEDI_SKEL=3Dm
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_PCMCIA_DRIVERS=3Dm
CONFIG_COMEDI_CB_DAS16_CS=3Dm
CONFIG_COMEDI_DAS08_CS=3Dm
# CONFIG_COMEDI_NI_DAQ_700_CS is not set
# CONFIG_COMEDI_NI_DAQ_DIO24_CS is not set
# CONFIG_COMEDI_NI_LABPC_CS is not set
# CONFIG_COMEDI_NI_MIO_CS is not set
CONFIG_COMEDI_QUATECH_DAQP_CS=3Dm
CONFIG_COMEDI_USB_DRIVERS=3Dm
CONFIG_COMEDI_DT9812=3Dm
CONFIG_COMEDI_USBDUX=3Dm
CONFIG_COMEDI_USBDUXFAST=3Dm
CONFIG_COMEDI_USBDUXSIGMA=3Dm
CONFIG_COMEDI_VMK80XX=3Dm
CONFIG_COMEDI_NI_COMMON=3Dm
CONFIG_COMEDI_MITE=3Dm
CONFIG_COMEDI_NI_TIO=3Dm
CONFIG_COMEDI_NI_LABPC=3Dm
CONFIG_COMEDI_8255=3Dm
CONFIG_COMEDI_FC=3Dm
CONFIG_COMEDI_DAS08=3Dm
# CONFIG_ASUS_OLED is not set
# CONFIG_PANEL is not set
CONFIG_R8187SE=3Dm
CONFIG_RTL8192U=3Dm
CONFIG_RTLLIB=3Dm
CONFIG_RTLLIB_CRYPTO_CCMP=3Dm
CONFIG_RTLLIB_CRYPTO_TKIP=3Dm
CONFIG_RTLLIB_CRYPTO_WEP=3Dm
CONFIG_RTL8192E=3Dm
CONFIG_R8712U=3Dm
CONFIG_RTS_PSTOR=3Dm
# CONFIG_RTS_PSTOR_DEBUG is not set
CONFIG_RTS5139=3Dm
# CONFIG_RTS5139_DEBUG is not set
# CONFIG_TRANZPORT is not set
CONFIG_IDE_PHISON=3Dm
# CONFIG_LINE6_USB is not set
# CONFIG_USB_SERIAL_QUATECH2 is not set
# CONFIG_VT6655 is not set
CONFIG_VT6656=3Dm
# CONFIG_DX_SEP is not set
# CONFIG_ZRAM is not set
# CONFIG_ZSMALLOC is not set
# CONFIG_WLAGS49_H2 is not set
# CONFIG_WLAGS49_H25 is not set
# CONFIG_FB_SM7XX is not set
# CONFIG_CRYSTALHD is not set
# CONFIG_FB_XGI is not set
# CONFIG_ACPI_QUICKSTART is not set
# CONFIG_USB_ENESTORAGE is not set
# CONFIG_BCM_WIMAX is not set
# CONFIG_FT1000 is not set

#
# Speakup console speech
#
CONFIG_SPEAKUP=3Dm
CONFIG_SPEAKUP_SYNTH_ACNTSA=3Dm
CONFIG_SPEAKUP_SYNTH_ACNTPC=3Dm
CONFIG_SPEAKUP_SYNTH_APOLLO=3Dm
CONFIG_SPEAKUP_SYNTH_AUDPTR=3Dm
CONFIG_SPEAKUP_SYNTH_BNS=3Dm
CONFIG_SPEAKUP_SYNTH_DECTLK=3Dm
CONFIG_SPEAKUP_SYNTH_DECEXT=3Dm
# CONFIG_SPEAKUP_SYNTH_DECPC is not set
CONFIG_SPEAKUP_SYNTH_DTLK=3Dm
CONFIG_SPEAKUP_SYNTH_KEYPC=3Dm
CONFIG_SPEAKUP_SYNTH_LTLK=3Dm
CONFIG_SPEAKUP_SYNTH_SOFT=3Dm
CONFIG_SPEAKUP_SYNTH_SPKOUT=3Dm
CONFIG_SPEAKUP_SYNTH_TXPRT=3Dm
CONFIG_SPEAKUP_SYNTH_DUMMY=3Dm
CONFIG_TOUCHSCREEN_CLEARPAD_TM1217=3Dm
CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4=3Dm
CONFIG_STAGING_MEDIA=3Dy
# CONFIG_VIDEO_DT3155 is not set
# CONFIG_EASYCAP is not set
# CONFIG_VIDEO_GO7007 is not set
# CONFIG_SOLO6X10 is not set
# CONFIG_LIRC_STAGING is not set

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_PHONE is not set
CONFIG_USB_WPAN_HCD=3Dm
# CONFIG_USB_G_CCG is not set
# CONFIG_IPACK_BUS is not set
# CONFIG_WIMAX_GDM72XX is not set
CONFIG_X86_PLATFORM_DEVICES=3Dy
CONFIG_ACER_WMI=3Dm
CONFIG_ACERHDF=3Dm
CONFIG_ASUS_LAPTOP=3Dm
CONFIG_DELL_LAPTOP=3Dm
CONFIG_DELL_WMI=3Dm
CONFIG_DELL_WMI_AIO=3Dm
CONFIG_FUJITSU_LAPTOP=3Dm
# CONFIG_FUJITSU_LAPTOP_DEBUG is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_AMILO_RFKILL is not set
# CONFIG_HP_ACCEL is not set
CONFIG_HP_WMI=3Dm
CONFIG_MSI_LAPTOP=3Dm
CONFIG_PANASONIC_LAPTOP=3Dm
CONFIG_COMPAL_LAPTOP=3Dm
CONFIG_SONY_LAPTOP=3Dm
CONFIG_SONYPI_COMPAT=3Dy
# CONFIG_IDEAPAD_LAPTOP is not set
CONFIG_THINKPAD_ACPI=3Dm
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=3Dy
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=3Dy
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=3Dy
CONFIG_SENSORS_HDAPS=3Dm
CONFIG_ACPI_WMI=3Dm
# CONFIG_MSI_WMI is not set
CONFIG_TOPSTAR_LAPTOP=3Dm
CONFIG_ACPI_TOSHIBA=3Dm
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_IBM_RTL is not set
# CONFIG_XO15_EBOOK is not set
CONFIG_SAMSUNG_LAPTOP=3Dm
CONFIG_MXM_WMI=3Dm
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set

#
# Hardware Spinlock drivers
#
CONFIG_CLKEVT_I8253=3Dy
CONFIG_I8253_LOCK=3Dy
CONFIG_CLKBLD_I8253=3Dy
CONFIG_IOMMU_SUPPORT=3Dy
# CONFIG_AMD_IOMMU is not set
# CONFIG_INTEL_IOMMU is not set
# CONFIG_IRQ_REMAP is not set

#
# Remoteproc drivers (EXPERIMENTAL)
#

#
# Rpmsg drivers (EXPERIMENTAL)
#
# CONFIG_VIRT_DRIVERS is not set
# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_VME_BUS is not set

#
# Firmware Drivers
#
CONFIG_EDD=3Dm
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=3Dy
CONFIG_EFI_VARS=3Dm
CONFIG_DELL_RBU=3Dm
CONFIG_DCDBAS=3Dm
CONFIG_DMIID=3Dy
# CONFIG_DMI_SYSFS is not set
CONFIG_ISCSI_IBFT_FIND=3Dy
# CONFIG_GOOGLE_FIRMWARE is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=3Dy
CONFIG_EXT2_FS=3Dm
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT2_FS_SECURITY=3Dy
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dm
CONFIG_EXT3_DEFAULTS_TO_ORDERED=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_SECURITY=3Dy
CONFIG_EXT4_FS=3Dm
CONFIG_EXT4_FS_XATTR=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_EXT4_FS_SECURITY=3Dy
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD=3Dm
# CONFIG_JBD_DEBUG is not set
CONFIG_JBD2=3Dm
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=3Dm
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=3Dy
CONFIG_REISERFS_FS_POSIX_ACL=3Dy
CONFIG_REISERFS_FS_SECURITY=3Dy
CONFIG_JFS_FS=3Dm
CONFIG_JFS_POSIX_ACL=3Dy
CONFIG_JFS_SECURITY=3Dy
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=3Dm
CONFIG_XFS_QUOTA=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
CONFIG_XFS_RT=3Dy
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=3Dm
CONFIG_GFS2_FS_LOCKING_DLM=3Dy
CONFIG_OCFS2_FS=3Dm
CONFIG_OCFS2_FS_O2CB=3Dm
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dm
CONFIG_OCFS2_FS_STATS=3Dy
CONFIG_OCFS2_DEBUG_MASKLOG=3Dy
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=3Dm
CONFIG_BTRFS_FS_POSIX_ACL=3Dy
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
CONFIG_NILFS2_FS=3Dm
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_EXPORTFS=3Dm
CONFIG_FILE_LOCKING=3Dy
CONFIG_FSNOTIFY=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=3Dy
CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
CONFIG_PRINT_QUOTA_WARNING=3Dy
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=3Dm
CONFIG_QFMT_V1=3Dm
CONFIG_QFMT_V2=3Dm
CONFIG_QUOTACTL=3Dy
CONFIG_QUOTACTL_COMPAT=3Dy
CONFIG_AUTOFS4_FS=3Dm
CONFIG_FUSE_FS=3Dm
CONFIG_CUSE=3Dm
CONFIG_GENERIC_ACL=3Dy

#
# Caches
#
CONFIG_FSCACHE=3Dm
CONFIG_FSCACHE_STATS=3Dy
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=3Dm
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_UDF_FS=3Dm
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"utf8"
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=3Dy

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_PROC_SYSCTL=3Dy
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_TMPFS_XATTR=3Dy
CONFIG_HUGETLBFS=3Dy
CONFIG_HUGETLB_PAGE=3Dy
CONFIG_CONFIGFS_FS=3Dm
CONFIG_MISC_FILESYSTEMS=3Dy
CONFIG_ADFS_FS=3Dm
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=3Dm
CONFIG_ECRYPT_FS=3Dm
CONFIG_HFS_FS=3Dm
CONFIG_HFSPLUS_FS=3Dm
CONFIG_BEFS_FS=3Dm
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=3Dm
CONFIG_EFS_FS=3Dm
CONFIG_JFFS2_FS=3Dm
CONFIG_JFFS2_FS_DEBUG=3D0
CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
CONFIG_JFFS2_SUMMARY=3Dy
CONFIG_JFFS2_FS_XATTR=3Dy
CONFIG_JFFS2_FS_POSIX_ACL=3Dy
CONFIG_JFFS2_FS_SECURITY=3Dy
CONFIG_JFFS2_COMPRESSION_OPTIONS=3Dy
CONFIG_JFFS2_ZLIB=3Dy
CONFIG_JFFS2_LZO=3Dy
CONFIG_JFFS2_RTIME=3Dy
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
CONFIG_JFFS2_CMODE_PRIORITY=3Dy
# CONFIG_JFFS2_CMODE_SIZE is not set
# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
CONFIG_UBIFS_FS=3Dm
CONFIG_UBIFS_FS_ADVANCED_COMPR=3Dy
CONFIG_UBIFS_FS_LZO=3Dy
CONFIG_UBIFS_FS_ZLIB=3Dy
# CONFIG_LOGFS is not set
CONFIG_CRAMFS=3Dm
CONFIG_SQUASHFS=3Dm
# CONFIG_SQUASHFS_XATTR is not set
CONFIG_SQUASHFS_ZLIB=3Dy
# CONFIG_SQUASHFS_LZO is not set
# CONFIG_SQUASHFS_XZ is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3
CONFIG_VXFS_FS=3Dm
CONFIG_MINIX_FS=3Dm
CONFIG_OMFS_FS=3Dm
CONFIG_HPFS_FS=3Dm
CONFIG_QNX4FS_FS=3Dm
# CONFIG_QNX6FS_FS is not set
CONFIG_ROMFS_FS=3Dm
# CONFIG_ROMFS_BACKED_BY_BLOCK is not set
# CONFIG_ROMFS_BACKED_BY_MTD is not set
CONFIG_ROMFS_BACKED_BY_BOTH=3Dy
CONFIG_ROMFS_ON_BLOCK=3Dy
CONFIG_ROMFS_ON_MTD=3Dy
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=3Dm
CONFIG_UFS_FS=3Dm
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
CONFIG_EXOFS_FS=3Dm
# CONFIG_EXOFS_DEBUG is not set
CONFIG_ORE=3Dm
CONFIG_NETWORK_FILESYSTEMS=3Dy
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V2=3Dy
CONFIG_NFS_V3=3Dy
CONFIG_NFS_V3_ACL=3Dy
CONFIG_NFS_V4=3Dy
# CONFIG_NFS_V4_1 is not set
CONFIG_NFS_FSCACHE=3Dy
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V2_ACL=3Dy
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V3_ACL=3Dy
CONFIG_NFSD_V4=3Dy
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_ACL_SUPPORT=3Dm
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_SUNRPC_GSS=3Dm
CONFIG_RPCSEC_GSS_KRB5=3Dm
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=3Dm
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_WEAK_PW_HASH=3Dy
CONFIG_CIFS_UPCALL=3Dy
CONFIG_CIFS_XATTR=3Dy
CONFIG_CIFS_POSIX=3Dy
# CONFIG_CIFS_DEBUG2 is not set
CONFIG_CIFS_DFS_UPCALL=3Dy
# CONFIG_CIFS_FSCACHE is not set
CONFIG_CIFS_ACL=3Dy
# CONFIG_NCP_FS is not set
CONFIG_CODA_FS=3Dm
CONFIG_AFS_FS=3Dm
# CONFIG_AFS_DEBUG is not set
CONFIG_AFS_FSCACHE=3Dy
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"utf8"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_936=3Dm
CONFIG_NLS_CODEPAGE_950=3Dm
CONFIG_NLS_CODEPAGE_932=3Dm
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_CODEPAGE_1250=3Dm
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ASCII=3Dm
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_U=3Dm
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=3Dm
CONFIG_DLM=3Dm
CONFIG_DLM_DEBUG=3Dy

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
CONFIG_PRINTK_TIME=3Dy
CONFIG_DEFAULT_MESSAGE_LOGLEVEL=3D4
CONFIG_ENABLE_WARN_DEPRECATED=3Dy
CONFIG_ENABLE_MUST_CHECK=3Dy
CONFIG_FRAME_WARN=3D2048
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_STRIP_ASM_SYMS=3Dy
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=3Dy
CONFIG_DEBUG_FS=3Dy
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_IPIPE_DEBUG is not set
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_SHIRQ is not set
# CONFIG_LOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=3D0
CONFIG_DETECT_HUNG_TASK=3Dy
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
CONFIG_SCHED_DEBUG=3Dy
# CONFIG_SCHEDSTATS is not set
CONFIG_TIMER_STATS=3Dy
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_PREEMPT=3Dy
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_STACKTRACE=3Dy
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_INFO=3Dy
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_WRITECOUNT is not set
CONFIG_DEBUG_MEMORY_INIT=3Dy
# CONFIG_DEBUG_LIST is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set
CONFIG_ARCH_WANT_FRAME_POINTERS=3Dy
# CONFIG_FRAME_POINTER is not set
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=3D60
CONFIG_RCU_CPU_STALL_VERBOSE=3Dy
# CONFIG_RCU_CPU_STALL_INFO is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_LKDTM is not set
# CONFIG_CPU_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_USER_STACKTRACE_SUPPORT=3Dy
CONFIG_NOP_TRACER=3Dy
CONFIG_HAVE_FUNCTION_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=3Dy
CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
CONFIG_HAVE_C_RECORDMCOUNT=3Dy
CONFIG_RING_BUFFER=3Dy
CONFIG_EVENT_TRACING=3Dy
CONFIG_EVENT_POWER_TRACING_DEPRECATED=3Dy
CONFIG_CONTEXT_SWITCH_TRACER=3Dy
CONFIG_RING_BUFFER_ALLOW_SWAP=3Dy
CONFIG_TRACING=3Dy
CONFIG_GENERIC_TRACER=3Dy
CONFIG_TRACING_SUPPORT=3Dy
CONFIG_FTRACE=3Dy
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_BRANCH_PROFILE_NONE=3Dy
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
CONFIG_BLK_DEV_IO_TRACE=3Dy
CONFIG_KPROBE_EVENT=3Dy
# CONFIG_UPROBE_EVENT is not set
CONFIG_PROBE_EVENTS=3Dy
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_FIREWIRE_OHCI_REMOTE_DMA is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=3Dy
# CONFIG_KGDB is not set
CONFIG_HAVE_ARCH_KMEMCHECK=3Dy
# CONFIG_TEST_KSTRTOX is not set
CONFIG_STRICT_DEVMEM=3Dy
CONFIG_X86_VERBOSE_BOOTUP=3Dy
CONFIG_EARLY_PRINTK=3Dy
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_X86_PTDUMP is not set
CONFIG_DEBUG_RODATA=3Dy
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_SET_MODULE_RONX is not set
# CONFIG_DEBUG_NX_TEST is not set
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=3D0
CONFIG_IO_DELAY_TYPE_0XED=3D1
CONFIG_IO_DELAY_TYPE_UDELAY=3D2
CONFIG_IO_DELAY_TYPE_NONE=3D3
CONFIG_IO_DELAY_0X80=3Dy
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=3D0
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=3Dy
# CONFIG_DEBUG_STRICT_USER_COPY_CHECKS is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set

#
# Security options
#
CONFIG_KEYS=3Dy
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEYS_DEBUG_PROC_KEYS=3Dy
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=3Dy
CONFIG_SECURITYFS=3Dy
CONFIG_SECURITY_NETWORK=3Dy
CONFIG_SECURITY_NETWORK_XFRM=3Dy
CONFIG_SECURITY_PATH=3Dy
CONFIG_LSM_MMAP_MIN_ADDR=3D65536
CONFIG_SECURITY_SELINUX=3Dy
CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=3D0
CONFIG_SECURITY_SELINUX_DISABLE=3Dy
CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1
# CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set
CONFIG_SECURITY_TOMOYO=3Dy
CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=3D2048
CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=3D1024
# CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
CONFIG_SECURITY_TOMOYO_POLICY_LOADER=3D"/sbin/tomoyo-init"
CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER=3D"/sbin/init"
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_SELINUX=3Dy
# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY=3D"selinux"
CONFIG_XOR_BLOCKS=3Dm
CONFIG_ASYNC_CORE=3Dm
CONFIG_ASYNC_MEMCPY=3Dm
CONFIG_ASYNC_XOR=3Dm
CONFIG_ASYNC_PQ=3Dm
CONFIG_ASYNC_RAID6_RECOV=3Dm
CONFIG_ASYNC_TX_DISABLE_PQ_VAL_DMA=3Dy
CONFIG_ASYNC_TX_DISABLE_XOR_VAL_DMA=3Dy
CONFIG_CRYPTO=3Dy

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=3Dy
CONFIG_CRYPTO_ALGAPI2=3Dy
CONFIG_CRYPTO_AEAD=3Dm
CONFIG_CRYPTO_AEAD2=3Dy
CONFIG_CRYPTO_BLKCIPHER=3Dm
CONFIG_CRYPTO_BLKCIPHER2=3Dy
CONFIG_CRYPTO_HASH=3Dy
CONFIG_CRYPTO_HASH2=3Dy
CONFIG_CRYPTO_RNG=3Dm
CONFIG_CRYPTO_RNG2=3Dy
CONFIG_CRYPTO_PCOMP=3Dm
CONFIG_CRYPTO_PCOMP2=3Dy
CONFIG_CRYPTO_MANAGER=3Dy
CONFIG_CRYPTO_MANAGER2=3Dy
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
CONFIG_CRYPTO_GF128MUL=3Dm
CONFIG_CRYPTO_NULL=3Dm
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=3Dy
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=3Dm
CONFIG_CRYPTO_TEST=3Dm

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=3Dm
CONFIG_CRYPTO_GCM=3Dm
CONFIG_CRYPTO_SEQIV=3Dm

#
# Block modes
#
CONFIG_CRYPTO_CBC=3Dm
CONFIG_CRYPTO_CTR=3Dm
CONFIG_CRYPTO_CTS=3Dm
CONFIG_CRYPTO_ECB=3Dm
CONFIG_CRYPTO_LRW=3Dm
CONFIG_CRYPTO_PCBC=3Dm
CONFIG_CRYPTO_XTS=3Dm

#
# Hash modes
#
CONFIG_CRYPTO_HMAC=3Dm
CONFIG_CRYPTO_XCBC=3Dm
CONFIG_CRYPTO_VMAC=3Dm

#
# Digest
#
CONFIG_CRYPTO_CRC32C=3Dm
CONFIG_CRYPTO_CRC32C_INTEL=3Dm
CONFIG_CRYPTO_GHASH=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_MICHAEL_MIC=3Dm
CONFIG_CRYPTO_RMD128=3Dm
CONFIG_CRYPTO_RMD160=3Dm
CONFIG_CRYPTO_RMD256=3Dm
CONFIG_CRYPTO_RMD320=3Dm
CONFIG_CRYPTO_SHA1=3Dm
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_TGR192=3Dm
CONFIG_CRYPTO_WP512=3Dm
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=3Dm
CONFIG_CRYPTO_AES_X86_64=3Dm
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_BLOWFISH_COMMON=3Dm
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=3Dm
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_FCRYPT=3Dm
CONFIG_CRYPTO_KHAZAD=3Dm
CONFIG_CRYPTO_SALSA20=3Dm
CONFIG_CRYPTO_SALSA20_X86_64=3Dm
CONFIG_CRYPTO_SEED=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_TEA=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_TWOFISH_COMMON=3Dm
CONFIG_CRYPTO_TWOFISH_X86_64=3Dm
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=3Dm
CONFIG_CRYPTO_ZLIB=3Dm
CONFIG_CRYPTO_LZO=3Dm

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=3Dm
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_HW=3Dy
CONFIG_CRYPTO_DEV_PADLOCK=3Dm
CONFIG_CRYPTO_DEV_PADLOCK_AES=3Dm
CONFIG_CRYPTO_DEV_PADLOCK_SHA=3Dm
CONFIG_HAVE_KVM=3Dy
CONFIG_HAVE_KVM_IRQCHIP=3Dy
CONFIG_HAVE_KVM_EVENTFD=3Dy
CONFIG_KVM_APIC_ARCHITECTURE=3Dy
CONFIG_KVM_MMIO=3Dy
CONFIG_KVM_ASYNC_PF=3Dy
CONFIG_HAVE_KVM_MSI=3Dy
CONFIG_VIRTUALIZATION=3Dy
CONFIG_KVM=3Dm
CONFIG_KVM_INTEL=3Dm
CONFIG_KVM_AMD=3Dm
# CONFIG_KVM_MMU_AUDIT is not set
# CONFIG_VHOST_NET is not set
CONFIG_BINARY_PRINTF=3Dy

#
# Library routines
#
CONFIG_RAID6_PQ=3Dm
CONFIG_BITREVERSE=3Dy
CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
CONFIG_GENERIC_STRNLEN_USER=3Dy
CONFIG_GENERIC_FIND_FIRST_BIT=3Dy
CONFIG_GENERIC_PCI_IOMAP=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_GENERIC_IO=3Dy
CONFIG_CRC_CCITT=3Dm
CONFIG_CRC16=3Dm
CONFIG_CRC_T10DIF=3Dm
CONFIG_CRC_ITU_T=3Dm
CONFIG_CRC32=3Dy
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=3Dy
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC7=3Dm
CONFIG_LIBCRC32C=3Dm
# CONFIG_CRC8 is not set
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_LZO_COMPRESS=3Dy
CONFIG_LZO_DECOMPRESS=3Dy
CONFIG_XZ_DEC=3Dy
CONFIG_XZ_DEC_X86=3Dy
CONFIG_XZ_DEC_POWERPC=3Dy
CONFIG_XZ_DEC_IA64=3Dy
CONFIG_XZ_DEC_ARM=3Dy
CONFIG_XZ_DEC_ARMTHUMB=3Dy
CONFIG_XZ_DEC_SPARC=3Dy
CONFIG_XZ_DEC_BCJ=3Dy
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=3Dy
CONFIG_DECOMPRESS_BZIP2=3Dy
CONFIG_DECOMPRESS_LZMA=3Dy
CONFIG_DECOMPRESS_XZ=3Dy
CONFIG_DECOMPRESS_LZO=3Dy
CONFIG_REED_SOLOMON=3Dm
CONFIG_REED_SOLOMON_DEC16=3Dy
CONFIG_TEXTSEARCH=3Dy
CONFIG_TEXTSEARCH_KMP=3Dm
CONFIG_TEXTSEARCH_BM=3Dm
CONFIG_TEXTSEARCH_FSM=3Dm
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT=3Dy
CONFIG_HAS_DMA=3Dy
CONFIG_CHECK_SIGNATURE=3Dy
CONFIG_CPU_RMAP=3Dy
CONFIG_DQL=3Dy
CONFIG_NLATTR=3Dy
CONFIG_AVERAGE=3Dy
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
-------------- next part --------------
Apr 19 17:34:41 IRT176 kernel: imklog 4.6.4, log source =3D /proc/kmsg star=
ted.
Apr 19 17:34:41 IRT176 rsyslogd: [origin software=3D"rsyslogd" swVersion=3D=
"4.6.4" x-pid=3D"1348" x-info=3D"http://www.rsyslog.com"] (re)start
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Initializing cgroup subsys cp=
uset
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Initializing cgroup subsys cpu
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Linux version 3.5.7-xenomai-2=
.6.2.1 (root@IRT176) (gcc version 4.4.5 (Debian 4.4.5-8) ) #4 SMP PREEMPT T=
hu Apr 18 19:36:18 CEST 2013
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Command line: BOOT_IMAGE=3D/b=
oot/vmlinuz-3.5.7-xenomai-2.6.2.1 root=3DUUID=3Dac291233-b3d4-4b70-b409-b36=
931bc7d7c ro quiet console=3DttyS0,9600
Apr 19 17:34:41 IRT176 kernel: [    0.000000] e820: BIOS-provided physical =
RAM map:
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000000=
00000-0x000000000009e7ff] usable
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000000=
9e800-0x000000000009ffff] reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000000=
e0000-0x00000000000fffff] reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000001=
00000-0x00000000be1e4fff] usable
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000be1=
e5000-0x00000000be4e8fff] reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000be4=
e9000-0x00000000be8dafff] ACPI NVS
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000be8=
db000-0x00000000bee2dfff] reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000bee=
2e000-0x00000000bee2efff] usable
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000bee=
2f000-0x00000000bf034fff] ACPI NVS
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000bf0=
35000-0x00000000bf452fff] usable
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000bf4=
53000-0x00000000bf7f3fff] reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000bf7=
f4000-0x00000000bf7fffff] usable
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000fec=
00000-0x00000000fec00fff] reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000fec=
10000-0x00000000fec10fff] reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000fec=
20000-0x00000000fec20fff] reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000fed=
00000-0x00000000fed00fff] reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000fed=
61000-0x00000000fed70fff] reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000fed=
80000-0x00000000fed8ffff] reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000000fef=
00000-0x00000000ffffffff] reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000] BIOS-e820: [mem 0x00000001000=
01000-0x000000043effffff] usable
Apr 19 17:34:41 IRT176 kernel: [    0.000000] NX (Execute Disable) protecti=
on: active
Apr 19 17:34:41 IRT176 kernel: [    0.000000] DMI 2.7 present.
Apr 19 17:34:41 IRT176 kernel: [    0.000000] DMI: To Be Filled By O.E.M. T=
o Be Filled By O.E.M./970 Extreme4, BIOS P2.20 10/12/2012
Apr 19 17:34:41 IRT176 kernel: [    0.000000] e820: update [mem 0x00000000-=
0x0000ffff] usable =3D=3D> reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000] e820: remove [mem 0x000a0000-=
0x000fffff] usable
Apr 19 17:34:41 IRT176 kernel: [    0.000000] No AGP bridge found
Apr 19 17:34:41 IRT176 kernel: [    0.000000] e820: last_pfn =3D 0x43f000 m=
ax_arch_pfn =3D 0x400000000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] MTRR default type: uncachable
Apr 19 17:34:41 IRT176 kernel: [    0.000000] MTRR fixed ranges enabled:
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   00000-9FFFF write-back
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   A0000-BFFFF write-through
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   C0000-CFFFF write-protect
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   D0000-EAFFF uncachable
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   EB000-FFFFF write-protect
Apr 19 17:34:41 IRT176 kernel: [    0.000000] MTRR variable ranges enabled:
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   0 base 000000000000 mask FF=
FF80000000 write-back
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   1 base 000080000000 mask FF=
FFC0000000 write-back
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   2 base 0000BF800000 mask FF=
FFFF800000 uncachable
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   3 disabled
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   4 disabled
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   5 disabled
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   6 disabled
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   7 disabled
Apr 19 17:34:41 IRT176 kernel: [    0.000000] TOM2: 000000043f000000 aka 17=
392M
Apr 19 17:34:41 IRT176 kernel: [    0.000000] x86 PAT enabled: cpu 0, old 0=
x7040600070406, new 0x7010600070106
Apr 19 17:34:41 IRT176 kernel: [    0.000000] e820: update [mem 0xbf800000-=
0xffffffff] usable =3D=3D> reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000] e820: last_pfn =3D 0xbf800 ma=
x_arch_pfn =3D 0x400000000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] found SMP MP-table at [mem 0x=
000fda10-0x000fda1f] mapped at [ffff8800000fda10]
Apr 19 17:34:41 IRT176 kernel: [    0.000000] initial memory mapped: [mem 0=
x00000000-0x1fffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Base memory trampoline at [ff=
ff880000098000] 98000 size 24576
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Using GB pages for direct map=
ping
Apr 19 17:34:41 IRT176 kernel: [    0.000000] init_memory_mapping: [mem 0x0=
0000000-0xbf7fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000]  [mem 0x00000000-0x7fffffff] =
page 1G
Apr 19 17:34:41 IRT176 kernel: [    0.000000]  [mem 0x80000000-0xbf7fffff] =
page 2M
Apr 19 17:34:41 IRT176 kernel: [    0.000000] kernel direct mapping tables =
up to 0xbf7fffff @ [mem 0x1fbfe000-0x1fffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000] init_memory_mapping: [mem 0x1=
00000000-0x43effffff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000]  [mem 0x100000000-0x3ffffffff=
] page 1G
Apr 19 17:34:41 IRT176 kernel: [    0.000000]  [mem 0x400000000-0x43effffff=
] page 2M
Apr 19 17:34:41 IRT176 kernel: [    0.000000] kernel direct mapping tables =
up to 0x43effffff @ [mem 0xbf7fe000-0xbf7fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000] RAMDISK: [mem 0x37880000-0x37=
feffff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: RSDP 00000000000f0490 0=
0024 (v02 ALASKA)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: XSDT 00000000be8c8070 0=
0064 (v01 ALASKA    A M I 01072009 AMI  00010013)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: FACP 00000000be8d1090 0=
010C (v05 ALASKA    A M I 01072009 AMI  00010013)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI Warning: Optional field =
Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (2012032=
0/tbfadt-579)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: DSDT 00000000be8c8170 0=
8F1C (v02 ALASKA    A M I 00000000 INTL 20051117)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: FACS 00000000be8d4080 0=
0040
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: APIC 00000000be8d11a0 0=
009E (v03 ALASKA    A M I 01072009 AMI  00010013)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: FPDT 00000000be8d1240 0=
0044 (v01 ALASKA    A M I 01072009 AMI  00010013)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: MCFG 00000000be8d1288 0=
003C (v01 ALASKA    A M I 01072009 MSFT 00010013)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: AAFT 00000000be8d12c8 0=
0062 (v01 ALASKA OEMAAFT  01072009 MSFT 00000097)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: HPET 00000000be8d1330 0=
0038 (v01 ALASKA    A M I 01072009 AMI  00000005)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: SSDT 00000000be8d1368 0=
1714 (v01 AMD    POWERNOW 00000001 AMD  00000001)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: BGRT 00000000be8d2a80 0=
0038 (v00 ALASKA    A M I 01072009 AMI  00010013)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: Local APIC address 0xfe=
e00000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] No NUMA configuration found
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Faking a node at [mem 0x00000=
00000000000-0x000000043effffff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Initmem setup node 0 [mem 0x0=
0000000-0x43effffff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   NODE_DATA [mem 0x43effc000-=
0x43effffff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000]  [ffffea0000000000-ffffea0010=
ffffff] PMD -> [ffff88042e600000-ffff88043e5fffff] on node 0
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Zone ranges:
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   DMA      [mem 0x00010000-0x=
00ffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   DMA32    [mem 0x01000000-0x=
ffffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   Normal   [mem 0x100000000-0=
x43effffff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Movable zone start for each n=
ode
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Early memory node ranges
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   node   0: [mem 0x00010000-0=
x0009dfff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   node   0: [mem 0x00100000-0=
xbe1e4fff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   node   0: [mem 0xbee2e000-0=
xbee2efff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   node   0: [mem 0xbf035000-0=
xbf452fff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   node   0: [mem 0xbf7f4000-0=
xbf7fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   node   0: [mem 0x100001000-=
0x43effffff]
Apr 19 17:34:41 IRT176 kernel: [    0.000000] On node 0 totalpages: 4183453
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   DMA zone: 64 pages used for=
 memmap
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   DMA zone: 6 pages reserved
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   DMA zone: 3912 pages, LIFO =
batch:0
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   DMA32 zone: 16320 pages use=
d for memmap
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   DMA32 zone: 759376 pages, L=
IFO batch:31
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   Normal zone: 53184 pages us=
ed for memmap
Apr 19 17:34:41 IRT176 kernel: [    0.000000]   Normal zone: 3350591 pages,=
 LIFO batch:31
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x808
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: Local APIC address 0xfe=
e00000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] la=
pic_id[0x10] enabled)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] la=
pic_id[0x11] enabled)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x03] la=
pic_id[0x12] enabled)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x04] la=
pic_id[0x13] enabled)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x05] la=
pic_id[0x14] enabled)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x06] la=
pic_id[0x15] enabled)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x07] la=
pic_id[0x16] enabled)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x08] la=
pic_id[0x17] enabled)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff=
] high edge lint[0x1])
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: IOAPIC (id[0x09] addres=
s[0xfec00000] gsi_base[0])
Apr 19 17:34:41 IRT176 kernel: [    0.000000] IOAPIC[0]: apic_id 9, version=
 33, address 0xfec00000, GSI 0-23
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: IOAPIC (id[0x0a] addres=
s[0xfec20000] gsi_base[24])
Apr 19 17:34:41 IRT176 kernel: [    0.000000] IOAPIC[1]: apic_id 10, versio=
n 33, address 0xfec20000, GSI 24-55
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_=
irq 0 global_irq 2 dfl dfl)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_=
irq 9 global_irq 9 low level)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: IRQ0 used by override.
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: IRQ2 used by override.
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: IRQ9 used by override.
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Using ACPI (MADT) for SMP con=
figuration information
Apr 19 17:34:41 IRT176 kernel: [    0.000000] ACPI: HPET id: 0x43538210 bas=
e: 0xfed00000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] SMP: Allowing 8 CPUs, 0 hotpl=
ug CPUs
Apr 19 17:34:41 IRT176 kernel: [    0.000000] nr_irqs_gsi: 72
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 000000000009e000 - 000000000009f000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 000000000009f000 - 00000000000a0000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000000a0000 - 00000000000e0000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000000e0000 - 0000000000100000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000be1e5000 - 00000000be4e9000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000be4e9000 - 00000000be8db000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000be8db000 - 00000000bee2e000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000bee2f000 - 00000000bf035000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000bf453000 - 00000000bf7f4000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000bf800000 - 00000000fec00000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000fec00000 - 00000000fec01000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000fec01000 - 00000000fec10000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000fec10000 - 00000000fec11000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000fec11000 - 00000000fec20000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000fec20000 - 00000000fec21000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000fec21000 - 00000000fed00000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000fed00000 - 00000000fed01000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000fed01000 - 00000000fed61000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000fed61000 - 00000000fed71000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000fed71000 - 00000000fed80000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000fed80000 - 00000000fed90000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000fed90000 - 00000000fef00000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000fef00000 - 0000000100000000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 0000000100000000 - 0000000100001000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] e820: [mem 0xbf800000-0xfebff=
fff] available for PCI devices
Apr 19 17:34:41 IRT176 kernel: [    0.000000] setup_percpu: NR_CPUS:512 nr_=
cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PERCPU: Embedded 160 pages/cp=
u @ffff88042de00000 s626688 r8192 d20480 u1048576
Apr 19 17:34:41 IRT176 kernel: [    0.000000] pcpu-alloc: s626688 r8192 d20=
480 u1048576 alloc=3D1*2097152
Apr 19 17:34:41 IRT176 kernel: [    0.000000] pcpu-alloc: [0] 0 1 [0] 2 3 [=
0] 4 5 [0] 6 7 =

Apr 19 17:34:41 IRT176 kernel: [    0.000000] Built 1 zonelists in Zone ord=
er, mobility grouping on.  Total pages: 4113879
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Policy zone: Normal
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Kernel command line: BOOT_IMA=
GE=3D/boot/vmlinuz-3.5.7-xenomai-2.6.2.1 root=3DUUID=3Dac291233-b3d4-4b70-b=
409-b36931bc7d7c ro quiet console=3DttyS0,9600
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PID hash table entries: 4096 =
(order: 3, 32768 bytes)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] __ex_table already sorted, sk=
ipping sort
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Xenomai: forcing noxsave
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Checking aperture...
Apr 19 17:34:41 IRT176 kernel: [    0.000000] No AGP bridge found
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Node 0: aperture @ c99c000000=
 size 32 MB
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Aperture beyond 4GB. Ignoring.
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Your BIOS doesn't leave a ape=
rture memory hole
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Please enable the IOMMU optio=
n in the BIOS setup
Apr 19 17:34:41 IRT176 kernel: [    0.000000] This costs you 64 MB of RAM
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Mapping aperture over 65536 K=
B of RAM @ b4000000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] PM: Registered nosave memory:=
 00000000b4000000 - 00000000b8000000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Memory: 16307816k/17809408k a=
vailable (3636k kernel code, 1075596k absent, 425996k reserved, 3005k data,=
 1308k init)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] SLUB: Genslabs=3D15, HWalign=
=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, Nodes=3D1
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Preemptible hierarchical RCU =
implementation.
Apr 19 17:34:41 IRT176 kernel: [    0.000000] NR_IRQS:33024 nr_irqs:1288 16
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Extended CMOS year: 2000
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Interrupt pipeline (release #=
3)
Apr 19 17:34:41 IRT176 kernel: [    0.000000] spurious 8259A interrupt: IRQ=
7.
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Console: colour VGA+ 80x25
Apr 19 17:34:41 IRT176 kernel: [    0.000000] console [ttyS0] enabled
Apr 19 17:34:41 IRT176 kernel: [    0.000000] hpet clockevent registered
Apr 19 17:34:41 IRT176 kernel: [    0.000000] Fast TSC calibration using PIT
Apr 19 17:34:41 IRT176 kernel: [    0.001000] Detected 3991.307 MHz process=
or.
Apr 19 17:34:41 IRT176 kernel: [    0.000003] Calibrating delay loop (skipp=
ed), value calculated using timer frequency.. 7982.61 BogoMIPS (lpj=3D39913=
07)
Apr 19 17:34:41 IRT176 kernel: [    0.000005] pid_max: default: 32768 minim=
um: 301
Apr 19 17:34:41 IRT176 kernel: [    0.000023] Security Framework initialized
Apr 19 17:34:41 IRT176 kernel: [    0.000025] SELinux:  Disabled at boot.
Apr 19 17:34:41 IRT176 kernel: [    0.000907] Dentry cache hash table entri=
es: 2097152 (order: 12, 16777216 bytes)
Apr 19 17:34:41 IRT176 kernel: [    0.004566] Inode-cache hash table entrie=
s: 1048576 (order: 11, 8388608 bytes)
Apr 19 17:34:41 IRT176 kernel: [    0.006120] Mount-cache hash table entrie=
s: 256
Apr 19 17:34:41 IRT176 kernel: [    0.006265] Initializing cgroup subsys cp=
uacct
Apr 19 17:34:41 IRT176 kernel: [    0.006267] Initializing cgroup subsys de=
vices
Apr 19 17:34:41 IRT176 kernel: [    0.006268] Initializing cgroup subsys fr=
eezer
Apr 19 17:34:41 IRT176 kernel: [    0.006270] Initializing cgroup subsys ne=
t_cls
Apr 19 17:34:41 IRT176 kernel: [    0.006286] tseg: 00bf800000
Apr 19 17:34:41 IRT176 kernel: [    0.006287] CPU: Physical Processor ID: 0
Apr 19 17:34:41 IRT176 kernel: [    0.006288] CPU: Processor Core ID: 0
Apr 19 17:34:41 IRT176 kernel: [    0.006289] mce: CPU supports 7 MCE banks
Apr 19 17:34:41 IRT176 kernel: [    0.006295] LVT offset 1 assigned for vec=
tor 0xf9
Apr 19 17:34:41 IRT176 kernel: [    0.006372] ACPI: Core revision 20120320
Apr 19 17:34:41 IRT176 kernel: [    0.032247] ..TIMER: vector=3D0x30 apic1=
=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
Apr 19 17:34:41 IRT176 kernel: [    0.042228] CPU0: AMD FX(tm)-8350 Eight-C=
ore Processor            stepping 00
Apr 19 17:34:41 IRT176 kernel: [    0.143580] Performance Events: AMD Famil=
y 15h PMU driver.
Apr 19 17:34:41 IRT176 kernel: [    0.143583] ... version:                0
Apr 19 17:34:41 IRT176 kernel: [    0.143584] ... bit width:              48
Apr 19 17:34:41 IRT176 kernel: [    0.143585] ... generic registers:      6
Apr 19 17:34:41 IRT176 kernel: [    0.143586] ... value mask:             0=
000ffffffffffff
Apr 19 17:34:41 IRT176 kernel: [    0.143587] ... max period:             0=
0007fffffffffff
Apr 19 17:34:41 IRT176 kernel: [    0.143588] ... fixed-purpose events:   0
Apr 19 17:34:41 IRT176 kernel: [    0.143589] ... event mask:             0=
00000000000003f
Apr 19 17:34:41 IRT176 kernel: [    0.153571] Booting Node   0, Processors =
 #1 #2 #3 #4 #5 #6 #7 Ok.
Apr 19 17:34:41 IRT176 kernel: [    0.268435] Brought up 8 CPUs
Apr 19 17:34:41 IRT176 kernel: [    0.268438] Total of 8 processors activat=
ed (63860.91 BogoMIPS).
Apr 19 17:34:41 IRT176 kernel: [    0.278104] devtmpfs: initialized
Apr 19 17:34:41 IRT176 kernel: [    0.280673] PM: Registering ACPI NVS regi=
on [mem 0xbe4e9000-0xbe8dafff] (4136960 bytes)
Apr 19 17:34:41 IRT176 kernel: [    0.280744] PM: Registering ACPI NVS regi=
on [mem 0xbee2f000-0xbf034fff] (2121728 bytes)
Apr 19 17:34:41 IRT176 kernel: [    0.280832] dummy: =

Apr 19 17:34:41 IRT176 kernel: [    0.280865] NET: Registered protocol fami=
ly 16
Apr 19 17:34:41 IRT176 kernel: [    0.281000] ACPI: bus type pci registered
Apr 19 17:34:41 IRT176 kernel: [    0.281041] PCI: MMCONFIG for domain 0000=
 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Apr 19 17:34:41 IRT176 kernel: [    0.281043] PCI: not using MMCONFIG
Apr 19 17:34:41 IRT176 kernel: [    0.281045] PCI: Using configuration type=
 1 for base access
Apr 19 17:34:41 IRT176 kernel: [    0.281046] PCI: Using configuration type=
 1 for extended access
Apr 19 17:34:41 IRT176 kernel: [    0.281684] bio: create slab <bio-0> at 0
Apr 19 17:34:41 IRT176 kernel: [    0.281734] ACPI: Added _OSI(Module Devic=
e)
Apr 19 17:34:41 IRT176 kernel: [    0.281735] ACPI: Added _OSI(Processor De=
vice)
Apr 19 17:34:41 IRT176 kernel: [    0.281736] ACPI: Added _OSI(3.0 _SCP Ext=
ensions)
Apr 19 17:34:41 IRT176 kernel: [    0.281738] ACPI: Added _OSI(Processor Ag=
gregator Device)
Apr 19 17:34:41 IRT176 kernel: [    0.282710] ACPI: EC: Look up EC in DSDT
Apr 19 17:34:41 IRT176 kernel: [    0.283788] ACPI: Executed 3 blocks of mo=
dule-level executable AML code
Apr 19 17:34:41 IRT176 kernel: [    0.289451] ACPI: Interpreter enabled
Apr 19 17:34:41 IRT176 kernel: [    0.289454] ACPI: (supports S0 S3 S4 S5)
Apr 19 17:34:41 IRT176 kernel: [    0.289471] ACPI: Using IOAPIC for interr=
upt routing
Apr 19 17:34:41 IRT176 kernel: [    0.289575] PCI: MMCONFIG for domain 0000=
 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Apr 19 17:34:41 IRT176 kernel: [    0.289603] PCI: MMCONFIG at [mem 0xe0000=
000-0xefffffff] reserved in ACPI motherboard resources
Apr 19 17:34:41 IRT176 kernel: [    0.307440] ACPI: No dock devices found.
Apr 19 17:34:41 IRT176 kernel: [    0.307443] PCI: Using host bridge window=
s from ACPI; if necessary, use "pci=3Dnocrs" and report a bug
Apr 19 17:34:41 IRT176 kernel: [    0.307554] ACPI: PCI Root Bridge [PCI0] =
(domain 0000 [bus 00-ff])
Apr 19 17:34:41 IRT176 kernel: [    0.307709] pci_root PNP0A03:00: host bri=
dge window [io  0x0000-0x03af]
Apr 19 17:34:41 IRT176 kernel: [    0.307711] pci_root PNP0A03:00: host bri=
dge window [io  0x03e0-0x0cf7]
Apr 19 17:34:41 IRT176 kernel: [    0.307713] pci_root PNP0A03:00: host bri=
dge window [io  0x03b0-0x03df]
Apr 19 17:34:41 IRT176 kernel: [    0.307715] pci_root PNP0A03:00: host bri=
dge window [io  0x0d00-0xffff]
Apr 19 17:34:41 IRT176 kernel: [    0.307717] pci_root PNP0A03:00: host bri=
dge window [mem 0x000a0000-0x000bffff]
Apr 19 17:34:41 IRT176 kernel: [    0.307718] pci_root PNP0A03:00: host bri=
dge window [mem 0x000c0000-0x000dffff]
Apr 19 17:34:41 IRT176 kernel: [    0.307720] pci_root PNP0A03:00: host bri=
dge window [mem 0xc0000000-0xffffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.307738] PCI host bridge to bus 0000:00
Apr 19 17:34:41 IRT176 kernel: [    0.307740] pci_bus 0000:00: root bus res=
ource [io  0x0000-0x03af]
Apr 19 17:34:41 IRT176 kernel: [    0.307742] pci_bus 0000:00: root bus res=
ource [io  0x03e0-0x0cf7]
Apr 19 17:34:41 IRT176 kernel: [    0.307744] pci_bus 0000:00: root bus res=
ource [io  0x03b0-0x03df]
Apr 19 17:34:41 IRT176 kernel: [    0.307745] pci_bus 0000:00: root bus res=
ource [io  0x0d00-0xffff]
Apr 19 17:34:41 IRT176 kernel: [    0.307747] pci_bus 0000:00: root bus res=
ource [mem 0x000a0000-0x000bffff]
Apr 19 17:34:41 IRT176 kernel: [    0.307749] pci_bus 0000:00: root bus res=
ource [mem 0x000c0000-0x000dffff]
Apr 19 17:34:41 IRT176 kernel: [    0.307750] pci_bus 0000:00: root bus res=
ource [mem 0xc0000000-0xffffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.307761] pci 0000:00:00.0: [1002:5a14]=
 type 00 class 0x060000
Apr 19 17:34:41 IRT176 kernel: [    0.307824] pci 0000:00:02.0: [1002:5a16]=
 type 01 class 0x060400
Apr 19 17:34:41 IRT176 kernel: [    0.307858] pci 0000:00:02.0: PME# suppor=
ted from D0 D3hot D3cold
Apr 19 17:34:41 IRT176 kernel: [    0.307876] pci 0000:00:09.0: [1002:5a1c]=
 type 01 class 0x060400
Apr 19 17:34:41 IRT176 kernel: [    0.307908] pci 0000:00:09.0: PME# suppor=
ted from D0 D3hot D3cold
Apr 19 17:34:41 IRT176 kernel: [    0.307921] pci 0000:00:0a.0: [1002:5a1d]=
 type 01 class 0x060400
Apr 19 17:34:41 IRT176 kernel: [    0.307953] pci 0000:00:0a.0: PME# suppor=
ted from D0 D3hot D3cold
Apr 19 17:34:41 IRT176 kernel: [    0.307975] pci 0000:00:11.0: [1002:4391]=
 type 00 class 0x010601
Apr 19 17:34:41 IRT176 kernel: [    0.307990] pci 0000:00:11.0: reg 10: [io=
  0xf090-0xf097]
Apr 19 17:34:41 IRT176 kernel: [    0.307997] pci 0000:00:11.0: reg 14: [io=
  0xf080-0xf083]
Apr 19 17:34:41 IRT176 kernel: [    0.308005] pci 0000:00:11.0: reg 18: [io=
  0xf070-0xf077]
Apr 19 17:34:41 IRT176 kernel: [    0.308012] pci 0000:00:11.0: reg 1c: [io=
  0xf060-0xf063]
Apr 19 17:34:41 IRT176 kernel: [    0.308020] pci 0000:00:11.0: reg 20: [io=
  0xf050-0xf05f]
Apr 19 17:34:41 IRT176 kernel: [    0.308027] pci 0000:00:11.0: reg 24: [me=
m 0xfeb0b000-0xfeb0b3ff]
Apr 19 17:34:41 IRT176 kernel: [    0.308073] pci 0000:00:12.0: [1002:4397]=
 type 00 class 0x0c0310
Apr 19 17:34:41 IRT176 kernel: [    0.308084] pci 0000:00:12.0: reg 10: [me=
m 0xfeb0a000-0xfeb0afff]
Apr 19 17:34:41 IRT176 kernel: [    0.308163] pci 0000:00:12.2: [1002:4396]=
 type 00 class 0x0c0320
Apr 19 17:34:41 IRT176 kernel: [    0.308177] pci 0000:00:12.2: reg 10: [me=
m 0xfeb09000-0xfeb090ff]
Apr 19 17:34:41 IRT176 kernel: [    0.308243] pci 0000:00:12.2: supports D1=
 D2
Apr 19 17:34:41 IRT176 kernel: [    0.308245] pci 0000:00:12.2: PME# suppor=
ted from D0 D1 D2 D3hot
Apr 19 17:34:41 IRT176 kernel: [    0.308263] pci 0000:00:13.0: [1002:4397]=
 type 00 class 0x0c0310
Apr 19 17:34:41 IRT176 kernel: [    0.308273] pci 0000:00:13.0: reg 10: [me=
m 0xfeb08000-0xfeb08fff]
Apr 19 17:34:41 IRT176 kernel: [    0.308327] pci 0000:00:13.2: [1002:4396]=
 type 00 class 0x0c0320
Apr 19 17:34:41 IRT176 kernel: [    0.308346] pci 0000:00:13.2: reg 10: [me=
m 0xfeb07000-0xfeb070ff]
Apr 19 17:34:41 IRT176 kernel: [    0.308409] pci 0000:00:13.2: supports D1=
 D2
Apr 19 17:34:41 IRT176 kernel: [    0.308410] pci 0000:00:13.2: PME# suppor=
ted from D0 D1 D2 D3hot
Apr 19 17:34:41 IRT176 kernel: [    0.308429] pci 0000:00:14.0: [1002:4385]=
 type 00 class 0x0c0500
Apr 19 17:34:41 IRT176 kernel: [    0.308485] pci 0000:00:14.1: [1002:439c]=
 type 00 class 0x01018a
Apr 19 17:34:41 IRT176 kernel: [    0.308495] pci 0000:00:14.1: reg 10: [io=
  0xf040-0xf047]
Apr 19 17:34:41 IRT176 kernel: [    0.308503] pci 0000:00:14.1: reg 14: [io=
  0xf030-0xf033]
Apr 19 17:34:41 IRT176 kernel: [    0.308510] pci 0000:00:14.1: reg 18: [io=
  0xf020-0xf027]
Apr 19 17:34:41 IRT176 kernel: [    0.308517] pci 0000:00:14.1: reg 1c: [io=
  0xf010-0xf013]
Apr 19 17:34:41 IRT176 kernel: [    0.308525] pci 0000:00:14.1: reg 20: [io=
  0xf000-0xf00f]
Apr 19 17:34:41 IRT176 kernel: [    0.308554] pci 0000:00:14.2: [1002:4383]=
 type 00 class 0x040300
Apr 19 17:34:41 IRT176 kernel: [    0.308570] pci 0000:00:14.2: reg 10: [me=
m 0xfeb00000-0xfeb03fff 64bit]
Apr 19 17:34:41 IRT176 kernel: [    0.308620] pci 0000:00:14.2: PME# suppor=
ted from D0 D3hot D3cold
Apr 19 17:34:41 IRT176 kernel: [    0.308632] pci 0000:00:14.3: [1002:439d]=
 type 00 class 0x060100
Apr 19 17:34:41 IRT176 kernel: [    0.308692] pci 0000:00:14.4: [1002:4384]=
 type 01 class 0x060401
Apr 19 17:34:41 IRT176 kernel: [    0.308725] pci 0000:00:14.5: [1002:4399]=
 type 00 class 0x0c0310
Apr 19 17:34:41 IRT176 kernel: [    0.308735] pci 0000:00:14.5: reg 10: [me=
m 0xfeb06000-0xfeb06fff]
Apr 19 17:34:41 IRT176 kernel: [    0.308790] pci 0000:00:15.0: [1002:43a0]=
 type 01 class 0x060400
Apr 19 17:34:41 IRT176 kernel: [    0.308846] pci 0000:00:15.0: supports D1=
 D2
Apr 19 17:34:41 IRT176 kernel: [    0.308865] pci 0000:00:15.1: [1002:43a1]=
 type 01 class 0x060400
Apr 19 17:34:41 IRT176 kernel: [    0.308920] pci 0000:00:15.1: supports D1=
 D2
Apr 19 17:34:41 IRT176 kernel: [    0.308941] pci 0000:00:15.2: [1002:43a2]=
 type 01 class 0x060400
Apr 19 17:34:41 IRT176 kernel: [    0.308997] pci 0000:00:15.2: supports D1=
 D2
Apr 19 17:34:41 IRT176 kernel: [    0.309016] pci 0000:00:15.3: [1002:43a3]=
 type 01 class 0x060400
Apr 19 17:34:41 IRT176 kernel: [    0.309072] pci 0000:00:15.3: supports D1=
 D2
Apr 19 17:34:41 IRT176 kernel: [    0.309091] pci 0000:00:16.0: [1002:4397]=
 type 00 class 0x0c0310
Apr 19 17:34:41 IRT176 kernel: [    0.309102] pci 0000:00:16.0: reg 10: [me=
m 0xfeb05000-0xfeb05fff]
Apr 19 17:34:41 IRT176 kernel: [    0.309156] pci 0000:00:16.2: [1002:4396]=
 type 00 class 0x0c0320
Apr 19 17:34:41 IRT176 kernel: [    0.309171] pci 0000:00:16.2: reg 10: [me=
m 0xfeb04000-0xfeb040ff]
Apr 19 17:34:41 IRT176 kernel: [    0.309235] pci 0000:00:16.2: supports D1=
 D2
Apr 19 17:34:41 IRT176 kernel: [    0.309237] pci 0000:00:16.2: PME# suppor=
ted from D0 D1 D2 D3hot
Apr 19 17:34:41 IRT176 kernel: [    0.309254] pci 0000:00:18.0: [1022:1600]=
 type 00 class 0x060000
Apr 19 17:34:41 IRT176 kernel: [    0.309273] pci 0000:00:18.1: [1022:1601]=
 type 00 class 0x060000
Apr 19 17:34:41 IRT176 kernel: [    0.309286] pci 0000:00:18.2: [1022:1602]=
 type 00 class 0x060000
Apr 19 17:34:41 IRT176 kernel: [    0.309301] pci 0000:00:18.3: [1022:1603]=
 type 00 class 0x060000
Apr 19 17:34:41 IRT176 kernel: [    0.309320] pci 0000:00:18.4: [1022:1604]=
 type 00 class 0x060000
Apr 19 17:34:41 IRT176 kernel: [    0.309342] pci 0000:00:18.5: [1022:1605]=
 type 00 class 0x060000
Apr 19 17:34:41 IRT176 kernel: [    0.309406] pci 0000:01:00.0: [1002:68e1]=
 type 00 class 0x030000
Apr 19 17:34:41 IRT176 kernel: [    0.309417] pci 0000:01:00.0: reg 10: [me=
m 0xc0000000-0xcfffffff 64bit pref]
Apr 19 17:34:41 IRT176 kernel: [    0.309427] pci 0000:01:00.0: reg 18: [me=
m 0xfea20000-0xfea3ffff 64bit]
Apr 19 17:34:41 IRT176 kernel: [    0.309433] pci 0000:01:00.0: reg 20: [io=
  0xe000-0xe0ff]
Apr 19 17:34:41 IRT176 kernel: [    0.309444] pci 0000:01:00.0: reg 30: [me=
m 0xfea00000-0xfea1ffff pref]
Apr 19 17:34:41 IRT176 kernel: [    0.309472] pci 0000:01:00.0: supports D1=
 D2
Apr 19 17:34:41 IRT176 kernel: [    0.309490] pci 0000:01:00.1: [1002:aa68]=
 type 00 class 0x040300
Apr 19 17:34:41 IRT176 kernel: [    0.309501] pci 0000:01:00.1: reg 10: [me=
m 0xfea40000-0xfea43fff 64bit]
Apr 19 17:34:41 IRT176 kernel: [    0.309552] pci 0000:01:00.1: supports D1=
 D2
Apr 19 17:34:41 IRT176 kernel: [    0.311207] pci 0000:00:02.0: PCI bridge =
to [bus 01-01]
Apr 19 17:34:41 IRT176 kernel: [    0.311211] pci 0000:00:02.0:   bridge wi=
ndow [io  0xe000-0xefff]
Apr 19 17:34:41 IRT176 kernel: [    0.311214] pci 0000:00:02.0:   bridge wi=
ndow [mem 0xfea00000-0xfeafffff]
Apr 19 17:34:41 IRT176 kernel: [    0.311217] pci 0000:00:02.0:   bridge wi=
ndow [mem 0xc0000000-0xcfffffff 64bit pref]
Apr 19 17:34:41 IRT176 kernel: [    0.311255] pci 0000:02:00.0: [1b21:1042]=
 type 00 class 0x0c0330
Apr 19 17:34:41 IRT176 kernel: [    0.311272] pci 0000:02:00.0: reg 10: [me=
m 0xfe900000-0xfe907fff 64bit]
Apr 19 17:34:41 IRT176 kernel: [    0.311357] pci 0000:02:00.0: PME# suppor=
ted from D3hot D3cold
Apr 19 17:34:41 IRT176 kernel: [    0.313202] pci 0000:00:09.0: PCI bridge =
to [bus 02-02]
Apr 19 17:34:41 IRT176 kernel: [    0.313207] pci 0000:00:09.0:   bridge wi=
ndow [mem 0xfe900000-0xfe9fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.313246] pci 0000:03:00.0: [1b21:1042]=
 type 00 class 0x0c0330
Apr 19 17:34:41 IRT176 kernel: [    0.313263] pci 0000:03:00.0: reg 10: [me=
m 0xfe800000-0xfe807fff 64bit]
Apr 19 17:34:41 IRT176 kernel: [    0.313348] pci 0000:03:00.0: PME# suppor=
ted from D3hot D3cold
Apr 19 17:34:41 IRT176 kernel: [    0.315197] pci 0000:00:0a.0: PCI bridge =
to [bus 03-03]
Apr 19 17:34:41 IRT176 kernel: [    0.315202] pci 0000:00:0a.0:   bridge wi=
ndow [mem 0xfe800000-0xfe8fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.315230] pci 0000:04:06.0: [8086:1229]=
 type 00 class 0x020000
Apr 19 17:34:41 IRT176 kernel: [    0.315248] pci 0000:04:06.0: reg 10: [me=
m 0xfe500000-0xfe500fff]
Apr 19 17:34:41 IRT176 kernel: [    0.315258] pci 0000:04:06.0: reg 14: [io=
  0xd000-0xd03f]
Apr 19 17:34:41 IRT176 kernel: [    0.315268] pci 0000:04:06.0: reg 18: [me=
m 0xfe400000-0xfe4fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.315302] pci 0000:04:06.0: reg 30: [me=
m 0xfe300000-0xfe3fffff pref]
Apr 19 17:34:41 IRT176 kernel: [    0.315331] pci 0000:04:06.0: supports D1=
 D2
Apr 19 17:34:41 IRT176 kernel: [    0.315333] pci 0000:04:06.0: PME# suppor=
ted from D0 D1 D2 D3hot D3cold
Apr 19 17:34:41 IRT176 kernel: [    0.315372] pci 0000:00:14.4: PCI bridge =
to [bus 04-04] (subtractive decode)
Apr 19 17:34:41 IRT176 kernel: [    0.315376] pci 0000:00:14.4:   bridge wi=
ndow [io  0xd000-0xdfff]
Apr 19 17:34:41 IRT176 kernel: [    0.315379] pci 0000:00:14.4:   bridge wi=
ndow [mem 0xfe300000-0xfe5fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.315382] pci 0000:00:14.4:   bridge wi=
ndow [io  0x0000-0x03af] (subtractive decode)
Apr 19 17:34:41 IRT176 kernel: [    0.315384] pci 0000:00:14.4:   bridge wi=
ndow [io  0x03e0-0x0cf7] (subtractive decode)
Apr 19 17:34:41 IRT176 kernel: [    0.315386] pci 0000:00:14.4:   bridge wi=
ndow [io  0x03b0-0x03df] (subtractive decode)
Apr 19 17:34:41 IRT176 kernel: [    0.315388] pci 0000:00:14.4:   bridge wi=
ndow [io  0x0d00-0xffff] (subtractive decode)
Apr 19 17:34:41 IRT176 kernel: [    0.315390] pci 0000:00:14.4:   bridge wi=
ndow [mem 0x000a0000-0x000bffff] (subtractive decode)
Apr 19 17:34:41 IRT176 kernel: [    0.315391] pci 0000:00:14.4:   bridge wi=
ndow [mem 0x000c0000-0x000dffff] (subtractive decode)
Apr 19 17:34:41 IRT176 kernel: [    0.315393] pci 0000:00:14.4:   bridge wi=
ndow [mem 0xc0000000-0xffffffff] (subtractive decode)
Apr 19 17:34:41 IRT176 kernel: [    0.315454] pci 0000:00:15.0: PCI bridge =
to [bus 05-05]
Apr 19 17:34:41 IRT176 kernel: [    0.315519] pci 0000:06:00.0: [10ec:8168]=
 type 00 class 0x020000
Apr 19 17:34:41 IRT176 kernel: [    0.315536] pci 0000:06:00.0: reg 10: [io=
  0xc000-0xc0ff]
Apr 19 17:34:41 IRT176 kernel: [    0.315565] pci 0000:06:00.0: reg 18: [me=
m 0xfe700000-0xfe700fff 64bit]
Apr 19 17:34:41 IRT176 kernel: [    0.315598] pci 0000:06:00.0: reg 30: [me=
m 0xfffe0000-0xffffffff pref]
Apr 19 17:34:41 IRT176 kernel: [    0.315675] pci 0000:06:00.0: supports D1=
 D2
Apr 19 17:34:41 IRT176 kernel: [    0.315677] pci 0000:06:00.0: PME# suppor=
ted from D1 D2 D3hot D3cold
Apr 19 17:34:41 IRT176 kernel: [    0.315702] pci 0000:06:00.0: disabling A=
SPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=3Dforce'
Apr 19 17:34:41 IRT176 kernel: [    0.315709] pci 0000:00:15.1: PCI bridge =
to [bus 06-06]
Apr 19 17:34:41 IRT176 kernel: [    0.315714] pci 0000:00:15.1:   bridge wi=
ndow [io  0xc000-0xcfff]
Apr 19 17:34:41 IRT176 kernel: [    0.315717] pci 0000:00:15.1:   bridge wi=
ndow [mem 0xfe700000-0xfe7fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.315774] pci 0000:07:00.0: [1106:3403]=
 type 00 class 0x0c0010
Apr 19 17:34:41 IRT176 kernel: [    0.315794] pci 0000:07:00.0: reg 10: [me=
m 0xfe600000-0xfe6007ff 64bit]
Apr 19 17:34:41 IRT176 kernel: [    0.315806] pci 0000:07:00.0: reg 18: [io=
  0xb000-0xb0ff]
Apr 19 17:34:41 IRT176 kernel: [    0.315894] pci 0000:07:00.0: supports D2
Apr 19 17:34:41 IRT176 kernel: [    0.315896] pci 0000:07:00.0: PME# suppor=
ted from D2 D3hot D3cold
Apr 19 17:34:41 IRT176 kernel: [    0.317196] pci 0000:00:15.2: PCI bridge =
to [bus 07-07]
Apr 19 17:34:41 IRT176 kernel: [    0.317201] pci 0000:00:15.2:   bridge wi=
ndow [io  0xb000-0xbfff]
Apr 19 17:34:41 IRT176 kernel: [    0.317204] pci 0000:00:15.2:   bridge wi=
ndow [mem 0xfe600000-0xfe6fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.317260] pci 0000:08:00.0: [10ec:8168]=
 type 00 class 0x020000
Apr 19 17:34:41 IRT176 kernel: [    0.317275] pci 0000:08:00.0: reg 10: [io=
  0xa000-0xa0ff]
Apr 19 17:34:41 IRT176 kernel: [    0.317302] pci 0000:08:00.0: reg 18: [me=
m 0xd0004000-0xd0004fff 64bit pref]
Apr 19 17:34:41 IRT176 kernel: [    0.317318] pci 0000:08:00.0: reg 20: [me=
m 0xd0000000-0xd0003fff 64bit pref]
Apr 19 17:34:41 IRT176 kernel: [    0.317392] pci 0000:08:00.0: supports D1=
 D2
Apr 19 17:34:41 IRT176 kernel: [    0.317394] pci 0000:08:00.0: PME# suppor=
ted from D0 D1 D2 D3hot D3cold
Apr 19 17:34:41 IRT176 kernel: [    0.319191] pci 0000:00:15.3: PCI bridge =
to [bus 08-08]
Apr 19 17:34:41 IRT176 kernel: [    0.319196] pci 0000:00:15.3:   bridge wi=
ndow [io  0xa000-0xafff]
Apr 19 17:34:41 IRT176 kernel: [    0.319202] pci 0000:00:15.3:   bridge wi=
ndow [mem 0xd0000000-0xd00fffff 64bit pref]
Apr 19 17:34:41 IRT176 kernel: [    0.319225] ACPI: PCI Interrupt Routing T=
able [\_SB_.PCI0._PRT]
Apr 19 17:34:41 IRT176 kernel: [    0.319372] ACPI: PCI Interrupt Routing T=
able [\_SB_.PCI0.PC02._PRT]
Apr 19 17:34:41 IRT176 kernel: [    0.319399] ACPI: PCI Interrupt Routing T=
able [\_SB_.PCI0.PC09._PRT]
Apr 19 17:34:41 IRT176 kernel: [    0.319419] ACPI: PCI Interrupt Routing T=
able [\_SB_.PCI0.PC0A._PRT]
Apr 19 17:34:41 IRT176 kernel: [    0.319452] ACPI: PCI Interrupt Routing T=
able [\_SB_.PCI0.P0PC._PRT]
Apr 19 17:34:41 IRT176 kernel: [    0.319500] ACPI: PCI Interrupt Routing T=
able [\_SB_.PCI0.PE20._PRT]
Apr 19 17:34:41 IRT176 kernel: [    0.319520] ACPI: PCI Interrupt Routing T=
able [\_SB_.PCI0.PE21._PRT]
Apr 19 17:34:41 IRT176 kernel: [    0.319540] ACPI: PCI Interrupt Routing T=
able [\_SB_.PCI0.PE22._PRT]
Apr 19 17:34:41 IRT176 kernel: [    0.319560] ACPI: PCI Interrupt Routing T=
able [\_SB_.PCI0.PE23._PRT]
Apr 19 17:34:41 IRT176 kernel: [    0.319581]  pci0000:00: Requesting ACPI =
_OSC control (0x1d)
Apr 19 17:34:41 IRT176 kernel: [    0.319583]  pci0000:00: ACPI _OSC reques=
t failed (AE_NOT_FOUND), returned control mask: 0x1d
Apr 19 17:34:41 IRT176 kernel: [    0.319584] ACPI _OSC control for PCIe no=
t granted, disabling ASPM
Apr 19 17:34:41 IRT176 kernel: [    0.324562] ACPI: PCI Interrupt Link [LNK=
A] (IRQs 10 11 14 15) *0
Apr 19 17:34:41 IRT176 kernel: [    0.324607] ACPI: PCI Interrupt Link [LNK=
B] (IRQs 10 11 14 15) *0
Apr 19 17:34:41 IRT176 kernel: [    0.324651] ACPI: PCI Interrupt Link [LNK=
C] (IRQs 10 11 14 15) *0
Apr 19 17:34:41 IRT176 kernel: [    0.324695] ACPI: PCI Interrupt Link [LNK=
D] (IRQs 10 11 14 15) *0
Apr 19 17:34:41 IRT176 kernel: [    0.324730] ACPI: PCI Interrupt Link [LNK=
E] (IRQs 10 11 14 15) *0
Apr 19 17:34:41 IRT176 kernel: [    0.324756] ACPI: PCI Interrupt Link [LNK=
F] (IRQs 10 11 14 15) *0
Apr 19 17:34:41 IRT176 kernel: [    0.324783] ACPI: PCI Interrupt Link [LNK=
G] (IRQs 10 11 14 15) *0
Apr 19 17:34:41 IRT176 kernel: [    0.324808] ACPI: PCI Interrupt Link [LNK=
H] (IRQs 10 11 14 15) *0
Apr 19 17:34:41 IRT176 kernel: [    0.324870] vgaarb: device added: PCI:000=
0:01:00.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
Apr 19 17:34:41 IRT176 kernel: [    0.324874] vgaarb: loaded
Apr 19 17:34:41 IRT176 kernel: [    0.324875] vgaarb: bridge control possib=
le 0000:01:00.0
Apr 19 17:34:41 IRT176 kernel: [    0.324896] PCI: Using ACPI for IRQ routi=
ng
Apr 19 17:34:41 IRT176 kernel: [    0.331217] PCI: pci_cache_line_size set =
to 64 bytes
Apr 19 17:34:41 IRT176 kernel: [    0.331328] e820: reserve RAM buffer [mem=
 0x0009e800-0x0009ffff]
Apr 19 17:34:41 IRT176 kernel: [    0.331329] e820: reserve RAM buffer [mem=
 0xbe1e5000-0xbfffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.331332] e820: reserve RAM buffer [mem=
 0xbee2f000-0xbfffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.331333] e820: reserve RAM buffer [mem=
 0xbf453000-0xbfffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.331335] e820: reserve RAM buffer [mem=
 0xbf800000-0xbfffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.331336] e820: reserve RAM buffer [mem=
 0x43f000000-0x43fffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.331411] hpet0: at MMIO 0xfed00000, IR=
Qs 2, 8, 0
Apr 19 17:34:41 IRT176 kernel: [    0.331414] hpet0: 3 comparators, 32-bit =
14.318180 MHz counter
Apr 19 17:34:41 IRT176 kernel: [    0.333446] Switching to clocksource hpet
Apr 19 17:34:41 IRT176 kernel: [    0.334532] pnp: PnP ACPI init
Apr 19 17:34:41 IRT176 kernel: [    0.334538] ACPI: bus type pnp registered
Apr 19 17:34:41 IRT176 kernel: [    0.334633] pnp 00:00: [bus 00-ff]
Apr 19 17:34:41 IRT176 kernel: [    0.334636] pnp 00:00: [io  0x0cf8-0x0cff]
Apr 19 17:34:41 IRT176 kernel: [    0.334638] pnp 00:00: [io  0x0000-0x03af=
 window]
Apr 19 17:34:41 IRT176 kernel: [    0.334639] pnp 00:00: [io  0x03e0-0x0cf7=
 window]
Apr 19 17:34:41 IRT176 kernel: [    0.334641] pnp 00:00: [io  0x03b0-0x03df=
 window]
Apr 19 17:34:41 IRT176 kernel: [    0.334643] pnp 00:00: [io  0x0d00-0xffff=
 window]
Apr 19 17:34:41 IRT176 kernel: [    0.334644] pnp 00:00: [mem 0x000a0000-0x=
000bffff window]
Apr 19 17:34:41 IRT176 kernel: [    0.334646] pnp 00:00: [mem 0x000c0000-0x=
000dffff window]
Apr 19 17:34:41 IRT176 kernel: [    0.334648] pnp 00:00: [mem 0xc0000000-0x=
ffffffff window]
Apr 19 17:34:41 IRT176 kernel: [    0.334649] pnp 00:00: [mem 0x00000000 wi=
ndow]
Apr 19 17:34:41 IRT176 kernel: [    0.334677] pnp 00:00: Plug and Play ACPI=
 device, IDs PNP0a03 (active)
Apr 19 17:34:41 IRT176 kernel: [    0.334699] pnp 00:01: [mem 0xe0000000-0x=
efffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.334728] system 00:01: [mem 0xe0000000=
-0xefffffff] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.334731] system 00:01: Plug and Play A=
CPI device, IDs PNP0c01 (active)
Apr 19 17:34:41 IRT176 kernel: [    0.334984] pnp 00:02: [mem 0x00000000-0x=
ffffffffffffffff disabled]
Apr 19 17:34:41 IRT176 kernel: [    0.334986] pnp 00:02: [mem 0xfec20000-0x=
fec200ff]
Apr 19 17:34:41 IRT176 kernel: [    0.335015] system 00:02: [mem 0xfec20000=
-0xfec200ff] could not be reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335018] system 00:02: Plug and Play A=
CPI device, IDs PNP0c02 (active)
Apr 19 17:34:41 IRT176 kernel: [    0.335050] pnp 00:03: [mem 0x00000000-0x=
ffffffffffffffff disabled]
Apr 19 17:34:41 IRT176 kernel: [    0.335077] system 00:03: Plug and Play A=
CPI device, IDs PNP0c02 (active)
Apr 19 17:34:41 IRT176 kernel: [    0.335243] pnp 00:04: [io  0x040b]
Apr 19 17:34:41 IRT176 kernel: [    0.335244] pnp 00:04: [io  0x04d6]
Apr 19 17:34:41 IRT176 kernel: [    0.335246] pnp 00:04: [io  0x0c00-0x0c01]
Apr 19 17:34:41 IRT176 kernel: [    0.335247] pnp 00:04: [io  0x0c14]
Apr 19 17:34:41 IRT176 kernel: [    0.335249] pnp 00:04: [io  0x0c50-0x0c51]
Apr 19 17:34:41 IRT176 kernel: [    0.335250] pnp 00:04: [io  0x0c52]
Apr 19 17:34:41 IRT176 kernel: [    0.335252] pnp 00:04: [io  0x0c6c]
Apr 19 17:34:41 IRT176 kernel: [    0.335253] pnp 00:04: [io  0x0c6f]
Apr 19 17:34:41 IRT176 kernel: [    0.335255] pnp 00:04: [io  0x0cd0-0x0cd1]
Apr 19 17:34:41 IRT176 kernel: [    0.335256] pnp 00:04: [io  0x0cd2-0x0cd3]
Apr 19 17:34:41 IRT176 kernel: [    0.335257] pnp 00:04: [io  0x0cd4-0x0cd5]
Apr 19 17:34:41 IRT176 kernel: [    0.335259] pnp 00:04: [io  0x0cd6-0x0cd7]
Apr 19 17:34:41 IRT176 kernel: [    0.335260] pnp 00:04: [io  0x0cd8-0x0cdf]
Apr 19 17:34:41 IRT176 kernel: [    0.335263] pnp 00:04: [io  0x0800-0x089f]
Apr 19 17:34:41 IRT176 kernel: [    0.335265] pnp 00:04: [io  0x0000-0xffff=
ffffffffffff disabled]
Apr 19 17:34:41 IRT176 kernel: [    0.335266] pnp 00:04: [io  0x0000-0x000f]
Apr 19 17:34:41 IRT176 kernel: [    0.335268] pnp 00:04: [io  0x0b20-0x0b3f]
Apr 19 17:34:41 IRT176 kernel: [    0.335269] pnp 00:04: [io  0x0900-0x090f]
Apr 19 17:34:41 IRT176 kernel: [    0.335271] pnp 00:04: [io  0x0910-0x091f]
Apr 19 17:34:41 IRT176 kernel: [    0.335272] pnp 00:04: [io  0xfe00-0xfefe]
Apr 19 17:34:41 IRT176 kernel: [    0.335274] pnp 00:04: [io  0x0060-0x005f=
 disabled]
Apr 19 17:34:41 IRT176 kernel: [    0.335275] pnp 00:04: [io  0x0064-0x0063=
 disabled]
Apr 19 17:34:41 IRT176 kernel: [    0.335277] pnp 00:04: [mem 0xfec00000-0x=
fec00fff]
Apr 19 17:34:41 IRT176 kernel: [    0.335278] pnp 00:04: [mem 0xfee00000-0x=
fee00fff]
Apr 19 17:34:41 IRT176 kernel: [    0.335280] pnp 00:04: [mem 0xfed80000-0x=
fed8ffff]
Apr 19 17:34:41 IRT176 kernel: [    0.335281] pnp 00:04: [mem 0xfed61000-0x=
fed70fff]
Apr 19 17:34:41 IRT176 kernel: [    0.335283] pnp 00:04: [mem 0xfec10000-0x=
fec10fff]
Apr 19 17:34:41 IRT176 kernel: [    0.335284] pnp 00:04: [mem 0xfed00000-0x=
fed00fff]
Apr 19 17:34:41 IRT176 kernel: [    0.335286] pnp 00:04: [mem 0xffc00000-0x=
ffffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.335346] system 00:04: [io  0x040b] ha=
s been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335348] system 00:04: [io  0x04d6] ha=
s been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335350] system 00:04: [io  0x0c00-0x0=
c01] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335352] system 00:04: [io  0x0c14] ha=
s been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335354] system 00:04: [io  0x0c50-0x0=
c51] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335355] system 00:04: [io  0x0c52] ha=
s been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335357] system 00:04: [io  0x0c6c] ha=
s been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335359] system 00:04: [io  0x0c6f] ha=
s been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335360] system 00:04: [io  0x0cd0-0x0=
cd1] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335362] system 00:04: [io  0x0cd2-0x0=
cd3] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335364] system 00:04: [io  0x0cd4-0x0=
cd5] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335365] system 00:04: [io  0x0cd6-0x0=
cd7] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335367] system 00:04: [io  0x0cd8-0x0=
cdf] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335369] system 00:04: [io  0x0800-0x0=
89f] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335371] system 00:04: [io  0x0b20-0x0=
b3f] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335372] system 00:04: [io  0x0900-0x0=
90f] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335374] system 00:04: [io  0x0910-0x0=
91f] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335376] system 00:04: [io  0xfe00-0xf=
efe] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335378] system 00:04: [mem 0xfec00000=
-0xfec00fff] could not be reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335380] system 00:04: [mem 0xfee00000=
-0xfee00fff] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335382] system 00:04: [mem 0xfed80000=
-0xfed8ffff] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335384] system 00:04: [mem 0xfed61000=
-0xfed70fff] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335386] system 00:04: [mem 0xfec10000=
-0xfec10fff] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335388] system 00:04: [mem 0xfed00000=
-0xfed00fff] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335390] system 00:04: [mem 0xffc00000=
-0xffffffff] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335392] system 00:04: Plug and Play A=
CPI device, IDs PNP0c02 (active)
Apr 19 17:34:41 IRT176 kernel: [    0.335436] pnp 00:05: [io  0x0000-0xffff=
ffffffffffff disabled]
Apr 19 17:34:41 IRT176 kernel: [    0.335437] pnp 00:05: [io  0x0290-0x029f]
Apr 19 17:34:41 IRT176 kernel: [    0.335439] pnp 00:05: [io  0x0000-0xffff=
ffffffffffff disabled]
Apr 19 17:34:41 IRT176 kernel: [    0.335472] system 00:05: [io  0x0290-0x0=
29f] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335474] system 00:05: Plug and Play A=
CPI device, IDs PNP0c02 (active)
Apr 19 17:34:41 IRT176 kernel: [    0.335632] pnp 00:06: [dma 4]
Apr 19 17:34:41 IRT176 kernel: [    0.335634] pnp 00:06: [io  0x0000-0x000f]
Apr 19 17:34:41 IRT176 kernel: [    0.335635] pnp 00:06: [io  0x0081-0x0083]
Apr 19 17:34:41 IRT176 kernel: [    0.335637] pnp 00:06: [io  0x0087]
Apr 19 17:34:41 IRT176 kernel: [    0.335638] pnp 00:06: [io  0x0089-0x008b]
Apr 19 17:34:41 IRT176 kernel: [    0.335640] pnp 00:06: [io  0x008f]
Apr 19 17:34:41 IRT176 kernel: [    0.335641] pnp 00:06: [io  0x00c0-0x00df]
Apr 19 17:34:41 IRT176 kernel: [    0.335660] pnp 00:06: Plug and Play ACPI=
 device, IDs PNP0200 (active)
Apr 19 17:34:41 IRT176 kernel: [    0.335667] pnp 00:07: [io  0x0070-0x0071]
Apr 19 17:34:41 IRT176 kernel: [    0.335673] pnp 00:07: [irq 8]
Apr 19 17:34:41 IRT176 kernel: [    0.335693] pnp 00:07: Plug and Play ACPI=
 device, IDs PNP0b00 (active)
Apr 19 17:34:41 IRT176 kernel: [    0.335699] pnp 00:08: [io  0x0061]
Apr 19 17:34:41 IRT176 kernel: [    0.335717] pnp 00:08: Plug and Play ACPI=
 device, IDs PNP0800 (active)
Apr 19 17:34:41 IRT176 kernel: [    0.335733] pnp 00:09: [io  0x0010-0x001f]
Apr 19 17:34:41 IRT176 kernel: [    0.335735] pnp 00:09: [io  0x0022-0x003f]
Apr 19 17:34:41 IRT176 kernel: [    0.335737] pnp 00:09: [io  0x0044-0x005f]
Apr 19 17:34:41 IRT176 kernel: [    0.335738] pnp 00:09: [io  0x0062-0x0063]
Apr 19 17:34:41 IRT176 kernel: [    0.335740] pnp 00:09: [io  0x0065-0x006f]
Apr 19 17:34:41 IRT176 kernel: [    0.335741] pnp 00:09: [io  0x0072-0x007f]
Apr 19 17:34:41 IRT176 kernel: [    0.335742] pnp 00:09: [io  0x0080]
Apr 19 17:34:41 IRT176 kernel: [    0.335744] pnp 00:09: [io  0x0084-0x0086]
Apr 19 17:34:41 IRT176 kernel: [    0.335745] pnp 00:09: [io  0x0088]
Apr 19 17:34:41 IRT176 kernel: [    0.335747] pnp 00:09: [io  0x008c-0x008e]
Apr 19 17:34:41 IRT176 kernel: [    0.335748] pnp 00:09: [io  0x0090-0x009f]
Apr 19 17:34:41 IRT176 kernel: [    0.335750] pnp 00:09: [io  0x00a2-0x00bf]
Apr 19 17:34:41 IRT176 kernel: [    0.335751] pnp 00:09: [io  0x00e0-0x00ef]
Apr 19 17:34:41 IRT176 kernel: [    0.335754] pnp 00:09: [io  0x04d0-0x04d1]
Apr 19 17:34:41 IRT176 kernel: [    0.335795] system 00:09: [io  0x04d0-0x0=
4d1] has been reserved
Apr 19 17:34:41 IRT176 kernel: [    0.335797] system 00:09: Plug and Play A=
CPI device, IDs PNP0c02 (active)
Apr 19 17:34:41 IRT176 kernel: [    0.335803] pnp 00:0a: [io  0x00f0-0x00ff]
Apr 19 17:34:41 IRT176 kernel: [    0.335807] pnp 00:0a: [irq 13]
Apr 19 17:34:41 IRT176 kernel: [    0.335826] pnp 00:0a: Plug and Play ACPI=
 device, IDs PNP0c04 (active)
Apr 19 17:34:41 IRT176 kernel: [    0.335866] system 00:0b: Plug and Play A=
CPI device, IDs PNP0c02 (active)
Apr 19 17:34:41 IRT176 kernel: [    0.335987] pnp 00:0c: [io  0x03f8-0x03ff]
Apr 19 17:34:41 IRT176 kernel: [    0.335991] pnp 00:0c: [irq 4]
Apr 19 17:34:41 IRT176 kernel: [    0.335993] pnp 00:0c: [dma 0 disabled]
Apr 19 17:34:41 IRT176 kernel: [    0.336033] pnp 00:0c: Plug and Play ACPI=
 device, IDs PNP0501 (active)
Apr 19 17:34:41 IRT176 kernel: [    0.336152] pnp 00:0d: [mem 0xfed00000-0x=
fed003ff]
Apr 19 17:34:41 IRT176 kernel: [    0.336178] pnp 00:0d: Plug and Play ACPI=
 device, IDs PNP0103 (active)
Apr 19 17:34:41 IRT176 kernel: [    0.336183] pnp: PnP ACPI: found 14 devic=
es
Apr 19 17:34:41 IRT176 kernel: [    0.336184] ACPI: ACPI bus type pnp unreg=
istered
Apr 19 17:34:41 IRT176 kernel: [    0.342303] pci 0000:06:00.0: no compatib=
le bridge window for [mem 0xfffe0000-0xffffffff pref]
Apr 19 17:34:41 IRT176 kernel: [    0.342339] pci 0000:00:15.1: BAR 15: ass=
igned [mem 0xd0100000-0xd01fffff pref]
Apr 19 17:34:41 IRT176 kernel: [    0.342342] pci 0000:00:02.0: PCI bridge =
to [bus 01-01]
Apr 19 17:34:41 IRT176 kernel: [    0.342344] pci 0000:00:02.0:   bridge wi=
ndow [io  0xe000-0xefff]
Apr 19 17:34:41 IRT176 kernel: [    0.342347] pci 0000:00:02.0:   bridge wi=
ndow [mem 0xfea00000-0xfeafffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342350] pci 0000:00:02.0:   bridge wi=
ndow [mem 0xc0000000-0xcfffffff 64bit pref]
Apr 19 17:34:41 IRT176 kernel: [    0.342353] pci 0000:00:09.0: PCI bridge =
to [bus 02-02]
Apr 19 17:34:41 IRT176 kernel: [    0.342356] pci 0000:00:09.0:   bridge wi=
ndow [mem 0xfe900000-0xfe9fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342359] pci 0000:00:0a.0: PCI bridge =
to [bus 03-03]
Apr 19 17:34:41 IRT176 kernel: [    0.342362] pci 0000:00:0a.0:   bridge wi=
ndow [mem 0xfe800000-0xfe8fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342366] pci 0000:00:14.4: PCI bridge =
to [bus 04-04]
Apr 19 17:34:41 IRT176 kernel: [    0.342369] pci 0000:00:14.4:   bridge wi=
ndow [io  0xd000-0xdfff]
Apr 19 17:34:41 IRT176 kernel: [    0.342372] pci 0000:00:14.4:   bridge wi=
ndow [mem 0xfe300000-0xfe5fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342379] pci 0000:00:15.0: PCI bridge =
to [bus 05-05]
Apr 19 17:34:41 IRT176 kernel: [    0.342387] pci 0000:06:00.0: BAR 6: assi=
gned [mem 0xd0100000-0xd011ffff pref]
Apr 19 17:34:41 IRT176 kernel: [    0.342389] pci 0000:00:15.1: PCI bridge =
to [bus 06-06]
Apr 19 17:34:41 IRT176 kernel: [    0.342391] pci 0000:00:15.1:   bridge wi=
ndow [io  0xc000-0xcfff]
Apr 19 17:34:41 IRT176 kernel: [    0.342394] pci 0000:00:15.1:   bridge wi=
ndow [mem 0xfe700000-0xfe7fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342397] pci 0000:00:15.1:   bridge wi=
ndow [mem 0xd0100000-0xd01fffff pref]
Apr 19 17:34:41 IRT176 kernel: [    0.342401] pci 0000:00:15.2: PCI bridge =
to [bus 07-07]
Apr 19 17:34:41 IRT176 kernel: [    0.342404] pci 0000:00:15.2:   bridge wi=
ndow [io  0xb000-0xbfff]
Apr 19 17:34:41 IRT176 kernel: [    0.342407] pci 0000:00:15.2:   bridge wi=
ndow [mem 0xfe600000-0xfe6fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342413] pci 0000:00:15.3: PCI bridge =
to [bus 08-08]
Apr 19 17:34:41 IRT176 kernel: [    0.342415] pci 0000:00:15.3:   bridge wi=
ndow [io  0xa000-0xafff]
Apr 19 17:34:41 IRT176 kernel: [    0.342420] pci 0000:00:15.3:   bridge wi=
ndow [mem 0xd0000000-0xd00fffff 64bit pref]
Apr 19 17:34:41 IRT176 kernel: [    0.342457] pci_bus 0000:00: resource 4 [=
io  0x0000-0x03af]
Apr 19 17:34:41 IRT176 kernel: [    0.342459] pci_bus 0000:00: resource 5 [=
io  0x03e0-0x0cf7]
Apr 19 17:34:41 IRT176 kernel: [    0.342461] pci_bus 0000:00: resource 6 [=
io  0x03b0-0x03df]
Apr 19 17:34:41 IRT176 kernel: [    0.342462] pci_bus 0000:00: resource 7 [=
io  0x0d00-0xffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342464] pci_bus 0000:00: resource 8 [=
mem 0x000a0000-0x000bffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342466] pci_bus 0000:00: resource 9 [=
mem 0x000c0000-0x000dffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342472] pci_bus 0000:00: resource 10 =
[mem 0xc0000000-0xffffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342474] pci_bus 0000:01: resource 0 [=
io  0xe000-0xefff]
Apr 19 17:34:41 IRT176 kernel: [    0.342476] pci_bus 0000:01: resource 1 [=
mem 0xfea00000-0xfeafffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342478] pci_bus 0000:01: resource 2 [=
mem 0xc0000000-0xcfffffff 64bit pref]
Apr 19 17:34:41 IRT176 kernel: [    0.342479] pci_bus 0000:02: resource 1 [=
mem 0xfe900000-0xfe9fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342481] pci_bus 0000:03: resource 1 [=
mem 0xfe800000-0xfe8fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342483] pci_bus 0000:04: resource 0 [=
io  0xd000-0xdfff]
Apr 19 17:34:41 IRT176 kernel: [    0.342484] pci_bus 0000:04: resource 1 [=
mem 0xfe300000-0xfe5fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342486] pci_bus 0000:04: resource 4 [=
io  0x0000-0x03af]
Apr 19 17:34:41 IRT176 kernel: [    0.342487] pci_bus 0000:04: resource 5 [=
io  0x03e0-0x0cf7]
Apr 19 17:34:41 IRT176 kernel: [    0.342489] pci_bus 0000:04: resource 6 [=
io  0x03b0-0x03df]
Apr 19 17:34:41 IRT176 kernel: [    0.342491] pci_bus 0000:04: resource 7 [=
io  0x0d00-0xffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342492] pci_bus 0000:04: resource 8 [=
mem 0x000a0000-0x000bffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342494] pci_bus 0000:04: resource 9 [=
mem 0x000c0000-0x000dffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342495] pci_bus 0000:04: resource 10 =
[mem 0xc0000000-0xffffffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342497] pci_bus 0000:06: resource 0 [=
io  0xc000-0xcfff]
Apr 19 17:34:41 IRT176 kernel: [    0.342499] pci_bus 0000:06: resource 1 [=
mem 0xfe700000-0xfe7fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342500] pci_bus 0000:06: resource 2 [=
mem 0xd0100000-0xd01fffff pref]
Apr 19 17:34:41 IRT176 kernel: [    0.342502] pci_bus 0000:07: resource 0 [=
io  0xb000-0xbfff]
Apr 19 17:34:41 IRT176 kernel: [    0.342503] pci_bus 0000:07: resource 1 [=
mem 0xfe600000-0xfe6fffff]
Apr 19 17:34:41 IRT176 kernel: [    0.342505] pci_bus 0000:08: resource 0 [=
io  0xa000-0xafff]
Apr 19 17:34:41 IRT176 kernel: [    0.342506] pci_bus 0000:08: resource 2 [=
mem 0xd0000000-0xd00fffff 64bit pref]
Apr 19 17:34:41 IRT176 kernel: [    0.342526] NET: Registered protocol fami=
ly 2
Apr 19 17:34:41 IRT176 kernel: [    0.342791] IP route cache hash table ent=
ries: 524288 (order: 10, 4194304 bytes)
Apr 19 17:34:41 IRT176 kernel: [    0.343896] TCP established hash table en=
tries: 524288 (order: 11, 8388608 bytes)
Apr 19 17:34:41 IRT176 kernel: [    0.345489] TCP bind hash table entries: =
65536 (order: 8, 1048576 bytes)
Apr 19 17:34:41 IRT176 kernel: [    0.345675] TCP: Hash tables configured (=
established 524288 bind 65536)
Apr 19 17:34:41 IRT176 kernel: [    0.345677] TCP: reno registered
Apr 19 17:34:41 IRT176 kernel: [    0.345694] UDP hash table entries: 8192 =
(order: 6, 262144 bytes)
Apr 19 17:34:41 IRT176 kernel: [    0.345760] UDP-Lite hash table entries: =
8192 (order: 6, 262144 bytes)
Apr 19 17:34:41 IRT176 kernel: [    0.345853] NET: Registered protocol fami=
ly 1
Apr 19 17:34:41 IRT176 kernel: [    0.600994] pci 0000:01:00.0: Boot video =
device
Apr 19 17:34:41 IRT176 kernel: [    0.601087] pci 0000:04:06.0: Firmware le=
ft e100 interrupts enabled; disabling
Apr 19 17:34:41 IRT176 kernel: [    0.601098] PCI: CLS 64 bytes, default 64
Apr 19 17:34:41 IRT176 kernel: [    0.601126] Unpacking initramfs...
Apr 19 17:34:41 IRT176 kernel: [    0.715805] Freeing initrd memory: 7616k =
freed
Apr 19 17:34:41 IRT176 kernel: [    0.717677] PCI-DMA: Disabling AGP.
Apr 19 17:34:41 IRT176 kernel: [    0.717739] PCI-DMA: aperture base @ b400=
0000 size 65536 KB
Apr 19 17:34:41 IRT176 kernel: [    0.717740] PCI-DMA: using GART IOMMU.
Apr 19 17:34:41 IRT176 kernel: [    0.717743] PCI-DMA: Reserving 64MB of IO=
MMU area in the AGP aperture
Apr 19 17:34:41 IRT176 kernel: [    0.722190] LVT offset 0 assigned for vec=
tor 0x400
Apr 19 17:34:41 IRT176 kernel: [    0.722215] perf: AMD IBS detected (0x000=
000ff)
Apr 19 17:34:41 IRT176 kernel: [    0.722319] audit: initializing netlink s=
ocket (disabled)
Apr 19 17:34:41 IRT176 kernel: [    0.722332] type=3D2000 audit(1366392870.=
583:1): initialized
Apr 19 17:34:41 IRT176 kernel: [    0.730568] I-pipe: head domain Xenomai r=
egistered.
Apr 19 17:34:41 IRT176 kernel: [    0.730833] Xenomai: hal/x86_64 started.
Apr 19 17:34:41 IRT176 kernel: [    0.730878] Xenomai: scheduling class idl=
e registered.
Apr 19 17:34:41 IRT176 kernel: [    0.730879] Xenomai: scheduling class rt =
registered.
Apr 19 17:34:41 IRT176 kernel: [    0.732342] Xenomai: real-time nucleus v2=
.6.2.1 (Day At The Beach) loaded.
Apr 19 17:34:41 IRT176 kernel: [    0.732344] Xenomai: debug mode enabled.
Apr 19 17:34:41 IRT176 kernel: [    0.736698] Xenomai: starting native API =
services.
Apr 19 17:34:41 IRT176 kernel: [    0.736700] Xenomai: starting POSIX servi=
ces.
Apr 19 17:34:41 IRT176 kernel: [    0.736775] Xenomai: starting RTDM servic=
es.
Apr 19 17:34:41 IRT176 kernel: [    0.737525] HugeTLB registered 2 MB page =
size, pre-allocated 0 pages
Apr 19 17:34:41 IRT176 kernel: [    0.738518] VFS: Disk quotas dquot_6.5.2
Apr 19 17:34:41 IRT176 kernel: [    0.738546] Dquot-cache hash table entrie=
s: 512 (order 0, 4096 bytes)
Apr 19 17:34:41 IRT176 kernel: [    0.738620] msgmni has been set to 31994
Apr 19 17:34:41 IRT176 kernel: [    0.738802] Block layer SCSI generic (bsg=
) driver version 0.4 loaded (major 252)
Apr 19 17:34:41 IRT176 kernel: [    0.738803] io scheduler noop registered
Apr 19 17:34:41 IRT176 kernel: [    0.738804] io scheduler deadline registe=
red
Apr 19 17:34:41 IRT176 kernel: [    0.738822] io scheduler cfq registered (=
default)
Apr 19 17:34:41 IRT176 kernel: [    0.739118] Serial: 8250/16550 driver, 4 =
ports, IRQ sharing enabled
Apr 19 17:34:41 IRT176 kernel: [    0.759577] serial8250: ttyS0 at I/O 0x3f=
8 (irq =3D 4) is a 16550A
Apr 19 17:34:41 IRT176 kernel: [    0.780218] 00:0c: ttyS0 at I/O 0x3f8 (ir=
q =3D 4) is a 16550A
Apr 19 17:34:41 IRT176 kernel: [    0.780367] Linux agpgart interface v0.103
Apr 19 17:34:41 IRT176 kernel: [    0.780443] i8042: PNP: No PS/2 controlle=
r found. Probing ports directly.
Apr 19 17:34:41 IRT176 kernel: [    0.782881] serio: i8042 KBD port at 0x60=
,0x64 irq 1
Apr 19 17:34:41 IRT176 kernel: [    0.782897] serio: i8042 AUX port at 0x60=
,0x64 irq 12
Apr 19 17:34:41 IRT176 kernel: [    0.782984] mousedev: PS/2 mouse device c=
ommon for all mice
Apr 19 17:34:41 IRT176 kernel: [    0.783022] rtc_cmos 00:07: RTC can wake =
from S4
Apr 19 17:34:41 IRT176 kernel: [    0.783106] rtc_cmos 00:07: rtc core: reg=
istered rtc_cmos as rtc0
Apr 19 17:34:41 IRT176 kernel: [    0.783126] rtc0: alarms up to one month,=
 y3k, 114 bytes nvram, hpet irqs
Apr 19 17:34:41 IRT176 kernel: [    0.783134] cpuidle: using governor ladder
Apr 19 17:34:41 IRT176 kernel: [    0.783135] cpuidle: using governor menu
Apr 19 17:34:41 IRT176 kernel: [    0.783196] RT-Socket-CAN 0.90.2 - (C) 20=
06 RT-Socket-CAN Development Team
Apr 19 17:34:41 IRT176 kernel: [    0.783209] rtcan: registered rtcan0
Apr 19 17:34:41 IRT176 kernel: [    0.783210] rtcan0: VIRT driver loaded
Apr 19 17:34:41 IRT176 kernel: [    0.783219] rtcan: registered rtcan1
Apr 19 17:34:41 IRT176 kernel: [    0.783220] rtcan1: VIRT driver loaded
Apr 19 17:34:41 IRT176 kernel: [    0.783322] TCP: cubic registered
Apr 19 17:34:41 IRT176 kernel: [    0.783397] NET: Registered protocol fami=
ly 10
Apr 19 17:34:41 IRT176 kernel: [    0.783562] mip6: Mobile IPv6
Apr 19 17:34:41 IRT176 kernel: [    0.783563] NET: Registered protocol fami=
ly 17
Apr 19 17:34:41 IRT176 kernel: [    0.783573] Key type dns_resolver registe=
red
Apr 19 17:34:41 IRT176 kernel: [    0.783667] PM: Hibernation image not pre=
sent or could not be loaded.
Apr 19 17:34:41 IRT176 kernel: [    0.783673] registered taskstats version 1
Apr 19 17:34:41 IRT176 kernel: [    0.784101] rtc_cmos 00:07: setting syste=
m clock to 2013-04-19 17:34:30 UTC (1366392870)
Apr 19 17:34:41 IRT176 kernel: [    0.785812] Freeing unused kernel memory:=
 1308k freed
Apr 19 17:34:41 IRT176 kernel: [    0.786062] Write protecting the kernel r=
ead-only data: 6144k
Apr 19 17:34:41 IRT176 kernel: [    0.787071] Freeing unused kernel memory:=
 448k freed
Apr 19 17:34:41 IRT176 kernel: [    0.788757] Freeing unused kernel memory:=
 792k freed
Apr 19 17:34:41 IRT176 kernel: [    0.815750] SCSI subsystem initialized
Apr 19 17:34:41 IRT176 kernel: [    0.815795] ACPI: bus type usb registered
Apr 19 17:34:41 IRT176 kernel: [    0.815814] usbcore: registered new inter=
face driver usbfs
Apr 19 17:34:41 IRT176 kernel: [    0.815822] usbcore: registered new inter=
face driver hub
Apr 19 17:34:41 IRT176 kernel: [    0.817628] r8169 Gigabit Ethernet driver=
 2.3LK-NAPI loaded
Apr 19 17:34:41 IRT176 kernel: [    0.817742] libata version 3.00 loaded.
Apr 19 17:34:41 IRT176 kernel: [    0.817780] r8169 0000:06:00.0: irq 72 fo=
r MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    0.817920] r8169 0000:06:00.0: eth0: RTL=
8168b/8111b at 0xffffc90001878000, f8:d1:11:02:8b:e5, XID 18000000 IRQ 72
Apr 19 17:34:41 IRT176 kernel: [    0.817923] r8169 0000:06:00.0: eth0: jum=
bo features [frames: 4080 bytes, tx checksumming: ko]
Apr 19 17:34:41 IRT176 kernel: [    0.817944] r8169 Gigabit Ethernet driver=
 2.3LK-NAPI loaded
Apr 19 17:34:41 IRT176 kernel: [    0.818061] r8169 0000:08:00.0: irq 73 fo=
r MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    0.818109] usbcore: registered new devic=
e driver usb
Apr 19 17:34:41 IRT176 kernel: [    0.818193] r8169 0000:08:00.0: eth1: RTL=
8168evl/8111evl at 0xffffc9000181e000, bc:5f:f4:8b:f4:94, XID 0c900800 IRQ =
73
Apr 19 17:34:41 IRT176 kernel: [    0.818197] r8169 0000:08:00.0: eth1: jum=
bo features [frames: 9200 bytes, tx checksumming: ko]
Apr 19 17:34:41 IRT176 kernel: [    0.818379] ahci 0000:00:11.0: version 3.0
Apr 19 17:34:41 IRT176 kernel: [    0.818554] ahci 0000:00:11.0: AHCI 0001.=
0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
Apr 19 17:34:41 IRT176 kernel: [    0.818557] ahci 0000:00:11.0: flags: 64b=
it ncq sntf ilck pm led clo pmp pio slum part =

Apr 19 17:34:41 IRT176 kernel: [    0.818713] ehci_hcd: USB 2.0 'Enhanced' =
Host Controller (EHCI) Driver
Apr 19 17:34:41 IRT176 kernel: [    0.818997] scsi0 : ahci
Apr 19 17:34:41 IRT176 kernel: [    0.819064] scsi1 : ahci
Apr 19 17:34:41 IRT176 kernel: [    0.819166] scsi2 : ahci
Apr 19 17:34:41 IRT176 kernel: [    0.819249] scsi3 : ahci
Apr 19 17:34:41 IRT176 kernel: [    0.819302] ata1: SATA max UDMA/133 abar =
m1024@0xfeb0b000 port 0xfeb0b100 irq 19
Apr 19 17:34:41 IRT176 kernel: [    0.819307] ata2: SATA max UDMA/133 abar =
m1024@0xfeb0b000 port 0xfeb0b180 irq 19
Apr 19 17:34:41 IRT176 kernel: [    0.819310] ata3: SATA max UDMA/133 abar =
m1024@0xfeb0b000 port 0xfeb0b200 irq 19
Apr 19 17:34:41 IRT176 kernel: [    0.819313] ata4: SATA max UDMA/133 abar =
m1024@0xfeb0b000 port 0xfeb0b280 irq 19
Apr 19 17:34:41 IRT176 kernel: [    0.819513] ehci_hcd 0000:00:12.2: EHCI H=
ost Controller
Apr 19 17:34:41 IRT176 kernel: [    0.819519] ehci_hcd 0000:00:12.2: new US=
B bus registered, assigned bus number 1
Apr 19 17:34:41 IRT176 kernel: [    0.819527] ehci_hcd 0000:00:12.2: applyi=
ng AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
Apr 19 17:34:41 IRT176 kernel: [    0.819542] QUIRK: Enable AMD PLL fix
Apr 19 17:34:41 IRT176 kernel: [    0.819551] ehci_hcd 0000:00:12.2: debug =
port 1
Apr 19 17:34:41 IRT176 kernel: [    0.819567] ehci_hcd 0000:00:12.2: irq 17=
, io mem 0xfeb09000
Apr 19 17:34:41 IRT176 kernel: [    0.819842] e100: Intel(R) PRO/100 Networ=
k Driver, 3.5.24-k2-NAPI
Apr 19 17:34:41 IRT176 kernel: [    0.819846] e100: Copyright(c) 1999-2006 =
Intel Corporation
Apr 19 17:34:41 IRT176 kernel: [    0.824769] ohci_hcd: USB 1.1 'Open' Host=
 Controller (OHCI) Driver
Apr 19 17:34:41 IRT176 kernel: [    0.825470] ehci_hcd 0000:00:12.2: USB 2.=
0 started, EHCI 1.00
Apr 19 17:34:41 IRT176 kernel: [    0.825488] usb usb1: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0002
Apr 19 17:34:41 IRT176 kernel: [    0.825491] usb usb1: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Apr 19 17:34:41 IRT176 kernel: [    0.825493] usb usb1: Product: EHCI Host =
Controller
Apr 19 17:34:41 IRT176 kernel: [    0.825496] usb usb1: Manufacturer: Linux=
 3.5.7-xenomai-2.6.2.1 ehci_hcd
Apr 19 17:34:41 IRT176 kernel: [    0.825498] usb usb1: SerialNumber: 0000:=
00:12.2
Apr 19 17:34:41 IRT176 kernel: [    0.825586] hub 1-0:1.0: USB hub found
Apr 19 17:34:41 IRT176 kernel: [    0.825590] hub 1-0:1.0: 5 ports detected
Apr 19 17:34:41 IRT176 kernel: [    0.825685] ehci_hcd 0000:00:13.2: EHCI H=
ost Controller
Apr 19 17:34:41 IRT176 kernel: [    0.825690] ehci_hcd 0000:00:13.2: new US=
B bus registered, assigned bus number 2
Apr 19 17:34:41 IRT176 kernel: [    0.825697] ehci_hcd 0000:00:13.2: applyi=
ng AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
Apr 19 17:34:41 IRT176 kernel: [    0.825713] ehci_hcd 0000:00:13.2: debug =
port 1
Apr 19 17:34:41 IRT176 kernel: [    0.825726] ehci_hcd 0000:00:13.2: irq 17=
, io mem 0xfeb07000
Apr 19 17:34:41 IRT176 kernel: [    0.831443] ehci_hcd 0000:00:13.2: USB 2.=
0 started, EHCI 1.00
Apr 19 17:34:41 IRT176 kernel: [    0.831458] usb usb2: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0002
Apr 19 17:34:41 IRT176 kernel: [    0.831461] usb usb2: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Apr 19 17:34:41 IRT176 kernel: [    0.831464] usb usb2: Product: EHCI Host =
Controller
Apr 19 17:34:41 IRT176 kernel: [    0.831466] usb usb2: Manufacturer: Linux=
 3.5.7-xenomai-2.6.2.1 ehci_hcd
Apr 19 17:34:41 IRT176 kernel: [    0.831468] usb usb2: SerialNumber: 0000:=
00:13.2
Apr 19 17:34:41 IRT176 kernel: [    0.831551] hub 2-0:1.0: USB hub found
Apr 19 17:34:41 IRT176 kernel: [    0.831555] hub 2-0:1.0: 5 ports detected
Apr 19 17:34:41 IRT176 kernel: [    0.831628] ehci_hcd 0000:00:16.2: EHCI H=
ost Controller
Apr 19 17:34:41 IRT176 kernel: [    0.831633] ehci_hcd 0000:00:16.2: new US=
B bus registered, assigned bus number 3
Apr 19 17:34:41 IRT176 kernel: [    0.831639] ehci_hcd 0000:00:16.2: applyi=
ng AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
Apr 19 17:34:41 IRT176 kernel: [    0.831654] ehci_hcd 0000:00:16.2: debug =
port 1
Apr 19 17:34:41 IRT176 kernel: [    0.831665] ehci_hcd 0000:00:16.2: irq 17=
, io mem 0xfeb04000
Apr 19 17:34:41 IRT176 kernel: [    0.838454] ehci_hcd 0000:00:16.2: USB 2.=
0 started, EHCI 1.00
Apr 19 17:34:41 IRT176 kernel: [    0.838468] usb usb3: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0002
Apr 19 17:34:41 IRT176 kernel: [    0.838471] usb usb3: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Apr 19 17:34:41 IRT176 kernel: [    0.838473] usb usb3: Product: EHCI Host =
Controller
Apr 19 17:34:41 IRT176 kernel: [    0.838475] usb usb3: Manufacturer: Linux=
 3.5.7-xenomai-2.6.2.1 ehci_hcd
Apr 19 17:34:41 IRT176 kernel: [    0.838476] usb usb3: SerialNumber: 0000:=
00:16.2
Apr 19 17:34:41 IRT176 kernel: [    0.838548] hub 3-0:1.0: USB hub found
Apr 19 17:34:41 IRT176 kernel: [    0.838551] hub 3-0:1.0: 4 ports detected
Apr 19 17:34:41 IRT176 kernel: [    0.838643] ohci_hcd 0000:00:12.0: OHCI H=
ost Controller
Apr 19 17:34:41 IRT176 kernel: [    0.838649] ohci_hcd 0000:00:12.0: new US=
B bus registered, assigned bus number 4
Apr 19 17:34:41 IRT176 kernel: [    0.838674] ohci_hcd 0000:00:12.0: irq 18=
, io mem 0xfeb0a000
Apr 19 17:34:41 IRT176 kernel: [    0.847487] e100 0000:04:06.0: eth2: addr=
 0xfe500000, irq 21, MAC addr 00:90:27:8f:f6:c4
Apr 19 17:34:41 IRT176 kernel: [    0.873372] firewire_ohci 0000:07:00.0: a=
dded OHCI v1.10 device as card 0, 4 IR + 8 IT contexts, quirks 0x11
Apr 19 17:34:41 IRT176 kernel: [    0.893320] usb usb4: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0001
Apr 19 17:34:41 IRT176 kernel: [    0.893322] usb usb4: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Apr 19 17:34:41 IRT176 kernel: [    0.893324] usb usb4: Product: OHCI Host =
Controller
Apr 19 17:34:41 IRT176 kernel: [    0.893326] usb usb4: Manufacturer: Linux=
 3.5.7-xenomai-2.6.2.1 ohci_hcd
Apr 19 17:34:41 IRT176 kernel: [    0.893327] usb usb4: SerialNumber: 0000:=
00:12.0
Apr 19 17:34:41 IRT176 kernel: [    0.893415] hub 4-0:1.0: USB hub found
Apr 19 17:34:41 IRT176 kernel: [    0.893420] hub 4-0:1.0: 5 ports detected
Apr 19 17:34:41 IRT176 kernel: [    0.893482] ohci_hcd 0000:00:13.0: OHCI H=
ost Controller
Apr 19 17:34:41 IRT176 kernel: [    0.893486] ohci_hcd 0000:00:13.0: new US=
B bus registered, assigned bus number 5
Apr 19 17:34:41 IRT176 kernel: [    0.893498] ohci_hcd 0000:00:13.0: irq 18=
, io mem 0xfeb08000
Apr 19 17:34:41 IRT176 kernel: [    0.948192] usb usb5: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0001
Apr 19 17:34:41 IRT176 kernel: [    0.948195] usb usb5: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Apr 19 17:34:41 IRT176 kernel: [    0.948197] usb usb5: Product: OHCI Host =
Controller
Apr 19 17:34:41 IRT176 kernel: [    0.948198] usb usb5: Manufacturer: Linux=
 3.5.7-xenomai-2.6.2.1 ohci_hcd
Apr 19 17:34:41 IRT176 kernel: [    0.948200] usb usb5: SerialNumber: 0000:=
00:13.0
Apr 19 17:34:41 IRT176 kernel: [    0.948288] hub 5-0:1.0: USB hub found
Apr 19 17:34:41 IRT176 kernel: [    0.948293] hub 5-0:1.0: 5 ports detected
Apr 19 17:34:41 IRT176 kernel: [    0.948355] ohci_hcd 0000:00:14.5: OHCI H=
ost Controller
Apr 19 17:34:41 IRT176 kernel: [    0.948359] ohci_hcd 0000:00:14.5: new US=
B bus registered, assigned bus number 6
Apr 19 17:34:41 IRT176 kernel: [    0.948371] ohci_hcd 0000:00:14.5: irq 18=
, io mem 0xfeb06000
Apr 19 17:34:41 IRT176 kernel: [    1.003076] usb usb6: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0001
Apr 19 17:34:41 IRT176 kernel: [    1.003079] usb usb6: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Apr 19 17:34:41 IRT176 kernel: [    1.003080] usb usb6: Product: OHCI Host =
Controller
Apr 19 17:34:41 IRT176 kernel: [    1.003082] usb usb6: Manufacturer: Linux=
 3.5.7-xenomai-2.6.2.1 ohci_hcd
Apr 19 17:34:41 IRT176 kernel: [    1.003083] usb usb6: SerialNumber: 0000:=
00:14.5
Apr 19 17:34:41 IRT176 kernel: [    1.003164] hub 6-0:1.0: USB hub found
Apr 19 17:34:41 IRT176 kernel: [    1.003169] hub 6-0:1.0: 2 ports detected
Apr 19 17:34:41 IRT176 kernel: [    1.003226] ohci_hcd 0000:00:16.0: OHCI H=
ost Controller
Apr 19 17:34:41 IRT176 kernel: [    1.003231] ohci_hcd 0000:00:16.0: new US=
B bus registered, assigned bus number 7
Apr 19 17:34:41 IRT176 kernel: [    1.003244] ohci_hcd 0000:00:16.0: irq 18=
, io mem 0xfeb05000
Apr 19 17:34:41 IRT176 kernel: [    1.057958] usb usb7: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0001
Apr 19 17:34:41 IRT176 kernel: [    1.057960] usb usb7: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Apr 19 17:34:41 IRT176 kernel: [    1.057962] usb usb7: Product: OHCI Host =
Controller
Apr 19 17:34:41 IRT176 kernel: [    1.057963] usb usb7: Manufacturer: Linux=
 3.5.7-xenomai-2.6.2.1 ohci_hcd
Apr 19 17:34:41 IRT176 kernel: [    1.057965] usb usb7: SerialNumber: 0000:=
00:16.0
Apr 19 17:34:41 IRT176 kernel: [    1.058042] hub 7-0:1.0: USB hub found
Apr 19 17:34:41 IRT176 kernel: [    1.058047] hub 7-0:1.0: 4 ports detected
Apr 19 17:34:41 IRT176 kernel: [    1.123829] ata4: SATA link down (SStatus=
 0 SControl 300)
Apr 19 17:34:41 IRT176 kernel: [    1.123855] ata1: SATA link down (SStatus=
 0 SControl 300)
Apr 19 17:34:41 IRT176 kernel: [    1.125825] ata3: SATA link down (SStatus=
 0 SControl 300)
Apr 19 17:34:41 IRT176 kernel: [    1.280481] ata2: SATA link up 3.0 Gbps (=
SStatus 123 SControl 300)
Apr 19 17:34:41 IRT176 kernel: [    1.281502] ata2.00: ATA-8: Hitachi HDS72=
1010CLA330, JP4OA3MA, max UDMA/133
Apr 19 17:34:41 IRT176 kernel: [    1.281504] ata2.00: 1953525168 sectors, =
multi 16: LBA48 NCQ (depth 31/32), AA
Apr 19 17:34:41 IRT176 kernel: [    1.282615] ata2.00: configured for UDMA/=
133
Apr 19 17:34:41 IRT176 kernel: [    1.282729] scsi 1:0:0:0: Direct-Access  =
   ATA      Hitachi HDS72101 JP4O PQ: 0 ANSI: 5
Apr 19 17:34:41 IRT176 kernel: [    1.285768] sd 1:0:0:0: [sda] 1953525168 =
512-byte logical blocks: (1.00 TB/931 GiB)
Apr 19 17:34:41 IRT176 kernel: [    1.285841] sd 1:0:0:0: [sda] Write Prote=
ct is off
Apr 19 17:34:41 IRT176 kernel: [    1.285844] sd 1:0:0:0: [sda] Mode Sense:=
 00 3a 00 00
Apr 19 17:34:41 IRT176 kernel: [    1.285872] sd 1:0:0:0: [sda] Write cache=
: enabled, read cache: enabled, doesn't support DPO or FUA
Apr 19 17:34:41 IRT176 kernel: [    1.306676]  sda: sda1 sda2 sda3
Apr 19 17:34:41 IRT176 kernel: [    1.306978] sd 1:0:0:0: [sda] Attached SC=
SI disk
Apr 19 17:34:41 IRT176 kernel: [    1.374319] firewire_core 0000:07:00.0: c=
reated device fw0: GUID 008f1300d3d31300, S400
Apr 19 17:34:41 IRT176 kernel: [    1.562845] usb 4-3: new low-speed USB de=
vice number 2 using ohci_hcd
Apr 19 17:34:41 IRT176 kernel: [    1.594491] PM: Starting manual resume fr=
om disk
Apr 19 17:34:41 IRT176 kernel: [    1.594493] PM: Hibernation image partiti=
on 8:2 present
Apr 19 17:34:41 IRT176 kernel: [    1.594494] PM: Looking for hibernation i=
mage.
Apr 19 17:34:41 IRT176 kernel: [    1.594656] PM: Image not found (code -22)
Apr 19 17:34:41 IRT176 kernel: [    1.594658] PM: Hibernation image not pre=
sent or could not be loaded.
Apr 19 17:34:41 IRT176 kernel: [    1.628365] EXT4-fs (sda1): mounted files=
ystem with ordered data mode. Opts: (null)
Apr 19 17:34:41 IRT176 kernel: [    1.713589] usb 4-3: New USB device found=
, idVendor=3D046d, idProduct=3Dc018
Apr 19 17:34:41 IRT176 kernel: [    1.713593] usb 4-3: New USB device strin=
gs: Mfr=3D1, Product=3D2, SerialNumber=3D0
Apr 19 17:34:41 IRT176 kernel: [    1.713595] usb 4-3: Product: USB Optical=
 Mouse
Apr 19 17:34:41 IRT176 kernel: [    1.713596] usb 4-3: Manufacturer: Logite=
ch
Apr 19 17:34:41 IRT176 kernel: [    1.721505] Refined TSC clocksource calib=
ration: 3991.359 MHz.
Apr 19 17:34:41 IRT176 kernel: [    1.721514] Switching to clocksource tsc
Apr 19 17:34:41 IRT176 kernel: [    1.942025] usb 4-4: new low-speed USB de=
vice number 3 using ohci_hcd
Apr 19 17:34:41 IRT176 kernel: [    2.094772] usb 4-4: New USB device found=
, idVendor=3D046a, idProduct=3D0001
Apr 19 17:34:41 IRT176 kernel: [    2.094775] usb 4-4: New USB device strin=
gs: Mfr=3D1, Product=3D0, SerialNumber=3D0
Apr 19 17:34:41 IRT176 kernel: [    2.094777] usb 4-4: Manufacturer: Cherry=
 GmbH
Apr 19 17:34:41 IRT176 kernel: [    3.125753] input: Power Button as /devic=
es/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
Apr 19 17:34:41 IRT176 kernel: [    3.125758] ACPI: Power Button [PWRB]
Apr 19 17:34:41 IRT176 kernel: [    3.125802] input: Power Button as /devic=
es/LNXSYSTM:00/LNXPWRBN:00/input/input1
Apr 19 17:34:41 IRT176 kernel: [    3.125804] ACPI: Power Button [PWRF]
Apr 19 17:34:41 IRT176 kernel: [    3.129634] input: PC Speaker as /devices=
/platform/pcspkr/input/input2
Apr 19 17:34:41 IRT176 kernel: [    3.204778] microcode: CPU0: patch_level=
=3D0x06000817
Apr 19 17:34:41 IRT176 kernel: [    3.241994] wmi: Mapper loaded
Apr 19 17:34:41 IRT176 kernel: [    3.330936] xhci_hcd 0000:02:00.0: xHCI H=
ost Controller
Apr 19 17:34:41 IRT176 kernel: [    3.330943] xhci_hcd 0000:02:00.0: new US=
B bus registered, assigned bus number 8
Apr 19 17:34:41 IRT176 kernel: [    3.335308] xhci_hcd 0000:02:00.0: irq 48=
, io mem 0xfe900000
Apr 19 17:34:41 IRT176 kernel: [    3.335348] xhci_hcd 0000:02:00.0: irq 74=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.335352] xhci_hcd 0000:02:00.0: irq 75=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.335357] xhci_hcd 0000:02:00.0: irq 76=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.335361] xhci_hcd 0000:02:00.0: irq 77=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.335365] xhci_hcd 0000:02:00.0: irq 78=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.335370] xhci_hcd 0000:02:00.0: irq 79=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.335373] xhci_hcd 0000:02:00.0: irq 80=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.335379] xhci_hcd 0000:02:00.0: irq 81=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.335486] usb usb8: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0002
Apr 19 17:34:41 IRT176 kernel: [    3.335488] usb usb8: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Apr 19 17:34:41 IRT176 kernel: [    3.335490] usb usb8: Product: xHCI Host =
Controller
Apr 19 17:34:41 IRT176 kernel: [    3.335491] usb usb8: Manufacturer: Linux=
 3.5.7-xenomai-2.6.2.1 xhci_hcd
Apr 19 17:34:41 IRT176 kernel: [    3.335493] usb usb8: SerialNumber: 0000:=
02:00.0
Apr 19 17:34:41 IRT176 kernel: [    3.335556] xHCI xhci_add_endpoint called=
 for root hub
Apr 19 17:34:41 IRT176 kernel: [    3.335557] xHCI xhci_check_bandwidth cal=
led for root hub
Apr 19 17:34:41 IRT176 kernel: [    3.335576] hub 8-0:1.0: USB hub found
Apr 19 17:34:41 IRT176 kernel: [    3.335581] hub 8-0:1.0: 2 ports detected
Apr 19 17:34:41 IRT176 kernel: [    3.335631] xhci_hcd 0000:02:00.0: xHCI H=
ost Controller
Apr 19 17:34:41 IRT176 kernel: [    3.335634] xhci_hcd 0000:02:00.0: new US=
B bus registered, assigned bus number 9
Apr 19 17:34:41 IRT176 kernel: [    3.335653] usb usb9: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0003
Apr 19 17:34:41 IRT176 kernel: [    3.335655] usb usb9: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Apr 19 17:34:41 IRT176 kernel: [    3.335657] usb usb9: Product: xHCI Host =
Controller
Apr 19 17:34:41 IRT176 kernel: [    3.335658] usb usb9: Manufacturer: Linux=
 3.5.7-xenomai-2.6.2.1 xhci_hcd
Apr 19 17:34:41 IRT176 kernel: [    3.335660] usb usb9: SerialNumber: 0000:=
02:00.0
Apr 19 17:34:41 IRT176 kernel: [    3.335702] xHCI xhci_add_endpoint called=
 for root hub
Apr 19 17:34:41 IRT176 kernel: [    3.335703] xHCI xhci_check_bandwidth cal=
led for root hub
Apr 19 17:34:41 IRT176 kernel: [    3.335722] hub 9-0:1.0: USB hub found
Apr 19 17:34:41 IRT176 kernel: [    3.335727] hub 9-0:1.0: 2 ports detected
Apr 19 17:34:41 IRT176 kernel: [    3.344042] xhci_hcd 0000:03:00.0: xHCI H=
ost Controller
Apr 19 17:34:41 IRT176 kernel: [    3.344047] xhci_hcd 0000:03:00.0: new US=
B bus registered, assigned bus number 10
Apr 19 17:34:41 IRT176 kernel: [    3.348409] xhci_hcd 0000:03:00.0: irq 47=
, io mem 0xfe800000
Apr 19 17:34:41 IRT176 kernel: [    3.348445] xhci_hcd 0000:03:00.0: irq 82=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.348450] xhci_hcd 0000:03:00.0: irq 83=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.348455] xhci_hcd 0000:03:00.0: irq 84=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.348459] xhci_hcd 0000:03:00.0: irq 85=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.348463] xhci_hcd 0000:03:00.0: irq 86=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.348468] xhci_hcd 0000:03:00.0: irq 87=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.348472] xhci_hcd 0000:03:00.0: irq 88=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.348476] xhci_hcd 0000:03:00.0: irq 89=
 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    3.348561] usb usb10: New USB device fou=
nd, idVendor=3D1d6b, idProduct=3D0002
Apr 19 17:34:41 IRT176 kernel: [    3.348563] usb usb10: New USB device str=
ings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Apr 19 17:34:41 IRT176 kernel: [    3.348565] usb usb10: Product: xHCI Host=
 Controller
Apr 19 17:34:41 IRT176 kernel: [    3.348567] usb usb10: Manufacturer: Linu=
x 3.5.7-xenomai-2.6.2.1 xhci_hcd
Apr 19 17:34:41 IRT176 kernel: [    3.348568] usb usb10: SerialNumber: 0000=
:03:00.0
Apr 19 17:34:41 IRT176 kernel: [    3.348629] xHCI xhci_add_endpoint called=
 for root hub
Apr 19 17:34:41 IRT176 kernel: [    3.348630] xHCI xhci_check_bandwidth cal=
led for root hub
Apr 19 17:34:41 IRT176 kernel: [    3.348647] hub 10-0:1.0: USB hub found
Apr 19 17:34:41 IRT176 kernel: [    3.348652] hub 10-0:1.0: 2 ports detected
Apr 19 17:34:41 IRT176 kernel: [    3.348699] xhci_hcd 0000:03:00.0: xHCI H=
ost Controller
Apr 19 17:34:41 IRT176 kernel: [    3.348702] xhci_hcd 0000:03:00.0: new US=
B bus registered, assigned bus number 11
Apr 19 17:34:41 IRT176 kernel: [    3.348722] usb usb11: New USB device fou=
nd, idVendor=3D1d6b, idProduct=3D0003
Apr 19 17:34:41 IRT176 kernel: [    3.348724] usb usb11: New USB device str=
ings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Apr 19 17:34:41 IRT176 kernel: [    3.348725] usb usb11: Product: xHCI Host=
 Controller
Apr 19 17:34:41 IRT176 kernel: [    3.348727] usb usb11: Manufacturer: Linu=
x 3.5.7-xenomai-2.6.2.1 xhci_hcd
Apr 19 17:34:41 IRT176 kernel: [    3.348728] usb usb11: SerialNumber: 0000=
:03:00.0
Apr 19 17:34:41 IRT176 kernel: [    3.348772] xHCI xhci_add_endpoint called=
 for root hub
Apr 19 17:34:41 IRT176 kernel: [    3.348774] xHCI xhci_check_bandwidth cal=
led for root hub
Apr 19 17:34:41 IRT176 kernel: [    3.348788] hub 11-0:1.0: USB hub found
Apr 19 17:34:41 IRT176 kernel: [    3.348793] hub 11-0:1.0: 2 ports detected
Apr 19 17:34:41 IRT176 kernel: [    3.419850] MCE: In-kernel MCE decoding e=
nabled.
Apr 19 17:34:41 IRT176 kernel: [    3.471855] EDAC MC: Ver: 2.1.0
Apr 19 17:34:41 IRT176 kernel: [    3.594820] kvm: Nested Virtualization en=
abled
Apr 19 17:34:41 IRT176 kernel: [    3.594824] kvm: Nested Paging enabled
Apr 19 17:34:41 IRT176 kernel: [    3.614558] usbcore: registered new inter=
face driver usbhid
Apr 19 17:34:41 IRT176 kernel: [    3.614560] usbhid: USB HID core driver
Apr 19 17:34:41 IRT176 kernel: [    3.645394] AMD64 EDAC driver v3.4.0
Apr 19 17:34:41 IRT176 kernel: [    3.645426] EDAC amd64: DRAM ECC disabled.
Apr 19 17:34:41 IRT176 kernel: [    3.645442] EDAC amd64: ECC disabled in t=
he BIOS or no ECC capability, module will not load.
Apr 19 17:34:41 IRT176 kernel: [    3.645442]  Either enable ECC checking o=
r force module loading by setting 'ecc_enable_override'.
Apr 19 17:34:41 IRT176 kernel: [    3.645442]  (Note that use of the overri=
de may cause unknown side effects.)
Apr 19 17:34:41 IRT176 kernel: [    3.688315] ACPI Warning: 0x0000000000000=
b00-0x0000000000000b07 SystemIO conflicts with Region \SOR1 1 (20120320/uta=
ddress-251)
Apr 19 17:34:41 IRT176 kernel: [    3.688321] ACPI: If an ACPI driver is av=
ailable for this device, you should use it instead of the native driver
Apr 19 17:34:41 IRT176 kernel: [    3.689754] [drm] Initialized drm 1.1.0 2=
0060810
Apr 19 17:34:41 IRT176 kernel: [    3.738024] microcode: failed to load fil=
e amd-ucode/microcode_amd_fam15h.bin
Apr 19 17:34:41 IRT176 kernel: [    3.772033] input: Logitech USB Optical M=
ouse as /devices/pci0000:00/0000:00:12.0/usb4/4-3/4-3:1.0/input/input3
Apr 19 17:34:41 IRT176 kernel: [    3.772133] hid-generic 0003:046D:C018.00=
01: input,hidraw0: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-=
0000:00:12.0-3/input0
Apr 19 17:34:41 IRT176 kernel: [    3.772235] input: Cherry GmbH as /device=
s/pci0000:00/0000:00:12.0/usb4/4-4/4-4:1.0/input/input4
Apr 19 17:34:41 IRT176 kernel: [    3.772297] hid-generic 0003:046A:0001.00=
02: input,hidraw1: USB HID v1.11 Keyboard [Cherry GmbH] on usb-0000:00:12.0=
-4/input0
Apr 19 17:34:41 IRT176 kernel: [    3.782901] sp5100_tco: SP5100 TCO WatchD=
og Timer Driver v0.01
Apr 19 17:34:41 IRT176 kernel: [    3.782945] sp5100_tco: mmio address 0xba=
fe00 already in use
Apr 19 17:34:41 IRT176 kernel: [    3.890874] microcode: CPU1: patch_level=
=3D0x06000817
Apr 19 17:34:41 IRT176 kernel: [    3.892175] microcode: failed to load fil=
e amd-ucode/microcode_amd_fam15h.bin
Apr 19 17:34:41 IRT176 kernel: [    3.977476] microcode: CPU2: patch_level=
=3D0x06000817
Apr 19 17:34:41 IRT176 kernel: [    3.978762] microcode: failed to load fil=
e amd-ucode/microcode_amd_fam15h.bin
Apr 19 17:34:41 IRT176 kernel: [    4.003092] [drm] radeon kernel modesetti=
ng enabled.
Apr 19 17:34:41 IRT176 kernel: [    4.003280] [drm] initializing kernel mod=
esetting (CEDAR 0x1002:0x68E1 0x174B:0x3000).
Apr 19 17:34:41 IRT176 kernel: [    4.064010] microcode: CPU3: patch_level=
=3D0x06000817
Apr 19 17:34:41 IRT176 kernel: [    4.064041] [drm] register mmio base: 0xF=
EA20000
Apr 19 17:34:41 IRT176 kernel: [    4.064043] [drm] register mmio size: 131=
072
Apr 19 17:34:41 IRT176 kernel: [    4.064199] ATOM BIOS: AMD
Apr 19 17:34:41 IRT176 kernel: [    4.064269] radeon 0000:01:00.0: VRAM: 10=
24M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
Apr 19 17:34:41 IRT176 kernel: [    4.064271] radeon 0000:01:00.0: GTT: 512=
M 0x0000000040000000 - 0x000000005FFFFFFF
Apr 19 17:34:41 IRT176 kernel: [    4.073772] [drm] Detected VRAM RAM=3D102=
4M, BAR=3D256M
Apr 19 17:34:41 IRT176 kernel: [    4.073775] [drm] RAM width 64bits DDR
Apr 19 17:34:41 IRT176 kernel: [    4.073831] [TTM] Zone  kernel: Available=
 graphics memory: 8191966 kiB
Apr 19 17:34:41 IRT176 kernel: [    4.073834] [TTM] Zone   dma32: Available=
 graphics memory: 2097152 kiB
Apr 19 17:34:41 IRT176 kernel: [    4.073836] [TTM] Initializing pool alloc=
ator
Apr 19 17:34:41 IRT176 kernel: [    4.073841] [TTM] Initializing DMA pool a=
llocator
Apr 19 17:34:41 IRT176 kernel: [    4.073864] [drm] radeon: 1024M of VRAM m=
emory ready
Apr 19 17:34:41 IRT176 kernel: [    4.073866] [drm] radeon: 512M of GTT mem=
ory ready.
Apr 19 17:34:41 IRT176 kernel: [    4.073880] [drm] Supports vblank timesta=
mp caching Rev 1 (10.10.2010).
Apr 19 17:34:41 IRT176 kernel: [    4.073882] [drm] Driver supports precise=
 vblank timestamp query.
Apr 19 17:34:41 IRT176 kernel: [    4.073926] radeon 0000:01:00.0: irq 90 f=
or MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    4.073937] radeon 0000:01:00.0: radeon: =
using MSI.
Apr 19 17:34:41 IRT176 kernel: [    4.073969] [drm] radeon: irq initialized.
Apr 19 17:34:41 IRT176 kernel: [    4.073974] [drm] GART: num cpu pages 131=
072, num gpu pages 131072
Apr 19 17:34:41 IRT176 kernel: [    4.074567] [drm] Loading CEDAR Microcode
Apr 19 17:34:41 IRT176 kernel: [    4.075021] microcode: failed to load fil=
e amd-ucode/microcode_amd_fam15h.bin
Apr 19 17:34:41 IRT176 kernel: [    4.160251] microcode: CPU4: patch_level=
=3D0x06000817
Apr 19 17:34:41 IRT176 kernel: [    4.161439] microcode: failed to load fil=
e amd-ucode/microcode_amd_fam15h.bin
Apr 19 17:34:41 IRT176 kernel: [    4.246701] microcode: CPU5: patch_level=
=3D0x06000817
Apr 19 17:34:41 IRT176 kernel: [    4.247971] microcode: failed to load fil=
e amd-ucode/microcode_amd_fam15h.bin
Apr 19 17:34:41 IRT176 kernel: [    4.333257] microcode: CPU6: patch_level=
=3D0x06000817
Apr 19 17:34:41 IRT176 kernel: [    4.334424] microcode: failed to load fil=
e amd-ucode/microcode_amd_fam15h.bin
Apr 19 17:34:41 IRT176 kernel: [    4.343706] r600_cp: Failed to load firmw=
are "radeon/CEDAR_pfp.bin"
Apr 19 17:34:41 IRT176 kernel: [    4.343708] [drm:evergreen_startup] *ERRO=
R* Failed to load firmware!
Apr 19 17:34:41 IRT176 kernel: [    4.343710] radeon 0000:01:00.0: disablin=
g GPU acceleration
Apr 19 17:34:41 IRT176 kernel: [    4.344748] radeon 0000:01:00.0: ffff8804=
286cd800 unpin not necessary
Apr 19 17:34:41 IRT176 kernel: [    4.344790] radeon 0000:01:00.0: ffff8804=
286cd400 unpin not necessary
Apr 19 17:34:41 IRT176 kernel: [    4.344792] radeon 0000:01:00.0: ffff8804=
286cd400 unpin not necessary
Apr 19 17:34:41 IRT176 kernel: [    4.344993] [drm] Radeon Display Connecto=
rs
Apr 19 17:34:41 IRT176 kernel: [    4.344993] [drm] Connector 0:
Apr 19 17:34:41 IRT176 kernel: [    4.344994] [drm]   HDMI-A-1
Apr 19 17:34:41 IRT176 kernel: [    4.344995] [drm]   HPD4
Apr 19 17:34:41 IRT176 kernel: [    4.344996] [drm]   DDC: 0x6440 0x6440 0x=
6444 0x6444 0x6448 0x6448 0x644c 0x644c
Apr 19 17:34:41 IRT176 kernel: [    4.344996] [drm]   Encoders:
Apr 19 17:34:41 IRT176 kernel: [    4.344997] [drm]     DFP1: INTERNAL_UNIP=
HY1
Apr 19 17:34:41 IRT176 kernel: [    4.344998] [drm] Connector 1:
Apr 19 17:34:41 IRT176 kernel: [    4.344998] [drm]   DVI-I-1
Apr 19 17:34:41 IRT176 kernel: [    4.344999] [drm]   HPD1
Apr 19 17:34:41 IRT176 kernel: [    4.345000] [drm]   DDC: 0x6460 0x6460 0x=
6464 0x6464 0x6468 0x6468 0x646c 0x646c
Apr 19 17:34:41 IRT176 kernel: [    4.345000] [drm]   Encoders:
Apr 19 17:34:41 IRT176 kernel: [    4.345001] [drm]     DFP2: INTERNAL_UNIP=
HY
Apr 19 17:34:41 IRT176 kernel: [    4.345001] [drm]     CRT1: INTERNAL_KLDS=
CP_DAC1
Apr 19 17:34:41 IRT176 kernel: [    4.345002] [drm] Connector 2:
Apr 19 17:34:41 IRT176 kernel: [    4.345002] [drm]   VGA-1
Apr 19 17:34:41 IRT176 kernel: [    4.345004] [drm]   DDC: 0x6430 0x6430 0x=
6434 0x6434 0x6438 0x6438 0x643c 0x643c
Apr 19 17:34:41 IRT176 kernel: [    4.345004] [drm]   Encoders:
Apr 19 17:34:41 IRT176 kernel: [    4.345004] [drm]     CRT2: INTERNAL_KLDS=
CP_DAC2
Apr 19 17:34:41 IRT176 kernel: [    4.345038] [drm] Internal thermal contro=
ller without fan control
Apr 19 17:34:41 IRT176 kernel: [    4.345061] [drm] radeon: power managemen=
t initialized
Apr 19 17:34:41 IRT176 kernel: [    4.636904] microcode: CPU7: patch_level=
=3D0x06000817
Apr 19 17:34:41 IRT176 kernel: [    4.638141] microcode: failed to load fil=
e amd-ucode/microcode_amd_fam15h.bin
Apr 19 17:34:41 IRT176 kernel: [    4.638758] [drm] fb mappable at 0xC00400=
00
Apr 19 17:34:41 IRT176 kernel: [    4.638759] [drm] vram apper at 0xC0000000
Apr 19 17:34:41 IRT176 kernel: [    4.638760] [drm] size 5242880
Apr 19 17:34:41 IRT176 kernel: [    4.638760] [drm] fb depth is 24
Apr 19 17:34:41 IRT176 kernel: [    4.638761] [drm]    pitch is 5120
Apr 19 17:34:41 IRT176 kernel: [    4.638809] fbcon: radeondrmfb (fb0) is p=
rimary device
Apr 19 17:34:41 IRT176 kernel: [    4.723525] microcode: Microcode Update D=
river: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
Apr 19 17:34:41 IRT176 kernel: [    4.785990] input: HDA ATI SB Line as /de=
vices/pci0000:00/0000:00:14.2/sound/card0/input5
Apr 19 17:34:41 IRT176 kernel: [    4.786041] input: HDA ATI SB Rear Mic as=
 /devices/pci0000:00/0000:00:14.2/sound/card0/input6
Apr 19 17:34:41 IRT176 kernel: [    4.786087] input: HDA ATI SB Line Out Si=
de as /devices/pci0000:00/0000:00:14.2/sound/card0/input7
Apr 19 17:34:41 IRT176 kernel: [    4.786131] input: HDA ATI SB Line Out CL=
FE as /devices/pci0000:00/0000:00:14.2/sound/card0/input8
Apr 19 17:34:41 IRT176 kernel: [    4.786176] input: HDA ATI SB Line Out Su=
rround as /devices/pci0000:00/0000:00:14.2/sound/card0/input9
Apr 19 17:34:41 IRT176 kernel: [    4.786221] input: HDA ATI SB Line Out Fr=
ont as /devices/pci0000:00/0000:00:14.2/sound/card0/input10
Apr 19 17:34:41 IRT176 kernel: [    4.971739] Console: switching to colour =
frame buffer device 160x64
Apr 19 17:34:41 IRT176 kernel: [    4.973961] fb0: radeondrmfb frame buffer=
 device
Apr 19 17:34:41 IRT176 kernel: [    4.973962] drm: registered panic notifier
Apr 19 17:34:41 IRT176 kernel: [    4.973966] [drm] Initialized radeon 2.18=
.0 20080528 for 0000:01:00.0 on minor 0
Apr 19 17:34:41 IRT176 kernel: [    4.974021] hda-intel: 0000:01:00.1: Hand=
le VGA-switcheroo audio client
Apr 19 17:34:41 IRT176 kernel: [    4.974087] snd_hda_intel 0000:01:00.1: i=
rq 90 for MSI/MSI-X
Apr 19 17:34:41 IRT176 kernel: [    5.001600] input: HD-Audio Generic HDMI/=
DP,pcm=3D3 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/inp=
ut11
Apr 19 17:34:41 IRT176 kernel: [    5.697845] Adding 19530748k swap on /dev=
/sda2.  Priority:-1 extents:1 across:19530748k =

Apr 19 17:34:41 IRT176 kernel: [    5.700437] EXT4-fs (sda1): re-mounted. O=
pts: (null)
Apr 19 17:34:41 IRT176 kernel: [    5.837542] EXT4-fs (sda1): re-mounted. O=
pts: errors=3Dremount-ro
Apr 19 17:34:41 IRT176 kernel: [    5.928800] loop: module loaded
Apr 19 17:34:41 IRT176 kernel: [    6.250409] EXT4-fs (sda3): mounted files=
ystem with ordered data mode. Opts: (null)
Apr 19 17:34:41 IRT176 kernel: [    6.738753] r8169 0000:08:00.0: eth0: una=
ble to load firmware patch rtl_nic/rtl8168e-3.fw (-2)
Apr 19 17:34:41 IRT176 kernel: [    6.745542] r8169 0000:08:00.0: eth0: lin=
k down
Apr 19 17:34:41 IRT176 kernel: [    6.745568] r8169 0000:08:00.0: eth0: lin=
k down
Apr 19 17:34:41 IRT176 kernel: [    6.746825] IPv6: ADDRCONF(NETDEV_UP): et=
h0: link is not ready
Apr 19 17:34:41 IRT176 kernel: [    8.302884] r8169 0000:08:00.0: eth0: lin=
k up
Apr 19 17:34:41 IRT176 kernel: [    8.304070] IPv6: ADDRCONF(NETDEV_CHANGE)=
: eth0: link becomes ready
Apr 19 17:34:41 IRT176 kernel: [   10.741956] r8169 0000:06:00.0: eth1: lin=
k down
Apr 19 17:34:41 IRT176 kernel: [   10.742001] r8169 0000:06:00.0: eth1: lin=
k down
Apr 19 17:34:41 IRT176 kernel: [   10.743249] IPv6: ADDRCONF(NETDEV_UP): et=
h1: link is not ready
Apr 19 17:34:41 IRT176 kernel: [   10.830039] e100 0000:04:06.0: eth3: NIC =
Link is Up 100 Mbps Full Duplex
Apr 19 17:34:41 IRT176 kernel: [   10.830438] IPv6: ADDRCONF(NETDEV_UP): et=
h3: link is not ready
Apr 19 17:34:41 IRT176 kernel: [   10.831521] IPv6: ADDRCONF(NETDEV_CHANGE)=
: eth3: link becomes ready
Apr 19 17:34:41 IRT176 kernel: [   11.101360] fuse init (API version 7.19)
Apr 19 17:34:41 IRT176 acpid: starting up with netlink and the input layer
Apr 19 17:34:41 IRT176 acpid: 1 rule loaded
Apr 19 17:34:41 IRT176 acpid: waiting for events: event logging is off
Apr 19 17:34:42 IRT176 kernel: [   12.864040] r8169 0000:06:00.0: eth1: lin=
k up
Apr 19 17:34:42 IRT176 kernel: [   12.865255] IPv6: ADDRCONF(NETDEV_CHANGE)=
: eth1: link becomes ready
Apr 19 17:34:42 IRT176 anacron[1487]: Anacron 2.3 started on 2013-04-19
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Found user 'avahi' (UID 104) and=
 group 'avahi' (GID 107).
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Successfully dropped root privil=
eges.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: avahi-daemon 0.6.27 starting up.
Apr 19 17:34:43 IRT176 dhcpd: Internet Systems Consortium DHCP Server 4.1.1=
-P1
Apr 19 17:34:43 IRT176 dhcpd: Copyright 2004-2010 Internet Systems Consorti=
um.
Apr 19 17:34:43 IRT176 dhcpd: All rights reserved.
Apr 19 17:34:43 IRT176 dhcpd: For info, please visit https://www.isc.org/so=
ftware/dhcp/
Apr 19 17:34:43 IRT176 dhcpd: Internet Systems Consortium DHCP Server 4.1.1=
-P1
Apr 19 17:34:43 IRT176 dhcpd: Copyright 2004-2010 Internet Systems Consorti=
um.
Apr 19 17:34:43 IRT176 dhcpd: All rights reserved.
Apr 19 17:34:43 IRT176 dhcpd: For info, please visit https://www.isc.org/so=
ftware/dhcp/
Apr 19 17:34:43 IRT176 dhcpd: Wrote 0 deleted host decls to leases file.
Apr 19 17:34:43 IRT176 dhcpd: Wrote 0 new dynamic host decls to leases file.
Apr 19 17:34:43 IRT176 dhcpd: Wrote 0 leases to leases file.
Apr 19 17:34:43 IRT176 anacron[1487]: Normal exit (0 jobs run)
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Successfully called chroot().
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Successfully dropped remaining c=
apabilities.
Apr 19 17:34:43 IRT176 bluetoothd[1556]: Bluetooth deamon 4.66
Apr 19 17:34:43 IRT176 dhcpd: =

Apr 19 17:34:43 IRT176 dhcpd: No subnet declaration for eth3 (192.168.0.21).
Apr 19 17:34:43 IRT176 dhcpd: ** Ignoring requests on eth3.  If this is not=
 what
Apr 19 17:34:43 IRT176 dhcpd:    you want, please write a subnet declaration
Apr 19 17:34:43 IRT176 dhcpd:    in your dhcpd.conf file for the network se=
gment
Apr 19 17:34:43 IRT176 dhcpd:    to which interface eth3 is attached. **
Apr 19 17:34:43 IRT176 dhcpd: =

Apr 19 17:34:43 IRT176 dhcpd: =

Apr 19 17:34:43 IRT176 dhcpd: No subnet declaration for eth0 ([...]).
Apr 19 17:34:43 IRT176 dhcpd: ** Ignoring requests on eth0.  If this is not=
 what
Apr 19 17:34:43 IRT176 dhcpd:    you want, please write a subnet declaration
Apr 19 17:34:43 IRT176 dhcpd:    in your dhcpd.conf file for the network se=
gment
Apr 19 17:34:43 IRT176 dhcpd:    to which interface eth0 is attached. **
Apr 19 17:34:43 IRT176 dhcpd: =

Apr 19 17:34:43 IRT176 acpid: client connected from 1574[109:117]
Apr 19 17:34:43 IRT176 acpid: 1 client rule loaded
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: No service file found in /etc/av=
ahi/services.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Joining mDNS multicast group on =
interface eth3.IPv6 with address fe80::290:27ff:fe8f:f6c4.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: New relevant interface eth3.IPv6=
 for mDNS.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Joining mDNS multicast group on =
interface eth3.IPv4 with address 192.168.0.21.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: New relevant interface eth3.IPv4=
 for mDNS.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Joining mDNS multicast group on =
interface eth0.IPv6 with address fe80::be5f:f4ff:fe8b:f494.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: New relevant interface eth0.IPv6=
 for mDNS.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Joining mDNS multicast group on =
interface eth0.IPv4 with address [...].
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: New relevant interface eth0.IPv4=
 for mDNS.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Joining mDNS multicast group on =
interface eth1.IPv6 with address fe80::fad1:11ff:fe02:8be5.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: New relevant interface eth1.IPv6=
 for mDNS.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Joining mDNS multicast group on =
interface eth1.IPv4 with address 192.168.1.254.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: New relevant interface eth1.IPv4=
 for mDNS.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Network interface enumeration co=
mpleted.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Registering new address record f=
or fe80::290:27ff:fe8f:f6c4 on eth3.*.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Registering new address record f=
or 192.168.0.21 on eth3.IPv4.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Registering new address record f=
or fe80::be5f:f4ff:fe8b:f494 on eth0.*.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Registering new address record f=
or [...] on eth0.IPv4.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Registering new address record f=
or fe80::fad1:11ff:fe02:8be5 on eth1.*.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Registering new address record f=
or 192.168.1.254 on eth1.IPv4.
Apr 19 17:34:43 IRT176 avahi-daemon[1525]: Registering HINFO record with va=
lues 'X86_64'/'LINUX'.
Apr 19 17:34:43 IRT176 bluetoothd[1556]: Starting SDP server
Apr 19 17:34:43 IRT176 kernel: [   13.900815] Bluetooth: Core ver 2.16
Apr 19 17:34:43 IRT176 kernel: [   13.900825] NET: Registered protocol fami=
ly 31
Apr 19 17:34:43 IRT176 kernel: [   13.900827] Bluetooth: HCI device and con=
nection manager initialized
Apr 19 17:34:43 IRT176 kernel: [   13.900829] Bluetooth: HCI socket layer i=
nitialized
Apr 19 17:34:43 IRT176 kernel: [   13.900830] Bluetooth: L2CAP socket layer=
 initialized
Apr 19 17:34:43 IRT176 kernel: [   13.900833] Bluetooth: SCO socket layer i=
nitialized
Apr 19 17:34:43 IRT176 kernel: [   13.988677] Bluetooth: RFCOMM TTY layer i=
nitialized
Apr 19 17:34:43 IRT176 kernel: [   13.988681] Bluetooth: RFCOMM socket laye=
r initialized
Apr 19 17:34:43 IRT176 kernel: [   13.988682] Bluetooth: RFCOMM ver 1.11
Apr 19 17:34:43 IRT176 /usr/sbin/cron[1530]: (CRON) INFO (pidfile fd =3D 3)
Apr 19 17:34:43 IRT176 /usr/sbin/cron[1609]: (CRON) STARTUP (fork ok)
Apr 19 17:34:43 IRT176 kernel: [   14.086401] sshd (1813): /proc/1813/oom_a=
dj is deprecated, please use /proc/1813/oom_score_adj instead.
Apr 19 17:34:43 IRT176 /usr/sbin/cron[1609]: (CRON) INFO (Running @reboot j=
obs)
Apr 19 17:34:43 IRT176 bluetoothd[1556]: Starting experimental netlink supp=
ort
Apr 19 17:34:43 IRT176 bluetoothd[1556]: Failed to find Bluetooth netlink f=
amily
Apr 19 17:34:43 IRT176 bluetoothd[1556]: Failed to init netlink plugin
Apr 19 17:34:43 IRT176 kernel: [   14.188880] Bluetooth: BNEP (Ethernet Emu=
lation) ver 1.3
Apr 19 17:34:43 IRT176 kernel: [   14.188883] Bluetooth: BNEP filters: prot=
ocol multicast
Apr 19 17:34:44 IRT176 bluetoothd[1556]: bridge pan0 created
Apr 19 17:34:44 IRT176 kernel: [   14.299885] Bridge firewalling registered
Apr 19 17:34:44 IRT176 avahi-daemon[1525]: Server startup complete. Host na=
me is IRT176.local. Local service cookie is 2509875026.
Apr 19 17:34:44 IRT176 acpid: client connected from 1872[0:0]
Apr 19 17:34:44 IRT176 acpid: 1 client rule loaded
Apr 19 17:34:44 IRT176 kernel: [   15.243601] lp: driver loaded but no devi=
ces found
Apr 19 17:34:45 IRT176 udev-configure-printer: add /module/lp
Apr 19 17:34:45 IRT176 udev-configure-printer: Failed to get parent
Apr 19 17:34:45 IRT176 kernel: [   15.301248] ppdev: user-space parallel po=
rt driver
Apr 19 17:34:46 IRT176 dhcpd: DHCPDISCOVER from 00:19:99:23:60:43 via eth1
Apr 19 17:34:46 IRT176 dhcpd: ns1.example.org: host unknown.
Apr 19 17:34:46 IRT176 dhcpd: ns2.example.org: host unknown.
Apr 19 17:34:46 IRT176 dhcpd: DHCPOFFER on 192.168.1.1 to 00:19:99:23:60:43=
 via eth1
Apr 19 17:34:46 IRT176 dhcpd: DHCPREQUEST for 192.168.1.1 (192.168.1.254) f=
rom 00:19:99:23:60:43 via eth1
Apr 19 17:34:46 IRT176 dhcpd: DHCPACK on 192.168.1.1 to 00:19:99:23:60:43 v=
ia eth1
Apr 19 17:34:48 IRT176 kdm_greet[1954]: Cannot load /usr/share/kde4/apps/kd=
m/faces/.default.face: Datei oder Verzeichnis nicht gefunden
Apr 19 17:34:54 IRT176 kernel: [   24.419944] [drm:drm_edid_block_valid] *E=
RROR* EDID checksum is invalid, remainder is 82
Apr 19 17:34:54 IRT176 kernel: [   24.516638] Raw EDID:
Apr 19 17:34:54 IRT176 kernel: [   24.543724]  	00 ff ff ff ff ff ff 00 05 =
23 50 74 df 1c 00 00
Apr 19 17:34:54 IRT176 kernel: [   24.612320]  	26 0f 01 03 6d 22 1b 78 ea =
2c 12 a2 5a 4a 99 25
Apr 19 17:34:54 IRT176 kernel: [   24.680940]  	1b 4e 56 bf ef 00 71 40 71 =
4a 71 4f 81 40 81 4a
Apr 19 17:34:54 IRT176 kernel: [   24.749616]  	81 4f 81 80 01 01 30 2a 00 =
98 51 00 2a 40 30 70
Apr 19 17:34:54 IRT176 kernel: [   24.818223]  	13 00 52 0e 11 00 00 1e 00 =
00 00 fd 00 31 4b 18
Apr 19 17:34:54 IRT176 kernel: [   24.886831]  	50 0e 00 0a 20 20 20 20 20 =
20 00 00 00 fc 00 46
Apr 19 17:34:54 IRT176 kernel: [   24.955514]  	2d 34 31 37 0a 20 20 20 20 =
20 20 20 00 00 00 ff
Apr 19 17:34:54 IRT176 kernel: [   25.024108]  	00 37 33 39 31 0a 20 20 3f =
ff ff ff ff ff ff ff
Apr 19 17:34:57 IRT176 anacron[2182]: Anacron 2.3 started on 2013-04-19
Apr 19 17:34:57 IRT176 anacron[2182]: Normal exit (0 jobs run)
Apr 19 17:35:01 IRT176 polkitd[2218]: started daemon version 0.96 using aut=
hority implementation `local' version `0.96'
Apr 19 17:39:46 IRT176 dhcpd: DHCPREQUEST for 192.168.1.1 from 00:19:99:23:=
60:43 via eth1
Apr 19 17:39:46 IRT176 dhcpd: ns1.example.org: host unknown.
Apr 19 17:39:46 IRT176 dhcpd: ns2.example.org: host unknown.
Apr 19 17:39:46 IRT176 dhcpd: DHCPACK on 192.168.1.1 to 00:19:99:23:60:43 v=
ia eth1
Apr 19 17:44:46 IRT176 dhcpd: DHCPREQUEST for 192.168.1.1 from 00:19:99:23:=
60:43 via eth1
Apr 19 17:44:46 IRT176 dhcpd: ns1.example.org: host unknown.
Apr 19 17:44:46 IRT176 dhcpd: ns2.example.org: host unknown.
Apr 19 17:44:46 IRT176 dhcpd: DHCPACK on 192.168.1.1 to 00:19:99:23:60:43 v=
ia eth1
