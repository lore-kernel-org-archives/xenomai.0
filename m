From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <3535aae80708090909m57f10233rd317cc862f534702@domain.hid>
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>
	<2ff1a98a0708090242k70178437y716b502ce338e0a6@domain.hid>
	<46BAF956.5090401@domain.hid>
	<3535aae80708090909m57f10233rd317cc862f534702@domain.hid>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 18:22:56 +0200
Message-Id: <1186676576.4978.12.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] hard lock-up
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: andy motten <andy.motten@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Thu, 2007-08-09 at 18:09 +0200, andy motten wrote:
> Hello, thanks for the fast response.
> 
> We have followed your advice:
>  - enabled the linux debugs, nmi_watchdog debugs and Xenomai debugs.
>  - make use of a serial console.
> 
> The linux kernel used now is 2.6.20.9 with ipipe patch 1.8-08.
> We use branch 2.3.x of Xenomai (Last changed Revision 2898)
> 
> While running xeno-test, the system locks-up just after the latency
> test.

Confirmed here. Houston, we do have a problem with the switchtest, or
soimething this test triggers (and not necessarily the FPU mgmt)...

Could you try switching on the Xenomai watchdog knob from the nucleus
debug options and see if something changes? TIA,

> (below is a small sample of the kernel messages received through the
> serial connection, the complete kernel message is included in
> attachment) 
> 
> The kernel message is sometimes cut off after "NMI early shots: 0". So
> we don't always get all the messages through.
> 
> thanks and greetings, andy
> 
> 
> NMI watchdog detected timer latency above 100 us 
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0 
> NMI early shots: 0
> NMI early shots: 0
> NMI early shots: 0
>  [<c027887f>] nmi_stack_correct+0x26/0x2b
>  [<c0212746>] i8042_panic_blink+0x46/0x135
>  [<c01ce319>] delay_tsc+0x5/0x13
>  [<c01154ab>] panic+0x104/0x119 
>  [<c0212746>] i8042_panic_blink+0x46/0x135
>  [<c01188f9>] do_exit+0x717/0x8d3
>  [<c01cdfa6>] vscnprintf+0x14/0x22
>  [<c0115ee7>] printk+0x9b/0xab
>  [<c0212746>] i8042_panic_blink+0x46/0x135 
>  [<c0104fc6>] die_nmi+0xe9/0xf0
>  [<c0212746>] i8042_panic_blink+0x46/0x135
>  [<c021ded3>] rthal_latency_above_max+0x38/0x41
>  [<c01cdfa6>] vscnprintf+0x14/0x22
>  [<c0115ee7>] printk+0x9b/0xab 
>  [<c021e427>] rthal_nmi_watchdog_tick+0x51/0x194
>  [<c01046e5>] do_nmi+0x75/0x296
>  [<c010d42a>] __ipipe_handle_irq+0x76/0x1c8
>  [<c027887f>] nmi_stack_correct+0x26/0x2b
>  [<c0212746>] i8042_panic_blink+0x46/0x135 
>  [<c01ce319>] delay_tsc+0x5/0x13
>  [<c01154ab>] panic+0x104/0x119
>  [<c0212746>] i8042_panic_blink+0x46/0x135
>  [<c01188f9>] do_exit+0x717/0x8d3
>  [<c01cdfa6>] vscnprintf+0x14/0x22 
>  [<c0115ee7>] printk+0x9b/0xab
>  [<c0212746>] i8042_panic_blink+0x46/0x135
>  [<c0104fc6>] die_nmi+0xe9/0xf0
>  [<c0212746>] i8042_panic_blink+0x46/0x135
>  [<c021ded3>] rthal_latency_above_max+0x38/0x41 
>  [<c01cdfa6>] vscnprintf+0x14/0x22
>  [<c0115ee7>] printk+0x9b/0xab
>  [<c021e427>] rthal_nmi_watchdog_tick+0x51/0x194
>  [<c01046e5>] do_nmi+0x75/0x296
>  [<c010d42a>] __ipipe_handle_irq+0x76/0x1c8 
> 
> 2007/8/9, Jan Kiszka <jan.kiszka@domain.hid>:
>         Gilles Chanteperdrix wrote:
>         > On 8/9/07, andy motten <andy.motten@domain.hid> wrote:
>         >> There seems to be a difference between the 2 versions
>         (Xenomai: POSIX: 
>         >> destroyed thread), Is this normal or part of the problem ?
>         >
>         > No, this is normal, this message is harmless, it only
>         appears if you
>         > select posix skin debugging.
>         >
>         >> Is there a possibility that this is a bug in Xenomai or in
>         the ipipe patch? 
>         >> Using the Xenomai 2.2.x branch is not an option since we
>         need the RT can
>         >> drivers provided in the Xenomai 2.3.x branch.
>         >
>         > There is certainly a bug somewhere. Could you enable Linux
>         debugs, its 
>         > NMI watchdog (by adding nmi_watchdog=1 on the kernel command
>         line), as
>         > well as Xenomai debugs ? In order to find where the lock-up
>         occurs.
>         >
>         
>         And have a look at linux/Documentation/serial-console.txt to
>         capture the
>         "last words" (without having to take pictures of your monitor)
>         in case
>         the lock-up remains hard even with debugging switches on.
>         
>         Jan
>         
>         
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



