Subject: Re: [Xenomai-help] Linux + PREEMPT_RT + LTTng + Xenomai
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200609111418.25324.Serge.Noiraud@domain.hid>
References: <200609071445.53611.Serge.Noiraud@domain.hid>
	<4500182A.6000009@domain.hid> <200609111418.25324.Serge.Noiraud@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 11 Sep 2006 15:30:19 +0200
Message-Id: <1157981420.4934.78.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
To: Serge Noiraud <serge.noiraud@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-09-11 at 14:18 +0200, Serge Noiraud wrote:
> Hi evrybody,
>=20
>    I send this message last week and I had no response. I don't see it =
in the archives, so I repost it.
>=20
> jeudi 7 Septembre 2006 15:01, Jan Kiszka wrote/a =E9crit :
> > Serge Noiraud wrote:
> > > Hi, everybody
> > >=20
> > > 	I'm new to this list and I have several questions :
> > >=20
> > > I currently use linux 2.6.16 + rt from Ingo Molnar + LTTng on IA32 =
architecture.
> > >=20
> > > I would like to know how difficult will be the job to add Xenomai o=
ver this.
> > > Perhaps this is already in your roadmap ?
> >=20
> > It is, see yesterday's thread on this:
> > https://mail.gna.org/public/xenomai-help/2006-09/msg00029.html
> >=20
> > LTTng will likely be supported far earlier. The nucleus is prepared f=
or
> > it for quite a while, we are currently just lacking a recent LTT+Ipip=
e
> > combo patch. But this task is scheduled to start soon. See also this
> > list's archive or xenomai-core on related discussions.
> >=20
> > > Do we need to wait for a main line inclusion of the RT patch ?
> > >=20
> >=20
> > Not necessarily, though this would simplify things.
> >=20
> > However, any helping hand or mind can accelerate the process. So,
> > contributions are welcome. What application scenario do you have in m=
ind?
> I take my machines on the shelves for economic strategy ! So they are c=
ertainly *NOT* realtime aware !
> I think my RT knowledges aren't sufficient to help you in development, =
but I can be a tester if you want. Plus if I can.
>=20
> I would like Xenomai manage IRQs for some specific cards.
> The others could be managed by linux-rt.
> If I understand correctly how it works, I must rewrite my drivers. is i=
t correct ?
>=20
> I currently get 50-60us latencies. This is not sufficient for me. I wou=
ld like to down to 10-15us for these cards.
> and I have one latency every three days about 9000us ( BIOS or hardware=
 problem ? ).

For the 9ms spot, this might be something already listed in our
TROUBLESHOOTING file in the ia32 section, regarding the kernel config /
SMI sources. Most of the hints found there are applicable to any
x86-based hw, whether it runs a co-kernel or native preemption.

> So I hope Xenomai could be the solution.
>=20
> Am I in the good way ?

If you cannot get better than 50 us with native preemption on your hw,
yes, it seems so.

As part of the Xenomai 3 effort, we have already planned to port our
real-time nucleus over PREEMPT_RT without Adeos; in this mode, it would
fully rely on the level of predictability native preemption gives, which
would not help you that much for the issue you are facing, if I
understand correctly. Xenomai would of course still be able to run as a
co-kernel, but not in a PREEMPT_RT environment, only over a vanilla
kernel like today.

What you would need is a PREEMPT_RT+Adeos combo, on top of which Xenomai
would run, still using the Adeos layer for getting stringent real-time
guarantees. The good news is that we already prototyped a port of this
kind a year ago, and it worked (e.g. you can still find some checks for
CONFIG_PREEMPT_RT in the Xenomai codebase, which dates back to this
attempt). The bad news is that the native preemption patch we used was
fairly ancient, and was not stepping that much on Adeos toes at that
time. In contrast, recent PREEMPT_RT patches do step on Adeos's toes, in
significant areas.

This means that an hybridization between PREEMPT_RT and Adeos is needed
anew, but using a different approach than a mere side-by-side
integration which would not fly anymore. Whether this combo should exist
before or after PREEMPT_RT has been merged into mainline is another
issue to solve, and likely depends on how fast the dust settles over the
native preemption code.

--=20
Philippe.



