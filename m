Message-ID: <467BEF18.3020609@domain.hid>
Date: Fri, 22 Jun 2007 17:47:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <403B28AE6257B548B66BB88414AC78330174BC72@domain.hid>
In-Reply-To: <403B28AE6257B548B66BB88414AC78330174BC72@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig97F9D2B574F17E379EA31897"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Adeos-main] New I-pipe patch for ARM
	needs	testing.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: BOUIN Alexandre <abouin@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig97F9D2B574F17E379EA31897
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

BOUIN Alexandre wrote:
> Same tests but for AT91SAM9263-EK board :=20
>  - one under DD load, latency set to 45=B5s
>  - another one under Calibrator load, latency set to 30=B5s
>  - and the last under Test_switch load, latency set to 45=B5s
> Xeno-test traces are available and the end of this mail.
>=20
> We used kernel 2.6.20.13, Xenomai snapshot from 08/06/2007, adeos-ipipe=
-2.6.20-arm-1.7-03.patch included plus 2.6.20-at91.patch.
>=20
> A little correction on macb and ipipe patch was needed :=20
>  - macb ethernet controler is not detected on startup
>  - we added some corrections to make 9263 usable under ipipe
>  - owing to changes in at91 patch (clk are now registered on startup) w=
e made a little correction for future adeos-ipipe-2.6.21-arm.patch.
>=20
> You will find all added patches attached to this mail.
>  <<adeos-ipipe-2.6.20-arm-AT91.patch>>  <<2.6.20-at91-macb-9263.patch>>=
  <<adeos-ipipe-2.6.20-arm-AT91.patch>>=20
> Latencies are a little worst than on other boards. We presume that it's=
 due to the large number of peripherals.

<pure theory without looking at details here>
Every additional IRQ source can cause additional delays of your
benchmarked event. All those IRQs may once in a while line up just in
front of your RT-IRQ, delaying it yet a bit more.
</end of theory>

Jan


--------------enig97F9D2B574F17E379EA31897
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGe+8YniDOoMHTA+kRAoJ4AJ0a5yzrsf6CrEqw2ZL6YvKxYSK2AACeO6My
f7+ahqJ7EtUMkaCkCFKJnUM=
=K6AL
-----END PGP SIGNATURE-----

--------------enig97F9D2B574F17E379EA31897--

