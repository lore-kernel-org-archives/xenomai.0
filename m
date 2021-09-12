From: <j.villena@ecler.com>
References: <003a01d7a10d$9268d6b0$b73a8410$@ecler.com>
 <87sfyk7pwl.fsf@xenomai.org> <001701d7a241$8f019ae0$ad04d0a0$@ecler.com>
 <87mtor6mi7.fsf@xenomai.org>
In-Reply-To: <87mtor6mi7.fsf@xenomai.org>
Subject: RE: Using oob GPIO on RPi4B and evl_poll
Date: Sun, 12 Sep 2021 22:38:52 +0200
Message-ID: <000001d7a816$334d9bb0$99e8d310$@ecler.com>
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



> -----Mensaje original-----
> De: Philippe Gerum <rpm@xenomai.org>
> Enviado el: domingo, 5 de septiembre de 2021 18:00
> CC: xenomai@xenomai.org
> Asunto: Re: Using oob GPIO on RPi4B and evl_poll
> 
> 
> j.villena--- via Xenomai <xenomai@xenomai.org> writes:
> 
> >>
> >> j.villena--- via Xenomai <xenomai@xenomai.org> writes:
> >>
> >> > Hi all,
> >> >
> >> >
> >> >
> >> > I am using the EVL Raspberry-PI-4 GPIO driver in oob mode for
> >> > waiting for 4 GPI signals changes by monitoring raising and falling
> >> > edges
> >> continuously.
> >> >
> >> >
> >> >
> >> > The first version uses 4 diferent oob threads and it works as
> >> > expected when waiting forever in oob_read on each thread.
> >> >
> >> >
> >> >
> >> > To optimize resources, I want to avoid to use the 4 threads
> >> > approach, and I want to create only one thread to handle all GPI
> functionality.
> >> > Thus I have added polling capabilities with evl_poll and related
> >> > API to GPIO file descriptors in only one thread.
> >> >
> >> >
> >> >
> >> > At first it seems to work, but when I added another file descriptor
> >> > to the same polliing set (from an event flag group) the program
> >> > freezes, and system becomes unstable.
> >> >
> >> >
> >> >
> >> > Then I noticed that in the "Polling file descriptors
> >> > <https://evlproject.org/core/user-api/poll/> " section of the EVL
> >> > online documentation, the GPIO real-time I/O driver is not listed
> >> > in the enumeration of pollable elements.
> >> >
> >> >
> >> >
> >> > Is this true and the cause of the wrong behavior when using polled
> >> > wait? If yes, could it be easily fixed?
> >> >
> >>
> >> The documentation only mentions EVL elements directly available from
> >> user- space as individual resources, however this does not preclude
> >> other resources created by drivers to be polled as well, which is the
> >> case for
> > GPIO
> >> lines. IOW, GPIO lines can be polled with evl_poll(), along with any
> >> data source/sink which invokes evl_signal_poll_events() in the
> >> kernel-side implementation.
> >>
> >> A couple of questions:
> >>
> >> - is there any message on the kernel console when the issue happens?
> >>
> >> - does the system freeze entirely? If so, did you enable
> >>   CONFIG_EVL_WATCHDOG to catch runaway threads?
> >>
> >> Can you share a simple test code illustrating the issue? I would
> > definitely
> >> have a look at it.
> >>
> >> [1] https://evlproject.org/core/build-steps/#core-kconfig
> >>
> >> --
> >> Philippe.
> >
> > Well, I have created a simple program to force the wrong behaviour. It
> > is at
> > https://www.dropbox.com/s/3vmp6e4o15c55tg/evl_poll_test.c?dl=0
> >
> > The program creates two threads (threadA and threadB). ThreadA creates
> > a timer and signals a global evl_flag once per second in an endless
loop.
> > ThreadB configures a pin of the Raspberry Pi 4 (CM4 really) as GPI,
> > with a GPIOEVENT when signal changes (any edge), and a pollset to wait
> > from the global evl_flag or any GPI event configured. Then, in other
> > endless loop, ThreadB waits for any poll event and then writes some
> > messages in the console.
> >
> > In this situation, all works as expected until I force a change in the
> > GPI signal, then the system freezes and the kernel console shows this
> output:
> >
> > [   28.954083] Unable to handle kernel paging request at virtual address
> > dead000000000108
> > [   28.954086] Mem abort info:
> > [   28.954087]   ESR = 0x96000044
> > [   28.954089]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [   28.954090]   SET = 0, FnV = 0
> > [   28.954091]   EA = 0, S1PTW = 0
> > [   28.954092] Data abort info:
> > [   28.954093]   ISV = 0, ISS = 0x00000044
> > [   28.954094]   CM = 0, WnR = 1
> > [   28.954096] [dead000000000108] address between user and kernel
> address
> > ranges
> > [   28.954097] Internal error: Oops: 96000044 [#1] PREEMPT SMP
> > [   28.954099] Modules linked in:
> > [   28.954103] CPU: 2 PID: 297 Comm: threadB:-1 Not tainted 5.10.59 #1
> > [   28.954104] Hardware name: Raspberry Pi Compute Module 4 (DT)
> > [   28.954105] IRQ stage: EVL
> > [   28.954106] pstate: 80000085 (Nzcv daIf -PAN -UAO -TCO BTYPE=--)
> > [   28.954108] pc : evl_ignore_fd+0x58/0x1f0
> > [   28.954109] lr : evl_ignore_fd+0x28/0x1f0
> > [   28.954110] sp : ffffffc011fb3be0
> > [   28.954111] x29: ffffffc011fb3be0 x28: ffffff804214d400
> > [   28.954114] x27: ffffffc0119dcab0 x26: dead000000000100
> > [   28.954117] x25: dead000000000122 x24: 0000000000000001
> > [   28.954120] x23: 0000000000000000 x22: 0000000000000000
> > [   28.954122] x21: 0000000000000000 x20: ffffffc01117f000
> > [   28.954125] x19: ffffffc0119dcb90 x18: 0000000000000000
> > [   28.954128] x17: 0000000000000000 x16: 0000000000000000
> > [   28.954130] x15: 0000000000000000 x14: 0000000000000000
> > [   28.954133] x13: 0000000000000000 x12: 0000000000000000
> > [   28.954135] x11: 0000000000000000 x10: 0000000000000000
> > [   28.954138] x9 : ffffffc010194c40 x8 : 0000000000000001
> > [   28.954140] x7 : 0000007ff7d65568 x6 : ffffff804214d1b8
> > [   28.954143] x5 : 0000007ff7d65578 x4 : ffffffc01117f7b8
> > [   28.954146] x3 : 0000000000000000 x2 : 0000000000000001
> > [   28.954149] x1 : dead000000000100 x0 : dead000000000122
> > [   28.954151] Call trace:
> > [   28.954152]  evl_ignore_fd+0x58/0x1f0
> 
> Uh oh, some stale watchpoint is being accessed when the caller unwinds
> from a poll it seems, this would match your description about the issue
> happening when the GPIO edge is raised.
> 
> > [   28.954154]  wait_events+0x2ec/0x4cc
> > [   28.954155]  poll_oob_ioctl+0xf8/0x530
> > [   28.954156]  EVL_ioctl+0x58/0xec
> > [   28.954157]  do_oob_syscall+0x118/0x380
> > [   28.954158]  handle_oob_syscall+0x28/0xe0
> > [   28.954159]  pipeline_syscall+0x8c/0x130
> > [   28.954160]  el0_svc_common.constprop.0+0x58/0x250
> > [   28.954161]  do_el0_svc+0x30/0xa0
> > [   28.954162]  el0_svc+0x20/0x30
> > [   28.954164]  el0_sync_handler+0x1a4/0x1b0
> > [   28.954165]  el0_sync+0x180/0x1c0
> > [   28.954166] Code: 88e47c02 2a0403e0 35000320 a9400261 (f9000420)
> > [   28.954167] ---[ end trace eb485c9145b7c640 ]---
> > [   28.954169] note: threadB:-1[297] exited with preempt_count 33554434
> >
> > However, using only the global flag event, or only the GPI event, all
> > work fine. Is the mix of both types of file descriptors in the polling
> > loop what seems to corrupt something.
> 
> Thanks for the detailed information, this is going to help a lot. I'll
follow up on
> this.
> 
> --
> Philippe.

> 
> Reproduced with [1], fixed by [2] (also merged into v5.14). Please confirm
> whether that fixes the issue you have observed.
> 
> [1]
>
https://source.denx.de/Xenomai/xenomai4/libevl/-/blob/master/tests/poll-mult
iple.c
> [2]
>
https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/8f1779a611242dcfa
7281ad71e36fec9f987882a
> 
> --
> Philippe.

Hi, Philippe,

Yes, it fixes the wrong behavior. Thank you!

Jesus



