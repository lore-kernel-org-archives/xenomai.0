Message-ID: <455DC001.2040001@domain.hid>
Date: Fri, 17 Nov 2006 14:58:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <434646.1163765689576.JavaMail.ngmail@domain.hid>
In-Reply-To: <434646.1163765689576.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA5B3F65C4B095F1F4A7425F1"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: What happens if task entry function returns?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA5B3F65C4B095F1F4A7425F1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,=20
>=20
> I found out, that is issue seems to be related to the NPTL (native posi=
x thread library).
> The pthread library in use was=20
> /lib/tls/i686/cmov/libpthread.so.0
> which is part of the Debian (testing) package libc6-i686.
> (see http://packages.debian.org/testing/libs/libc6-i686)
>=20
> When renaming the lib/tls to lib/tls.disabled the pthread library in us=
e is
> /lib/libpthread.so.0
> and then it is working perfectly!

=2E..which does not yet explain WHY the other scenario fails.

>=20
> It seems that the i686 optimized libc is not fully compatible with Xeno=
mai.

That's not true in such a common form. We are using NTPL libs for i586
and i686 (SuSE builds) without /general/ issues. Still, specific
problems like this may sleep somewhere.

> I read about this library at Romain Lenglet's web page:
> http://www.csg.is.titech.ac.jp/~lenglet/howtos/realtimelinuxhowto/index=
=2Ehtml
> I think this library uses the NPTL (Native Posix Thread Lib).
> The i686 optimized library shows the value
> NPTL 2.3.6 =20
> at=20
> getconf GNU_LIBPTHREAD_VERSION
> The "old" pthread lib shows the value:
> linuxthreads-0.10
>=20
> Now, I tried to reconfigure Xenomai with --enable-x86-sep to use
> the NPTL but this did not help either.

That only influences the way syscalls are passed down into the kernel.

> When I rename now  /lib/tls to /lib/tls.disabled, the application compl=
ains
> about the missing NPTL support in the library.
> Well, I have now a solution that works:
> I can use the standard pthread lib and not the i686 optimized NPTL.
> However, as NPTL seems to be a performance benefit, I think it could be=

> worth to get this combination up and running.
>=20
> Is there anybody out there that uses a Debian based system with the i68=
6
> optimized libc that works perfectly?
>=20
> BTW: I am using xenomai 2.2.4 from end of October.
>=20

Again my question: is the issue SMP related?

Reproducing your problem over a qemu box (with or without SMP) failed so
far for me. But I'm not on your glibc.

Jan


--------------enigA5B3F65C4B095F1F4A7425F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXcABniDOoMHTA+kRAv4aAJoDiaN1lR6lkt7dZ93bXGxwrq8zwACZAZFF
NnEK3/Hcw5X3ObujJFNIXiU=
=aXwc
-----END PGP SIGNATURE-----

--------------enigA5B3F65C4B095F1F4A7425F1--

