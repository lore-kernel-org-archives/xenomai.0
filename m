Message-ID: <2ff1a98a0710010204x60178291u9633e61a89d49921@domain.hid>
Date: Mon, 1 Oct 2007 11:04:06 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <46FFC139.60905@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <46F9167F.20008@domain.hid> <1190756271.26427.0.camel@domain.hid>
	<46FA26ED.4070505@domain.hid> <46FF78DF.7090104@domain.hid>
	<1191149545.5989.7.camel@domain.hid> <46FF81BA.1020506@domain.hid>
	<46FF8BB9.9080207@domain.hid> <1191156133.5989.17.camel@domain.hid>
	<46FFC139.60905@domain.hid>
Subject: Re: [Xenomai-core] crashing 2.6.22
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 9/30/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Philippe Gerum wrote:
> > On Sun, 2007-09-30 at 13:42 +0200, Jan Kiszka wrote:
> >> Jan Kiszka wrote:
> >>> Philippe Gerum wrote:
> >>>> On Sun, 2007-09-30 at 12:22 +0200, Jan Kiszka wrote:
> >> ...
> >>>>>  And a third
> >>>>> one only gives me "Detected illicit call from domain Xenomai" before the
> >>>>> box reboots. :(
> >>>> Grmff... Do you run with your smp_processor_id() instrumentation in?
> >>> Yes, but I suspect this is just a symptom of some severe memory
> >>> corruption that (also?) hits I-pipe data structures. I just put in some
> >>> different instrumentation, and that warning is gone, the box just hangs
> >>> hard at a different point. Very unfriendly.
> >> Hah! Got some crash log by hacking a raw printk-to-uart:
> >>
> >> [...]
> >> <6>Xenomai: starting RTDM services.
> >> <6>NET: Registered protocol family 10
> >> <6>lo: Disabled Privacy Extensions
> >> <6>ADDRCONF(NETDEV_UP): eth0: link is not ready
> >> <3>I-pipe: Detected illicit call from domain 'Xenomai'
> >> <3>        into a service reserved for domain 'Linux' and below.
> >>        f3a6bc18 00000000 00000000 c05dad6c f3a6bc3c c0105fc3 c03513c7 c05dc100
> >>        00000009 f3a6bc54 c01479cb c03592f8 c0357ae2 c035e069 f3a6bc88 f3a6bc70
> >>        c0127224 c0111df8 00000000 f3a6bd74 00000000 f3a6bd74 f3a6bc80 c012727f
> >> Call Trace:
> >>  [<c010520f>] show_trace_log_lvl+0x1f/0x40
> >>  [<c01052e1>] show_stack_log_lvl+0xb1/0xe0
> >>  [<c0105fc3>] show_stack+0x33/0x40
> >>  [<c01479cb>] ipipe_check_context+0x7b/0x90
> >>  [<c0127224>] __atomic_notifier_call_chain+0x24/0x60
> >>  [<c012727f>] atomic_notifier_call_chain+0x1f/0x30
> >>  [<c0131e02>] notify_die+0x32/0x40
> >>  [<c0105d29>] do_invalid_op+0x59/0xa0
> >>  [<c0111d0b>] __ipipe_handle_exception+0x7b/0x144
> >>  [<c02dfaeb>] error_code+0x6f/0x7c
> >
> > Wow. Why that?
> >
> >>  [<c0111d13>] __ipipe_handle_exception+0x83/0x144
> >>  [<c02dfaeb>] error_code+0x6f/0x7c
> >
> > And this? We should not get any exception over an IPI3 handler. I guess
> > the double fault may be explained by this root cause.
> >
> >>  [<c01117df>] __ipipe_handle_irq+0x4f/0x140
> >>  [<c0104c5e>] ipipe_ipi3+0x26/0x40
> >
> > Our LAPIC timer vector. Are you running full modular or statically btw?
>
> Fully modular. Compiling the nucleus in makes the lock-up move to
> another, once again invisible spot.
>
> I nailed down the fault address in the scenario above. It's in the
> nucleus module, at the first byte of xntimer_tick_aperiodic. Are we
> loosing module text pages over the time? This functions must have been
> executed before as the timer was armed while I collected the
> /proc/modules and then triggered the crash.

There is a pending issue about vmalloced areas, which I completely forgot:
https://mail.gna.org/public/xenomai-core/2007-02/msg00138.html

-- 
                                               Gilles Chanteperdrix

