Message-ID: <450E9103.8080203@domain.hid>
Date: Mon, 18 Sep 2006 14:28:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <J5SF9Z$7F2EF49769B98E8D95E7CDDC32F233C4@domain.hid>
In-Reply-To: <J5SF9Z$7F2EF49769B98E8D95E7CDDC32F233C4@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig81D542EC916688742465A21F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: rare brokenness in latency output - FPU bug!
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "gilles.chanteperdrix" <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig81D542EC916688742465A21F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

gilles.chanteperdrix wrote:
> ---------- Debut du message initial -----------
>=20
> De     : jan.kiszka@domain.hid
> A      : "xenomai-core" xenomai@xenomai.org
> Chanteperdrix" gilles.chanteperdrix@xenomai.org
> Copies :=20
> Date   : Mon, 18 Sep 2006 11:30:45 +0200
> Objet  : rare brokenness in latency output - FPU bug!
>=20
>> Gilles, what info do you need? It's all the latest on x86 here:
>> 2.6.17.13 (.config attached), ipipe-1.4, SVN #1646, gcc4.1.0.
>=20
> It would be interesting if you could:
> - try reverting the last FPU changes

Meanwhile identified: 1595 for trunk, likely 1597 for 2.2.x (so 2.2.3 is
affected as well).

> - try to narrow down the issue by reducing the number of
> threads created
> by switchtest (for example, try keeping only the threads whose
> switch
> fails)

I tried both with "rtup0 rtup0 rtup_ufpp0 rtup_ufpp0" and only "rtup0
rtup_ufpp0", but that seems to work fine.

> - try dumping the FPU context before the first fp_regs_set,
> chances are that the FPU context is already clobbered before
> the first fp_regs_set;=20

I guess in rtup() in the switchtest driver, right? Will try.

> when the FPU context is already clobbered, running fp_regs_set
> set the
> value of the already set registers to qnan, and fp_regs_check
> returns
> INT_MAX when the register is set to qnan. I will send tomorrow
> the=20
> header I use for converting FPU contexts into human readable form.
>=20

TIA.


--------------enig81D542EC916688742465A21F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFDpEDniDOoMHTA+kRAnC/AJoDflbA9uJDGQfoRGx1jT6MRdPWGwCdGKmS
lZwvW+sNdspwKIA+oiKCVTM=
=heU/
-----END PGP SIGNATURE-----

--------------enig81D542EC916688742465A21F--

