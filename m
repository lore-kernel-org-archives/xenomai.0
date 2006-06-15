Message-ID: <449155C3.6030502@domain.hid>
Date: Thu, 15 Jun 2006 14:42:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44720BD1.805@domain.hid>
	<447E9E9E.6070301@domain.hid>	<4486FCA3.2070501@domain.hid>
	<448703C2.8030601@domain.hid> <4487DEC5.50705@domain.hid>
	<448B4589.6030101@domain.hid> <448D2574.1000204@domain.hid>
	<448D2861.9010704@domain.hid> <448D337F.9060002@domain.hid>
In-Reply-To: <448D337F.9060002@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2BE3103B96221C01C64BAF56"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [PATCH] kgdb/x86 over I-pipe
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
--------------enig2BE3103B96221C01C64BAF56
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> While we are at it,
>>> #define current ipipe_safe_current() /* ? */
>>
>>
>> Nope, there is the need for some special changes.
>>
>=20
> If you refer to the cache flushing issue, then it would be better to
> actually check for foreign stacks explicitely, so that you could
> substitute current globally:
>=20
> -    if (CACHE_FLUSH_IS_SAFE && current->mm &&
> -            addr < TASK_SIZE)
> +    if (CACHE_FLUSH_IS_SAFE && !testbit(IPIPE_NOSTACK_FLAG,        =20
> +     &ipipe_percpu_domain[cpuid]->cpudata[cpuid].status) &&
> +            current->mm && addr < TASK_SIZE)
>=20

Right - on first sight. I tried to redefine current, but the
ipipe_safe_current macro requires that symbol itself, ugh. Turning
ipipe_safe_current into a static inline doesn't work due to circular
dependencies on linux/sched.h.

So I guess it's best to keep it as it is (though kgdb-ipipe.patch would
have become really cute).

Jan


--------------enig2BE3103B96221C01C64BAF56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEkVXDniDOoMHTA+kRAg7eAJ9+1Df5IbwmjiH87ulza2OKFw9jrwCeL3ms
Xm6ZxeW6EFw237XVW7SbGfE=
=dZ6m
-----END PGP SIGNATURE-----

--------------enig2BE3103B96221C01C64BAF56--

