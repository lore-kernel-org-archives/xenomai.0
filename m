Message-ID: <45754D10.1000501@domain.hid>
Date: Tue, 05 Dec 2006 11:42:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] vxworks- and posix-skin simultaneously
References: <5D63919D95F87E4D9D34FF7748CE2C2A6C6377@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A6C6377@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7071A1EA2EF70FE0D0C1DF27"
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7071A1EA2EF70FE0D0C1DF27
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
> Can anybody tell me about the actual state of using vxworks-skin and po=
six-skin simultaneously ? Is it possible, compiling one application with =
vxWorks-skin and an other one with the posix-skin and to use/execute thes=
e two applications simultaneously on one system ?

Yes, feasible. There are example applications available for both skins,
so setting up your own quick test will not take you much time.

>=20
> In an earlier posting I have read, that all skins (or at least the nati=
ve and the posix one) should be compiled as modules, so they do not overi=
de the timer mode. Is this still true ? And if yes, dosn?t need the posix=
 skin an aperiodic timer, but the timer is set to periodic mode by the vx=
works skin ? So, can an vxworks application and an posix applications run=
 together ??

It's true that the vxworks skin still forces the nucleus into periodic
timer mode. This is a known shortcoming of the current timer subsystem.
As announced earlier, we are aiming at a redesign to overcome this
during the 2.4 development cycle. Ideas exist, remaining issues are also
identified. But our resources are still limited, so there is no promise
on a time-frame.

Anyway, if you do not rely on having sub-tick timer precision for the
posix applications you are planning, the available support should
already be fine for you.

Jan


--------------enig7071A1EA2EF70FE0D0C1DF27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdU0QniDOoMHTA+kRAhGdAJwJhNihEPMH7u/6sOKIr7yLxKNx7wCfSHOO
JzYfc27c9icvJGDEyUNUNRs=
=6POY
-----END PGP SIGNATURE-----

--------------enig7071A1EA2EF70FE0D0C1DF27--

