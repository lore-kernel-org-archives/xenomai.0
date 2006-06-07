Message-ID: <448703C2.8030601@domain.hid>
Date: Wed, 07 Jun 2006 18:50:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44720BD1.805@domain.hid> <447E9E9E.6070301@domain.hid>
	<4486FCA3.2070501@domain.hid>
In-Reply-To: <4486FCA3.2070501@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9F599BB24A975E32AE019E38"
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
--------------enig9F599BB24A975E32AE019E38
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
>=20
> Hi Jan,
>=20
> Based on your previous work, here is a set of patches coupling KGDB and=

> the I-pipe. Basically, I've attempted to shrink the extra patches neede=
d
> against the original KGDB + I-pipe ones to the bare minimum. This has
> been obtained by having the I-pipe provide ipipe_current_safe(), and
> drastically reduce the amount of fiddling with smp_processor_id().
>=20
> The key difference with the former implementation is that a domain (e.g=
=2E
> Xenomai) is now expected to tell the I-pipe when it's switching to a
> non-Linux stack, and the I-pipe makes good use of this information to
> return the proper "current" value when asked to through
> ipipe_safe_current() from the KGDB code. The issue of swapping

This looks nice.

> smp_processor_id() with ipipe_processor_id() has been addressed the har=
d
> way: smp_processor_id() is simply defined as ipipe_processor_id() when
> CONFIG_IPIPE and CONFIG_KGDB are both enabled in include/linux/smp.h.
> This approach was actually used during the old Adeos times when pipelin=
e
> domain had their own separate stack. I take for granted that the CPU
> penalty taken in doing this is perfectly acceptable, since well, we are=

> debugging after all.

There is only one drawback: we will not be able to debug
smp_processor_id-related bugs in ipipe/Xenomai anymore...

>=20
> Aside of the small patches attached, you will need the latest I-pipe
> 1.3-05 patch for x86, adding the foreign stack notifier and the
> ipipe_safe_current() support:
> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.16-i386=
-1.3-05.patch
>=20
>=20
> Patches should be applied in this order on a vanilla 2.6.16 kernel:
>=20
> - KGDB 2.4 patch series over 2.6.16 (quilt)
> - pre-kgdb-ipipe-i386.patch
> - adeos-ipipe-2.6.16-i386-1.3-05.patch
> - kgdb-ipipe.patch
> - post-kgdb-ipipe-i386.patch
>=20
> Xenomai's trunk/ should be used. Older code won't work and likely crash=

> since the I-pipe would not be notified about foreign stack switches.
>=20
> Now the surprise: I did not test this stuff, I mean, at all. Eh. :o)

That's fair: leave the head banging while debugging debuggers (*) up to
me. ;)

Will try to let this fly, likely not before the weekend.

BTW, there is one pending issue of gcc-4.1 which popped up under kgdb,
see [1] (also for a workaround).

Jan


(*) Actually, that's feasible: kgdb-patched kernel inside qemu - already
done this (to find [1]), it's just a bit sloooow.

[1]http://sourceforge.net/mailarchive/forum.php?thread_id=3D10452132&foru=
m_id=3D5557


--------------enig9F599BB24A975E32AE019E38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEhwPCniDOoMHTA+kRAjFDAJ43YHbAsimkEq7m6fjo3LjdGSxgSACfUx54
+souzKy/m+3i0Pp+aAaRVJI=
=ZjxL
-----END PGP SIGNATURE-----

--------------enig9F599BB24A975E32AE019E38--

