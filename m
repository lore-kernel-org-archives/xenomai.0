Message-ID: <44CE11FB.3070309@domain.hid>
Date: Mon, 31 Jul 2006 16:21:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] two questions about using rtdm
References: <02AA386EB831044F8537A696BA785C78A668C7@domain.hid>
In-Reply-To: <02AA386EB831044F8537A696BA785C78A668C7@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA4959029F443F0069EBB6A38"
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
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA4959029F443F0069EBB6A38
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Landau, Bracha wrote:
> I downloaded RTNet and tried to compile it for mpc8260 fcc enet.=20
> I use linux kernel 2.6.14.
> The file drivers/rt_mpc8260_fcc_enet.c did not compile. It's looking fo=
r files named "immap_8260.h" and "immap_cpm2.h", neither of which exists.=

>=20

I think to remember Wolfgang said that 2.6 is not yet supposed to work
with this particular driver. So I better redirect this question for more
details.

But before digging to deep into this: What are you planning to do with
RTnet? My point is if you actually need deterministic network access or
if you may live with relaxed services via normal Linux. It's not that
RTnet is bad :), but it might not be required here.

Jan


--------------enigA4959029F443F0069EBB6A38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEzhH7niDOoMHTA+kRAsEPAJ9tBoSXpvJ9oVDNaZZt9Jp5JZyaQACbBgqh
D+iHMGUZ7exec9Q4Mluesdg=
=vuKY
-----END PGP SIGNATURE-----

--------------enigA4959029F443F0069EBB6A38--

