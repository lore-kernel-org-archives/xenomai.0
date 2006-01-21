Message-ID: <43D26907.8020900@domain.hid>
Date: Sat, 21 Jan 2006 18:01:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
References: <43D21144.8040005@domain.hid> <43D265A8.1020407@domain.hid>
In-Reply-To: <43D265A8.1020407@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8D83AD26870BB755D942FC93"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8D83AD26870BB755D942FC93
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hannes Mayer wrote:
> Jan Kiszka wrote:
> [...]
>> PS: Out of curiosity I also checked RTAI's migration mechanism in this=

>> regard. It's similar except for the fact that it does the gatekeeper's=

>> work in the Linux scheduler's tail (i.e. after the next context switch=
).
>> And RTAI seems it suffers from the very same race. So this is either a=

>> fundamental issue - or I'm fundamentally wrong.
>=20
>=20
> Well, most of the stuff you guys talk about in this thread is still
> beyond my level, but out of curiosity I ported the SEM example to
> RTAI (see attached sem.c)
> I couldn't come up with something similar to rt_sem_inquire and
> rt_task_inquire in RTAI (in "void output(char c)")...
> Anyway, unless I haven't missed something else important while
> porting, the example runs flawlessly on RTAI 3.3test3 (kernel 2.6.15).
>=20

My claim on the RTAI race is based on quick code analysis and a bit
outdated information about its core design. I haven't tried any code to
crash it, and I guess it will take a slightly different test design to
trigger the issue there. As soon as someone could follow my reasoning
and confirm it (don't mind that you did not understand it, I hadn't
either two days ago, this is quite heavy stuff), I will inform Paolo
about this potential problem.

Jan


--------------enig8D83AD26870BB755D942FC93
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD0mkMniDOoMHTA+kRAucWAJ46GgvhqjbGtygixLDnsUM++8fHZgCePOjh
LPeV4o1z+bxtoOUztZK7foA=
=NLRJ
-----END PGP SIGNATURE-----

--------------enig8D83AD26870BB755D942FC93--

