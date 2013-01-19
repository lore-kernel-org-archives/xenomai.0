Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1283)
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <50FAA967.3090306@xenomai.org>
Date: Sat, 19 Jan 2013 15:14:23 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <D291A2E5-1A46-4501-9781-3ACCC0F20E51@mah.priv.at>
References: <4D4F8D1B-022E-47F8-A579-EBF2A3427C5D@mah.priv.at>	<50F6D940.3040406@xs4all.nl>	<F1ACE4FC-3E71-4498-B683-81F5C40CB6E3@mah.priv.at>	<50F7AF53.2090800@xs4all.nl>
	<50F7BC13.50009@xenomai.org>	<50F7FCD8.7020105@xs4all.nl>
	<50FA9FA0.7020400@xenomai.org>
	<F995AEC4-6B7E-4DB9-9C64-A5ED3F01DCFA@mah.priv.at>
	<50FAA967.3090306@xenomai.org>
Subject: Re: [Xenomai] [Emc-developers] "new RTOS" status:
	Scheduler	(?)	lockup on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Am 19.01.2013 um 15:10 schrieb Gilles Chanteperdrix:

> On 01/19/2013 03:09 PM, Michael Haberler wrote:
>=20
>>=20
>> Am 19.01.2013 um 14:29 schrieb Gilles Chanteperdrix:
>>=20
>>> On 01/17/2013 02:30 PM, Bas Laarhoven wrote:
>>>=20
>>>> On 17-1-2013 9:53, Gilles Chanteperdrix wrote:
>>>>> On 01/17/2013 08:59 AM, Bas Laarhoven wrote:
>>>>>=20
>>>>>> On 16-1-2013 20:36, Michael Haberler wrote:
>>>>>>> Am 16.01.2013 um 17:45 schrieb Bas Laarhoven:
>>>>>>>=20
>>>>>>>> On 16-1-2013 15:15, Michael Haberler wrote:
>>>>>>>>> ARM work:
>>>>>>>>>=20
>>>>>>>>> Several people have been able to get the Beaglebone =
ubuntu/xenomai setup working as outlined here: =
http://wiki.linuxcnc.org/cgi-bin/wiki.pl?BeagleboneDevsetup
>>>>>>>>> I have updated the kernel and rootfs image a few days ago so =
the kernel includes ext2/3/4 support compiled in, which should take care =
of two failure reports I got.
>>>>>>>>>=20
>>>>>>>>> Again that xenomai kernel is based on 3.2.21; it works very =
stable for me but there have been several reports of 'sudden stops'. The =
BB is a bit sensitive to power fluctuations but it might be more than =
that. As for that kernel, it works, but it is based on a branch which =
will see no further development. It supports most of the stuff needed to =
development; there might be some patches coming from more active BB =
users than me.
>>>>>>>> Hi Michael,
>>>>>>>>=20
>>>>>>>> Are you saying you don't have seen these 'sudden stops' =
yourself?
>>>>>>> No, never, after swapping to stronger power supplies; I have two =
of these boards running over NFS all the time. I dont have Linuxcnc =
running on them though, I'll do that and see if that changes the =
picture. Maybe keeping the torture test running helps trigger it.
>>>>>> Beginners error! :-P The power supply is indeed critical, but the
>>>>>> stepdown converter on my BeBoPr is dimensioned for at least 2A =
and
>>>>>> hasn't failed me yet.
>>>>>>=20
>>>>>> I think that running linuxcnc is mandatory for the lockup. After =
a dozen
>>>>>> runs, it looks like I can reproduce the lockup with 100% =
certainty
>>>>>> within one hour.
>>>>>> Using the JTAG interface to attach a debugger to the Bone, I've =
found
>>>>>> that once stalled the kernel is still running. It looks like it =
won't
>>>>>> schedule properly and almost all time is spent in the cpu_idle =
thread.
>>>>>=20
>>>>> This is typical of a tsc emulation or timer issue. On a system =
without
>>>>> anything running, please let the "tsc -w" command run. It will =
take some
>>>>> time to run (the wrap time of the hardware timer used for tsc
>>>>> emulation), if it runs correctly, then you need to check whether =
the
>>>>> timer is still running when the bug happens (cat /proc/xenomai/irq
>>>>> should continue increasing when for instance the latency test is
>>>>> running). If the timer is stopped, it may have been programmed for =
a too
>>>>> short delay, to avoid that, you can try:
>>>>> - increasing the ipipe_timer min_delay_ticks member (by default, =
it uses
>>>>> a value corresponding to the min_delta_ns member in the clockevent
>>>>> structure);
>>>>> - checking after programming the timer (in the set_next_event =
method) if
>>>>> the timer counter is already 0, in which case you can return a =
negative
>>>>> value, usually -ETIME.
>>>>>=20
>>>>=20
>>>> Hi Gilles,
>>>>=20
>>>> Thanks for the swift reply.
>>>>=20
>>>> As far as I can see, tsc -w runs without an error:
>>>>=20
>>>> ARM: counter wrap time: 179 seconds
>>>> Checking tsc for 6 minute(s)
>>>> min: 5, max: 12, avg: 5.04168
>>>> ...
>>>> min: 5, max: 6, avg: 5.03771
>>>> min: 5, max: 28, avg: 5.03989 -> 0.209995 us
>>>>=20
>>>> real    6m0.284s
>>>>=20
>>>> I've also done the other regression tests and all were successful.
>>>>=20
>>>> Problem is that once the bug happens I won't be able to issue the =
cat=20
>>>> command.
>>>> I've fixed my debug setup so I don't have to use the System.map to=20=

