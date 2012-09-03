MIME-Version: 1.0
In-Reply-To: <CAHue_TVSGuatTqL4fRFoOABo4KTm8dFPmRFp7QJNmpk=ZU7NtQ@mail.gmail.com>
References: <CAHue_TVRdTsre3E7NxHtb=6XfxkL7_36nsLLxSkiF3kUJAJ5Vw@mail.gmail.com>
	<5022B5E4.7040101@xenomai.org>
	<CAHue_TWodrVNxhsxXZ6_xcOGWHDqVGe41qbY0=R3RhFjBedG+g@mail.gmail.com>
	<50339840.1070202@xenomai.org>
	<CAHue_TVSGuatTqL4fRFoOABo4KTm8dFPmRFp7QJNmpk=ZU7NtQ@mail.gmail.com>
Date: Mon, 3 Sep 2012 20:04:55 +0200
Message-ID: <CAHue_TUKTiusLqfXK59O+PVoxONKAE2xQyBYOgjDh=dZZ2-b3w@mail.gmail.com>
From: =?ISO-8859-2?Q?Marcin_Ku=B6ka?= <marckuska@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cortex-a9 - please fix xenomai-fix-lfs-issue.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This time i only changed the IP address and the result is different (maybe
that seg fault was caused by unreachable host):

