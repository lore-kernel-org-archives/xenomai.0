Message-ID: <45212AA7.7010705@domain.hid>
Date: Mon, 02 Oct 2006 17:05:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Issue installing Xenomai 2.2.3 on Ubuntu 6.06
	using	kernel 2.6.17
References: <7658F43095156B4C8791BCF468A298FE08E5D8B9@domain.hid>
In-Reply-To: <7658F43095156B4C8791BCF468A298FE08E5D8B9@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig022C2CE6F9AEB557BD5B00C1"
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
To: "Montibus, Vincent (GE Healthcare)" <Vincent.Montibus@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig022C2CE6F9AEB557BD5B00C1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Montibus, Vincent (GE Healthcare) wrote:
> Hi all,
> =20
> I've been spending last week in trying to setup xenomai 2.2.3 on a
> 2.6.17 Kernel (from kernel.org).
> I have the kernel 2.6.17 sources in /tmp/linux.
> I have Xenomai 2.2.3 sources in /tmp/xenomai.
> =20
> Here are the steps I followed :
>=20
> *	cd /tmp/xenomai=20
> *	scripts/prepare-kernel.sh --linux=3D../linux
> --adeos=3Dksrc/arch/i386/patches/adeos-ipipe-2.6.17-i386-1.4-00.patch
> --arch=3Di386=20
> *	cd ../linux=20
> *	cp /boot/.config .config (in order to use a working .config
> file)=20
> *	make xconfig=20
> *	make-kpkg clean=20
> *	make-kpkg -initrd --revision=3D386 kernel_image kernel_headers
> modules_image=20
> *	dpkg -i kernel_headers... .deb=20
> *	dpkg -i kernel_image... .deb=20
> *	modify grub menu.lst in order to pass "lapic=3D1" as boot
> parameter for the kernel=20
> *	Reboot on the xenomai patched kernel
>=20
> The boot hangs up every time at the same level :
> =20
> I-pipe: Domaine Xenomai registered
> Xenomai: hal/x86 started
> Xenomai: real-time nucleus v2.2.3 (Memories) loaded
> Xenomai: starting native API services
> Xenomai: starting RTDM services
> ...
> Limiting direct PCI/PCI transfert.
> =20
> I have no clue on where to start my investigation and on what am I doin=
g
> wrong.
> =20
> I joint with this mail the .config file used.

Maybe it's our old friend MSI again. Please try to disable
CONFIG_PCI_MSI to see if the situation improves and report back. If not,
try to disable Xenomai and boot your box only with I-pipe enabled.

Jan


--------------enig022C2CE6F9AEB557BD5B00C1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFISqnniDOoMHTA+kRAoEVAJ0VTRAlvn4r0FVR08VTqbiO3l1+iwCeJkHj
ViH8rs6fXO1sH/JXrYPPjHI=
=H3EJ
-----END PGP SIGNATURE-----

--------------enig022C2CE6F9AEB557BD5B00C1--

