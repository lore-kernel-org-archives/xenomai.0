Message-ID: <4627631B.9080405@domain.hid>
Date: Thu, 19 Apr 2007 14:39:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <88AEA5AC18A141439A0D954EB037B0D30439F5B8@domain.hid>
In-Reply-To: <88AEA5AC18A141439A0D954EB037B0D30439F5B8@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4C088001F041A37350428171"
Sender: jan.kiszka@domain.hid
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
To: "Krause, Karl-Heinz" <karl-heinz.krause@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4C088001F041A37350428171
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Krause, Karl-Heinz wrote:
> Hi Jan
>=20
> Sorry for attaching the wrong patch. Here is the right one.

Thanks. Am I right, it also contains the full A&D RT-kernel?

> From all the ipipe patches/hooks we use only a few one.
> The ipipe changes we did fall into two categories
> - one additional hook in entry.s which checks at system call exit wheth=
er =20
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
but this optimisation still allows multiple lower domains, not just Linux=
=2E

Maybe it is worth looking at the I-pipe abstractions again with the
hard-wired scenario "dual domain system" in mind, checking for further
optimisation possibilities that do not kill the common model and its
clean realisation. Optimisations are not bad, but they also have to be
balanced against potentially increased porting effort for other archs.

>=20
> Common for both is the check for preemption which we have in the optimi=
zed handle_irq routine as well as in sync_stage.
>=20
> More generic are the patches we made for the POSIX message queues and f=
or saving/restoring the fpu context

IIRC, sanitising xxx_fpu services in order to make them domain-agnostic
without hacking preempt_enable/disable is something of generic interest
for ipipe as well (Or are you patching fpu services for another
reason?). I recall to stumble over this on my own when trying
to detect invalid calls of Linux services from non-root domains
automatically.

>=20
> We are not specifically locked to 2.6.15.4 and we don't expect any surp=
rises if we would upgrade.

Hmm, I wouldn't be surprised if things like genirq or upcoming
clockevent/hrtimers _will_ cause a few surprises. The latter is actually
also a to-do for vanilla ipipe in order to move to 2.6.21 and beyond.

> (Of course we know that  we have to do some additions to hook into PI m=
utexes, despite the fact that for priority changes itself the domain boun=
dary is already transparent). It is only caused by our general policy to =
keep the number of different versions minimal, since we cannot simply for=
get older versions, we have to maintain it.(It is not only  a kernel for =
x86, it is for ARM with and without MMU and for MIPS as well and it is th=
e complete tool chain). So we always will do some skipping and we haven't=
 decided yet what our next version will be.

Does your RT-kernel run on ARM and MIPS as well already? Did you port
ipipe (or a subset) to MIPS?

>=20
> Concerning testing we took mainly the existing POSIX test suites which =
we
> had to make suitable for static priorities > 0. We added a few tests fo=
r checking the transparency of the domain boundary for POSIX message queu=
es, futexes and priority changes and we combined them with performance me=
asurement that is all.

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



--------------enig4C088001F041A37350428171
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGJ2MbniDOoMHTA+kRAuM0AJ4vMhZQHg5jAIflSKf+ItnKWZefJwCfWA9Q
stWIoEXQivhlWgg2ZeAnF6s=
=Cx1Y
-----END PGP SIGNATURE-----

--------------enig4C088001F041A37350428171--

