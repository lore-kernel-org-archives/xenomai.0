From: <j.villena@ecler.com>
References: <003a01d7a10d$9268d6b0$b73a8410$@ecler.com>
 <87sfyk7pwl.fsf@xenomai.org> <001701d7a241$8f019ae0$ad04d0a0$@ecler.com>
 <87mtor6mi7.fsf@xenomai.org> <000001d7a816$334d9bb0$99e8d310$@ecler.com>
In-Reply-To: <000001d7a816$334d9bb0$99e8d310$@ecler.com>
Subject: RE: Using oob GPIO on RPi4B and evl_poll
Date: Mon, 13 Sep 2021 09:58:04 +0200
Message-ID: <000e01d7a875$15c08ee0$4141aca0$@ecler.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: es
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Sorry Philippe, I have found another evl_poll related issue, similar to the
previous one. This time, a system crash happens when waiting in evl_poll for
more than 3 file descriptors.

This is a simple program to force the wrong behavior:
https://www.dropbox.com/s/bq7lng7dgvknypv/evl_poll_test2.c?dl=0

It's very similar to the other sent previously, but not using any GPIO
related functionality. The only objects which file descriptors are used in
evl_poll are evl_flags. The program works as expected using a value of
kFlagsCount < 4. From 4 upwards the kernel freezes.

The kernel console output using kFlagsCount > 3 is:

