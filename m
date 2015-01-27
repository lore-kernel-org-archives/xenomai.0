Date: Tue, 27 Jan 2015 18:18:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150127171850.GA20726@hermes.click-hack.org>
References: <20150126190911.GN12812@hermes.click-hack.org>
 <20150126195219.GA10959@bugfree>
 <20150126195409.GA1491@hermes.click-hack.org>
 <20150127130925.GA22089@dmia-degroote.isae.fr>
 <20150127132647.GA16502@hermes.click-hack.org>
 <20150127135506.GB22089@dmia-degroote.isae.fr>
 <20150127140003.GB16502@hermes.click-hack.org>
 <20150127145812.GC22089@dmia-degroote.isae.fr>
 <20150127150307.GC16502@hermes.click-hack.org>
 <20150127164934.GD22089@dmia-degroote.isae.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150127164934.GD22089@dmia-degroote.isae.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting Xenomai on Odroid-U3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Arnaud Degroote <arnaud.degroote@isae.fr>
Cc: xenomai@xenomai.org

On Tue, Jan 27, 2015 at 05:49:34PM +0100, Arnaud Degroote wrote:
> On 27/Jan - 16:03, Gilles Chanteperdrix wrote:
> > On Tue, Jan 27, 2015 at 03:58:12PM +0100, Arnaud Degroote wrote:
> > > On 27/Jan - 15:00, Gilles Chanteperdrix wrote:
> > > > On Tue, Jan 27, 2015 at 02:55:06PM +0100, Arnaud Degroote wrote:
> > > > > On 27/Jan - 14:26, Gilles Chanteperdrix wrote:
> > > > > > On Tue, Jan 27, 2015 at 02:09:25PM +0100, Arnaud Degroote wrote:
> > > > > > > I suppose the offender is related to exynos_eint_gpio_irq available here
> > > > > > > 
> > > > > > > https://github.com/adegroote/linux/blob/linux-stable-xenomai-odroid-3.17.y/drivers/pinctrl/samsung/pinctrl-exynos.c#L278
> > > > > > > 
> > > > > > > but from documentation and other code sample, I don't see the cause of the trouble.
> > > > > > > Any idea / guidance is welcome. Thanks in advance,
> > > > > > 
> > > > > > If all the generic_handle_irq were properly replaced with
> > > > > > ipipe_handle_demuxed_irq, you should not arrive at
> > > > > > exynos_eint_gpio_irq via generic_handle_irq. There is a hole somewhere.
> > > > > 
> > > > > I double checked, the only generic_handle_irq caller in vmlinux is
> > > > > handle_IRQ. And the two only callers of handle_IRQ are asm_handle_IRQ
> > > > > and __ipipe_do_IRQ, so it looks like I'm good on this point.
> > > > 
> > > > Unless I misunderstand the trace you have sent, as I said, I suspect
> > > > you are not.
> > > 
> > > I checked it again, and there is really no more call to
> > > generic_handle_irq. 
> > > 
> > > Maybe an interesting point, exynos_eint_gpio_irq appears only in a call
> > > to devm_request_irq. Does that ring a bell with you? Does it need a
> > > special behaviour in the Ipipe case ?
> > 
> > Yes, this can not work. It is really strange to use devm_request_irq
> > for that. Normally chained irq handlers are registered as such, not
> > as regular handlers.
> 
> If I understand you properly, it won't work with Xenomai as it, and it
> needs to be rewrite as standard chained handler if I want to be usable
> with Xenomai ?

No, I only said that you should avoid calling that handler through
generic_handle_irq, but even that is not true, you can keep it that
way and just put a hard_local_irq_save/hard_local_irq_restore around
the call to ipipe_handle_demuxed_irq.

