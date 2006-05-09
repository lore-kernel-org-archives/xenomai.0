Message-ID: <44610180.30206@domain.hid>
Date: Tue, 09 May 2006 22:54:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] lock-up by failing rt_task_spawn/create
References: <4460FC50.6030904@domain.hid>
	<17504.65186.650064.785243@domain.hid>
In-Reply-To: <17504.65186.650064.785243@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7561DFEE101F6540FA0E3097"
Sender: jan.kiszka@domain.hid
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7561DFEE101F6540FA0E3097
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > BTW, this reminds me the ask for a merging plan of the kgdb support =
for
>  > ipipe - this bug was tracked down via kgdb...
>=20
> There are some issues with the kgdb patch:
> - it does not work if the nucleus is compiled as a module, because it
>   uses xnpod_current_thread()

I know, but I do not have a clean solution for this yet. A workaround
would be to force the nucleus into the kernel via kconfig if the kgdb is
enabled. Any other ideas how to detect kernel-only threads (i.e. invalid
"current")?

> - it does not work on SMP because the kgdb patch uses
>   smp_processor_id(), which does not work on SMP over Xenomai domain.
>=20

Ok, but probably fixable. If simple search&replace in the kgdb patch is
not enough, a similar workaround could be applied for now: disallow kgdb
usage over SMP.

Jan


--------------enig7561DFEE101F6540FA0E3097
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEYQGAniDOoMHTA+kRAmBJAJ9naXcP3YsMKIsLyvZp+/dMMPlKbgCeJUn7
e4ubxqspReU5EfsX95ehvpE=
=c/6w
-----END PGP SIGNATURE-----

--------------enig7561DFEE101F6540FA0E3097--

