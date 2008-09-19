Message-ID: <48D34936.7090206@domain.hid>
Date: Fri, 19 Sep 2008 08:39:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7ed3bc8b0809171347j6744978ck69959990435942ea@domain.hid>	
	<48D176F0.7060805@domain.hid>
	<894886ec0809181640t3d413a73h5c02da73dc3000c9@domain.hid>
In-Reply-To: <894886ec0809181640t3d413a73h5c02da73dc3000c9@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig668A676243A0AC7030152801"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai IRQ Disable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rob Wheeler <wheeler@domain.hid>
Cc: soa@domain.hid, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig668A676243A0AC7030152801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rob Wheeler wrote:
> I'm having similar issues with IRQs and keyboard/mouse configurations.
>  For me, if I use a combination mouse/keyboard device then the kernel
> has issues.  So I have to use the most simplistic form of USB keyboard
> I can locate.  Also, it seems to be dependent on which USB port I plug
> into.  Finally, I need to use the 'irqpoll' option to the kernel,
> otherwise I can't boot with even a simple USB keyboard.

Are these effects limited to I-pipe-patched kernels? Or do you have the
same issues with the corresponding vanilla Linux?

Jan


--------------enig668A676243A0AC7030152801
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjTSTYACgkQniDOoMHTA+mcEwCeMIJP6RZgR2tEKIm9DYUgzNGp
dEMAnR8h31PNpB9SEBcQAuv4nGcLiLO4
=YazF
-----END PGP SIGNATURE-----

--------------enig668A676243A0AC7030152801--

