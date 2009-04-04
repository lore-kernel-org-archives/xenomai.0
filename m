Message-ID: <49D70E31.4070706@domain.hid>
Date: Sat, 04 Apr 2009 09:37:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49D513D8.5020001@domain.hid> <49D530C8.8050109@domain.hid>
	<1238708700.6932.136.camel@domain.hid>
In-Reply-To: <1238708700.6932.136.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7023A6B1FD2A53DC13F7614F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] libnative: Avoid double-evaluation of
 rt_task_self()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7023A6B1FD2A53DC13F7614F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2009-04-02 at 23:40 +0200, Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> [ can be pulled from git.xenomai.org/xenomai-jki.git queues/assorted =
]
>>>
>>> Keep the result of rt_task_self() in a local variable to avoid the
>>> second invocation.
>> Maybe we could create a pure/const variant of rt_task_self() for use i=
n
>> task.c only which would avoid the double evaluatino ?
>>
>=20
> Can't do const because of pthread_getspecific(), but pure attribute is =
t
> hand, yes.
>=20

At least my gcc 4.3 ignores

RT_TASK *rt_task_self(void) __attribute__ ((pure));

and keeps on inserting two calls in rt_task_delete.

Jan


--------------enig7023A6B1FD2A53DC13F7614F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAknXDjYACgkQniDOoMHTA+npDQCeNsS2ifSJTw6wiCAwPFY94PIH
ghEAn3VXBnvsnRpEYxwpdrSNNr/a2VuR
=ufsQ
-----END PGP SIGNATURE-----

--------------enig7023A6B1FD2A53DC13F7614F--

