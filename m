Message-ID: <4BDC6924.2070302@domain.hid>
Date: Sat, 01 May 2010 19:47:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BD5987A.2050804@domain.hid>
	<4BD59A48.5070002@domain.hid>	<4BD5BA03.5000101@domain.hid>	<1272331158.28983.287.camel@domain.hid>	<4BD68843.4030806@domain.hid>	<1272356029.28983.333.camel@domain.hid>	<4BD69F7D.9060006@domain.hid>	<1272359559.28983.380.camel@domain.hid>	<4BD6AE1E.6050704@domain.hid>	<1272360740.28983.382.camel@domain.hid>	<4BD6AFC2.1090300@domain.hid>	<1272361898.28983.395.camel@domain.hid>	<4BD6BF21.20303@domain.hid>
	<1272734766.2440.46.camel@domain.hid>
In-Reply-To: <1272734766.2440.46.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDC1666C91AE67CFD8C41238A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] nucleus: Plug race between
	rpi_clear_remote and rpi_next
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC1666C91AE67CFD8C41238A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Don't you think that, quoting yourself:
>=20
> "I have to confess, I do not understand how the patch may relate to our=

> crash. But that's because I still only have a semi-understanding of thi=
s
> frightening complex RPI code"
>=20
> does not fit that well with any kind of strong assertion made later on
> the same topic, not backed by facts?

See, as long as you do not directly explain why my concerns on this
naturally racy construct were not valid (I brought up quite a few
concrete questions), I couldn't help raising them over and over again.
This has, in fact, nothing to do with understanding the RPI code in all
its details. It's about reviewing basic patterns of it. But now that the
critical bit is gone, I'm surely no longer concerned. :)

>=20
> So, I'm suggesting that we move on, and end this discussion in a
> positive manner, i.e. by fixing this code. I hear your concerns, like I=

> always do, and I'm trying to find a solution that does not paper over
> another issue. I guess we should be able to settle on this.
>=20
> I pushed two patches in my for-upstream queue, with lengthy comments to=

> explain what they do and why this is needed:
>=20
> http://git.xenomai.org/?p=3Dxenomai-rpm.git;a=3Dcommit;h=3Dac5c739dabcb=
14334c2e390a9e3064f11f97283c
> http://git.xenomai.org/?p=3Dxenomai-rpm.git;a=3Dcommit;h=3Dd3242401b8e1=
cf2c28822f801b681194243b4394
>=20
> - the first patch is a plain revert of the commit introducing
> rpi_next(), which caused the bug you observed in SMP mode, and that you=
r
> patch plugged successfully.
>=20
> - the second patch is the proper fix for the issue rpi_next() tried to
> address.
>=20
> Could you please try them, and report whether this also fixes the issue=

> for you? In the meantime, I will be analyzing the RPI code once again,
> to check whether your patch still covers a possible case, or not.

I will try my best, but the issue showed up only once in countless
application runs. We will role out the patches at the next chance (we
already had to push my workaround as we need to deliver the fastsynch
fix, so it may take a while).

Jan


--------------enigDC1666C91AE67CFD8C41238A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvcaSgACgkQitSsb3rl5xSclACgmq5f4HaALrDHbOJvA4A8quq0
I7wAnRpmXtohon+Xp4s7A5rz5NEaoARy
=70Ar
-----END PGP SIGNATURE-----

--------------enigDC1666C91AE67CFD8C41238A--

