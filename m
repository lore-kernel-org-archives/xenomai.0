Message-ID: <48AFEBB9.9080108@domain.hid>
Date: Sat, 23 Aug 2008 12:51:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48AFCB3F.6070902@domain.hid> <48AFE9E9.3050509@domain.hid>
In-Reply-To: <48AFE9E9.3050509@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8DAFA32C14C4A798A8C5B482"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Racy pse51_mutex_check_init?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8DAFA32C14C4A798A8C5B482
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Hi Gilles,
>>
>> trying to understand the cb_read/write lock usage, some question came =
up
>> here: What prevents that the mutexq iteration in pse51_mutex_check_ini=
t
>> races against pse51_mutex_destroy_internal?
>>
>> If nothing, then I wonder if we actually have to iterate over the whol=
e
>> queue to find out whether a given object has been initialized and
>> registered already or not. Can't this be encoded differently?
>=20
> We actually iterate over the queue only if the magic happens to be
> correct, which is not the common case.

However, there remains a race window with other threads removing other
mutex objects in parallel, changing the queue - risking a kernel oops.
And that is what worries me. It's unlikely. but possible. It's unclean.

Jan


--------------enig8DAFA32C14C4A798A8C5B482
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkiv67kACgkQniDOoMHTA+k77ACffc5RMjmyRa0LR290eEd30aL1
9lcAnRwPQMOun/6zH6dvRzu15NV+icQM
=EFxe
-----END PGP SIGNATURE-----

--------------enig8DAFA32C14C4A798A8C5B482--

