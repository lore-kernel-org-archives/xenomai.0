From: Raistlin <raistlin@domain.hid>
In-Reply-To: <49F06D77.7050103@domain.hid>
References: <1043994168.4085071240493189508.JavaMail.root@domain.hid>
	<49F06D77.7050103@domain.hid>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-XexnlFWG75mSEQU+7Ov9"
Date: Thu, 07 May 2009 13:23:14 +0200
Message-Id: <1241695394.6157.7.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] Problem of freeze
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>


--=-XexnlFWG75mSEQU+7Ov9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-04-23 at 15:30 +0200, Gilles Chanteperdrix wrote:
> > I use xenomai with the patch adeos-ipipe-2.6.28.9-x86-2.2-07.patch from=
 the Xenomai git
> >=20
> > But i have the same problem :(
Just to make you know that I'm (still) experimenting exactly the same
random freeze on Ubuntu Jaunty, with 2.6.28.9 kernel,
adeos-ipipe-2.6.28.9... patch and xenomai-git (but I think that does not
matter, since it seems a kernel issue!!)

> I see that you are using X-window, so I guess you do not see the
> console. Unfortunately, if your hang is due to a kernel oops we do not
> have a clue. So, you should try and get the console output on another
> machine, using preferably a serial cable, or if not possible the netconso=
le.
I'll try to setup a netconsole environment as soon possible and let you
know what I can see in the kernel logs.

Regards,
Dario

--=20
<<This happens because I choose it to happen!>> (Raistlin Majere)
----------------------------------------------------------------------
Dario Faggioli, ReTiS Lab, Scuola Superiore Sant'Anna, Pisa  (Italy)

http://blog.linux.it/raistlin / raistlin@domain.hid /
dario.faggioli@domain.hid

--=-XexnlFWG75mSEQU+7Ov9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoCxJwACgkQk4XaBE3IOsRYlACeL7e6KRCnK4uvL5jjilyNPc8m
+rQAoKkvyWGxV2c2xAhDXdVH1wxyXR9M
=zEgV
-----END PGP SIGNATURE-----

--=-XexnlFWG75mSEQU+7Ov9--


