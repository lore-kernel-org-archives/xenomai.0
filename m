Message-ID: <46E07430.2060309@domain.hid>
Date: Thu, 06 Sep 2007 23:42:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46DFD2EA.6000202@domain.hid>
In-Reply-To: <46DFD2EA.6000202@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig72D8EB50F577CDAA2478654D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] RTDM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig72D8EB50F577CDAA2478654D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Patrick wrote:
> Hy,
>=20
> I don't understand the difference between rtdm function and standard fu=
nction.
> For exemple what is the diffrence between rtdm_printk and printk=20

Technically? None these days (printk is provided RT-safe by
Adeos/I-pipe), but it documents that the message may be printed from RT
context. And who know if some future RTDM implementation may not have to
differentiate internally again...

> or rtdm_malloc=20
> and malloc ?

You mean kmalloc (malloc is user space only)? rtdm_malloc provides
memory from a dedicated pool (dedicated to Xenomai, excluding Linux) and
uses a predictable allocator (as long as the memory usage pattern is
predictable). kmalloc is non-deterministic, and is shared with the whole
Linux kernel.

>=20
> I am developping an RT driver so I must simply used only functions rtdm=
 ?

Regarding the two services above: Depends on the context. If they run in
non-RT driver cleanup or device instantiation context, you should
continue to use standard Linux services. Just for usage from RT contexts
(tasks, IRQ handlers (please don't allocate memory in the latter
context, though...)) switch to those RTDM variants.

Jan


--------------enig72D8EB50F577CDAA2478654D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG4HQwniDOoMHTA+kRApgQAJkBf9Q19v86W0E8G2hwoYJJv6FWlgCggk9X
yOdExdfUqUpk6VtsMiN5FZE=
=m8Vf
-----END PGP SIGNATURE-----

--------------enig72D8EB50F577CDAA2478654D--

