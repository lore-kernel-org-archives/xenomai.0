Message-ID: <47EA9022.7010504@domain.hid>
Date: Wed, 26 Mar 2008 19:04:18 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20080325224919.582BD243A7@domain.hid>	<47EA14F7.7040004@domain.hid>
	<47EA4F65.7050600@domain.hid>
In-Reply-To: <47EA4F65.7050600@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Xenomai/SOLO - RTOS emulation for standard Linux
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
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

Steven A. Falco wrote:
> I'll of course have to make my own tests, but I am curious - do folks
> expect that Xenomai/SOLO will be able to equal the interrupt performance
> of Xenomai/IPIPE?  I guess my intuition says that the IPIPE approach
> would guarantee better interrupt response, but maybe my intuition is
> completely wrong.  I'll try to post some results in a few weeks...
>

SOLO is not about pretending that native preemption should now be the one a=
nd
only solution to real-time requirements. The point is that there are differ=
ent
levels of real-time requirements, different real-time applications, differe=
nt
real-time environments. Since I just don't believe in the one-fits-it-all
marketro=EFd message, SOLO is there to bring the Xenomai emulators to the n=
ative
preemption world, because a significant portion of the application base to =
be
migrated to Linux will be just fine in that environment.

FWIW, I like the co-kernel approach for the principle of least surprise it
brings with respect to latency; if the latency tests run fine, it is extrem=
ely
likely that deadlines will always be met within the application, provided t=
he
latter behaves properly, even if you upgrade your target kernel. But on the
other hand, I like the native preemption as well, for its ability to keep t=
hings
reasonably simple when it comes to port large legacy applications, which us=
ed to
rely on zillions of libraries; in that case, the necessary co-kernel/Linux
programming model split is just a massive pain in the neck (i.e. primary &
secondary runtime modes, restriction on using the glibc in real-time mode a=
nd so
on).

But obviously, the co-kernel mode based on the I-pipe is here to stay, and =
the
purpose of Xenomai 3 is to allow the emulators to be usable on top of both
real-time cores (i.e. PREEMPT_RT, or I-pipe + nucleus), using a simple
recompilation. SOLO is an intermediate step, before both approaches are
reconciled with a common emulator code base in Xenomai 3. In other words: t=
wo
real-time cores, one set of emulators. Well, that's the plan.

I will send a roadmap to Xenomai 3 asap (take this literally, because of he=
ctic
schedule here), to explain where we are heading to.

>     Steve Falco
>=20
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>=20


--=20
Philippe.

