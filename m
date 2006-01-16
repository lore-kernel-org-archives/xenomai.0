Message-ID: <43CBD72A.30809@domain.hid>
Date: Mon, 16 Jan 2006 18:26:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Scheduling while atomic
References: <fd6a47a90601160809l6aa38508o@domain.hid>
In-Reply-To: <fd6a47a90601160809l6aa38508o@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7E15419AE5332F3719B687CB"
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7E15419AE5332F3719B687CB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeroen Van den Keybus wrote:
> I got a fair number of 'scheduling while atomic' entries in the dmesg l=
og
> after running a multithread Xenomai program. What do they mean ?
>=20

Backtraces, i.e. the dmesg logs, please.

The general meaning is that the Linux scheduler was invoked in a
non-schedulable context, e.g. with preemption lock held. The precise
meaning can only be derived from that output.

Jan


--------------enig7E15419AE5332F3719B687CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDy9cqniDOoMHTA+kRAu5BAJ0RP1VIAcLCVZ1a2LfIlT3MWwZL4wCfZD2U
QK+oRvfK7kaGP7uVV8mgjH0=
=R9OC
-----END PGP SIGNATURE-----

--------------enig7E15419AE5332F3719B687CB--

