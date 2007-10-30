Message-ID: <4726EB6E.8020207@domain.hid>
Date: Tue, 30 Oct 2007 09:29:34 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47266BC6.7060807@domain.hid>
In-Reply-To: <47266BC6.7060807@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6D61355EA92AB7DA408D7B56"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] build kernel missing  System.map, vmlinuz,
 initrd when using $xenomai_root/configure --enable-x86-sep
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dennis Nguyen <dennisnguy@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D61355EA92AB7DA408D7B56
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dennis Nguyen wrote:
> I followed the README from xenomai to build kernel+xenomai:
> -prepare-kernel.sh ...
> cd $linux_tree
> make menuconfig
> make bzImage modules
> make modules_install

make install?

>=20
> When ever I used $xenomai_root/configure --enable-x86-sep, It won't=20
> create System.map vmlinux, and initrd under/boot.
>=20
> I used different combo kernel linux-2.6.20.10 with xenomai-2.3.4.
> kernel linux-2.6.22.10 with xenomai-2.4-rc4.
> kernel linux-2.6.22.10 with xenomai 2.4-rc5.
> The result for the System.map vmlinux, and initrd under /boot are the=20
> same.  If I do not used the configure --enable-x86-sep then the files=20
> built under /boot.
>=20
> Any suggestion please,
> Thanks
> Dennis

Jan


--------------enig6D61355EA92AB7DA408D7B56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHJutuniDOoMHTA+kRAjrxAJ99iMNqaB+yu6liMMYsqymDxhHhsQCeNbNf
Ue8UjMfjy9tC6ylfHNy8yMM=
=XUx2
-----END PGP SIGNATURE-----

--------------enig6D61355EA92AB7DA408D7B56--

