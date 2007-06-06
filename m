Message-ID: <4666B186.6090303@domain.hid>
Date: Wed, 06 Jun 2007 15:07:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7289437c0706060600n22effdc6l872cb6ba0df2e818@domain.hid>
In-Reply-To: <7289437c0706060600n22effdc6l872cb6ba0df2e818@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig79B143908C1F3F0A16D65743"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Compatibility "Preemptible kernel" and Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig79B143908C1F3F0A16D65743
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Perrine Martignoni wrote:
> Hello,
>=20
> I would like to know if Xenomai is compatible with the option "Preempti=
ble
> Kernel" (CONFIG_PREEMPT) of Linux 2.6.19.

It is. Though, you don't have to enable it to obtain good Xenomai
latencies, tuning Linux is orthogonal.

> And if CONFIG_PREEMPT  is the patch PREEMP_RT.

Nope, PREEMPT_RT comes via this patch:

	http://people.redhat.com/mingo/realtime-preempt/

But this clashes with Xenomai at the moment. Until we provide a separate
patch for a preempt-rt-patched kernel or the latter goes mainline (end
of 2007 according to a fairly optimistic schedule), you have to stick
with vanilla Linux.

Jan


--------------enig79B143908C1F3F0A16D65743
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZrGGniDOoMHTA+kRAnvnAJ96j9zfxJ5rK4qF+5Hc2UQ68RHNYgCcDlH4
Im7iE+o0DwDKOlwEF0jL89A=
=FSSz
-----END PGP SIGNATURE-----

--------------enig79B143908C1F3F0A16D65743--

