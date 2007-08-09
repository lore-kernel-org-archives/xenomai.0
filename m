Message-ID: <3535aae80708090909m57f10233rd317cc862f534702@domain.hid>
Date: Thu, 9 Aug 2007 18:09:49 +0200
From: "andy motten" <andy.motten@domain.hid>
In-Reply-To: <46BAF956.5090401@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_159251_28903295.1186675789563"
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>
	<2ff1a98a0708090242k70178437y716b502ce338e0a6@domain.hid>
	<46BAF956.5090401@domain.hid>
Subject: Re: [Xenomai-help] hard lock-up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_159251_28903295.1186675789563
Content-Type: multipart/alternative; 
	boundary="----=_Part_159252_10168277.1186675789563"

------=_Part_159252_10168277.1186675789563
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, thanks for the fast response.

We have followed your advice:
 - enabled the linux debugs, nmi_watchdog debugs and Xenomai debugs.
 - make use of a serial console.

The linux kernel used now is 2.6.20.9 with ipipe patch 1.8-08.
We use branch 2.3.x of Xenomai (Last changed Revision 2898)

While running xeno-test, the system locks-up just after the latency test.
(below is a small sample of the kernel messages received through the serial
connection, the complete kernel message is included in attachment)

The kernel message is sometimes cut off after "NMI early shots: 0". So we
don't always get all the messages through.

thanks and greetings, andy


NMI watchdog detected timer latency above 100 us
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
NMI early shots: 0
 [<c027887f>] nmi_stack_correct+0x26/0x2b
 [<c0212746>] i8042_panic_blink+0x46/0x135
 [<c01ce319>] delay_tsc+0x5/0x13
 [<c01154ab>] panic+0x104/0x119
 [<c0212746>] i8042_panic_blink+0x46/0x135
 [<c01188f9>] do_exit+0x717/0x8d3
 [<c01cdfa6>] vscnprintf+0x14/0x22
 [<c0115ee7>] printk+0x9b/0xab
 [<c0212746>] i8042_panic_blink+0x46/0x135
 [<c0104fc6>] die_nmi+0xe9/0xf0
 [<c0212746>] i8042_panic_blink+0x46/0x135
 [<c021ded3>] rthal_latency_above_max+0x38/0x41
 [<c01cdfa6>] vscnprintf+0x14/0x22
 [<c0115ee7>] printk+0x9b/0xab
 [<c021e427>] rthal_nmi_watchdog_tick+0x51/0x194
 [<c01046e5>] do_nmi+0x75/0x296
 [<c010d42a>] __ipipe_handle_irq+0x76/0x1c8
 [<c027887f>] nmi_stack_correct+0x26/0x2b
 [<c0212746>] i8042_panic_blink+0x46/0x135
 [<c01ce319>] delay_tsc+0x5/0x13
 [<c01154ab>] panic+0x104/0x119
 [<c0212746>] i8042_panic_blink+0x46/0x135
 [<c01188f9>] do_exit+0x717/0x8d3
 [<c01cdfa6>] vscnprintf+0x14/0x22
 [<c0115ee7>] printk+0x9b/0xab
 [<c0212746>] i8042_panic_blink+0x46/0x135
 [<c0104fc6>] die_nmi+0xe9/0xf0
 [<c0212746>] i8042_panic_blink+0x46/0x135
 [<c021ded3>] rthal_latency_above_max+0x38/0x41
 [<c01cdfa6>] vscnprintf+0x14/0x22
 [<c0115ee7>] printk+0x9b/0xab
 [<c021e427>] rthal_nmi_watchdog_tick+0x51/0x194
 [<c01046e5>] do_nmi+0x75/0x296
 [<c010d42a>] __ipipe_handle_irq+0x76/0x1c8

2007/8/9, Jan Kiszka <jan.kiszka@domain.hid>:
>
> Gilles Chanteperdrix wrote:
> > On 8/9/07, andy motten <andy.motten@domain.hid> wrote:
> >> There seems to be a difference between the 2 versions (Xenomai: POSIX:
> >> destroyed thread), Is this normal or part of the problem ?
> >
> > No, this is normal, this message is harmless, it only appears if you
> > select posix skin debugging.
> >
> >> Is there a possibility that this is a bug in Xenomai or in the ipipe
> patch?
> >> Using the Xenomai 2.2.x branch is not an option since we need the RT
> can
> >> drivers provided in the Xenomai 2.3.x branch.
> >
> > There is certainly a bug somewhere. Could you enable Linux debugs, its
> > NMI watchdog (by adding nmi_watchdog=1 on the kernel command line), as
> > well as Xenomai debugs ? In order to find where the lock-up occurs.
> >
>
> And have a look at linux/Documentation/serial-console.txt to capture the
> "last words" (without having to take pictures of your monitor) in case
> the lock-up remains hard even with debugging switches on.
>
> Jan
>
>
>

