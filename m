Message-ID: <2F8EE677D406514ABE53EF9C0934A666017CAFF1@domain.hid>
From: Dominique.RAGOT@fr.thalesgroup.com
Subject: RE: [Xenomai-help] RTDM interrupt programming practice
Date: Tue, 3 Jan 2006 17:22:37 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeroen.VandenKeybus@domain.hid
Cc: xenomai@xenomai.org

Hello,

I can answer only to item 2.

Measurements were made on bi-Xeon PCs for SMP and SMP+SMT =
configurations, using kernel 2.6.13 and Xenomai 2.0. It showed that SMT =
has a negative impact on latency benchmark figures. Disabling SMT and =
keeping SMP brought latency figures back to nominal performance.

Hope this can help.

----------
Dominique RAGOT

> -----Message d'origine-----
> De : xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid la part de Philippe Gerum
> Envoy=E9 : mardi 3 janvier 2006 10:27
> =C0 : vdkeybus
> Cc : xenomai@xenomai.org
> Objet : Re: [Xenomai-help] RTDM interrupt programming practice
>=20
>=20
> vdkeybus wrote:
> > Ok. I've applied the patches (kernel is now also 2.6.14-5).
> >=20
> > 1. I've also upgraded the kernel from 2.6.14 to 2.6.14-5, because=20
> > Xenomai's make ...config was complaining about not finding=20
> > CONFIG_IPIPE_EXTENDED after application of Adeos patch 1.1-00 to=20
> > a 'vanilla' 2.6.14-5 Linux kernel. Eventually I added the=20
> CONFIG line=20
> > myself, but I'm now consequently working with a newer=20
> kernel than the=20
> > one in my previous report.
>=20
> Which is wrong. Xeno 2.0.x is not expected to work with the Adeos 1.1 =

> series. The fact that it still does with -00 is pure luck,=20
> and won't be=20
> true anymore with the next 1.1 releases. You should stick with the=20
> patches available from arch/i386/patches which have been validated=20
> against the Xeno version that ships them, at least until you have a=20
> working configuration. I know that the tracer is a very=20
> desirable tool,=20
> but the workforce is not infinite here, and backporting every=20
> significant improvement to each Xenomai version on every=20
> platform is not=20
> possible.
>=20
> >=20
> > 2. While compiling kernels (I'm still far from enjoying this=20
> > activity...), I accidentally turned back on SMP (2 CPUs) with=20
> > multithreading (SMT). Everything worked fine (as opposed to=20
> my first=20
> > 2.6.14 SMP venture some weeks ago, which gave tons of=20
> smp_processor_id
> > () bugwarnings and forced me to turn of SMP), but I was=20
> getting massive=20
> > delays with ./latency (about 20 times normal values with lots of=20
> > overruns). I turned SMP+SMT back off, and all values are=20
> normal again.=20
> > Is this a known issue ? Or should I just not try to push things...
> >=20
>=20
> It's hard to answer this until you explain which things you=20
> are trying=20
> to push... Xeno version? Adeos patch version? Kind of hw?
>=20
> > 3. Three things concerning interrupt programming:
> >=20
> > 3a - I _did_ disable the card's interrupt lines, but I _forgot_ to=20
> > enable interrupts with rtdm_irq_enable(). Nevertheless, I=20
> still _got_=20
> > the interrupts, until I placed the PCI card in a slot=20
> without interrupt=20
> > sharing. BTW the return value of the rtdm_irq_request() and=20
> > rtdm_irq_free() funtions was 0.
> >=20
>=20
> Linux was likely re-enabling the channel after the interrupt hit its=20
> pipeline stage.
>=20
> > 3b - Is it ok to return from the ISR with RTDM_IRQ_ENABLE if the=20
> > interrupt is for the card and to return with=20
> RTDM_IRQ_PROPAGATE if it=20
> > is not ?
>=20
> If Linux is not expected to care for the interrupt, yes.
>=20
>   Should I logically OR them together ?
> >=20
>=20
> You would relay interrupts Linux does not care for uselessly.
>=20
> > 3c - ipipe_trace() indeed seems to be a very powerful tool=20
> for finding=20
> > out the source of excessive latencies. Thanks for pointing it out.
> >=20
> > 4. What is the test one has to perform to 'load' a Linux=20
> machine and=20
> > verify proper operation of Xenomai ?
>=20
> Resilience to cache trashing is a significant aspect; running the=20
> latency test + dd loop + some compilation in the background would be=20
> meaningful.
>=20
>   I've tried running 'latency' while
> > my RT program is running, but it causes a missed deadline in my RT=20
> > program and latency won't run.
> >=20
>=20
> Did you look at the the code in latency.c? What it does very likely=20
> conflicts with what your program does wrt configuration and deadlines =

> (timer setup, task priorities...).
>=20
> > 5. While X is running, the computer becomes very sluggish during=20
> > execution of an RT-program. I'm getting processing times of=20
> around 30=20
> > us between interrupt generation and PCI register updates and a=20
> > repetition rate of 100 us (all measured with a hardware=20
> timer on the=20
> > PCI board). I'm wondering what could be the reason for this=20
> > disproportional degradation of the user interface (it=20
> certainly doesn't=20
> > seem the computer is only 30 % slower. Rather, it feels=20
> like 95 % and=20
> > bringing up e.g. Firefox takes more than 30 s.).
> >
>=20
> X acceleration often leads to surprising results, since=20
> nowadays graphic=20
> cards are not that RT friendly when they "optimize" things.
>=20
> >=20
> >>>Hmm, is that IRQ line shared with non-RT hardware BTW? This is
> >>
> >>typically
> >>
> >>>a no-go for hard-RT scenarios. Already tried to disable that sound
> >>>interface (e.g. in the BIOS if on-chip)?
> >=20
> >=20
> > It was. And in fact, it still is, because if I removed the sound in =

> > BIOS, it got replaced by USB. Touch the mouse in RT and...
> >=20
> >=20
> >>>>4. How can I verify the status of running xenomai processes (and
> >>
> >>the=20
> >>
> >>>>driver). I would like to find out why I'm not meeting my =
interrupt
> >>>>deadlines.
> >>>
> >>$ cat /proc/xenomai/sched
> >>$ cat /proc/xenomai/stat
> >=20
>=20
> Stats requires the proper option to be selected in the Nucleus menu.
>=20
> >=20
> > I could not find stat. (Xenomai 2.0.2) But sched also shows=20
> the status.=20
> > I found the symbol explanations in thread.h.
> >=20
> > Anyway, the system is now working at interrupt rates=20
> between 4,000 and=20
> > 20,000 per second. There is still an occasional overrun,=20
> which I'll try=20
> > to trace with my new toy (ipipe_trace).
> >=20
> > Thanks for all your help,
> >=20
> >=20
> > Jeroen.
> >=20
> > Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm
> >=20
> >=20
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> >=20
>=20
>=20
> --=20
>=20
> Philippe.
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20

