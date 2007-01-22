Message-ID: <45B4C112.9040500@domain.hid>
Date: Mon, 22 Jan 2007 14:50:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] weired behaviour around userspace interrupts
References: <45B495F9.6090808@domain.hid> <45B4A1CF.8090304@domain.hid>
	<45B4BD4D.8010206@domain.hid>
In-Reply-To: <45B4BD4D.8010206@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig035F64778962DADA536BCB23"
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig035F64778962DADA536BCB23
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stephan Zimmermann wrote:
> Jan Kiszka schrieb:
>> Stephan Zimmermann wrote:
>>> Hello all,
>>> I guess I found some weired memory bug in Xenomai's (userspace?)
>>> interrupt handling. When I run the attached testprogram (or another
>>> program using userspace interrupt's) it happens that 'cat
>>> /proc/xenomai/irq' delivers the following output:
>>
>> Which Xenomai version? We recently fixed some maybe related issues, bo=
th
>> in trunk and the v2.3.x branch. Please give one of them a try as well.=

>=20
> I just checked out braches/v2.3.x rev 2077, patched a fresh 2.6.17.14
> Kernel an rebuilded everything (was a kernel rebuild necessary?).

Simply calling "make" on the tree catches all dependencies on 2.6. If
you repatched the kernel, then you may see a full rebuild then.
Normally, a prepare-kernel is safe enough to catch potentially added new
Xenomai files.

>=20
> Seems to work for now. Thanks for your Hint.
>=20
> Stephan
>=20
>=20
> P.S. I think it would be great if you could announce maintenance
> releases for stable (and how to get them) on the xenomai website, makin=
g
> post's like mine disappear from the list ;)

Philippe does so regularly, and if you look back in Xenomai's history,
you will find *a lot* of maintenance releases for previous series. The
2.3 is fairly new, and so far the critical mass for a patch release was
not reached (no mission-critical bugs - though I see your issues can be
quite annoying).

Jan


--------------enig035F64778962DADA536BCB23
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFtMETniDOoMHTA+kRAscJAJ4qaA0lfeLeIyQ44nScku4u43yHPwCfcgPB
hUca/NQ2k5F9oaqcMvb6oSw=
=E2RZ
-----END PGP SIGNATURE-----

--------------enig035F64778962DADA536BCB23--

