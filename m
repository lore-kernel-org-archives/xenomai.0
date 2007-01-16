Message-ID: <45ACCDEC.2080807@domain.hid>
Date: Tue, 16 Jan 2007 14:06:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Porting IPIPE on MIPS Architecture, User Process
	running error, Kernel hangs.
References: <25dd9bf10701160219w72c8e522l33f4eb9cec59b869@domain.hid>	
	<45ACB7EB.1060708@domain.hid>
	<25dd9bf10701160444s1eed7edfwabd5302b022902aa@domain.hid>
In-Reply-To: <25dd9bf10701160444s1eed7edfwabd5302b022902aa@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7CE266E4B803BBFF5C768A56"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Subramani Venkatesh <subbu31mani@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7CE266E4B803BBFF5C768A56
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Subramani Venkatesh wrote:
> BTW Jan, may I know how different is the IPIPE port on the Linux-2.6.10=
 and
> the current IPIPE port on Linux-2.6.16 or Linux-2.6.18.

As you already picked a fairly new I-pipe core (1.5), the differences
will be around the kernel subsystems that changed meanwhile. Philippe
may better comment on details, still I guess no one here has tracked the
MIPS development to be aware of important changes there. Aspects to
check are specifically the timer and the IRQ subsystems. Both are under
heavy reconstruction recently, heading toward more generic
implementation which is a Good Thing also for I-pipe.

When you upgrade, going to head (then likely 2.6.20) is recommended to
avoid doing work twice - given that this kernel is stable in vanilla
form for you.

Jan


--------------enig7CE266E4B803BBFF5C768A56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFFrM3sniDOoMHTA+kRAphtAJ9xsSljQlYPGY6Qb64wCUltnDp4NgCY/clJ
omkKU3V5qdSApe7IXpa77Q==
=VhUZ
-----END PGP SIGNATURE-----

--------------enig7CE266E4B803BBFF5C768A56--

