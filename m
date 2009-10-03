Message-ID: <4AC78C48.7020904@domain.hid>
Date: Sat, 03 Oct 2009 19:39:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AC61F57.2010404@domain.hid> <4AC62804.7090903@domain.hid>
	<4AC62B41.3050404@domain.hid> <4AC65172.8060900@domain.hid>
	<4AC65CEB.7080107@domain.hid> <4AC65F5A.7040307@domain.hid>
	<4AC65FFC.5040902@domain.hid> <4AC66211.3030204@domain.hid>
	<4AC6667E.10704@domain.hid>
In-Reply-To: <4AC6667E.10704@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig80E5179EBE4F13640E9A541A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RTDM fd support.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig80E5179EBE4F13640E9A541A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Then please summarize again what you want change from the user's POV (=
fd
>> range and arbitration, I guess, but also their scope?)
>=20
> Basically, when going from user-space to kernel-space, instead of a
> simple translation, currently done with an addition in user-space for
> most services, in kernel-space for select, there is a hash lookup, done=

> in kernel-space.
>=20
>  and what impact
>> that will have on the library and kernel ABIs.
>=20
> The impact on the ABI is that we no longer do the translation using
> addition/substraction. If we broke all at once in version 2.5.x, we
> could not run a 2.5.x-1 user-space support that does the
> addition/substraction, with a 2.5.x kernel-space support which has the
> unified file descriptors abstraction.
>=20
>  What would be part of
>> step 1, what of step 2 later in 2.5.x?
>=20
> Step 1 is adding the fdtable, use it in the rtdm and posix skin before
> returning a fd to user-space, and when getting an fd from user-space.
> Remove the translation by addition/substraction in the rtdm part of
> libpthread_rt.

I assume this mapping will already make user-visible fds process-local,
right?

BTW, one downside of pushing the translation into the kernel part of the
skins is that POSIX borderline threads will pay via an additional
syscall + a futile lookup in the Xenomai fdtable. So far we can dispatch
 very cheaply. On the other hand, POSIX users who care about performance
could also user __real_* or avoid the automatic wrapping.

>=20
> Step 2 is replacing the rtdm and posix registries with an unified fd
> support based on the fdtable, the real kernel-space file descriptors (I=

> mean, the one which really belong to a kernel-space app) would be
> implemented using a global fdtable. Duplicate the fdtable at fork, etc.=
=2E.
>=20

OK, if you are willing to draft a prototype for step 1, I'm open to
discuss it. My requirements would be:
 - per-process fdtables (and locks) for the first level lookup
 - the second level lookup should be limited to device creation; simply
   keep a permanent reference to the rtdm_context in the fdtable

Jan


--------------enig80E5179EBE4F13640E9A541A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrHjE0ACgkQitSsb3rl5xRTOwCeJE0DcB9bW+/Mwo4kzbsu3Lrr
AUQAnRbAaIC5ddzTKKPEV9xaduODErHW
=ROe8
-----END PGP SIGNATURE-----

--------------enig80E5179EBE4F13640E9A541A--

