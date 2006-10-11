Message-ID: <452CCA4B.6010806@domain.hid>
Date: Wed, 11 Oct 2006 12:41:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Need for non-rt open/close
References: <452CC669.2010308@domain.hid>
In-Reply-To: <452CC669.2010308@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4721CE0ABCE07991D1E7D27E"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marcelo Coelho <mjcoelho@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4721CE0ABCE07991D1E7D27E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Marcelo Coelho wrote:
> Greetings,
>=20
>=20
> Is there a special reason for the need of having a non-rt open and clos=
e
>  functions in order to have a sucessfull rtdm driver registration?

There is only a need for a non-rt close handler in order to enforce a
device instance cleanup (ATM only via echo FD_NUMBER >
/proc/xenomai/rtdm/open_fildes, future version will also do cleanup on
process termination).

Jan


--------------enig4721CE0ABCE07991D1E7D27E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFLMpLniDOoMHTA+kRAonoAJ4kUBVYJmIm2yjKfnRNHQL+UTFZVACeLM1H
qfd2IEa+NY37lnDJxXh6Fv0=
=XLiq
-----END PGP SIGNATURE-----

--------------enig4721CE0ABCE07991D1E7D27E--

