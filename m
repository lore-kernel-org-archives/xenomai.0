Date: Mon, 14 Sep 2015 21:59:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150914195941.GC27502@hermes.click-hack.org>
References: <20150914062111.GE4195@hermes.click-hack.org>
 <CAPRPZsB5PCNmrrqfE4u8E23JEL=_aRhTPS=kUHtEZwpRPjhagw@mail.gmail.com>
 <20150914074527.GA17701@hermes.click-hack.org>
 <CAPRPZsADxhfhhGOP_9rE__yR-Bb_QgJzyGn4K-kmgHvjO=3WjA@mail.gmail.com>
 <55F7037D.609@siemens.com>
 <20150914190123.GA27502@hermes.click-hack.org>
 <55F71AE8.9090706@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55F71AE8.9090706@siemens.com>
Subject: Re: [Xenomai] SMI count polling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, Sep 14, 2015 at 09:07:20PM +0200, Jan Kiszka wrote:
> On 2015-09-14 21:01, Gilles Chanteperdrix wrote:
> > On Mon, Sep 14, 2015 at 07:27:25PM +0200, Jan Kiszka wrote:
> >> On 2015-09-14 10:09, Jeroen Van den Keybus wrote:
> >>>> Well, in that case you can install msr-tools:
> >>>> https://01.org/msr-tools
> >>>
> >>> Thanks for pointing out. I didn't know these existed. Always used
> >>> direct msr device access.
> >>>
> >>>> And run:
> >>>> rdmsr 0x34
> >>>
> >>>> Of course, this requires CONFIG_X86_MSR in the kernel configuration,
> >>>> which putting the count in /proc would avoid. But still, this would
> >>>> be a bit redundant.
> >>>
> >>> True, but given the frequent usage of SMI on many mainboards, their
> >>> serious impact on realtime performance and SMIs being designed to
> >>> remain undetected, a convenience function wouldn't hurt. Especially
> >>> since I have the impression that it's an important stumbling stone for
> >>> first-time users.
> >>>
> >>> Also, the total count would be useful since you would have to run
> >>> rdmsr -p <CPU> 0x34 for every CPU in the system. I believe it's
> >>> important to check for SMI occurrence on non-realtime CPUs as well,
> >>> since I understand any of them might be handling them eventually ?
> >>
> >> Usually, the BIOS will force all cores into SMM: one core receives a
> >> triggering SMI and then it sends SMIs as IPIs to the others. So the
> >> counters increases on all cores, just with a minor delay.
> >>
> >> That said, having the rmdsr diagnosis documented would already be a
> >> valuable addition for users.
> > 
> > On the machine I was using where I discovered that tool, the value
> > is indeed the same on all cores, and it incremented by the number of
> > cores when . So, Jan, what do you think about
> > adding code to the tracer generating an event when the counter
> > value changes?
> 
> As we will have to poll for that event, it may be a little bit costly to
> do this on every ipipe tracer entry. But then we could make it
> configurable (via /proc) with default off - worth a try.

Ok. A first test gives the following trace:

:    +func               -2471	  0.360  page_add_new_anon_rmap+0x0 (handle_mm_fault+0x3a7)
:    +func               -2471	  0.372  __mod_zone_page_state+0x0 (page_add_new_anon_rmap+0x47)
:    +func               -2471	  0.372  __page_set_anon_rmap+0x0 (page_add_new_anon_rmap+0x5a)
:    +func               -2470! 2426.001  lru_cache_add+0x0 (page_add_new_anon_rmap+0xae)
:|   +SMI     0x00000002   -44	  0.516  apic_timer_interrupt+0x6d (__ipipe_trace+0x4e6)
:|   +begin   0x000000ef   -44	  0.613  apic_timer_interrupt+0x6d (__ipipe_trace+0x4e6)
:|   +func                 -43	  0.601  __ipipe_handle_irq+0x0 (apic_timer_interrupt+0x7c)
:|   +func                 -43	  0.444  __ipipe_dispatch_irq+0x0 (__ipipe_handle_irq+0x151)
:|   +func                 -42	  0.444  __ipipe_ack_hrtimer_irq+0x0 (__ipipe_dispatch_irq+0xba)
:|   +func                 -42	  0.745  lapic_itimer_ack+0x0 (__ipipe_ack_hrtimer_irq+0x6c)
:|  # func                 -41	  0.685  xnintr_clock_handler+0x0 (__ipipe_dispatch_irq+0x279)
:|  # func                 -40	  0.541  xntimer_tick_aperiodic+0x0 (xnintr_clock_handler+0x130)
:|  # func                 -40	  0.372  xnthread_periodic_handler+0x0 (xntimer_tick_aperiodic+0xd6)
:|  # func                 -39	  0.553  xnpod_resume_thread+0x0 (xnthread_periodic_handler+0x2a)
:|  # [  954] samplin 99   -39	  0.985  xnpod_resume_thread+0xe1 (xnthread_periodic_handler+0x2a)
:|  # func                 -38	  0.444  xntimer_next_local_shot+0x0 (xntimer_tick_aperiodic+0x64)
:|  # event   tick@-33     -37	  0.492  xntimer_next_local_shot+0x8e (xntimer_tick_aperiodic+0x64)

The printed value indicates the SMI count increment.

-- 
					    Gilles.
https://click-hack.org