> 
> I don't need really it for moment, so for the moment, I will just
> comment the the init method. I'm more interested by smp support, but in
> the current state, it fails miserably with the following panic (IPIPE
> only kernel):
> 
> 
> [    0.074528] Setting up static identity map for 0x40428218 - 0x40428270
> [    0.108995] CPU1: Booted secondary processor
> [    0.109061] CPU1: thread -1, cpu 1, socket 10, mpidr 80000a01
> [    0.119009] CPU2: Booted secondary processor
> [    0.119071] CPU2: thread -1, cpu 2, socket 10, mpidr 80000a02
> [    0.128996] CPU3: Booted secondary processor
> [    0.129054] CPU3: thread -1, cpu 3, socket 10, mpidr 80000a03
> [    0.129182] Brought up 4 CPUs
> [    0.162536] SMP: Total of 4 processors activated.
> [    0.167326] CPU: All CPU(s) started in SVC mode.
> [    0.172393] ------------[ cut here ]------------
> [    0.176951] WARNING: CPU: 0 PID: 0 at kernel/rcu/tree.c:649 rcu_eqs_exit_common.isra.47+0xf4/0x100()
> [    0.186123] Modules linked in:
> [    0.189254] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.17.8-00008-g912f34f-dirty #94
> [    0.197179] [<c0014900>] (unwind_backtrace) from [<c00119b4>] (show_stack+0x10/0x14)
> [    0.204972] [<c00119b4>] (show_stack) from [<c04224a0>] (dump_stack+0x80/0xc0)
> [    0.212268] [<c04224a0>] (dump_stack) from [<c00212f4>] (warn_slowpath_common+0x6c/0x88)
> [    0.220418] [<c00212f4>] (warn_slowpath_common) from [<c00213ac>] (warn_slowpath_null+0x1c/0x24)
> [    0.229274] [<c00213ac>] (warn_slowpath_null) from [<c00609b0>] (rcu_eqs_exit_common.isra.47+0xf4/0x100)
> [    0.238820] [<c00609b0>] (rcu_eqs_exit_common.isra.47) from [<c0061898>] (rcu_idle_exit+0x8c/0xc0)
> [    0.247848] [<c0061898>] (rcu_idle_exit) from [<c004d474>] (cpu_startup_entry+0x11c/0x160)
> [    0.256188] [<c004d474>] (cpu_startup_entry) from [<c05bbbd0>] (start_kernel+0x3a0/0x3ac)
> [    0.264424] [<c05bbbd0>] (start_kernel) from [<40008074>] (0x40008074)
> [    0.271030] ---[ end trace 6f25337e92b79b7d ]---
> [    0.275737] BUG: scheduling while atomic: swapper/0/0/0x00010001
> [    0.281794] Modules linked in:
> [    0.284901] Preemption disabled at:[<  (null)>]   (null)
> [    0.290297] 
> [    0.291852] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W      3.17.8-00008-g912f34f-dirty #94
> [    0.300908] [<c0014900>] (unwind_backtrace) from [<c00119b4>] (show_stack+0x10/0x14)
> [    0.308717] [<c00119b4>] (show_stack) from [<c04224a0>] (dump_stack+0x80/0xc0)
> [    0.316002] [<c04224a0>] (dump_stack) from [<c041fe9c>] (__schedule_bug+0x9c/0xb0)
> [    0.323643] [<c041fe9c>] (__schedule_bug) from [<c04234b0>] (__schedule+0x4c8/0x5ac)
> [    0.331454] [<c04234b0>] (__schedule) from [<c04239e4>] (schedule_preempt_disabled+0x14/0x20)
> [    0.340047] [<c04239e4>] (schedule_preempt_disabled) from [<c004d424>] (cpu_startup_entry+0xcc/0x160)
> [    0.349335] [<c004d424>] (cpu_startup_entry) from [<c05bbbd0>] (start_kernel+0x3a0/0x3ac)
> [    0.357578] [<c05bbbd0>] (start_kernel) from [<40008074>] (0x40008074)
> [    0.364219] BUG: scheduling while atomic: swapper/1/0/0x00010001
> [    0.364443] ------------[ cut here ]------------
> [    0.364471] WARNING: CPU: 0 PID: 0 at kernel/rcu/tree.c:528 rcu_eqs_enter_common.isra.46+0x11c/0x128()
> [    0.364478] Modules linked in:
> [    0.364486] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W      3.17.8-00008-g912f34f-dirty #94
> [    0.364516] [<c0014900>] (unwind_backtrace) from [<c00119b4>] (show_stack+0x10/0x14)
> [    0.364529] [<c00119b4>] (show_stack) from [<c04224a0>] (dump_stack+0x80/0xc0)
> 
> Through, as I don't have another smp card, I don't know at all if it is related
> to my port of ipipe on 3.17, or something specific to the U3 code. And I cannot
> test on 3.16, as the standard 3.16 kernel does not boot properly on the U3. 
> 
> Any idea ? 

Please post your kernel configuration, if you have
CONFIG_TRACE_IRQFLAGS turned on, please try to turn it off.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150127/914969db/attachment.sig>
