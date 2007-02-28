Message-ID: <45E54B9E.9050306@domain.hid>
Date: Wed, 28 Feb 2007 10:30:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Semaphore Task
References: <e45fe62b0702280117k23198918y971763b877cd9b9a@domain.hid>
In-Reply-To: <e45fe62b0702280117k23198918y971763b877cd9b9a@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE781D4E73D793CFF42C680ED"
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
--------------enigE781D4E73D793CFF42C680ED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Preetam Joshi wrote:
> Hi i have a problem in my code the rt_sem_create calls returns a negati=
ve
> value i.e. -17
>=20

http://www.xenomai.org/index.php/Resolving_Error_Codes

> THat is semaphore creation fails? Why is it so?

Leftover registered name from a previous run? You are not cleaning up
the semaphore on termination. See /proc/xenomai/registry.

Jan


--------------enigE781D4E73D793CFF42C680ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5UueniDOoMHTA+kRAseYAJsFoDrRYfwP35HknlpTpw7kCObB5gCfcBpS
BpjOplSm0K/9XX/uCbxBU1M=
=RTNc
-----END PGP SIGNATURE-----

--------------enigE781D4E73D793CFF42C680ED--

