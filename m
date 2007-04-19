From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <88AEA5AC18A141439A0D954EB037B0D30439F5BC@ERLD164A.ww004.siemens.net>
References: <88AEA5AC18A141439A0D954EB037B0D30439F5BC@ERLD164A.ww004.siemens.net>
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 19 Apr 2007 20:13:58 +0200
Message-Id: <1177006438.8053.57.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Ipipe and Siemens A&D Realtime
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Krause, Karl-Heinz" <karl-heinz.krause@domain.hid>
Cc: jan.kiszka@domain.hid, xenomai@xenomai.org

On Thu, 2007-04-19 at 18:09 +0200, Krause, Karl-Heinz wrote:
> Yes, it contains the full A&D RT Kernel.

There seems to be lot of work there. I had a look at this patch, and
basically, it looks like an effort to create an integrated POSIX
co-kernel that does not look like a co-kernel anymore, while still
exhibiting rt and non-rt domain separation though.  This seems to have
required adding new real-time support in vanilla code, and ironing other
parts of the original code in order to allow mixed uses between both
domains (hence the glibc patching too).

>=20
> If it were only the path to ISR entry, there is not much difference to th=
e wired optimization (the main difference is a stripped down ack-Routine).

Perhaps a bit too much stripped down; I see you don't handle the per-IRQ
locking bit anymore, which means that RT drivers are not allowed to
solely rely on the PIC to mask interrupts without going for
local_irq_disable(). This said, only vanilla Linux drivers might rely on
this trick, so this is ok in the fast mode approach, I guess.

>  The=20
> problem we saw with the wired-optimzation is, that -- if we want an inter=
rupt dedicated exclusively to the RT domain -- it doesn't provide for a fin=
al ack-Routine.

It does since genirq is supported by the I-pipe; it's the ipipe_end
handler from the irq descriptor.

>  We always have to take the entire round trip.

It's due to the way this co-kernel is layered, but that's not a
requirement. For instance, Xenomai ISRs are in charge of ending the
interrupt by calling the ipipe_end hook for the processed IRQ channel;
this is no different than ending it upon return from your ISR to
__ipipe_handle_irq, except that the vanilla I-pipe never overrides any
decision the RTOS ISR could make regarding PIC manipulation.

> If you look at the comment for the fast handle_irq, you will see what we =
had in  mind.=20
> For the other part --the system call entry/exit -- we simply put it under=
 the same optimization decision, but  I guess we can separate it.
>=20

I recall we once discussed about the SYSCALL_EXIT event, but did not
catch the idea behind this requirement, i.e. forcing a relaxed thread
back to the real-time domain after a syscall. Is there any reason why
you don't want the lazy scheme to be used, i.e. migrate to whatever
domain may process any given syscall upon entry, run the handler, then
leave the caller running in the current domain until the next syscall
occurs?

> The fpu stuff has two parts, first we borrowed somewhat from the 2.6.20 s=
olution to avoid restore on exception, but had to disable the "256-exceptio=
n". Second we hacked meaning we replaced the preempt_disable/enable in the =
three low level routines in i387.h, by local interrupt disable/enable. Ther=
e may be a way around, but since we call the same __switch_to() routine, we=
 had to avoid running into preempt_disable/enable.
>=20
> Can understand, when I said I don't expect big surprises, then I assumed =
be based on an existing ipipe-patch. Yes HRT timers are a problem but doesn=
't cause us to much of a headache right now, since we are required to suppo=
rt only features available on all architectures.
>=20

Generally speaking, this code has to know about a lot of kernel innards
through. I understand this is due to the effort to integrate this
co-kernel into the vanilla one, so that it does not look like a separate
extension anymore.

> This leads to the last point. No we haven't running RT on ARM and MIPS ye=
t.
> The main work so far was to have common base for the tool chain and the g=
libc. And having a working solution for TLS on ARM without MMU caused us so=
me trouble. But now we are through and I expect having RT on ARM very soon.=
 MIPS is scheduled for the third quarter.
>=20

How much much would it require to be able to run more than a single RT
process? Is this only related to the RT futex support, or are there
other issues to solve?

> As for the test suite, let me defer it to tomorrow.
>=20