[  330.641524] Unable to handle kernel paging request at virtual address
dead000000000108
[  330.641527] Mem abort info:
[  330.641528]   ESR = 0x96000044
[  330.641530]   EC = 0x25: DABT (current EL), IL = 32 bits
[  330.641531]   SET = 0, FnV = 0
[  330.641532]   EA = 0, S1PTW = 0
[  330.641533] Data abort info:
[  330.641534]   ISV = 0, ISS = 0x00000044
[  330.641535]   CM = 0, WnR = 1
[  330.641537] [dead000000000108] address between user and kernel address
ranges
[  330.641538] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[  330.641539] Modules linked in:
[  330.641543] CPU: 2 PID: 293 Comm: threadB:-1 Not tainted 5.10.61 #1
[  330.641545] Hardware name: Raspberry Pi Compute Module 4 (DT)
[  330.641546] IRQ stage: EVL
[  330.641547] pstate: 80000085 (Nzcv daIf -PAN -UAO -TCO BTYPE=--)
[  330.641549] pc : evl_ignore_fd+0x58/0x1f0
[  330.641550] lr : evl_ignore_fd+0x28/0x1f0
[  330.641551] sp : ffffffc011f7bbe0
[  330.641552] x29: ffffffc011f7bbe0 x28: ffffff8041af1800
[  330.641555] x27: ffffffc0119e4a50 x26: dead000000000100
[  330.641558] x25: dead000000000122 x24: 0000000000000003
[  330.641560] x23: 0000000000000000 x22: 0000000000000000
[  330.641563] x21: 0000000000000000 x20: ffffffc01117f000
[  330.641565] x19: ffffffc0119e4b30 x18: 0000000000000000
[  330.641568] x17: 0000000000000000 x16: 0000000000000000
[  330.641570] x15: 0000000000000000 x14: 0000000000000000
[  330.641573] x13: 0000000000000000 x12: 0000000000000000
[  330.641575] x11: 0000000000000000 x10: 0000000000000000
[  330.641578] x9 : ffffffc010193eb8 x8 : 0000000100000001
[  330.641581] x7 : 0000007ff7d4a468 x6 : ffffff80421d8988
[  330.641583] x5 : 0000007ff7d4a488 x4 : ffffffc01117f7b8
[  330.641586] x3 : 0000000000000000 x2 : 0000000000000001
[  330.641588] x1 : dead000000000100 x0 : dead000000000122
[  330.641591] Call trace:
[  330.641592]  evl_ignore_fd+0x58/0x1f0
[  330.641593]  wait_events+0x2e8/0x4c0
[  330.641594]  poll_oob_ioctl+0xf8/0x530
[  330.641595]  EVL_ioctl+0x58/0xec
[  330.641596]  do_oob_syscall+0x118/0x380
[  330.641598]  handle_oob_syscall+0x28/0xe0
[  330.641599]  pipeline_syscall+0x8c/0x130
[  330.641600]  el0_svc_common.constprop.0+0x58/0x250
[  330.641601]  do_el0_svc+0x30/0xa0
[  330.641602]  el0_svc+0x20/0x30
[  330.641603]  el0_sync_handler+0xe8/0xf0
[  330.641604]  el0_sync+0x180/0x1c0
[  330.641606] Code: 88e47c02 2a0403e0 35000320 a9400261 (f9000420)
[  330.641607] ---[ end trace 7644e8508f5880b6 ]---
[  330.641608] note: threadB:-1[293] exited with preempt_count 33554434
[  330.871055] ------------[ cut here ]------------
[  330.871057] corrupted preempt_count: swapper/2/0/0x2000001
[  330.871059] WARNING: CPU: 2 PID: 0 at kernel/sched/core.c:3602
finish_task_switch+0x228/0x230
[  330.871060] Modules linked in:
[  330.871063] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D
5.10.61 #1
[  330.871064] Hardware name: Raspberry Pi Compute Module 4 (DT)
[  330.871065] IRQ stage: EVL
[  330.871067] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[  330.871068] pc : finish_task_switch+0x228/0x230
[  330.871069] lr : finish_task_switch+0x228/0x230
[  330.871070] sp : ffffffc011f7b790
[  330.871071] x29: ffffffc011f7b790 x28: ffffff8040188000
[  330.871074] x27: ffffffc011145000 x26: ffffff80401b6130
[  330.871077] x25: 0000000000000000 x24: ffffffc010076c44
[  330.871079] x23: ffffffc0109943a0 x22: ffffffc010fd9b28
[  330.871082] x21: ffffff80401b0000 x20: 0000000000000000
[  330.871084] x19: ffffff807fbb8380 x18: 0000000000000020
[  330.871087] x17: 0000000000000000 x16: 0000000000000017
[  330.871089] x15: ffffffffffffffff x14: ffffff807fba6878
[  330.871092] x13: ffffffffffffffff x12: ffffff807fba48e6
[  330.871095] x11: ffffff807fb98400 x10: 00000000000019e0
[  330.871097] x9 : ffffffc0100a4f48 x8 : 00000000ffffffff
[  330.871100] x7 : 000000000000000f x6 : ffffff807fba48ee
[  330.871102] x5 : 0000000000000001 x4 : 0000000000000000
[  330.871105] x3 : 0000000000000023 x2 : 0000000000000000
[  330.871107] x1 : 0000000000000000 x0 : ffffff80401b5ac0
[  330.871110] Call trace:
[  330.871111] ---[ end trace 7644e8508f5880b7 ]---
[  330.871113] Unable to handle kernel NULL pointer dereference at virtual
address 00000000000001b8
[  330.871114] Mem abort info:
[  330.871115]   ESR = 0x96000006
[  330.871116]   EC = 0x25: DABT (current EL), IL = 32 bits
[  330.871117]   SET = 0, FnV = 0
[  330.871118]   EA = 0, S1PTW = 0
[  330.871119] Data abort info:
[  330.871121]   ISV = 0, ISS = 0x00000006
[  330.871122]   CM = 0, WnR = 0
[  330.871123] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000041b19000
[  330.871124] [00000000000001b8] pgd=0000000040b4b003,
p4d=0000000040b4b003, pud=0000000040b4b003, pmd=0000000000000000
[  330.871129] Internal error: Oops: 96000006 [#2] PREEMPT SMP
[  330.871130] Modules linked in:
[  330.871132] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D W
5.10.61 #1
[  330.871134] Hardware name: Raspberry Pi Compute Module 4 (DT)
[  330.871135] IRQ stage: EVL
[  330.871136] pstate: 40000345 (nZcv DAiF -PAN -UAO -TCO BTYPE=--)
[  330.871137] pc : handle_oob_trap_exit+0x48/0xd0
[  330.871138] lr : __oob_trap_unwind+0x30/0x60
[  330.871139] sp : ffffffc011f7b580
[  330.871141] x29: ffffffc011f7b580 x28: ffffff80401b5ac0
[  330.871143] x27: ffffffc011145000 x26: ffffff80401b6130
[  330.871146] x25: 0000000000000000 x24: ffffffc010076c44
[  330.871148] x23: 0000000060000005 x22: ffffffc0100712cc
[  330.871151] x21: 0000000000000000 x20: 0000000000000003
[  330.871153] x19: ffffffc011f7b640 x18: 0000000000000030
[  330.871156] x17: 0000000000000000 x16: 0000000000000017
[  330.871159] x15: ffffffffffffffff x14: ffffff807fba6878
[  330.871161] x13: 0000000000000010 x12: ffffff807fba4d6c
[  330.871163] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[  330.871166] x9 : ffffffc010992920 x8 : 656361727420646e
[  330.871169] x7 : 000000000000000f x6 : ffffff807fba4d82
[  330.871171] x5 : 0000000000000000 x4 : ffffffc01114a000
[  330.871174] x3 : 0000000002000001 x2 : ffffff80401b5ac0
[  330.871177] x1 : ffffffc011f7b640 x0 : 00000000000000e0
[  330.871179] Call trace:
[  330.871181] Code: a9025bf5 d2801c00 f9401055 d50342ff (b941baa0)
[  330.871182] ---[ end trace 7644e8508f5880b8 ]---
[  330.871183] Kernel panic - not syncing: Attempted to kill the idle task!
[  330.871194] SMP: stopping secondary CPUs

Thank you.

Jesus

> -----Mensaje original-----
> De: Xenomai <xenomai-bounces@xenomai.org> En nombre de j.villena---
> via Xenomai
> Enviado el: domingo, 12 de septiembre de 2021 22:39
> Para: xenomai@xenomai.org
> Asunto: RE: Using oob GPIO on RPi4B and evl_poll
> 
> 
> 
> > -----Mensaje original-----
> > De: Philippe Gerum <rpm@xenomai.org>
> > Enviado el: domingo, 5 de septiembre de 2021 18:00
> > CC: xenomai@xenomai.org
> > Asunto: Re: Using oob GPIO on RPi4B and evl_poll
> >
> >
> > j.villena--- via Xenomai <xenomai@xenomai.org> writes:
> >
> > >>
> > >> j.villena--- via Xenomai <xenomai@xenomai.org> writes:
> > >>
> > >> > Hi all,
> > >> >
> > >> >
> > >> >
> > >> > I am using the EVL Raspberry-PI-4 GPIO driver in oob mode for
> > >> > waiting for 4 GPI signals changes by monitoring raising and
> > >> > falling edges
> > >> continuously.
> > >> >
> > >> >
> > >> >
> > >> > The first version uses 4 diferent oob threads and it works as
> > >> > expected when waiting forever in oob_read on each thread.
> > >> >
> > >> >
> > >> >
> > >> > To optimize resources, I want to avoid to use the 4 threads
> > >> > approach, and I want to create only one thread to handle all GPI
> > functionality.
> > >> > Thus I have added polling capabilities with evl_poll and related
> > >> > API to GPIO file descriptors in only one thread.
> > >> >
> > >> >
> > >> >
> > >> > At first it seems to work, but when I added another file
> > >> > descriptor to the same polliing set (from an event flag group)
> > >> > the program freezes, and system becomes unstable.
> > >> >
> > >> >
> > >> >
> > >> > Then I noticed that in the "Polling file descriptors
> > >> > <https://evlproject.org/core/user-api/poll/> " section of the EVL
> > >> > online documentation, the GPIO real-time I/O driver is not listed
> > >> > in the enumeration of pollable elements.
> > >> >
> > >> >
> > >> >
> > >> > Is this true and the cause of the wrong behavior when using
> > >> > polled wait? If yes, could it be easily fixed?
> > >> >
> > >>
> > >> The documentation only mentions EVL elements directly available
> > >> from
> > >> user- space as individual resources, however this does not preclude
> > >> other resources created by drivers to be polled as well, which is
> > >> the case for
> > > GPIO
> > >> lines. IOW, GPIO lines can be polled with evl_poll(), along with
> > >> any data source/sink which invokes evl_signal_poll_events() in the
> > >> kernel-side implementation.
> > >>
> > >> A couple of questions:
> > >>
> > >> - is there any message on the kernel console when the issue happens?
> > >>
> > >> - does the system freeze entirely? If so, did you enable
> > >>   CONFIG_EVL_WATCHDOG to catch runaway threads?
> > >>
> > >> Can you share a simple test code illustrating the issue? I would
> > > definitely
> > >> have a look at it.
> > >>
> > >> [1] https://evlproject.org/core/build-steps/#core-kconfig
> > >>
> > >> --
> > >> Philippe.
> > >
> > > Well, I have created a simple program to force the wrong behaviour.
> > > It is at
> > > https://www.dropbox.com/s/3vmp6e4o15c55tg/evl_poll_test.c?dl=0
> > >
> > > The program creates two threads (threadA and threadB). ThreadA
> > > creates a timer and signals a global evl_flag once per second in an
> > > endless
> loop.
> > > ThreadB configures a pin of the Raspberry Pi 4 (CM4 really) as GPI,
> > > with a GPIOEVENT when signal changes (any edge), and a pollset to
> > > wait from the global evl_flag or any GPI event configured. Then, in
> > > other endless loop, ThreadB waits for any poll event and then writes
> > > some messages in the console.
> > >
> > > In this situation, all works as expected until I force a change in
> > > the GPI signal, then the system freezes and the kernel console shows
> > > this
> > output:
> > >
> > > [   28.954083] Unable to handle kernel paging request at virtual
address
> > > dead000000000108
> > > [   28.954086] Mem abort info:
> > > [   28.954087]   ESR = 0x96000044
> > > [   28.954089]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > [   28.954090]   SET = 0, FnV = 0
> > > [   28.954091]   EA = 0, S1PTW = 0
> > > [   28.954092] Data abort info:
> > > [   28.954093]   ISV = 0, ISS = 0x00000044
> > > [   28.954094]   CM = 0, WnR = 1
> > > [   28.954096] [dead000000000108] address between user and kernel
> > address
> > > ranges
> > > [   28.954097] Internal error: Oops: 96000044 [#1] PREEMPT SMP
> > > [   28.954099] Modules linked in:
> > > [   28.954103] CPU: 2 PID: 297 Comm: threadB:-1 Not tainted 5.10.59 #1
> > > [   28.954104] Hardware name: Raspberry Pi Compute Module 4 (DT)
> > > [   28.954105] IRQ stage: EVL
> > > [   28.954106] pstate: 80000085 (Nzcv daIf -PAN -UAO -TCO BTYPE=--)
> > > [   28.954108] pc : evl_ignore_fd+0x58/0x1f0
> > > [   28.954109] lr : evl_ignore_fd+0x28/0x1f0
> > > [   28.954110] sp : ffffffc011fb3be0
> > > [   28.954111] x29: ffffffc011fb3be0 x28: ffffff804214d400
> > > [   28.954114] x27: ffffffc0119dcab0 x26: dead000000000100
> > > [   28.954117] x25: dead000000000122 x24: 0000000000000001
> > > [   28.954120] x23: 0000000000000000 x22: 0000000000000000
> > > [   28.954122] x21: 0000000000000000 x20: ffffffc01117f000
> > > [   28.954125] x19: ffffffc0119dcb90 x18: 0000000000000000
> > > [   28.954128] x17: 0000000000000000 x16: 0000000000000000
> > > [   28.954130] x15: 0000000000000000 x14: 0000000000000000
> > > [   28.954133] x13: 0000000000000000 x12: 0000000000000000
> > > [   28.954135] x11: 0000000000000000 x10: 0000000000000000
> > > [   28.954138] x9 : ffffffc010194c40 x8 : 0000000000000001
> > > [   28.954140] x7 : 0000007ff7d65568 x6 : ffffff804214d1b8
> > > [   28.954143] x5 : 0000007ff7d65578 x4 : ffffffc01117f7b8
> > > [   28.954146] x3 : 0000000000000000 x2 : 0000000000000001
> > > [   28.954149] x1 : dead000000000100 x0 : dead000000000122
> > > [   28.954151] Call trace:
> > > [   28.954152]  evl_ignore_fd+0x58/0x1f0
> >
> > Uh oh, some stale watchpoint is being accessed when the caller unwinds
> > from a poll it seems, this would match your description about the
> > issue happening when the GPIO edge is raised.
> >
> > > [   28.954154]  wait_events+0x2ec/0x4cc
> > > [   28.954155]  poll_oob_ioctl+0xf8/0x530
> > > [   28.954156]  EVL_ioctl+0x58/0xec
> > > [   28.954157]  do_oob_syscall+0x118/0x380
> > > [   28.954158]  handle_oob_syscall+0x28/0xe0
> > > [   28.954159]  pipeline_syscall+0x8c/0x130
> > > [   28.954160]  el0_svc_common.constprop.0+0x58/0x250
> > > [   28.954161]  do_el0_svc+0x30/0xa0
> > > [   28.954162]  el0_svc+0x20/0x30
> > > [   28.954164]  el0_sync_handler+0x1a4/0x1b0
> > > [   28.954165]  el0_sync+0x180/0x1c0
> > > [   28.954166] Code: 88e47c02 2a0403e0 35000320 a9400261 (f9000420)
> > > [   28.954167] ---[ end trace eb485c9145b7c640 ]---
> > > [   28.954169] note: threadB:-1[297] exited with preempt_count
33554434
> > >
> > > However, using only the global flag event, or only the GPI event,
> > > all work fine. Is the mix of both types of file descriptors in the
> > > polling loop what seems to corrupt something.
> >
> > Thanks for the detailed information, this is going to help a lot. I'll
> follow up on
> > this.
> >
> > --
> > Philippe.
> 
> >
> > Reproduced with [1], fixed by [2] (also merged into v5.14). Please
> > confirm whether that fixes the issue you have observed.
> >
> > [1]
> >
> https://source.denx.de/Xenomai/xenomai4/libevl/-/blob/master/tests/poll-
> mult
> iple.c
> > [2]
> >
> https://source.denx.de/Xenomai/xenomai4/linux-evl/-
> /commit/8f1779a611242dcfa
> 7281ad71e36fec9f987882a
> >
> > --
> > Philippe.
> 
> Hi, Philippe,
> 
> Yes, it fixes the wrong behavior. Thank you!
> 
> Jesus
> 
> 



