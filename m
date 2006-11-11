Message-ID: <4555A4FE.2090500@domain.hid>
Date: Sat, 11 Nov 2006 11:25:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Sudo not found when running the latency test
References: <ff1d78710611110157v20f11fd5ibb35b60502a6dbdb@domain.hid>
In-Reply-To: <ff1d78710611110157v20f11fd5ibb35b60502a6dbdb@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5328DC94A1CB8B041D37EA3C"
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
To: Steven Kauffmann <steven.kauffmann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5328DC94A1CB8B041D37EA3C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Kauffmann wrote:
> Hi,
>=20
> We're using an embedded system, the Virtex2pro from Xilinx (XC2VP300). =
This
> chipset includes 2 powerpc's (ppc-405) and a FPGA. We're running a linu=
x
> kernel from denx (20060707) patched with 'adeos-ipipe-2.4.25-ppc-CVS-
> 20060707-1.1-04.patch '. We got the linux kernel from denx with cvs:
>        cvs -d :pserver:anonymous@domain.hid login
>        cvs -z6 -d :pserver:anonymous@domain.hid co -P -D 2006=
0707
> linuxppc_2_4_devel
> We got xenomai with svn:
>        svn co svn://svn.gna.org/svn/xenomai/branches/v2.2.x
> xenomai_branches
>=20
> With the Xilinx software (EDK 8.1) we built board support packages for =
the
> kernel.  We use the crosstool from
> <http://kegel.com/crosstool/#download> to build the ppc crosscompiler.
>=20
>=20
> We build the rootfilesystem with the busybox_1_1_stable release. We got=
 the
> following error when running the latency test: "./run".
>=20
> *
> *
> * Type ^C to stop this application.
> *
> *
> /usr/xenomai/bin/xeno-load: /usr/xenomai/bin/xeno-load: 249: sudo: not
> found
>=20
> If we run "./latency", no error occurs.
>=20
> Did we forget something obvious?  What would be the best way to debug t=
his
> situation?  Any hints are welcome!

It's a bug in the xeno-load script for the benchmarks which prevents the
execution over busybox. Fixed in the 2.3 branch, maybe we should
back-port it.

Jan


--------------enig5328DC94A1CB8B041D37EA3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFVaT+niDOoMHTA+kRAptrAJ9iyoqaLrVGCo7DIYPnapzjzR37XACfRMey
IpWC9JF0xC0d0KtJ3lTN+0Y=
=Bnkq
-----END PGP SIGNATURE-----

--------------enig5328DC94A1CB8B041D37EA3C--