>>>> manually translate the debugger addresses : /
>>>> Now I'm waiting for another lockup to see what's happening.
>>>=20
>>>=20
>>> You may want to have a look at the xeno-regression-test script to =
put
>>> your system under pressure (and likely generate the lockup faster).
>>=20
>> running tsc -w and xeno-regression-test in parallel I get errors like =
so (not on every run; no lockup so far):
>>=20
>> ++ /usr/xenomai/bin/mutex-torture-native
>> simple_wait
>> recursive_wait
>> timed_mutex
>> mode_switch
>> pi_wait
>> lock_stealing
>> NOTE: lock_stealing mutex_trylock: not supported
>> deny_stealing
>> simple_condwait
>> recursive_condwait
>> auto_switchback
>> FAILURE: current prio (0) !=3D expected prio (2)
>>=20
>> dmesg=20
>> [501963.390598] Xenomai: native: cleaning up mutex "" (ret=3D0).
>> [502170.164984] usb 1-1: reset high-speed USB device number 2 using =
musb-hdrc
>>=20
>> on another run, I got a segfault while running sigdebug:
>> ++ /usr/xenomai/bin/regression/native/sigdebug
>> mayday page starting at 0x400eb000 [/dev/rtheap]
>> mayday code: 0c 00 9f e5 0c 70 9f e5 00 00 00 ef 00 00 a0 e3 00 00 80 =
e5 2b 02 00 0a 42 00 0f 00 db d7 ee b8
>> mlockall
>> syscall
>> signal
>> relaxed mutex owner
>> page fault
>> watchdog
>> ./xeno-regression-test: line 53:  4210 Segmentation fault      =
/usr/xenomai/bin/regression/native/sigdebug
>>=20
>> root@bb1:/usr/xenomai/bin# dmesg=20
>> [502442.312996] Xenomai: watchdog triggered -- signaling runaway =
thread 'rt_task'
>> [502443.054186] Xenomai: native: cleaning up mutex "prio_invert" =
(ret=3D0).
>> [502443.055730] Xenomai: native: cleaning up sem "send_signal" =
(ret=3D0).
>> [502518.134977] usb 1-1: reset high-speed USB device number 2 using =
musb-hdrc
>>=20
>>=20
>> unsure what to make of it - any suggestions? the usb reset looks =
suspicious
>=20
>=20
> What version of xenomai are you using? These look like old issues?


