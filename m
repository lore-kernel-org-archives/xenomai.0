Message-ID: <47ED5DE3.60202@domain.hid>
Date: Fri, 28 Mar 2008 17:06:43 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>


Hi,

I'm getting kernel crashes with my native skin user-space Xenomai 
application. It looks like the crash happens after clone/fork. I'm using 
kernel 2.6.24.3, SMP, RT_PREEMPT (settings like  2.6.22-14-rt from 
Ubuntu 7.10). Xenomai 2.4.2.

The thread causing the crash is a Xenomai task, running most of the time 
in the Linux domain. The application is very huge, getting a short 
example leading to the bug is unfortunatelly not realistic.

The crash happens when running on real hardware (x86_64 with 32 bit 
kernel and applications).  The system is unusable after it happens, can 
only be rebooted, the dump is from serial console.
In VMWare on another x86_64 machine, it does not crash.

Anyone getting a similar error ? Any ideas where to look for the problem ?

Thanks,

Tomas

 

kernel crash dump

[  139.814229] ------------[ cut here ]------------
[  139.818830] kernel BUG at arch/x86/mm/highmem_32.c:42!
[  139.823945] invalid opcode: 0000 [#1] PREEMPT SMP 
[  139.828739] Modules linked in: rfcomm l2cap bluetooth ppdev sbp2 parport_pc lp parport sr_mod cdrom pcspkr iTCO_wdt iTCO_vendor_support ipv6 shpchp 
pci_hotplug evdev ext3 jbd mbcache sg sd_mod ata_piix usbhid hid floppy ata_generic ahci ohci1394 libata scsi_mod ieee1394 ehci_hcd tg3 uhci_hcd usbcor
e fuse
[  139.855896] 
[  139.857378] Pid: 4959, comm: ovmtask Not tainted (2.6.24.3xenomai #1)
[  139.863790] EIP: 0060:[<c011a8d8>] EFLAGS: 00010286 CPU: 0
[  139.869255] EIP is at kmap_atomic_prot+0x98/0xa0
[  139.873850] EAX: d91aa163 EBX: c2b23540 ECX: fffff000 EDX: c044fecc
[  139.880088] ESI: 00000007 EDI: 00000163 EBP: 08003875 ESP: df68fea0
[  139.886326]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[  139.891699] Process ovmtask (pid: 4959, ti=df68e000 task=df685080 task.ti=df68e000)<0>
[  139.899148] I-pipe domain Linux
[  139.902539] Stack: fffb2000 00000000 c2b2354c c01a967a fffb7000 fffb6000 df89395c df4ad580 
[  139.910930]        df4ad900 dfaf5084 df9f5084 08615000 08400000 08615000 f7c02ec0 c2b23560 
[  139.919323]        00000000 00000000 c2b2354c c2be8acc fffb3000 08614fff 00000000 00000000 
[  139.927714] Call Trace:
[  139.930329]  [<c01a967a>] copy_page_range+0x13a/0x560
[  139.935368]  [<c01224bf>] copy_process+0x8df/0x1250
[  139.940235]  [<c012306c>] do_fork+0x4c/0x200
[  139.944495]  [<c01022d2>] sys_clone+0x32/0x40
[  139.948839]  [<c0104431>] syscall_call+0x7/0xb
[  139.953272]  =======================
[  139.956828] Code: b5 00 00 00 00 29 c2 8b 02 85 c0 75 1e 2b 1d 80 0c 50 c0 8d 46 45 c1 e0 0c c1 fb 05 29 c1 c1 e3 0c 89 c8 09 fb 89 1a 5b 5e 5f c3 <
0f> 0b eb fe 8d 74 26 00 8b 0d f4 b1 45 c0 e9 55 ff ff ff 90 8d 
[  139.976150] EIP: [<c011a8d8>] kmap_atomic_prot+0x98/0xa0 SS:ESP 0068:df68fea0
[  139.983355] ---[ end trace 1cb0b5180594e9d9 ]---
[  139.987956] note: ovmtask[4959] exited with preempt_count 1


end of strace output

4959  fcntl64(2, F_GETFL)               = 0x8001 (flags O_WRONLY|O_LARGEFILE)
4959  rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], [], 8) = 0
4959  rt_sigaction(SIGUSR1, NULL, {SIG_DFL}, 8) = 0
4959  rt_sigaction(SIGUSR1, {0x85ec4b0, [], SA_RESTART|SA_SIGINFO}, {SIG_DFL}, 8) = 0
4959  rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
4959  fcntl64(2, F_GETFL)               = 0x8001 (flags O_WRONLY|O_LARGEFILE)
4959  write(2, "#<", 2)                 = 2
4959  fcntl64(2, F_GETFL)               = 0x8001 (flags O_WRONLY|O_LARGEFILE)
4959  fcntl64(2, F_GETFL)               = 0x8001 (flags O_WRONLY|O_LARGEFILE)
4959  write(2, "executive", 9)          = 9
4959  fcntl64(2, F_GETFL)               = 0x8001 (flags O_WRONLY|O_LARGEFILE)
4959  fcntl64(2, F_GETFL)               = 0x8001 (flags O_WRONLY|O_LARGEFILE)
4959  write(2, "> ", 2)                 = 2
4959  fcntl64(2, F_GETFL)               = 0x8001 (flags O_WRONLY|O_LARGEFILE)
4959  fcntl64(2, F_GETFL)               = 0x8001 (flags O_WRONLY|O_LARGEFILE)
4959  write(2, "[Testing ", 9)          = 9
4959  fcntl64(2, F_GETFL)               = 0x8001 (flags O_WRONLY|O_LARGEFILE)
4959  fcntl64(2, F_GETFL)               = 0x8001 (flags O_WRONLY|O_LARGEFILE)
4959  write(2, "AbstractInterpretation", 22) = 22
4959  fcntl64(2, F_GETFL)               = 0x8001 (flags O_WRONLY|O_LARGEFILE)
4959  pipe([7, 8])                      = 0
4959  fcntl64(7, F_GETFL)               = 0 (flags O_RDONLY)
4959  fcntl64(7, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
4959  fcntl64(8, F_GETFL)               = 0x1 (flags O_WRONLY)
4959  fcntl64(8, F_SETFL, O_WRONLY|O_NONBLOCK) = 0
4959  clone( <unfinished ...>
4958  <... nanosleep resumed> NULL)     = 0


