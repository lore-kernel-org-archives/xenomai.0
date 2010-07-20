Message-ID: <4C45770F.10302@domain.hid>
Date: Tue, 20 Jul 2010 12:14:39 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid>
In-Reply-To: <4C45539B.70204@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0FECB268856C1AF21BEA07FD"
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0FECB268856C1AF21BEA07FD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20.07.2010 09:43, Theo Veenker wrote:
> Hi,
>
> I want to upgrade all our PC's from Ubuntu hardy to lucid and in the pr=
ocess
> I'm also going from kernel 2.6.29.5 with Xenomai 2.4.8 to kernel 2.6.32=
=2E11
> with Xenomai 2.5.3.
>
> I first built and tested the 2.6.32.11 kernel with 2.5.3 on my hardy sy=
stem
> and all went fine. But the problem is it just doesn't run on the lucid =
distro.
> However the vanilla kernel runs fine. I also tried with a config based =
on the
> ubuntu lucid config, with relevant modules compiled in (I don't use ini=
trd).
>  =20

Are you sure it's not initrd related ?

After installing the kernel with dpkg --install i had to run
'# update-initramfs -c -k all' and '# update-grub' manually.
This is not necessary on debian lenny/squeeze and worked
(if I remember correctly) with ubuntu karmic too.
Check in your grub config if there is a initrd entry.

Stefan

> It looks like the same problem as in this thread:
> https://mail.gna.org/public/xenomai-help/2010-06/msg00008.html
> Just a black screen after the boot loader. The keyboard leds responds t=
o
> capslock etc for a few seconds.
>
> What could it be that with identical hardware the same kernel runs fine=
 (with
> decent latencies) under ubuntu hardy and not at all under ubuntu lucid?=
 I
> also tested another (older) system with a different mobo. Same result.
>
> If there's anyone running a recent kernel with Xenomai 2.5.3 on an ubun=
tu lucid
> system, could you please send me the kernel config?
>
> Thanks,
> Theo
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>  =20



--------------enig0FECB268856C1AF21BEA07FD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkxFdxYACgkQIPTw9rIdn6rJRACeKpHSdpH0lgxKUOPT6QrBFApA
LYoAn0VlUiups3kITvsn86GMWZwIJYpo
=Gpr0
-----END PGP SIGNATURE-----

--------------enig0FECB268856C1AF21BEA07FD--

