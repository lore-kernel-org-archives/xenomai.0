Message-ID: <467A7593.4040402@domain.hid>
Date: Thu, 21 Jun 2007 14:56:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46782305.4080501@domain.hid>	
	<b647ffbd0706201404r256038b7sbb9318cdc1746b7c@domain.hid>	
	<4679A302.2060403@domain.hid>	
	<b647ffbd0706210103q186c00d7wdb861759ff5c0d78@domain.hid>	
	<467A42F6.8080706@domain.hid>
	<b647ffbd0706210252o1074fa6aof00e82b5ba5a2509@domain.hid>
In-Reply-To: <b647ffbd0706210252o1074fa6aof00e82b5ba5a2509@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5DE16AFD6AA59D26EC6BA92F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC][PATCH] shirq locking rework
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5DE16AFD6AA59D26EC6BA92F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 21/06/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> [ ... ]
>>
>> Unfortunately, that whole thing make me meditate about the whole issue=

>> again. And now I wonder why we make such a fuss about locking for shar=
ed
>> IRQs (where it should be correct with any of the new patches) while we=

>> do not care about the non-shared, standard scenario.
>=20
> surprise-surprise.. sure, one way or another it must be fixed. heh..
> too many bugs (and I don't even want to say who's responsible) :-/

I wouldn't accept all the responsibility if I were you. We all went
through this code several times. It's a sign that the design might be
too complex now, and I feel like having some share in this.

>=20
>> Sigh, the never ending IRQ story...
>=20
> should be reviewed.
>=20

Things get worse, at least with XENO_OPT_STATS: Due to the runtime
statistics collection, we may end up with dangling references to our
xnintr object even after xnintr_shirq_unlock().

We would actually need some kind of IRQ_INPROGRESS + synchronize_irq()
at i-pipe level. But we have the problem, in contrast to the kernel,
that we reschedule from inside the handler (more precisely: at nucleus
level), thus synchronize_irq() would not just wait on some simple
handler to exit...

Jan


--------------enig5DE16AFD6AA59D26EC6BA92F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGenWTniDOoMHTA+kRAlQzAKCBPbrC2YbnoTmbK7OZWf+B2TRIXgCfUNgS
5UU2QmPiSv+vqw7qhQm4Jfw=
=Byxh
-----END PGP SIGNATURE-----

--------------enig5DE16AFD6AA59D26EC6BA92F--

