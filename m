Message-ID: <4C695C36.1030308@domain.hid>
Date: Mon, 16 Aug 2010 17:41:42 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <76E258664B189C4CBEF125491CA11ECC9458403922@domain.hid>	<76E258664B189C4CBEF125491CA11ECC9458403925@domain.hid>	<1281597159.1730.71.camel@domain.hid>	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD14F757@domain.hid>,
	<4C642F04.4020008@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065786@domain.hid>,
	<4C651A5D.9030101@domain.hid>,
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065788@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065789@domain.hid>
In-Reply-To: <E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065789@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6DB864BD92F984B0D723ADEC"
Subject: Re: [Xenomai-help] 2.6.32.18/x86 (Ubuntu) hangs at boot w/ Xenomai
 2.5.3 [was: HELP]
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Hemal C.Bavishi" <Hemal.Bavishi@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DB864BD92F984B0D723ADEC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 13.08.2010 12:28, Hemal C.Bavishi wrote:
> Dear Stefan,
>
> I have taken the snapshopts of the command prompt and attached below fo=
r your reference
>
> root@domain.hid:~# update-initramfs -c -k all
> update-initramfs: Generating /boot/initrd.img-2.6.32-24-generic
> update-initramfs: Generating /boot/initrd.img-2.6.32-21-generic
> root@domain.hid:~# update-grub
> Generating grub.cfg ...
> Found linux image: /boot/vmlinuz-2.6.32.15-xenomai-2.5.4
> Found linux image: /boot/vmlinuz-2.6.32-24-generic
> Found initrd image: /boot/initrd.img-2.6.32-24-generic
> Found linux image: /boot/vmlinuz-2.6.32-21-generic
> Found initrd image: /boot/initrd.img-2.6.32-21-generic
> Found memtest86+ image: /boot/memtest86+.bin
> Found Microsoft Windows XP Professional on /dev/sda1
> done
> root@domain.hid:~#
>  =20

According to your "Task execution order"-mail it seems you finally fixed
this initrd-problem.
What did you do to solve the issue ? Is something wrong/unclear in the
"building debian packages howto" that could be improved ? Do I need to
add the "update-initramfs, update-grub" to the howto for ubuntu lucid ?

Thanks. Stefan

> [cut]



--------------enig6DB864BD92F984B0D723ADEC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkxpXD0ACgkQIPTw9rIdn6ohlACfUJhSSxX6pqNUcD5zEF+SDakr
BQgAnjDENBTqifNXlc6oIDO25TSEW6Kj
=g4eU
-----END PGP SIGNATURE-----

--------------enig6DB864BD92F984B0D723ADEC--