------=_Part_159252_10168277.1186675789563
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, thanks for the fast response.<br><br>We have followed your advice:<br>&nbsp;- enabled the linux debugs, nmi_watchdog debugs and Xenomai debugs.<br>&nbsp;- make use of a serial console.<br><br>The linux kernel used now is <a href="http://2.6.20.9">
2.6.20.9</a> with ipipe patch 1.8-08.<br>We use branch 2.3.x of Xenomai (Last changed Revision 2898)<br><br>While running xeno-test, the system locks-up just after the latency test.<br>(below is a small sample of the kernel messages received through the serial connection, the complete kernel message is included in attachment)
<br><br>The kernel message is sometimes cut off after &quot;NMI early shots: 0&quot;. So we don&#39;t always get all the messages through.<br><br>thanks and greetings, andy<br><br><br>NMI watchdog detected timer latency above 100 us
<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>
NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0
<br>NMI early shots: 0<br>NMI early shots: 0<br>NMI early shots: 0<br>&nbsp;[&lt;c027887f&gt;] nmi_stack_correct+0x26/0x2b<br>&nbsp;[&lt;c0212746&gt;] i8042_panic_blink+0x46/0x135<br>&nbsp;[&lt;c01ce319&gt;] delay_tsc+0x5/0x13<br>&nbsp;[&lt;c01154ab&gt;] panic+0x104/0x119
<br>&nbsp;[&lt;c0212746&gt;] i8042_panic_blink+0x46/0x135<br>&nbsp;[&lt;c01188f9&gt;] do_exit+0x717/0x8d3<br>&nbsp;[&lt;c01cdfa6&gt;] vscnprintf+0x14/0x22<br>&nbsp;[&lt;c0115ee7&gt;] printk+0x9b/0xab<br>&nbsp;[&lt;c0212746&gt;] i8042_panic_blink+0x46/0x135
<br>&nbsp;[&lt;c0104fc6&gt;] die_nmi+0xe9/0xf0<br>&nbsp;[&lt;c0212746&gt;] i8042_panic_blink+0x46/0x135<br>&nbsp;[&lt;c021ded3&gt;] rthal_latency_above_max+0x38/0x41<br>&nbsp;[&lt;c01cdfa6&gt;] vscnprintf+0x14/0x22<br>&nbsp;[&lt;c0115ee7&gt;] printk+0x9b/0xab
<br>&nbsp;[&lt;c021e427&gt;] rthal_nmi_watchdog_tick+0x51/0x194<br>&nbsp;[&lt;c01046e5&gt;] do_nmi+0x75/0x296<br>&nbsp;[&lt;c010d42a&gt;] __ipipe_handle_irq+0x76/0x1c8<br>&nbsp;[&lt;c027887f&gt;] nmi_stack_correct+0x26/0x2b<br>&nbsp;[&lt;c0212746&gt;] i8042_panic_blink+0x46/0x135
<br>&nbsp;[&lt;c01ce319&gt;] delay_tsc+0x5/0x13<br>&nbsp;[&lt;c01154ab&gt;] panic+0x104/0x119<br>&nbsp;[&lt;c0212746&gt;] i8042_panic_blink+0x46/0x135<br>&nbsp;[&lt;c01188f9&gt;] do_exit+0x717/0x8d3<br>&nbsp;[&lt;c01cdfa6&gt;] vscnprintf+0x14/0x22
<br>&nbsp;[&lt;c0115ee7&gt;] printk+0x9b/0xab<br>&nbsp;[&lt;c0212746&gt;] i8042_panic_blink+0x46/0x135<br>&nbsp;[&lt;c0104fc6&gt;] die_nmi+0xe9/0xf0<br>&nbsp;[&lt;c0212746&gt;] i8042_panic_blink+0x46/0x135<br>&nbsp;[&lt;c021ded3&gt;] rthal_latency_above_max+0x38/0x41
<br>&nbsp;[&lt;c01cdfa6&gt;] vscnprintf+0x14/0x22<br>&nbsp;[&lt;c0115ee7&gt;] printk+0x9b/0xab<br>&nbsp;[&lt;c021e427&gt;] rthal_nmi_watchdog_tick+0x51/0x194<br>&nbsp;[&lt;c01046e5&gt;] do_nmi+0x75/0x296<br>&nbsp;[&lt;c010d42a&gt;] __ipipe_handle_irq+0x76/0x1c8
<br><br><div><span class="gmail_quote">2007/8/9, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Gilles Chanteperdrix wrote:<br>&gt; On 8/9/07, andy motten &lt;<a href="mailto:andy.motten@domain.hid">andy.motten@domain.hid</a>&gt; wrote:<br>&gt;&gt; There seems to be a difference between the 2 versions (Xenomai: POSIX:
<br>&gt;&gt; destroyed thread), Is this normal or part of the problem ?<br>&gt;<br>&gt; No, this is normal, this message is harmless, it only appears if you<br>&gt; select posix skin debugging.<br>&gt;<br>&gt;&gt; Is there a possibility that this is a bug in Xenomai or in the ipipe patch?
<br>&gt;&gt; Using the Xenomai 2.2.x branch is not an option since we need the RT can<br>&gt;&gt; drivers provided in the Xenomai 2.3.x branch.<br>&gt;<br>&gt; There is certainly a bug somewhere. Could you enable Linux debugs, its
<br>&gt; NMI watchdog (by adding nmi_watchdog=1 on the kernel command line), as<br>&gt; well as Xenomai debugs ? In order to find where the lock-up occurs.<br>&gt;<br><br>And have a look at linux/Documentation/serial-console.txt
 to capture the<br>&quot;last words&quot; (without having to take pictures of your monitor) in case<br>the lock-up remains hard even with debugging switches on.<br><br>Jan<br><br><br></blockquote></div><br>

------=_Part_159252_10168277.1186675789563--

------=_Part_159251_28903295.1186675789563
Content-Type: application/zip; 
	name=kernel-2.6.10.9-ipipe-1.8-08_gdb_latency_hardlockup.zip
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f55g2sj9
Content-Disposition: attachment; filename="kernel-2.6.10.9-ipipe-1.8-08_gdb_latency_hardlockup.zip"

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
------=_Part_159251_28903295.1186675789563--

