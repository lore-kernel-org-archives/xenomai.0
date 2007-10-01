Message-ID: <47015EDF.9010402@domain.hid>
Date: Mon, 01 Oct 2007 22:55:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47014BED.1090005@domain.hid>
	<18177.20421.874002.472501@domain.hid>
In-Reply-To: <18177.20421.874002.472501@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig24102112F055CE2012C10049"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] posix skin thread doesn't
	respect	/proc/xenomai/affinity
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
--------------enig24102112F055CE2012C10049
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi Gilles,
>  >=20
>  > almost forgot to report this, didn't find time to dig into it. You c=
an
>  > easily check this with cyclictest: affinity mask set to 2, the test =
will
>  > still schedule on CPU0.
>=20
> Ok, what is needed at skin level to get it to work ?

If the user doesn't care about affinity explicitly, the skin should have
set the current task's affinity to XNPOD_ALL_CPUS on xnshadow_map (same
for xnpod_start_thread):

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/shadow.c?v=
=3DSVN-trunk#1350

Jan


--------------enig24102112F055CE2012C10049
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHAV7fniDOoMHTA+kRAldsAJ4jnoY5c6KBZPNeJMSkTPtubImKuwCeLl7Z
uoStHpPXYwCtBMVUSzVmqtw=
=6fRq
-----END PGP SIGNATURE-----

--------------enig24102112F055CE2012C10049--

