Message-ID: <4C68FB95.8060400@domain.hid>
Date: Mon, 16 Aug 2010 10:49:25 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <76E258664B189C4CBEF125491CA11ECC945840392E@KCINPUNHJCMS01.kpit.com>
In-Reply-To: <76E258664B189C4CBEF125491CA11ECC945840392E@KCINPUNHJCMS01.kpit.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig169CEE32E6F63037EAE5515C"
Subject: Re: [Xenomai-help] HELP:  Xen kernel on non-Xen host
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
--------------enig169CEE32E6F63037EAE5515C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 16.08.2010 07:43, Zafar Iqbal wrote:
> Dear Sir,
>
> I followed the way as Instructed in the website http://www.xenomai.org/=
index.php/Building_Debian_packages, for the installation of Xenomai patch=
 in my Ubuntu Machine.
>
> I am reminding you that I am using UBUNTU 10.04.
> Kernel version linux-2.6.32.18
> xenomai-2.5.4.
>
> While Building everything was fine and I was able to create the images =
successfully.
> The following packages was made sucessfully:
>      linux-image-2.6.32.18-xenomai-2.5.4
>      linux-headers-2.6.32.18-xenomai-2.5.4=20
>
> But at the time of Installation with the following command=20
> dpkg -i linux-image*.deb
>
> I got the problem in the following steps. and the bootloader(GRUB) was =
not updated with the xenomai patched kernel image
>
> Searching for default file ... found: /boot/grub/default
> Testing for an existing GRUB menu.lst file ... found: /boot/grub/menu.l=
st
> Searching for splash image ... none found, skipping ...
> Ignoring Xen kernel on non-Xen host: vmlinuz-2.6.32.18-xenomai-2.5.4
>
> Please Suggest me the possible solution for the above problem.
>  =20

Try to rename the kernel, don't use 'xen' in the kernel name, example:

vmlinuz-2.6.32.18-xn-2.5.4

That was a problem, years ago. However, using -xenomai-2.5.3 worked
for me with Ubuntu 10.04. (Was just a test with ubuntu, i'm using debian)=


If you have grub and not grub2, try to upgrade to grub2.

Stefan

> Thanks and Regards,
> Zafar
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>  =20



--------------enig169CEE32E6F63037EAE5515C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkxo+5sACgkQIPTw9rIdn6pMeQCeLo3CMrzzIiBOWR3Rcv4mxiQd
dl4AoIBvm16TzCcayTgLkapw30g+ZO56
=Qfty
-----END PGP SIGNATURE-----

--------------enig169CEE32E6F63037EAE5515C--

