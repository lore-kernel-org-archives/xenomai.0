Message-ID: <4C8C9525.1060101@domain.hid>
Date: Sun, 12 Sep 2010 10:53:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7301cc886b22b37fcbc8cda61c515d07.squirrel@domain.hid>
In-Reply-To: <7301cc886b22b37fcbc8cda61c515d07.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB8F6A68963A52E4FCF5E2939"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Bottom half task scheduling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: tstratman@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB8F6A68963A52E4FCF5E2939
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 11.09.2010 22:08, Travis Stratman wrote:
> Hello,
>=20
> I am writing a Xenomai driver with an interrupt that must trigger a
> complex series of hardware accesses that may not be atomic (i.e. waitin=
g
> for DMA to complete). I'd like to move this section to a bottom half. I=
n a
> Linux driver I would use a workqueue but I haven't been able to determi=
ne
> what the preferred method would be in Xenomai. All of the task creation=

> API that I have considered cannot be called from an interrupt handler a=
s
> they may reschedule.

Simply create the RTDM task(s) in advance. Creating tasks on demand and
in IRQ context would be crazy.

At this chance, also start thinking about what priorities you want to
assign to them (typically the harder part of the design).

>=20
> Can anyone point me to some documentation or example that covers this? =
Any
> pointers would be appreciated.

RTnet uses RTDM tasks quite heavily. But its code base is large, and not
all usages are really good examples anymore.

Jan


--------------enigB8F6A68963A52E4FCF5E2939
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkyMlSgACgkQitSsb3rl5xTzzgCgu9f2SxRijQwbUp7sQyfgV1fe
X+QAn1U/GBpzTKhOLpvNDAOKiQucixeP
=EGDV
-----END PGP SIGNATURE-----

--------------enigB8F6A68963A52E4FCF5E2939--

