Message-ID: <4C099329.6000303@domain.hid>
Date: Sat, 05 Jun 2010 01:58:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1OKZdD-0003ml-45@domain.hid> <4C095876.3060605@domain.hid>
In-Reply-To: <4C095876.3060605@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6B1F4D7F5AD81EE8686EAD00"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : native: Rework
 handling of pthread carrier thread
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B1F4D7F5AD81EE8686EAD00
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> GIT version control wrote:
>> Module: xenomai-jki
>> Branch: for-upstream
>> Commit: 0352b068600bd4ef3172c8a42416badbcdad32ca
>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3D035=
2b068600bd4ef3172c8a42416badbcdad32ca
>>
>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>> Date:   Wed Apr 28 15:08:11 2010 +0200
>>
>> native: Rework handling of pthread carrier thread
>>
>> This patch improves two pitfalls of libnative's interaction with
>> underlying pthreads:
>>
>> First, it tries to detect double deletions (cancellations or joinings)=

>> of pthreads and report them via an error code. This reduces the risk t=
o
>> trigger a SIGSEGV accessing meanwhile released pthread objects. And
>> second, it properly detaches joinable pthreads when they are deleted
>> instead. This properly releases the pthread resources.
>=20
> I really do not understand that. What is the point of creating a
> joinable thread if you do not want to join it once it has been canceled=
?
>=20

Keep in mind that there is no pthread_cancel equivalent in the native
API. Moreover, even POSIX has pthread_detach so that you are not forced
to join every joinable thread. I could imagine that one may want to use
this fot error cleanups. But first of all this is about improving the
API consistency and fault tolerance.

Jan


--------------enig6B1F4D7F5AD81EE8686EAD00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwJky4ACgkQitSsb3rl5xQ/GACg2A09tlJVhLqD7UQrXi6i6DuG
qeAAnRiHGbrckYep5SvoBXImnfPqQ5D6
=kNZE
-----END PGP SIGNATURE-----

--------------enig6B1F4D7F5AD81EE8686EAD00--

