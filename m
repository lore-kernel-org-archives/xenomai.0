Message-ID: <d6c8ef150803180622g6883e066v70c21ba846acdaab@domain.hid>
Date: Tue, 18 Mar 2008 14:22:06 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <47DAA815.4010804@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0803120923m76f75bder857abac049c22e4d@domain.hid>
	<d6c8ef150803140404y1febc9e0g7c6ab90497b347d3@domain.hid>
	<d6c8ef150803140407j496a8d9ah477b001a49e411bf@domain.hid>
	<d6c8ef150803140920u59c84733l64d9cf0c8669097c@domain.hid>
	<47DAA815.4010804@domain.hid>
Subject: Re: [Xenomai-help] [Adeos-main] New I-pipe patch for ARM.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: philippe.gerum@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>

OK. What about memcpy-ing to kmalloc()-ed memory? Like, kmalloc() is
called outside real-time task, but memcpy-in something to that memory
is done in realtime.

On Fri, Mar 14, 2008 at 5:30 PM, Philippe Gerum
<philippe.gerum@domain.hid> wrote:
> Bosko Radivojevic wrote:
>  > OK here are a bit more details, output from the module (rt_task_create
>  > and rt_task_start lines are printing the return value). It looks like
>  > the same problem as Johan reported a few hours ago. Am I right?
>  >
>
>  Yes, you may not call kmalloc() on behalf of a real-time thread in kernel space.
>  If you run on top of rtdm, then rtdm_malloc/free() will work. Otherwise, you may
>  pull memory directly from the Xenomai heap using xnmalloc()/xnfree(). Make sure
>  to set CONFIG_XENO_OPT_SYS_HEAPSZ accordingly.
>  If you happen to use the native skin, then you may create your own private heap
>  using rt_heap_create() as well (from module_init context).
>
>
>
>  > rt_task_create(): 0
>  >
>  > I-pipe: Detected illicit call from domain 'Xenomai'
>  >         into a service reserved for domain 'Linux' and below.
>  >
>  > [<c001e0b0>] (dump_stack+0x0/0x14) from [<c00575a8>] (ipipe_check_context+0x80/0
>  > x9c)
>  > [<c0057528>] (ipipe_check_context+0x0/0x9c) from [<c00a7af0>] (__kmalloc+0x60/0x
>  > 108)
>  >  r4:c3d2fc00
>  > [<c00a7a90>] (__kmalloc+0x0/0x108) from [<bf000724>] (ebustxrx+0x30/0x148 [macb2
>  > ])
>  >  r7:00000010 r6:c3d7fb40 r5:bf0015cc r4:c3d2fc00
>  > [<bf0006f4>] (ebustxrx+0x0/0x148 [macb2]) from [<bf003b7c>] (bus_fixed_msg_cycle
>  > +0x1c/0x3c [rt_bus_driver])
>  > [<bf003b60>] (bus_fixed_msg_cycle+0x0/0x3c [rt_bus_driver]) from [<bf004f60>] (R
>  > ead_inputs+0x28/0x164 [rt_bus_driver])
>  > [<bf004f38>] (Read_inputs+0x0/0x164 [rt_bus_driver]) from [<bf0038d0>] (do_upg+0
>  > x44/0x250 [rt_bus_driver])
>  > [<bf00388c>] (do_upg+0x0/0x250 [rt_bus_driver]) from [<c005f964>] (xnarch_thread
>  > _trampoline+0x28/0x34)
>  >  r7:00000000 r6:00000000 r5:bf00b508 r4:bf00b508
>  > [<c005f93c>] (xnarch_thread_trampoline+0x0/0x34) from [<c005ee14>] (xnpod_schedu
>  > le+0x470/0x760)
>  >  r4:c005f93c
>  >
>  > rt_task_start(): 0
>  >
>  >
>  > On Fri, Mar 14, 2008 at 12:07 PM, Bosko Radivojevic
>  > <bosko.radivojevic@domain.hid> wrote:
>  >> Sorry, my fingers are faster than my mind. The same happens when I
>  >>  remove rt_task_set_mode call. In the meantime, I realized that
>  >>  T_PRIMARY is invalid for kernel based tasks. So... maybe this is a
>  >>  bug? :)
>  >>
>  >>  On Fri, Mar 14, 2008 at 12:04 PM, Bosko Radivojevic
>  >>
>  >> <bosko.radivojevic@domain.hid> wrote:
>  >>
>  >>
>  >>> Hi,
>  >>  >
>  >>  >  now, I have a problem with our application. It is using native skin,
>  >>  >  when I start it I get:
>  >>  >
>  >>  >  kernel BUG at kernel/ipipe/core.c:322!
>  >>  >  Xenomai: suspending kernel thread bf00b4e8 ('do_upg') at 0xc001db14
>  >>  >  after exception #0
>  >>  >
>  >>  >  It looks to me that this happens after rt_task_set_mode(0, T_PRIMARY,
>  >>  >  NULL) call in our module. Maybe something changed from 2.3.x Xenomai
>  >>  >  to 2.4.x?
>  >>  >
>  >>  >  On Wed, Mar 12, 2008 at 5:23 PM, Gilles Chanteperdrix
>  >>  >
>  >>  > <gilles.chanteperdrix@xenomai.org> wrote:
>  >>  >
>  >>  >
>  >>  > > Hi,
>  >>  >  >
>  >>  >  >  as you may have already noticed, the ARM I-pipe patch for linux 2.6.24
>  >>  >  >  is available on Adeos download site and in Xenomai svn.
>  >>  >  >
>  >>  >  >  This patch incorporates modifications of all boards code to adapt to
>  >>  >  >  the ipipe_tickdev system which couples timer requests with Linux
>  >>  >  >  clockevent/clocksource framework.
>  >>  >  >
>  >>  >  >  As usual, it is tested only on AT91RM9200 and only compile-tested for
>  >>  >  >  other boards. So, it would be nice if people could test this new patch
>  >>  >  >  on their board.
>  >>  >  >
>  >>  >  >  Thanks and regards.
>  >>  >  >
>  >>  >  >  --
>  >>  >  >   Gilles Chanteperdrix
>  >>  >  >
>  >>  >  >  _______________________________________________
>  >>  >  >  Adeos-main mailing list
>  >>  >  >  Adeos-main@domain.hid
>  >>  >  >  https://mail.gna.org/listinfo/adeos-main
>  >>  >  >
>  >>  >
>  >>
>  >
>  > _______________________________________________
>  > Adeos-main mailing list
>  > Adeos-main@domain.hid
>  > https://mail.gna.org/listinfo/adeos-main
>  >
>
>
>  --
>  Philippe.
>