*/usr/xenomai/bin # ./xeno-test -l "dohell -s xx.xx.xx.117 -m /mnt -l" -t 2
Started child 466: /bin/sh /usr/xenomai/bin/xeno-test-run-wrapper
./xeno-test -t 2
+ echo 0
+ /usr/xenomai/bin/arith
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 666.600 ns, rejected 9997/10000
inlined llimd: 0x79364d9364d9362f: 3354.500 ns, rejected 20/10000
inlined llmulshft: 0x79364d92ffffffe1: -166.600 ns, rejected 9998/10000
inlined nodiv_llimd: 0x79364d9364d9362f: -166.600 ns, rejected 9998/10000
out of line calibration: 0x0000000000000000: 500.000 ns, rejected 9998/1000=
0
out of line llimd: 0x79364d9364d9362f: 3542.200 ns, rejected 10/10000
out of line llmulshft: 0x79364d92ffffffe1: 166.600 ns, rejected 9997/10000
out of line nodiv_llimd: 0x79364d9364d9362f: 166.600 ns, rejected 9997/1000=
0

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 800.000 ns, rejected 9995/10000
inlined llimd: 0x86c9b26c9b26c9d1: 3237.300 ns, rejected 16/10000
inlined llmulshft: 0x86c9b26d0000001e: 33.300 ns, rejected 9994/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: -800.000 ns, rejected 9999/10000
out of line calibration: 0x0000000000000000: 750.000 ns, rejected 9996/1000=
0
out of line llimd: 0x86c9b26c9b26c9d1: 3313.200 ns, rejected 11/10000
out of line llmulshft: 0x86c9b26d0000001e: 0.000 ns, rejected 9996/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: -83.400 ns, rejected 9997/1000=
0

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 500.000 ns, rejected 9998/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 250.000 ns, rejected 9996/10000
out of line calibration: 0x0000000000000000: 666.600 ns, rejected 9997/1000=
0
out of line nodiv_ullimd: 0x79364d9364d9362f: 270.900 ns, rejected
9984/10000
+ /usr/xenomai/bin/clocktest -C 42 -T 30
=3D=3D Tested clock: 42 (CLOCK_HOST_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  3.0            0.000          0            0.0
+ /usr/xenomai/bin/switchtest -T 30
=3D=3D Testing FPU check routines...
d0: 1 !=3D 2
d1: 1 !=3D 2
d2: 1 !=3D 2
d3: 1 !=3D 2
d4: 1 !=3D 2
d5: 1 !=3D 2
d6: 1 !=3D 2
d7: 1 !=3D 2
d8: 1 !=3D 2
d9: 1 !=3D 2
d10: 1 !=3D 2
d11: 1 !=3D 2
d12: 1 !=3D 2
d13: 1 !=3D 2
d14: 1 !=3D 2
d15: 1 !=3D 2
=3D=3D FPU check routines: OK.
=3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtupXenomai: suspending
kernel thread 82922908 ('rtk5/0') at 0x8005bbc8 after exception #0x0
_ufpp0-9 rtup_ufpp0-10 rtus0-11 rtus0-12 rtus_ufps0-13 rXenomai: zombie
thread rtk3/0 (829218c8) would not die...

 CPU  PID    PRI      TIMEOUT  STAT      NAME
   0  0       -1      0        00500088  ROOT
   0  471      0      0        00b00380  switchtest
   0  0        1      0        00004082  rtk1/0
   0  0        1      0        00004082  rtk2/0
>  0  0        1      0        00104080  rtk3/0
   0  0        1      0        00104082  rtk4/0
   0  0        1      0        00104081  rtk5/0
   0  0        1      0        00104082  rtk6/0
   0  475      1      0        00304182  rtup0-7
   0  476      1      0        00304182  rtup0-8
   0  477      1      0        00304182  rtup_ufpp0-9
   0  478      1      0        00304182  rtup_ufpp0-10
   0  479      1      0        00300380  rtus0-11
   0  480      1      0        00300380  rtus0-12
   0  481      1      0        00300380  rtus_ufps0-13
   0  482      1      0        00300380  rtus_ufps0-14
   0  483      1      0        00300380  rtuo0-15
   0  484      1      0        00300380  rtuo0-16
   0  485      1      0        00300380  rtuo_ufpp0-17
   0  486      1      0        00300380  rtuo_ufpp0-18
   0  487      1      0        00300380  rtuo_ufps0-19
   0  488      1      0        00300380  rtuo_ufps0-20
   0  489      1      0        00300380  rtuo_ufpp_ufps0-21
   0  490      1      0        00300380  rtuo_ufpp_ufps0-22
Master time base: clock=3D667017595
[<80013fc4>] (unwind_backtrace+0x0/0x104) from [<800125b0>]
(show_stack+0x20/0x24)
[<800125b0>] (show_stack+0x20/0x24) from [<800ad770>]
(__xnpod_schedule+0x8a8/0xc8c)
[<800ad770>] (__xnpod_schedule+0x8a8/0xc8c) from [<0000005e>] (0x5e)
I-pipe tracer log (100 points):
 |  # func                    0 ipipe_trace_panic_freeze+0x10
(__xnpod_schedule+0x860)
 |  # [   -1] -<?>-    1     -1 __xnpod_schedule+0x3e8 ()
 |  + begin   0x80000000     -2 xnsched_finish_unlocked_switch+0x118
(__xnpod_schedule+0x3c4)
    + func                   -3 xnsched_finish_unlocked_switch+0x10
(__xnpod_schedule+0x3c4)
 |  + end     0x80000000     -4 __ipipe_restore_head+0xb0
(__xnpod_schedule+0x564)
 |  # func                   -5 __ipipe_restore_head+0x10
(__xnpod_schedule+0x564)
 |  # func                   -7 xnsched_pick_next+0x10
(__xnpod_schedule+0x10c)
 |  # [  487] rtuo_uf -1     -8 __xnpod_schedule+0xa8
(xnpod_schedule_handler+0x40)
 |  # func                   -9 __xnpod_schedule+0x14
(xnpod_schedule_handler+0x40)
 |  # func                  -10 xnpod_schedule_handler+0x10
(__ipipe_do_sync_stage+0x144)
 |  + func                  -11 __ipipe_do_sync_stage+0x10
(__ipipe_do_sync_pipeline+0x78)
 |   +func                  -12 __ipipe_do_sync_pipeline+0x10
(__ipipe_restore_head+0xd4)
 |  *+func                  -12 __ipipe_restore_head+0x10
(rtdm_event_signal+0xec)
 |  *+func                  -14 __ipipe_set_irq_pending+0x10
(__ipipe_dispatch_irq_fast+0x14c)
 |  *+func                  -14 __ipipe_dispatch_irq_fast+0x10
(__ipipe_dispatch_irq+0xe4)
 |  *+func                  -15 __ipipe_dispatch_irq+0x10
(ipipe_raise_irq+0x30)
 |  *+func                  -16 ipipe_raise_irq+0x10
(__xnpod_schedule+0x7c8)
 |  *+func                  -17 __xnpod_schedule+0x14
(rtdm_event_signal+0x200)
 |  *+[   -1] -<?>-    1    -18 xnpod_resume_thread+0x70
(xnsynch_flush+0xb0)
 |  *+func                  -19 xnpod_resume_thread+0x14
(xnsynch_flush+0xb0)
 |  *+func                  -20 xnsynch_flush+0x14 (rtdm_event_signal+0x74)
 |   +begin   0x80000000    -21 rtdm_event_signal+0x1f4
(rtswitch_ioctl_nrt+0x380)
     +func                  -22 rtdm_event_signal+0x14
(rtswitch_ioctl_nrt+0x380)
     +func                  -23 rtswitch_ioctl_nrt+0x14
(__rt_dev_ioctl+0x74)
 |   +end     0x80000000    -23 __ipipe_restore_head+0xb0
(rtdm_context_get+0xb4)
 |  *+func                  -24 __ipipe_restore_head+0x10
(rtdm_context_get+0xb4)
 |   +begin   0x80000000    -26 rtdm_context_get+0x140 (__rt_dev_ioctl+0x38=
)
     +func                  -27 rtdm_context_get+0x14 (__rt_dev_ioctl+0x38)
     +func                  -27 __rt_dev_ioctl+0x18 (sys_rtdm_ioctl+0x38)
     +func                  -28 sys_rtdm_ioctl+0x10 (losyscall_event+0xd0)
     +func                  -29 losyscall_event+0x14
(ipipe_syscall_hook+0x40)
     +func                  -30 ipipe_syscall_hook+0x10
(__ipipe_notify_syscall+0x60)
 |   +end     0x80000001    -30 __ipipe_notify_syscall+0xfc
(__ipipe_syscall_root+0x68)
 |  + begin   0x80000001    -31 __ipipe_notify_syscall+0x110
(__ipipe_syscall_root+0x68)
    + func                  -32 debug_lockdep_rcu_enabled+0x10
(hisyscall_event+0xdc)
    + func                  -32 hisyscall_event+0x14
(ipipe_syscall_hook+0x40)
    + func                  -33 ipipe_syscall_hook+0x10
(__ipipe_notify_syscall+0x60)
 |  + end     0x80000001    -34 __ipipe_notify_syscall+0xfc
(__ipipe_syscall_root+0x68)
 |   +begin   0x80000001    -34 __ipipe_notify_syscall+0x14c
(__ipipe_syscall_root+0x68)
     +func                  -35 __ipipe_notify_syscall+0x14
(__ipipe_syscall_root+0x68)
     +func                  -36 __ipipe_syscall_root+0x10 (vector_swi+0x50)
 |   +func                  -37 __ipipe_check_root+0x10
(ret_from_exception+0x14)
 |   +func                  -38 __ipipe_notify_trap+0x14 (__und_usr+0x3c)
 |   +end     0x80000000    -40 __ipipe_syscall_root+0xc4 (vector_swi+0x50)
 |   +begin   0x80000000    -41 __ipipe_syscall_root+0x124 (vector_swi+0x50=
)
 |   +end     0x80000001    -41 __ipipe_notify_syscall+0x130
(__ipipe_syscall_root+0x68)
 |  + begin   0x80000001    -42 __ipipe_notify_syscall+0x110
(__ipipe_syscall_root+0x68)
    + func                  -43 xnarch_divrem_billion+0x14
(clock_gettime+0x7c)
    + func                  -44 xnarch_tsc_to_ns+0x10
(xnarch_get_cpu_time+0x24)
    + func                  -45 xnarch_get_cpu_time+0x10
(clock_gettime+0x68)
    + func                  -45 clock_gettime+0x14 (__clock_gettime+0x28)
    + func                  -46 __clock_gettime+0x14 (hisyscall_event+0x200=
)
    + func                  -47 debug_lockdep_rcu_enabled+0x10
(hisyscall_event+0xdc)
    + func                  -48 hisyscall_event+0x14
(ipipe_syscall_hook+0x40)
    + func                  -48 ipipe_syscall_hook+0x10
(__ipipe_notify_syscall+0x60)
 |  + end     0x80000001    -49 __ipipe_notify_syscall+0xfc
(__ipipe_syscall_root+0x68)
 |   +begin   0x80000001    -50 __ipipe_notify_syscall+0x14c
(__ipipe_syscall_root+0x68)
     +func                  -50 __ipipe_notify_syscall+0x14
(__ipipe_syscall_root+0x68)
     +func                  -51 __ipipe_syscall_root+0x10 (vector_swi+0x50)
 |   +end     0x80000000    -53 ipipe_unstall_root+0x54
(_raw_spin_unlock_irqrestore+0x4c)
 |   #func                  -54 ipipe_root_only+0x10
(ipipe_unstall_root+0x24)
 |   #begin   0x80000000    -55 ipipe_unstall_root+0x68
(_raw_spin_unlock_irqrestore+0x4c)
     #func                  -55 ipipe_unstall_root+0x10
(_raw_spin_unlock_irqrestore+0x4c)
 |   #end     0x80000001    -56 lock_release+0x150
(_raw_spin_unlock_irqrestore+0x2c)
 |   #begin   0x80000001    -57 lock_release+0x13c
(_raw_spin_unlock_irqrestore+0x2c)
     #func                  -57 _raw_spin_unlock_irqrestore+0x10
(free_object+0x98)
 |   #end     0x80000001    -58 lock_acquire+0xfc
(_raw_spin_lock_irqsave+0x70)
 |   #begin   0x80000001    -59 lock_acquire+0xe4
(_raw_spin_lock_irqsave+0x70)
 |   #end     0x80000001    -60 _raw_spin_lock_irqsave+0xa8
(free_object+0x1c)
 |   +begin   0x80000001    -60 _raw_spin_lock_irqsave+0x90
(free_object+0x1c)
     +func                  -61 _raw_spin_lock_irqsave+0x14
(free_object+0x1c)
 |   +end     0x80000000    -61 ipipe_unstall_root+0x54
(_raw_spin_unlock_irqrestore+0x4c)
 |   #func                  -62 ipipe_root_only+0x10
(ipipe_unstall_root+0x24)
 |   #begin   0x80000000    -63 ipipe_unstall_root+0x68
(_raw_spin_unlock_irqrestore+0x4c)
     #func                  -63 ipipe_unstall_root+0x10
(_raw_spin_unlock_irqrestore+0x4c)
 |   #end     0x80000001    -64 lock_release+0x150
(_raw_spin_unlock_irqrestore+0x2c)
 |   #begin   0x80000001    -65 lock_release+0x13c
(_raw_spin_unlock_irqrestore+0x2c)
     #func                  -65 _raw_spin_unlock_irqrestore+0x10
(debug_object_free+0xf8)
 |   #end     0x80000001    -67 lock_acquire+0xfc
(_raw_spin_lock_irqsave+0x70)
 |   #begin   0x80000001    -67 lock_acquire+0xe4
(_raw_spin_lock_irqsave+0x70)
 |   #end     0x80000001    -68 _raw_spin_lock_irqsave+0xa8
(debug_object_free+0x54)
 |   +begin   0x80000001    -68 _raw_spin_lock_irqsave+0x90
(debug_object_free+0x54)
     +func                  -69 _raw_spin_lock_irqsave+0x14
(debug_object_free+0x54)
     +func                  -70 destroy_hrtimer_on_stack+0x10
(hrtimer_nanosleep+0x100)
 |   +end     0x80000000    -71 ipipe_unstall_root+0x54
(_raw_spin_unlock_irqrestore+0x4c)
 |   #func                  -71 ipipe_root_only+0x10
(ipipe_unstall_root+0x24)
 |   #begin   0x80000000    -72 ipipe_unstall_root+0x68
(_raw_spin_unlock_irqrestore+0x4c)
     #func                  -72 ipipe_unstall_root+0x10
(_raw_spin_unlock_irqrestore+0x4c)
 |   #end     0x80000001    -73 lock_release+0x150
(_raw_spin_unlock_irqrestore+0x2c)
 |   #begin   0x80000001    -74 lock_release+0x13c
(_raw_spin_unlock_irqrestore+0x2c)
     #func                  -75 _raw_spin_unlock_irqrestore+0x10
(hrtimer_try_to_cancel+0x50)
 |   #end     0x80000001    -76 lock_acquire+0xfc
(_raw_spin_lock_irqsave+0x70)
 |   #begin   0x80000001    -76 lock_acquire+0xe4
(_raw_spin_lock_irqsave+0x70)
 |   #end     0x80000001    -77 _raw_spin_lock_irqsave+0xa8
(hrtimer_try_to_cancel+0x24)
 |   +begin   0x80000001    -78 _raw_spin_lock_irqsave+0x90
(hrtimer_try_to_cancel+0x24)
     +func                  -78 _raw_spin_lock_irqsave+0x14
(hrtimer_try_to_cancel+0x24)
     +func                  -79 hrtimer_try_to_cancel+0x10
(hrtimer_cancel+0x24)
     +func                  -80 hrtimer_cancel+0x10 (do_nanosleep+0xac)
 |   +end     0x80000000    -80 ipipe_unstall_root+0x54
(finish_task_switch.constprop.137+0x7c)
 |   #func                  -81 ipipe_root_only+0x10
(ipipe_unstall_root+0x24)*

And it stops here - no signs of life given.


Regards,

Marcin

2012/9/3 Marcin Ku=B6ka <marckuska@gmail.com>

> I used standard ipipe-core-3.2.21-arm-1.patch, I made no corrections to
> it. I attache a my linux kernel defconfig. I used CodeSourcery 2012.03 to
> compile it.
>
> This is what I got through the console during booting and after running
> latency test:
>
> *V2P CA9 #bootm 0x8000
> ## Booting kernel from Legacy Image at 00008000 ...
>    Image Name:   linux-3.2
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    48478028 Bytes =3D 46.2 MB
>    Load Address: 60008000
>    Entry Point:  60008000
>    Loading Kernel Image ... OK
> OK
> ARM internal:: Moved kernel boot params from 0x00000100 to 0x60000100 to
> match image header entry point 0x60008000
>
> Starting kernel ...
>
> Initializing cgroup subsys cpuset
> Linux version 3.2.21-ipipe (marcin@simisc.EMEA) (gcc version 4.6.0
> (crosstool-NG 1.16.0) ) #17 Mon Sep 3 18:15:11 CEST 2012
> CPU: ARMv7 Processor [410fc091] revision 1 (ARMv7), cr=3D10c53c7d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine: ARM-Versatile Express
> bootconsole [earlycon0] enabled
> Memory policy: ECC disabled, Data cache writeback
> sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 6496=
0
> Kernel command line: ip=3Ddhcp earlyprintk console=3DttyAMA0 mem=3D256M
> reboot=3Dsoft
> PID hash table entries: 1024 (order: 0, 4096 bytes)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 256MB =3D 256MB total
> Memory: 206236k/206236k available, 55908k reserved, 0K highmem
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0x90800000 - 0xf8000000   (1656 MB)
>     lowmem  : 0x80000000 - 0x90000000   ( 256 MB)
>     modules : 0x7f000000 - 0x80000000   (  16 MB)
>       .text : 0x80008000 - 0x805befec   (5852 kB)
>       .init : 0x805bf000 - 0x82e0b000   (41264 kB)
>       .data : 0x82e0c000 - 0x82e43728   ( 222 kB)
>        .bss : 0x82e4374c - 0x83419120   (5975 kB)
> NR_IRQS:128
> I-pipe, 1.000 MHz clocksource
> Interrupt pipeline (release #1)
> Console: colour dummy device 80x30
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> ... MAX_LOCKDEP_SUBCLASSES:  8
> ... MAX_LOCK_DEPTH:          48
> ... MAX_LOCKDEP_KEYS:        8191
> ... CLASSHASH_SIZE:          4096
> ... MAX_LOCKDEP_ENTRIES:     16384
> ... MAX_LOCKDEP_CHAINS:      32768
> ... CHAINHASH_SIZE:          16384
>  memory used by lock dependency info: 3695 kB
>  per task-struct memory footprint: 1152 bytes
> kmemleak: Early log buffer exceeded, please increase
> DEBUG_KMEMLEAK_EARLY_LOG_SIZE
> kmemleak: Kernel memory leak detector disabled
> ODEBUG: selftest passed
> Calibrating delay loop... 795.44 BogoMIPS (lpj=3D3977216)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7 counters
> available
> NET: Registered protocol family 16
> L310 cache controller enabled
> l2x0: 8 ways, CACHE_ID 0x410000c3, AUX_CTRL 0x02460000, Cache size: 52428=
8
> B
> hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint register=
s.
> hw-breakpoint: maximum watchpoint size is 4 bytes.
> Serial: AMBA PL011 UART driver
> mb:uart0: ttyAMA0 at MMIO 0x10009000 (irq =3D 37) is a PL011 rev2
> console [ttyAMA0] enabled, bootconsole disabled
> console [ttyAMA0] enabled, bootconsole disabled
> mb:uart1: ttyAMA1 at MMIO 0x1000a000 (irq =3D 38) is a PL011 rev2
> mb:uart2: ttyAMA2 at MMIO 0x1000b000 (irq =3D 39) is a PL011 rev2
> mb:uart3: ttyAMA3 at MMIO 0x1000c000 (irq =3D 40) is a PL011 rev2
> bio: create slab <bio-0> at 0
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> Advanced Linux Sound Architecture Driver Version 1.0.24.
> Switching to clocksource ipipe_tsc
> NET: Registered protocol family 2
> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP reno registered
> UDP hash table entries: 128 (order: 1, 10240 bytes)
> UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
> NET: Registered protocol family 1
> I-pipe: head domain Xenomai registered.
> Xenomai: hal/arm started.
> Xenomai: scheduling class idle registered.
> Xenomai: scheduling class rt registered.
> Xenomai: real-time nucleus v2.6.1 (Light Years Away) loaded.
> Xenomai: debug mode enabled.
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
> JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
> msgmni has been set to 402
> io scheduler noop registered (default)
> start plist test
> end plist test
> smsc911x: Driver version 2008-10-21
> smsc911x-mdio: probed
> smsc911x smsc911x: eth0: attached PHY driver [Generic PHY]
> (mii_bus:phy_addr=3Dffffffff:01, irq=3D-1)
> smsc911x smsc911x: eth0: MAC Address: 00:02:f7:00:40:9c
> ------------[ cut here ]------------
> WARNING: at mm/slab.c:2264 kmem_cache_create+0x690/0x6dc()
> Modules linked in:
> [<80013fc4>] (unwind_backtrace+0x0/0x104) from [<80432938>]
> (dump_stack+0x20/0x24)
> [<80432938>] (dump_stack+0x20/0x24) from [<80027bec>]
> (warn_slowpath_common+0x5c/0x74)
> [<80027bec>] (warn_slowpath_common+0x5c/0x74) from [<80027c30>]
> (warn_slowpath_null+0x2c/0x34)
> [<80027c30>] (warn_slowpath_null+0x2c/0x34) from [<80162f10>]
> (kmem_cache_create+0x690/0x6dc)
> [<80162f10>] (kmem_cache_create+0x690/0x6dc) from [<805d3a34>]
> (init_kmem_once+0x30/0xb4)
> [<805d3a34>] (init_kmem_once+0x30/0xb4) from [<805d3ac8>]
> (isp1760_init+0x10/0x30)
> [<805d3ac8>] (isp1760_init+0x10/0x30) from [<800087cc>]
> (do_one_initcall+0x48/0x1a0)
> [<800087cc>] (do_one_initcall+0x48/0x1a0) from [<805bf94c>]
> (kernel_init+0xc0/0x164)
> [<805bf94c>] (kernel_init+0xc0/0x164) from [<8000f47c>]
> (kernel_thread_exit+0x0/0x8)
> ---[ end trace debe15f42d5fcf56 ]---
> isp1760 isp1760: NXP ISP1760 USB Host Controller
> isp1760 isp1760: new USB bus registered, assigned bus number 1
> isp1760 isp1760: bus width: 32, oc: digital
> isp1760 isp1760: irq 48, io mem 0x4f000000
> isp1760 isp1760: USB ISP 1761 HW rev. 1 started
> usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002
> usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> usb usb1: Product: NXP ISP1760 USB Host Controller
> usb usb1: Manufacturer: Linux 3.2.21-ipipe isp1760-hcd
> usb usb1: SerialNumber: isp1760
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> ISP1760 USB device initialised
> Initializing USB Mass Storage driver...
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> mousedev: PS/2 mouse device common for all mice
> rtc-pl031 mb:rtc: rtc core: registered pl031 as rtc0
> isp1760 isp1760: port 1 high speed
> mmci-pl18x mb:mmci: mmc0: PL180 manf 41 rev0 at 0x10005000 irq 41,42 (pio=
)
> usb 1-1: new high-speed USB device number 2 using isp1760
> sdhci: Secure Digital Host Controller Interface driver
> sdhci: Copyright(c) Pierre Ossman
> sdhci-pltfm: SDHCI platform and OF driver helper
> isp1760 isp1760: port 1 high speed
> usb 1-1: New USB device found, idVendor=3D0471, idProduct=3D3526
> usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
> usb 1-1: Product: ISP1520
> usb 1-1: Manufacturer: Philips Semiconductors
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> hub 1-1:1.0: USB hub found
> hub 1-1:1.0: 3 ports detected
> aaci-pl041 mb:aaci: ARM AC'97 Interface PL041 rev0 at 0x10004000, irq 43
> aaci-pl041 mb:aaci: FIFO 512 entries
> atkbd serio0: keyboard reset failed on mb:kmi0
> ALSA device list:
>   #0: ARM AC'97 Interface PL041 rev0 at 0x10004000, irq 43
> oprofile: using arm/armv7-ca9
> TCP cubic registered
> NET: Registered protocol family 17
> VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 0
> rtc-pl031 mb:rtc: setting system clock to 1970-01-28 07:16:11 UTC (235897=
1)
> smsc911x smsc911x: eth0: SMSC911x/921x identified at 0x90a60000, IRQ: 47
> Sending DHCP requests ., OK
> IP-Config: Got DHCP answer from 0.0.0.0, my address is 10.76.18.138
> IP-Config: Complete:
>      device=3Deth0, addr=3D10.76.18.138, mask=3D255.255.252.0, gw=3D10.76=
.16.1,
>      host=3D10.76.18.138, domain=3Demea.home.ra-int.com, nis-domain=3D(no=
ne),
>      bootserver=3D0.0.0.0, rootserver=3D0.0.0.0, rootpath=3D
> Freeing init memory: 41264K
> atkbd serio1: keyboard reset failed on mb:kmi1
>
> test01 login: root
> Password:
> login[430]: root login on 'ttyAMA0'
> ~ # /usr/xenomai/bin/latency
> =3D=3D Sampling period: 1000 us
> =3D=3D Test mode: periodic user-mode task
> =3D=3D All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
> worst
> RTD|     61.000|     63.000|     74.000|       0|     0|     61.000|
> 74.000
> RTD|     61.000|     63.000|     83.000|       0|     0|     61.000|
> 83.000
> RTD|     61.000|     63.000|     80.000|       0|     0|     61.000|
> 83.000
> RTD|     61.000|     63.000|     80.000|       0|     0|     61.000|
> 83.000
> RTD|     61.000|     63.000|     79.000|       0|     0|     61.000|
> 83.000
> RTD|     61.000|     63.000|     80.000|       0|     0|     61.000|
> 83.000
> RTD|     61.000|     63.000|     86.000|       0|     0|     61.000|
> 86.000
> RTD|     61.000|     63.000|     79.000|       0|     0|     61.000|
> 86.000
> RTD|     61.000|     63.000|     78.000|       0|     0|     61.000|
> 86.000
> RTD|     61.000|     63.000|     78.000|       0|     0|     61.000|
> 86.000
> RTD|     61.000|     63.000|     80.000|       0|     0|     61.000|
> 86.000
> RTD|     61.000|     63.000|     80.000|       0|     0|     61.000|
> 86.000
> RTD|     61.000|     63.000|     78.000|       0|     0|     61.000|
> 86.000
> RTD|     61.000|     63.000|     80.000|       0|     0|     61.000|
> 86.000
> RTD|     61.000|     63.000|     81.000|       0|     0|     61.000|
> 86.000
>
> ---|-----------|-----------|-----------|--------|------|-----------------=
--------
> RTS|     61.000|     63.000|     86.000|       0|     0|
>  00:00:15/00:00:15
> ~ #*
>
> But when I try to run:
>
> */usr/xenomai/bin # ./xeno-test -l "dohell -s 192.168.0.5 -m /mnt -l" -t =
2
> *
>
> It ends up with segmentation fault or message "Unable to handle kernel
> paging request at virtual address ... "
>
> *Started child 440: /bin/sh /usr/xenomai/bin/xeno-test-run-wrapper
> ./xeno-test -t 2
> + echo 0
> + /usr/xenomai/bin/arith
> mul: 0x79364d93, shft: 26
> integ: 30, frac: 0x4d9364d9364d9364
>
> signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
> inline calibration: 0x0000000000000000: 500.000 ns, rejected 9998/10000
> inlined llimd: 0x79364d9364d9362f: 3521.000 ns, rejected 15/10000
> inlined llmulshft: 0x79364d92ffffffe1: 166.600 ns, rejected 9997/10000
> inlined nodiv_llimd: 0x79364d9364d9362f: 333.300 ns, rejected 9994/10000
> out of line calibration: 0x0000000000000000: 500.000 ns, rejected
> 9998/10000
> out of line llimd: 0x79364d9364d9362f: 3541.200 ns, rejected 10/10000
> out of line llmulshft: 0x79364d92ffffffe1: 0.000 ns, rejected 9998/10000
> out of line nodiv_llimd: 0x79364d9364d9362f: 300.000 ns, rejected
> 9995/10000
>
> signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
> inline calibration: 0x0000000000000000: 666.600 ns, rejected 9997/10000
> inlined llimd: 0x86c9b26c9b26c9d1: 3378.100 ns, rejected 19/10000
> inlined llmulshft: 0x86c9b26d0000001e: 0.000 ns, rejected 9997/10000
> inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 83.400 ns, rejected 9996/10000
> out of line calibration: 0x0000000000000000: 500.000 ns, rejected
> 9998/10000
> out of line llimd: 0x86c9b26c9b26c9d1: 3565.400 ns, rejected 12/10000
> out of line llmulshft: 0x86c9b26d0000001e: 250.000 ns, rejected 9996/1000=
0
> out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 437.500 ns, rejected
> 9984/10000
>
> unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
> inline calibration: 0x0000000000000000: 833.300 ns, rejected 9994/10000
> inlined nodiv_ullimd: 0x79364d9364d9362f: -166.700 ns, rejected 9997/1000=
0
> out of line calibration: 0x0000000000000000: 666.600 ns, rejected
> 9997/10000
> out of line nodiv_ullimd: 0x79364d9364d9362f: 83.400 ns, rejected
> 9996/10000
> + /usr/xenomai/bin/clocktest -C 42 -T 30
> =3D=3D Tested clock: 42 (CLOCK_HOST_REALTIME)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>   0                  2.0            0.000          0            0.0
> + /usr/xenomai/bin/switchtest -T 30
> =3D=3D Testing FPU check routines...
> d0: 1 !=3D 2
> d1: 1 !=3D 2
> d2: 1 !=3D 2
> d3: 1 !=3D 2
> d4: 1 !=3D 2
> d5: 1 !=3D 2
> d6: 1 !=3D 2
> d7: 1 !=3D 2
> d8: 1 !=3D 2
> d9: 1 !=3D 2
> d10: 1 !=3D 2
> d11: 1 !=3D 2
> d12: 1 !=3D 2
> d13: 1 !=3D 2
> d14: 1 !=3D 2
> d15: 1 !=3D 2
> =3D=3D FPU check routines: OK.
> =3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
> rtk_fp_ufpp0-5 rtk_fp_ufppXenomai: suspending kernel thread 829210a8
> ('rtk2/0') at 0x8005bbc8 after exception #0x0
> 0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10 rtus0-11 rtus0-12
> rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16 rtuo_ufpp0-17 rtuo_ufpp0-18
> rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22
> Xenomai: RTDM: closing file descriptor 0.
> Segmentation fault
> *
>
> Do you have any clues what might be the problem? Btw, the example
> applications are working fine.
>
>
> Marcin
>
> 2012/8/21 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> > On 08/21/2012 04:05 PM, Marcin Ku=B6ka wrote:
> >> Sorry for no response.
> >>
> >> I'm still struggling with running xenomai-patched-kernel image on
> versatile
> >> express. As soon as i understand how i managed to make it working i wi=
ll
> >> post a solution.
> >
> > Maybe a patch review would help?
> >
> > --
> >                                             Gilles.
>
>
>
> --
> Marcin Ku=B6ka
>
>



--=20
Marcin Ku=B6ka
