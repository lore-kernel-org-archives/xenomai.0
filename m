Message-ID: <45DEF06F.7070800@domain.hid>
Date: Fri, 23 Feb 2007 14:47:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rtdm, rtc and printk driver.
References: <s5def92b.000@domain.hid>
In-Reply-To: <s5def92b.000@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDD57841C2BE9A290A9211EEA"
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
To: Nicolas BLANCHARD <n.blanchard@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDD57841C2BE9A290A9211EEA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nicolas BLANCHARD wrote:
> Hello,
> =20
> I've write a little rtdm driver to r/w RealTimeClock on rtc146818
> chipset.

/me not having done much with rtc (hmm, a lot of years back on PCs, I
think): can this chip be found in normal PC hardware? Or is it only on
specific embedded boards? (Means: can I actually play with your driver? :=
) )

> I also use this driver to write kernel message from user-space
> (printk).
> =20
> In attachment you can find an archive with the driver and an example of=

> use (just code).
> to compil, you must change kernel sources directory (KERNELSOURCEDIR
> flag).
> =20
> It Based on code of Jan Kiszka found in http://www.captain.at/
> =20
> I hope it could be interesting.
> All feedback are welcome.
> =20

You will get it. Thanks for sharing your code!

Jan


--------------enigDD57841C2BE9A290A9211EEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3vBvniDOoMHTA+kRAnC0AJ4giysKCyh6wmmo0TiPtTkhfcvYtwCfR8wh
cpEElJ9RXW2U7DSoBjXv9WY=
=cU0V
-----END PGP SIGNATURE-----

--------------enigDD57841C2BE9A290A9211EEA--

