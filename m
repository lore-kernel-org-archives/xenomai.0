Message-ID: <47C278F3.1060309@domain.hid>
Date: Mon, 25 Feb 2008 09:14:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47BED8A502000001001928B7@domain.hid>
In-Reply-To: <47BED8A502000001001928B7@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6D8CBB7896ACC8514FF8C202"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Non RT PCI device driver vs interrupts (go with
 rtdm...)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hubert Talbot <Hubert.Talbot@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D8CBB7896ACC8514FF8C202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hubert Talbot wrote:
> Finally, I got the precision I expected. The problem was on the way the=
 results were reported.
>=20
> However, more the frequency of the pulse generator is raised, less the =
results are good.
>=20
> I think it is time to go with rtdm...

RTDM is no magic bullet /wrt latency or jitter. You should try to=20
understand what you are measuring first before blindly replacing=20
something. I'm surely not saying porting to RTDM is a bad idea, but I=20
may not help you with what you are actually looking for.

What do you mean with "less good"? What frequencies are we talking=20
about? What is the critical code path (already considered to use some=20
tracing tool for analysis?)?

Jan


--------------enig6D8CBB7896ACC8514FF8C202
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHwnjzniDOoMHTA+kRAlz1AJ0ZXyjEoPWdSTYmyFEoBmT3UxDhXQCdEynj
TNqIcN2wsAmT9VHRfmVo3kc=
=Xm7P
-----END PGP SIGNATURE-----

--------------enig6D8CBB7896ACC8514FF8C202--

