Message-ID: <43E232CB.7000700@domain.hid>
Date: Thu, 02 Feb 2006 17:26:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM timing problems
References: <200601301611.53089.lbocseg@domain.hid>
	<200602021046.00546.lbocseg@domain.hid> <43E1FFAC.3040409@domain.hid>
	<200602021323.04666.lbocseg@domain.hid>
In-Reply-To: <200602021323.04666.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC95F1B1D68C371D54B3603A1"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC95F1B1D68C371D54B3603A1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Quinta 02 Fevereiro 2006 10:48, voc=EA escreveu:
>=20
>> Rodrigo Rosenfeld Rosas wrote:
>>> Em Segunda 30 Janeiro 2006 16:42, Jan Kiszka escreveu:
>>>> The point is that rtdm_clock_read() relies on the nucleus timer bein=
g
>>>> started. Otherwise, it just returns plain wrong numbers.
>>>>
>>>> This makes me scream again for that damn timer being started
>>>> AUTOMATICALLY! I guess Philippe knows what I'm talking about... ;)
>>>> Meanwhile, we should state this in the docs. At least for 2.0.x, thi=
s
>>>> will remain true anyway.
>>> What can I do for now? What is the relation between the system time a=
nd
>>> the timer?
>> Just start the timer before using rtdm_clock_read().
>=20
> Sorry, It is not clear to me how can I do that.

rt_timer_start() if you use the native API in your application. But I
would suggest to maintain a simple helper tool just for starting /
stopping the timer for native apps as long as this is explicitly needed.
As I indicated, plans exist to overcome this in 2.1.

Jan



--------------enigC95F1B1D68C371D54B3603A1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4jLLniDOoMHTA+kRAlP3AKCE7YuCbWaOA1OkJpMYEuEKtrLhHQCdGJ0l
596nqLFsKVrGzEPKmFGtR5s=
=2kye
-----END PGP SIGNATURE-----

--------------enigC95F1B1D68C371D54B3603A1--

