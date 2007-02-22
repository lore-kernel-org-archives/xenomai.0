Message-ID: <45DD99D1.9000600@domain.hid>
Date: Thu, 22 Feb 2007 14:25:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] hello xenomai world?
References: <bc4264770702220311m604b0dcdh2543e40405451147@domain.hid>	
	<45DD7E00.8020505@domain.hid>
	<bc4264770702220456se1cb181r8aee5fde75c93db4@domain.hid>
In-Reply-To: <bc4264770702220456se1cb181r8aee5fde75c93db4@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2C285D32848B2E0E439387F3"
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
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C285D32848B2E0E439387F3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi Jan,
>=20
> Thanks that looks a lot more comprehensible. I cannot make it however
> it seems to rely on a big heap of XENOCONFIG things. Due to my live
> setup those must have got lost. Are they stored somewhere (I see a
> xeno_config file mentioned somewhere) and can I load them in some easy
> manner? Otherwise where would be the best place to learn what they are
> and how I must get them into the shell environment?

See, you seem to manage choosing the complicated, non-standard way of
doing things first. Now try to solve your issues one by one, not in
arbitrary order.

1. Make your kernel boot fine, including all desired modules, without
having it issue any kind of error messages. Bootlogs are under /var/log,
just look into those files.

2. Check where you have installed the user space part. Default is
/usr/xenomai, and for a first run it's probably wise to keep this.

3. Check if you can build the examples repository. If you installed the
user space part to default location, it must work with only providing
the "make KSRC=3D<path-to-kernel-src>" as described in the Makefile.
Inside examples/native, you even just need to type "make".

>=20
> I am also looking at your url to the xenomai CAN documentation. Strange=
ly
> when I read about it there is looks a lot more friendly than in the
> code or the utils.
>=20
> I will presume (and hope)  that what I have to do is just much simpler
> than what Wolfgang is doing there :)
>=20
> I won;t be using printf in my final application I hope. It will be in
> C++ with Qt and I fear I am going to battle my bum off to get that
> going......
>=20

We can come back to this once the first part is working.

Jan


--------------enig2C285D32848B2E0E439387F3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3ZnRniDOoMHTA+kRAnWmAJ9PawUgKLVooCdWIGBoFwZgKY0aPgCfeItb
lfwiFZyUTxzkp03/Q4O2HgQ=
=TjOW
-----END PGP SIGNATURE-----

--------------enig2C285D32848B2E0E439387F3--