that was xenomai 2.6.1 as per release tag in the git repo; the rest as =
outlined here: =
http://www.xenomai.org/pipermail/xenomai/2013-January/027164.html

just caught one more error:

-m

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
switchtest: Unable to open switchtest device.
(modprobe xeno_switchtest ?)
switchtest: Unable to open switchtest device.
(modprobe xeno_switchtest ?)
=3D=3D Threads:=3D=3D Threads:./xeno-regression-test failed: child 11343 =
exited with status 1
root@bb1:/usr/xenomai/bin# dmesg=20
[502442.312996] Xenomai: watchdog triggered -- signaling runaway thread =
'rt_task'
[502443.054186] Xenomai: native: cleaning up mutex "prio_invert" =
(ret=3D0).
[502443.055730] Xenomai: native: cleaning up sem "send_signal" (ret=3D0).
[502518.134977] usb 1-1: reset high-speed USB device number 2 using =
musb-hdrc
[502561.165050] usb 1-1: reset high-speed USB device number 2 using =
musb-hdrc
[502658.312984] Xenomai: watchdog triggered -- signaling runaway thread =
'rt_task'
[502721.135190] usb 1-1: reset high-speed USB device number 2 using =
musb-hdrc
[502737.613198] Xenomai: Posix: closing message queue descriptor 3.
[502738.607343] switchtest: page allocation failure: order:4, mode:0xd0
[502738.607369] Backtrace:=20
[502738.607436] [<c0010ea0>] (dump_backtrace+0x0/0x110) from =
[<c041e9a0>] (dump_stack+0x18/0x1c)
[502738.607453]  r6:00000000 r5:000000d0 r4:00000001 r3:00000000
[502738.607507] [<c041e988>] (dump_stack+0x0/0x1c) from [<c00cd668>] =
(warn_alloc_failed+0xf4/0x114)
[502738.607536] [<c00cd574>] (warn_alloc_failed+0x0/0x114) from =
[<c00cfbe0>] (__alloc_pages_nodemask+0x65c/0x6dc)
[502738.607554]  r3:00000006 r2:00000000
[502738.607570]  r7:00000004 r6:00000001 r5:cc14a000 r4:000000d0
[502738.607610] [<c00cf584>] (__alloc_pages_nodemask+0x0/0x6dc) from =
[<c041ffb0>] (cache_alloc_refill+0x2d0/0x5cc)
[502738.607645] [<c041fce0>] (cache_alloc_refill+0x0/0x5cc) from =
[<c00f7574>] (__kmalloc+0xb4/0x114)
[502738.607683] [<c00f74c0>] (__kmalloc+0x0/0x114) from [<c033a53c>] =
(rtswitch_ioctl_nrt+0xc0/0x3f4)
[502738.607756]  r7:c16c9800 r6:cf587ca0 r5:00000017 r4:cf587c80
[502738.607800] [<c033a47c>] (rtswitch_ioctl_nrt+0x0/0x3f4) from =
[<c00c4ea0>] (__rt_dev_ioctl+0x6c/0x1c4)
[502738.607817]  r7:c16c9800 r6:40040630 r5:00000017 r4:cf587c80
[502738.607856] [<c00c4e34>] (__rt_dev_ioctl+0x0/0x1c4) from =
[<c00c73fc>] (sys_rtdm_ioctl+0x28/0x2c)
[502738.607872]  r3:00000017 r2:40040630
[502738.607889]  r7:00000020 r6:cc14bfb0 r5:d088aa08 r4:00000050
[502738.607938] [<c00c73d4>] (sys_rtdm_ioctl+0x0/0x2c) from [<c009ffa8>] =
(losyscall_event+0xc0/0x224)
[502738.607973] [<c009fee8>] (losyscall_event+0x0/0x224) from =
[<c0083bb0>] (ipipe_syscall_hook+0x34/0x3c)
[502738.607998] [<c0083b7c>] (ipipe_syscall_hook+0x0/0x3c) from =
[<c0082738>] (__ipipe_notify_syscall+0x74/0xec)
[502738.608028] [<c00826c4>] (__ipipe_notify_syscall+0x0/0xec) from =
[<c001385c>] (__ipipe_syscall_root+0x7c/0x104)
[502738.608055] [<c00137e0>] (__ipipe_syscall_root+0x0/0x104) from =
[<c000da04>] (vector_swi+0x44/0x90)
[502738.608071]  r7:000f0042 r6:40114000 r5:00000380 r4:00030000
[502738.608099] Mem-info:
[502738.608110] Normal per-cpu:
[502738.608122] CPU    0: hi:   90, btch:  15 usd:   0
[502738.608149] active_anon:398 inactive_anon:473 isolated_anon:0
[502738.608157]  active_file:9642 inactive_file:14449 isolated_file:0
[502738.608164]  unevictable:4882 dirty:2 writeback:63 unstable:0
[502738.608171]  free:2028 slab_reclaimable:25399 =
slab_unreclaimable:4175
[502738.608179]  mapped:1370 shmem:4 pagetables:244 bounce:0
[502738.608222] Normal free:8112kB min:2036kB low:2544kB high:3052kB =
active_anon:1592kB inactive_anon:1892kB active_file:38568kB =
inactive_file:57796kB unevictable:19528kB isolated(anon):0kB =
isolated(file):0kB present:260096kB mlocked:19528kB dirty:8kB =
writeback:252kB mapped:5480kB shmem:16kB slab_reclaimable:101596kB =
slab_unreclaimable:16700kB kernel_stack:840kB pagetables:976kB =
unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 =
all_unreclaimable? no
[502738.608267] lowmem_reserve[]: 0 0
[502738.608286] Normal: 1502*4kB 195*8kB 34*16kB 0*32kB 0*64kB 0*128kB =
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB =3D 8112kB
[502738.608354] 24648 total pagecache pages
[502738.608366] 162 pages in swap cache
[502738.608378] Swap cache stats: add 3925, delete 3763, find =
35641/35775
[502738.608391] Free swap  =3D 3898276kB
[502738.608401] Total swap =3D 3909628kB
[502738.710325] switchtest: page allocation failure: order:4, mode:0xd0
[502738.710350] Backtrace:=20
[502738.710416] [<c0010ea0>] (dump_backtrace+0x0/0x110) from =
[<c041e9a0>] (dump_stack+0x18/0x1c)
[502738.710434]  r6:00000000 r5:000000d0 r4:00000001 r3:00000000
[502738.710487] [<c041e988>] (dump_stack+0x0/0x1c) from [<c00cd668>] =
(warn_alloc_failed+0xf4/0x114)
[502738.710516] [<c00cd574>] (warn_alloc_failed+0x0/0x114) from =
[<c00cfbe0>] (__alloc_pages_nodemask+0x65c/0x6dc)
[502738.710533]  r3:00000006 r2:00000000
[502738.710550]  r7:00000004 r6:00000001 r5:cc1fe000 r4:000000d0
[502738.710589] [<c00cf584>] (__alloc_pages_nodemask+0x0/0x6dc) from =
[<c041ffb0>] (cache_alloc_refill+0x2d0/0x5cc)
[502738.710624] [<c041fce0>] (cache_alloc_refill+0x0/0x5cc) from =
[<c00f7574>] (__kmalloc+0xb4/0x114)
[502738.710662] [<c00f74c0>] (__kmalloc+0x0/0x114) from [<c033a53c>] =
(rtswitch_ioctl_nrt+0xc0/0x3f4)
[502738.710678]  r7:cf35d800 r6:cf2ff4e0 r5:00000017 r4:cf2ff4c0
[502738.710777] [<c033a47c>] (rtswitch_ioctl_nrt+0x0/0x3f4) from =
[<c00c4ea0>] (__rt_dev_ioctl+0x6c/0x1c4)
[502738.710795]  r7:cf35d800 r6:40040630 r5:00000017 r4:cf2ff4c0
[502738.710834] [<c00c4e34>] (__rt_dev_ioctl+0x0/0x1c4) from =
[<c00c73fc>] (sys_rtdm_ioctl+0x28/0x2c)
[502738.710850]  r3:00000017 r2:40040630
[502738.710867]  r7:00000020 r6:cc1fffb0 r5:d0889c08 r4:00000050
[502738.710915] [<c00c73d4>] (sys_rtdm_ioctl+0x0/0x2c) from [<c009ffa8>] =
(losyscall_event+0xc0/0x224)
[502738.710949] [<c009fee8>] (losyscall_event+0x0/0x224) from =
[<c0083bb0>] (ipipe_syscall_hook+0x34/0x3c)
[502738.710975] [<c0083b7c>] (ipipe_syscall_hook+0x0/0x3c) from =
[<c0082738>] (__ipipe_notify_syscall+0x74/0xec)
[502738.711004] [<c00826c4>] (__ipipe_notify_syscall+0x0/0xec) from =
[<c001385c>] (__ipipe_syscall_root+0x7c/0x104)
[502738.711031] [<c00137e0>] (__ipipe_syscall_root+0x0/0x104) from =
[<c000da04>] (vector_swi+0x44/0x90)
[502738.711047]  r7:000f0042 r6:4008e000 r5:00000381 r4:00030000
[502738.711075] Mem-info:
[502738.711085] Normal per-cpu:
[502738.711097] CPU    0: hi:   90, btch:  15 usd:   0
[502738.711124] active_anon:408 inactive_anon:477 isolated_anon:0
[502738.711132]  active_file:9541 inactive_file:14408 isolated_file:0
[502738.711139]  unevictable:4883 dirty:3 writeback:63 unstable:0
[502738.711147]  free:2321 slab_reclaimable:25246 =
slab_unreclaimable:4168
[502738.711155]  mapped:1383 shmem:4 pagetables:243 bounce:0
[502738.711197] Normal free:9284kB min:2036kB low:2544kB high:3052kB =
active_anon:1632kB inactive_anon:1908kB active_file:38164kB =
inactive_file:57632kB unevictable:19532kB isolated(anon):0kB =
isolated(file):0kB present:260096kB mlocked:19532kB dirty:12kB =
writeback:252kB mapped:5532kB shmem:16kB slab_reclaimable:100984kB =
slab_unreclaimable:16672kB kernel_stack:832kB pagetables:972kB =
unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 =
all_unreclaimable? no
[502738.711243] lowmem_reserve[]: 0 0
[502738.711261] Normal: 1725*4kB 214*8kB 40*16kB 1*32kB 0*64kB 0*128kB =
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB =3D 9284kB
[502738.711328] 24511 total pagecache pages
[502738.711339] 167 pages in swap cache
[502738.711351] Swap cache stats: add 3933, delete 3766, find =
35641/35776
[502738.711364] Free swap  =3D 3898276kB
[502738.711374] Total swap =3D 3909628kB
[502738.738776] 65536 pages of RAM
[502738.738802] 2390 free pages
[502738.738812] 2463 reserved pages
[502738.738822] 29511 slab pages
[502738.738831] 9664 pages shared
[502738.738840] 159 pages swap cached
[502738.846993] 65536 pages of RAM
[502738.847018] 2605 free pages
[502738.847028] 2463 reserved pages
[502738.847038] 29379 slab pages
[502738.847047] 9815 pages shared
[502738.847056] 170 pages swap cached
[502739.570312] Xenomai: native: cleaning up sem "dispsem-11349" =
(ret=3D0).
[502752.205048] usb 1-1: reset high-speed USB device number 2 using =
musb-hdrc



>=20
> --=20
>                                                                Gilles.


