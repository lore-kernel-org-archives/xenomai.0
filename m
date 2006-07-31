Message-ID: <44CE172C.1040103@domain.hid>
Date: Mon, 31 Jul 2006 16:43:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] two questions about using rtdm
References: <02AA386EB831044F8537A696BA785C78A668C8@domain.hid>
In-Reply-To: <02AA386EB831044F8537A696BA785C78A668C8@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig75EC3735CCC7456D3A768CDD"
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
--------------enig75EC3735CCC7456D3A768CDD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Landau, Bracha wrote:
> I don't need deterministic network access, but I was hoping it would im=
prove performance.

RTnet is designed to provide services deterministically, which doesn't
necessarily means with improved performance (nevertheless, you /can/
gain performance this way - for supported protocols).

But your problem can be that, by pulling networking services into the
real-time domain of Xenomai, you affect the whole RT-system. If incoming
traffic (e.g. broadcasts) is not strictly bounded and predictable, it
can cause serious harm due to the CPU time spent on dropping or
forwarding it. Just be warned, that RTnet is not a simple "performance
booster".

Jan


--------------enig75EC3735CCC7456D3A768CDD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEzhcsniDOoMHTA+kRAnrTAJ9xMtmi0bCaizTULkdzekLHAxP/jACcDo5d
+bNXPu85kCXYQBM0KJjOuHo=
=QwVE
-----END PGP SIGNATURE-----

--------------enig75EC3735CCC7456D3A768CDD--

