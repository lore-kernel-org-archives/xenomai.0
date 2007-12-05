Message-ID: <47569787.6060906@domain.hid>
Date: Wed, 05 Dec 2007 13:20:23 +0100
From: "=?UTF-8?B?UGV0ZXIgU2NodWXCn2xsZXI=?="
	<peter.schueller@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
References: <474D8B34.8080502@domain.hid>
	<474D9B1C.7060003@domain.hid>
In-Reply-To: <474D9B1C.7060003@domain.hid>
Subject: Re: [Xenomai-core] ipipe_suspend_domain() not scheduling IRQ threads
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org


Philippe Gerum wrote:
> A common issue causing lockups is having the CPU being stormed by a
> level triggered interrupt which does not get masked and processed
> properly. IRQ threading may add a certain amount of confusion to this,
> since  it may have an impact on the order your IRQ threads must be
> scheduled to avoid this situation. Think of the situation with a GPIO
> demultiplexing IRQ for instance, where you want all multiplexed IRQ
> threads to run before the demultiplexer ISR runs and unmasks the
> interrupt source.
>=20
> Even without the threading issue, the interrupt storm issue is quite
> frequent during the initial stage of porting the I-pipe; it usually
> happens because the assumption that the IRQ handler would be called
> shortly after the interrupt is taken becomes wrong with the I-pipe. As =
a
> matter of fact, pipelining interrupts means that they may be delayed fo=
r
> some time, before the Linux device driver is called and actually remove=
s
> the interrupt condition at hw level (think of a real-time activity
> preempting the CPU, while some device hammers the CPU with interrupts
> because Linux does not seem to care fast enough). This is why most - if=

> not all interrupts - should be masked+acked at receipt (see ipipe_ack)
> then unmasked after handler completion, when the I-pipe is enabled.

Oh yes I already had such interrupt storms, I now use the "level" interru=
pt handler as blackfin
does. Because the IRQ ack process is very IRQ source specific, the IRQ is=
masked as long as it is
not allowed to be served and unmasked after the real ISR has run (the ISR=
has to do the ack).

>> I think the problem is that the IRQ threads do not get scheduled and s=
o cannot handle the
>> Interrupts, although they have been "kicked" by __ipipe_run_isr.
>=20
> Are you sure you need to thread the Linux ISRs on your target
> architecture? This is a Blackfin-specific implementation of the I-pipe,=

> which addresses some arch-dependent peculiarities on this CPU. I suspec=
t
> you may not need this at all, which would greatly simplify the issue.

Thanks for this hint, actually after removing the IRQ threads the interru=
pts of the Linux domain get
served whenever the higher-priority Test domain suspends itself.

But even though the Test domain suspends itself the Linux domain never ru=
ns. Do I need
to check for TIF_NEED_RESCHED (like after a syscall) after executing an I=
SR via ipipe?

Or as a more general question: Where should the switch from one domain to=
 another domain be done=20
when one domain suspends itself?

> Which arch are we talking about?

Unfortunately Theobroma Systems is not yet allowed to disclose (under NDA=
) the architecture but this=20
will soon be the case and the whole Code will be publicly available under=
 the GPL license.

Best regards,

Peter

--=20

Peter Sch=C3=BCller
Theobroma Systems Design und Consulting GmbH
Gutheil-Schoder-Gasse 17, A-1230 Vienna, Austria
Phone: +43 (1) 2369893-403, Fax: +43 (1) 2369893-9-403
http://www.theobroma-systems.com




