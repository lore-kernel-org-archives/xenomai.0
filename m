Message-ID: <45DEDBA1.70900@domain.hid>
Date: Fri, 23 Feb 2007 13:18:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Semaphore Behavior
References: <e45fe62b0702230245w5f373b0etc8828b042b97c4f0@domain.hid>
In-Reply-To: <e45fe62b0702230245w5f373b0etc8828b042b97c4f0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD6A18DD3167E6153D8ACB8EF"
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
To: Preetam Joshi <j.preetam@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD6A18DD3167E6153D8ACB8EF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Preetam Joshi wrote:
> Hi all,
>=20
> I am using the rt_sem_p and rt_sem_v API's in my semaphore application.=

> What
> i would like to know is whether the API rt_sem_p is a blocking call or =
not?
> Reasons being when i use it in my code the task does not block when it
> encounters rt_sem_p ?
>=20

Check http://www.xenomai.org/index.php/API_documentation

If you are unsure what the state your your semaphore is before calling
rt_sem_p, have a look at rt_sem_inquire().

Jan


--------------enigD6A18DD3167E6153D8ACB8EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3tuhniDOoMHTA+kRAvoQAJ9dhdPJGdEoui9bee/jGZuJuAA+QwCeIBNe
Ag7DxkuU32kz94T1gIz5tcY=
=JZCr
-----END PGP SIGNATURE-----

--------------enigD6A18DD3167E6153D8ACB8EF--

