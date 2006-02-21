Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] Timer and calibration
Date: Tue, 21 Feb 2006 14:34:42 +0100
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E00430CE@EINT11.einet.ad.eivd.ch>
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210D26@domain.hid>
	<43FB003B.1090409@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi Philippe,

I perfectly got the point that the pipeline is already up and running =
when calibrate_delay() is called. On our ARM board, the pipeline seems =
to work perfectly. I however misunderstands something.

The ipipe configures the timer in one-shot mode when ipipe_init is =
called, right? (also according to what it is mentioned in the =
Adeos-enhanced configuration file of Linux). Tracing the kernel during =
the boot process showed us one timer IRQ only; this is coherent.

Is it correct that right after ipipe_init(), there is no realtime =
scheduler yet? The pipeline doesn't care about the schedule (it's the =
stuff of the Xenomai pod), and therefore, the pipline doesn't reprogram =
the timer by itself, right? - and it would be necessary to do that if =
the timer is in oneshot mode.

So, if calibrate_delay() -not used by Adeos/Xenomai, I agree - is doing =
a busy loop to evaluate the CPU performance, waiting for the next =
incoming timer IRQ, the system doesn't exit the loop and freezes. It =
actually works as long as the timer is in periodic mode.
It's actually the behaviour we observed on the ARM board with the ARM =
patch.=20

I probably missed something, please correct me.


Thanks again for your input.

Daniel


-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]
Sent: Tue 2/21/2006 12:57 PM
To: ROSSIER Daniel
Subject: Re: [Xenomai-core] Timer and calibration
=20
ROSSIER Daniel wrote:
> Hi Philippe,
>=20
> Great! Thx a lot for these precisions, it will help us.
>=20
> But regarding calibrate_delay(), it's still called in the normal boot =
process of Linux even with the Adeos/Xenomai patch.

Sure it is. The interrupt pipeline is up and running at this point =
(ipipe_init),=20
so there is no issue getting IRQs there.

  I've also seen that the boot process on a x86 architecture actually =
works since=20
the timer value is read directly from the

timer (calibrate_delay_direct() in init/calibrate.c) and this doesn't =
need to get=20
a timer IRQ. But without that,

and if calibrate_delay() is called instead of calibrate_delay_direct(), =
it fails.
>=20

It actually works in both cases. You do have the IRQ sub-system already=20
virtualized at that point. ipipe_init has engaged the pipeline, =
local_irq_enable()=20
right before the calibration delay unstalls the root domain, so the =
timer ticks=20
can flow through the pipeline, and they actually do (well, otherwise, =
you would=20
not have a single Adeos-enabled x86 box working since 2002 :o)

You can convince yourself by commenting out the local_irq_enable() =
statement=20
before the calibration is started: then your x86 box would completely =
stall.

> (Sorry for my previous mail; when I talked about timer calibration, it =
was delay calibration)
>=20
> Daniel
>=20
>=20
>=20
>>-----Message d'origine-----
>>De : Philippe Gerum [mailto:rpm@xenomai.org]
>>Envoy=E9 : mardi, 21. f=E9vrier 2006 12:41
>>=C0 : ROSSIER Daniel
>>Cc : xenomai@xenomai.org
>>Objet : Re: [Xenomai-core] Timer and calibration
>>
>>ROSSIER Daniel wrote:
>>
>>>Hello,
>>>
>>>
>>>
>>>We are currently porting Adeos/Xenomai with Linux 2.6.14 on a =
ARM9-based
>>>Freescale i.mx21 (litekit) development board.
>>>
>>>We started from the available patch for the ARM-based Integrator =
board.
>>>
>>>
>>>
>>>We are now facing some interesting problems regarding clock/timer
>>>frequencies with this board, but they are about to be solved J
>>>
>>>
>>>
>>>However, we have a question of understanding; as far as we know, =
ipipe
>>>starts with an aperiodic (one-shot) timer at the initialization time,
>>>and that before
>>>
>>>the calibrate function has been called. So, we get one interrupt only
>>>since the xenomai scheduler has not been registered (we understand
>>>
>>>that the xenomai scheduler should give the next timer shot, but since =
it
>>>is not registered yet, no timer reprogramming is achieved).
>>>
>>>
>>>
>>>So, how can the calibrate function can be invoked safely if no timer =
IRQ
>>>is received since this kind of calibration comes before the xenomai
>>>registration
>>>
>>>(the calibrate function needs IRQ timers to calibrate the number of =
busy
>>>loops between two jiffies) ?
>>>
>>
>>Unlike Linux's calibrate_delay loop, Xenomai's timer calibration code =
does
>>not
>>measure the CPU performance level, but only the average cost of
>>programming the
>>underlying timer hw in oneshot mode (time-wise), so that the nucleus =
can
>>take this
>>unavoidable delay into account when programming the next shot.
>>
>>Nowadays, this is basically an x86+8254 PIT only issue, since on this
>>platform,
>>one has to go through the ISA bus to (re)program the PIT for the next
>>timer shot,
>>and this is quite expensive (1.5 - 2.5 us for each outb, and you need =
two
>>of them
>>for programming the shot). Btw, this is the reason why using the APIC =
when
>>available on x86 is always a good idea, since it only costs ~100 ns to
>>program the
>>timer there through a memory mapped register.
>>
>>IOW, the code does not wait for any timer IRQ, but only measures the
>>average time
>>for setting up the proper hw registers in order to program a timer =
shot.
>>
>>
>>>
>>>How is it realized with a x86 architecture (another timer source?)
>>>
>>
>>Look at ksrc/arch/*/hal.c, where all archs implement
>>rthal_timer_calibrate() their
>>own way.
>>
>>
>>>
>>>Is there any documentation - or discussion threads - which gives some
>>>information about the use of timers/RTC/TSC with Xenomai?
>>>
>>
>>Maybe. Try browsing the archive.
>>
>>
>>>
>>>Thanks so much for your help
>>>
>>>
>>>
>>>Kind regards
>>>
>>>
>>>
>>>Daniel Rossier
>>>
>>>
>>>----------------------------------------------------------------------=
--
>>>
>>>_______________________________________________
>>>Xenomai-core mailing list
>>>Xenomai-core@domain.hid
>>>https://mail.gna.org/listinfo/xenomai-core
>>
>>
>>--
>>
>>Philippe.


--=20

Philippe.


