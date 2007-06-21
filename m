Message-ID: <467A7FCA.40708@domain.hid>
Date: Thu, 21 Jun 2007 15:40:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46782305.4080501@domain.hid>	
	<b647ffbd0706201404r256038b7sbb9318cdc1746b7c@domain.hid>	
	<4679A302.2060403@domain.hid>	
	<b647ffbd0706210103q186c00d7wdb861759ff5c0d78@domain.hid>	
	<467A42F6.8080706@domain.hid>	
	<b647ffbd0706210252o1074fa6aof00e82b5ba5a2509@domain.hid>	
	<467A7593.4040402@domain.hid>
	<b647ffbd0706210614ib24568bq6f5bc149c2bbc423@domain.hid>
In-Reply-To: <b647ffbd0706210614ib24568bq6f5bc149c2bbc423@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig17E5CC957125601C4C85AF1F"
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
--------------enig17E5CC957125601C4C85AF1F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 21/06/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> > [ .. ]
>> > surprise-surprise.. sure, one way or another it must be fixed. heh..=

>> > too many bugs (and I don't even want to say who's responsible) :-/
>>
>> I wouldn't accept all the responsibility if I were you.
>=20
> I have no problems in this respect. I was just a bit sarcastic with
> the way to say "it's my fault".
>=20
>=20
>> It's a sign that the design might be
>> too complex now
>=20
> frankly speaking, I don't think it's really complex :)
>=20
>=20
>> Things get worse, at least with XENO_OPT_STATS: Due to the runtime
>> statistics collection, we may end up with dangling references to our
>> xnintr object even after xnintr_shirq_unlock().
>>
>> We would actually need some kind of IRQ_INPROGRESS + synchronize_irq()=

>> at i-pipe level. But we have the problem, in contrast to the kernel,
>> that we reschedule from inside the handler (more precisely: at nucleus=

>> level), thus synchronize_irq() would not just wait on some simple
>> handler to exit...
>=20
> Yeah.. we had already conversations on this topic (I think with
> Philippe) and, if I recall right, that was one of the reasons. That's
> why synchronize_irq() is in the nucleus layer.

Hmm, then we may be forced to get the cookie out of ipipe's hands again
and put it back into a nucleus irq array, i.e. move the cookie
dereferencing under a nucleus managed per-irq lock. But there is still
the issue with xnsched_t::current_account...


--------------enig17E5CC957125601C4C85AF1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGen/KniDOoMHTA+kRAuVDAJ9GHjXQxYGsyiyF7dihwbjJgUUH8wCfcr1w
A+8NnY8AW9f33CtGVnFgt5A=
=IIY/
-----END PGP SIGNATURE-----

--------------enig17E5CC957125601C4C85AF1F--