> Karl-Heinz
>=20
>=20
>=20
>=20
> -----Urspr=FCngliche Nachricht-----
> Von: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]=20
> Gesendet: Donnerstag, 19. April 2007 14:40
> An: Krause, Karl-Heinz
> Cc: xenomai@xenomai.org
> Betreff: Re: AW: [Xenomai-core] Ipipe and Siemens A&D Realtime
>=20
> Krause, Karl-Heinz wrote:
> > Hi Jan
> >=20
> > Sorry for attaching the wrong patch. Here is the right one.
>=20
> Thanks. Am I right, it also contains the full A&D RT-kernel?
>=20
> > From all the ipipe patches/hooks we use only a few one.
> > The ipipe changes we did fall into two categories
> > - one additional hook in entry.s which checks at system call exit wheth=
er =20
> >   the thread has to migrate to the realtime domain
> > - optimizations for a dual domain system concerning the dispatching of =

> >   events and interrupt handling.
>=20
> The latter makes me wonder if you already analysed the "wired" top-most
> domain optimisation in recent I-pipe and compared it to your approach.
>=20
> > So if just that kind of dual domain system is of interest, the patches =
may be of general interest and we are willing to support it. =20
> > To allow for a possible integration we made it configurable as follows
> > [ ] interrupt pipeline
> > [ ]   rtx domain system
> > [ ]     fast rtx dual domain system
>=20
> A wired ipipe domain is known to stay the top-most one in the pipeline,
> but this optimisation still allows multiple lower domains, not just Linux.
>=20
> Maybe it is worth looking at the I-pipe abstractions again with the
> hard-wired scenario "dual domain system" in mind, checking for further
> optimisation possibilities that do not kill the common model and its
> clean realisation. Optimisations are not bad, but they also have to be
> balanced against potentially increased porting effort for other archs.
>=20
> >=20
> > Common for both is the check for preemption which we have in the optimi=
zed handle_irq routine as well as in sync_stage.
> >=20
> > More generic are the patches we made for the POSIX message queues and f=
or saving/restoring the fpu context
>=20
> IIRC, sanitising xxx_fpu services in order to make them domain-agnostic
> without hacking preempt_enable/disable is something of generic interest
> for ipipe as well (Or are you patching fpu services for another
> reason?). I recall to stumble over this on my own when trying
> to detect invalid calls of Linux services from non-root domains
> automatically.
>=20
> >=20
> > We are not specifically locked to 2.6.15.4 and we don't expect any surp=
rises if we would upgrade.
>=20
> Hmm, I wouldn't be surprised if things like genirq or upcoming
> clockevent/hrtimers _will_ cause a few surprises. The latter is actually
> also a to-do for vanilla ipipe in order to move to 2.6.21 and beyond.
>=20
> > (Of course we know that  we have to do some additions to hook into PI m=
utexes, despite the fact that for priority changes itself the domain bounda=
ry is already transparent). It is only caused by our general policy to keep=
 the number of different versions minimal, since we cannot simply forget ol=
der versions, we have to maintain it.(It is not only  a kernel for x86, it =
is for ARM with and without MMU and for MIPS as well and it is the complete=
 tool chain). So we always will do some skipping and we haven't decided yet=
 what our next version will be.
>=20
> Does your RT-kernel run on ARM and MIPS as well already? Did you port
> ipipe (or a subset) to MIPS?
>=20
> >=20
> > Concerning testing we took mainly the existing POSIX test suites which =
we
> > had to make suitable for static priorities > 0. We added a few tests fo=
r checking the transparency of the domain boundary for POSIX message queues=
, futexes and priority changes and we combined them with performance measur=
ement that is all.
>=20
> Those changes may be of some interest for POSIX testing with Xenomai as
> well, that's why I was asking for a complete, instrumented testsuite. If
> you could share it with the community, that would be great.
>=20
> >=20
> > Just let me know what else you need.
> >=20
> >=20
> > Karl-Heinz
> >=20
>=20
> Thanks for making your code available. I think both sides can benefit
> from discussing new approaches based on public code.
>=20
> Jan
>=20
>=20
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
--=20
Philippe.



