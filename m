Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Apr 2007 18:09:09 +0200
Message-ID: <88AEA5AC18A141439A0D954EB037B0D30439F5BC@ERLD164A.ww004.siemens.net>
In-reply-to: <4627631B.9080405@domain.hid>
From: "Krause, Karl-Heinz" <karl-heinz.krause@domain.hid>
Subject: Re: [Xenomai-core] Ipipe and Siemens A&D Realtime
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Yes, it contains the full A&D RT Kernel.

If it were only the path to ISR entry, there is not much difference to =
the wired optimization (the main difference is a stripped down =
ack-Routine). The=20
problem we saw with the wired-optimzation is, that -- if we want an =
interrupt dedicated exclusively to the RT domain -- it doesn't provide =
for a final ack-Routine. We always have to take the entire round trip.
If you look at the comment for the fast handle_irq, you will see what we =
had in  mind.=20
For the other part --the system call entry/exit -- we simply put it =
under the same optimization decision, but  I guess we can separate it.

The fpu stuff has two parts, first we borrowed somewhat from the 2.6.20 =
solution to avoid restore on exception, but had to disable the =
"256-exception". Second we hacked meaning we replaced the =
preempt_disable/enable in the three low level routines in i387.h, by =
local interrupt disable/enable. There may be a way around, but since we =
call the same __switch_to() routine, we had to avoid running into =
preempt_disable/enable.

Can understand, when I said I don't expect big surprises, then I assumed =
be based on an existing ipipe-patch. Yes HRT timers are a problem but =
doesn't cause us to much of a headache right now, since we are required =
to support only features available on all architectures.

This leads to the last point. No we haven't running RT on ARM and MIPS =
yet.
The main work so far was to have common base for the tool chain and the =
glibc. And having a working solution for TLS on ARM without MMU caused =
us some trouble. But now we are through and I expect having RT on ARM =
very soon. MIPS is scheduled for the third quarter.

As for the test suite, let me defer it to tomorrow.

Karl-Heinz




-----Urspr=FCngliche Nachricht-----
Von: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
Gesendet: Donnerstag, 19. April 2007 14:40
An: Krause, Karl-Heinz
Cc: xenomai@xenomai.org
Betreff: Re: AW: [Xenomai-core] Ipipe and Siemens A&D Realtime

Krause, Karl-Heinz wrote:
> Hi Jan
>=20
> Sorry for attaching the wrong patch. Here is the right one.

Thanks. Am I right, it also contains the full A&D RT-kernel?

> From all the ipipe patches/hooks we use only a few one.
> The ipipe changes we did fall into two categories
> - one additional hook in entry.s which checks at system call exit =
whether =20
>   the thread has to migrate to the realtime domain
> - optimizations for a dual domain system concerning the dispatching of =

>   events and interrupt handling.

The latter makes me wonder if you already analysed the "wired" top-most
domain optimisation in recent I-pipe and compared it to your approach.

> So if just that kind of dual domain system is of interest, the patches =
may be of general interest and we are willing to support it. =20
> To allow for a possible integration we made it configurable as follows
> [ ] interrupt pipeline
> [ ]   rtx domain system
> [ ]     fast rtx dual domain system

A wired ipipe domain is known to stay the top-most one in the pipeline,
but this optimisation still allows multiple lower domains, not just =
Linux.

Maybe it is worth looking at the I-pipe abstractions again with the
hard-wired scenario "dual domain system" in mind, checking for further
optimisation possibilities that do not kill the common model and its
clean realisation. Optimisations are not bad, but they also have to be
balanced against potentially increased porting effort for other archs.

>=20
> Common for both is the check for preemption which we have in the =
optimized handle_irq routine as well as in sync_stage.
>=20
> More generic are the patches we made for the POSIX message queues and =
for saving/restoring the fpu context

IIRC, sanitising xxx_fpu services in order to make them domain-agnostic
without hacking preempt_enable/disable is something of generic interest
for ipipe as well (Or are you patching fpu services for another
reason?). I recall to stumble over this on my own when trying
to detect invalid calls of Linux services from non-root domains
automatically.

>=20
> We are not specifically locked to 2.6.15.4 and we don't expect any =
surprises if we would upgrade.

Hmm, I wouldn't be surprised if things like genirq or upcoming
clockevent/hrtimers _will_ cause a few surprises. The latter is actually
also a to-do for vanilla ipipe in order to move to 2.6.21 and beyond.

> (Of course we know that  we have to do some additions to hook into PI =
mutexes, despite the fact that for priority changes itself the domain =
boundary is already transparent). It is only caused by our general =
policy to keep the number of different versions minimal, since we cannot =
simply forget older versions, we have to maintain it.(It is not only  a =
kernel for x86, it is for ARM with and without MMU and for MIPS as well =
and it is the complete tool chain). So we always will do some skipping =
and we haven't decided yet what our next version will be.

Does your RT-kernel run on ARM and MIPS as well already? Did you port
ipipe (or a subset) to MIPS?

>=20
> Concerning testing we took mainly the existing POSIX test suites which =
we
> had to make suitable for static priorities > 0. We added a few tests =
for checking the transparency of the domain boundary for POSIX message =
queues, futexes and priority changes and we combined them with =
performance measurement that is all.

Those changes may be of some interest for POSIX testing with Xenomai as
well, that's why I was asking for a complete, instrumented testsuite. If
you could share it with the community, that would be great.

>=20
> Just let me know what else you need.
>=20
>=20
> Karl-Heinz
>=20

Thanks for making your code available. I think both sides can benefit
from discussing new approaches based on public code.

Jan



