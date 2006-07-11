Message-ID: <44B3BBCE.8080906@domain.hid>
Date: Tue, 11 Jul 2006 16:55:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] do memory functions switch to secondary mode ?
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F9354@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A3F9354@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6865AE86978A6915E9D8F93F"
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6865AE86978A6915E9D8F93F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
> Does any of the memory functions like :
> memcopy,
> memset,
> bzero,
>=20
> :
> :
>=20
> cause Xenomai to switch to secondary mode ?
> I am asking as I have a high priority task, which mesures its
> periodicity (set to 1ms).
> This task is using just rt_-functions and memcpy.
> When in low priority tasks memory intensively is used (memset,
> rt_heap_alloc, rt_heap_create, NFS-transfers in Linux threads), the
> cycle time of the high priority task inreases to nearly twice the time
> it has been set up (2ms++; at least 1 time, as I just measure maxima).
>=20
> Is this possible, or am I doing something wrong ?

Try catching unwanted context switches via the SIGXCPU signal. Given you
have a sane glibc, non of those functions should cause a context switch
- unless you touch some piece of memory for the first time (lazy
mapping...).

[Unfortunately, the I-pipe tracer is only available over 2.6 so far.
Otherwise, putting a xntrace_user_freeze() right at that line in your
application where you detect the deadline miss would give a nice view
back in history.]

Jan


--------------enig6865AE86978A6915E9D8F93F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEs7vPniDOoMHTA+kRAt2TAJ9ZtyNWbHP+jsmnHY83XAHhjHLfVwCeK/Lc
abI8gZ9ObiA4nTrYvOLA608=
=7usP
-----END PGP SIGNATURE-----

--------------enig6865AE86978A6915E9D8F93F--

