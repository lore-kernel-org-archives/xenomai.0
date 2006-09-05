Message-ID: <44FD308F.6030604@domain.hid>
Date: Tue, 05 Sep 2006 10:08:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai port to MIPS
References: <20060905065021.9474.qmail@domain.hid>
In-Reply-To: <20060905065021.9474.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDE1F908DD99A194BD835C413"
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
To: somshekar kadam <som_kadam@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE1F908DD99A194BD835C413
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

somshekar kadam wrote:
> Hi All,=20
>=20
> After a good study with help of mailing list, we fix
> on porting Xenomai to our ustom board running with
> Mips4k .

Nice to hear. :)

> what I understand is we have Adeos with Xenomai, and
> realtime capability of Xenomai.=20

Yep.

>=20
> our ultimate goal is realtime. To Begin with port of
> Xenomai I would like to know , in case is there a
> porting doc or some pointer which help to understand
> Xenomai better and quick, to go ahead.
> Please comment on this.=20

Your first step still remains the fairly independent port of Adeos/Ipipe
over MIPS. Philippe already pointed out the available resources. Start
over a recent vanilla kernel (or do you need special patches for your
targets?), make Linux boot with Ipipe enabled, then stress the event
pipeline with a simple Ipipe test module.

Once this works you can proceed to Xenomai, porting over what's under
ksrc/arch/<arch> and include/asm-<arch>. Not all internal functions may
be documented. Try to grab their meaning from other archs and/or their
usage - or ask on this list.

Another hint: post your patches early even if they do not work yet. We
may have a look and comment on style and functionality. This will make
it easier to finally merge them (which should be your goal to ease
long-term maintenance). And it may attract early adopters that can
provide further feedback and test results.

Jan


--------------enigDE1F908DD99A194BD835C413
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/TCQniDOoMHTA+kRAhBSAJ9rDjFdv6g2AdHd1cpEZoNnmRIeLgCdE6gh
7fxKSAs+nLWghmx2URS42Ts=
=Iadj
-----END PGP SIGNATURE-----

--------------enigDE1F908DD99A194BD835C413--

