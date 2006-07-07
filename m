Message-ID: <44AEC245.7090702@domain.hid>
Date: Fri, 07 Jul 2006 22:21:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xenomai beginner problem.
References: <e325d110607071259g5ebc019bs2565887803265adc@domain.hid>
In-Reply-To: <e325d110607071259g5ebc019bs2565887803265adc@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4D2E71F5741192830340A3E3"
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
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4D2E71F5741192830340A3E3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Kim Chuan Lim wrote:
> Hi all,
> The following is my problem...
>=20
> suse003:/usr/xenomai/testsuite/latency # ./run
> *
> *
> * Type ^C to stop this application.
> *
> *
> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_native?)
> suse003:/usr/xenomai/testsuite/latency # modprobe xeno_native
> FATAL: Module xeno_native not found.

xeno_nucleus and xeno_native are by default both compiled into your
kernel. Therefore: no modules.

What does dmesg tell you regarding Xenomai? Any suspicious
warnings/errors? I'm thinking now of the issue that local APIC is
enabled in the kernel, but "lapic" is missing in the kernel command
line. The kernel messages should indicate this.

>=20
> i'm using an old pentium 3 1GHz machine with suse9.3.
> i recently downloaded kernel 2.6.17 from kernel.org and patch it with
> xenomai trunk.
>=20
> May i know what is my problem??
> Is it i didnt setup my kernel probably?
>=20
> The following is the result of my locate..
>=20
> locate xeno_native
> /home/username/linux-2.6.17.4/kernel/xenomai/skins/native/.xeno_native.=
o.cmd
>=20
> /home/username/linux-2.6.17.4/kernel/xenomai/skins/native/xeno_native.o=

>=20
> How can i load the xeno_native manually?

Check you kernel configuration if this is really needed - I bet not.

Jan


--------------enig4D2E71F5741192830340A3E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFErsJFniDOoMHTA+kRAjM3AJ4n3RwFcRIT5U9WGtiCTOWA6VxIKQCfSoKv
1pV7TixbK67LNz6bCvWHf6w=
=fz3v
-----END PGP SIGNATURE-----

--------------enig4D2E71F5741192830340A3E3--

