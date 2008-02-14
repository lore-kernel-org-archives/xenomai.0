Message-ID: <47B3F307.3030109@domain.hid>
Date: Thu, 14 Feb 2008 08:51:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080214073423.118970@domain.hid>
In-Reply-To: <20080214073423.118970@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0F3DA67EED2D737DFD12C8B6"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] code -19 after rebooting the xenomai-kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: timo.pallach@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0F3DA67EED2D737DFD12C8B6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

timo.pallach@domain.hid wrote:
> Hi,
>=20
> I am tying to install Xenomai on a Beckhoff CX1010.
>=20
> I use the following components:
> Adeos: adeos-ipipe-2.6.22-i386-1.10-12.patch
> Xenomai: xenomai-2.4.1.tar.bz2
> Linux: actual linux-source-2.6.22.tar.bz2 from the ubuntu repository (u=
buntu-server)

In order to benefit from latest bug fixes, I recommend Xenomai 2.4.2=20
with a more recent kernel, preferably a vanilla kernel (unless you know=20
the differences in details...).

>=20
> The compilation works without errors
> ("make-kpkg --initrd --revision=3D$KERNEL_REVISION_XENOMAI kernel_image=
").
> After installing the the kernel via "dpkg -i $XENOMAI_KERNEL.deb" reboo=
ting into the new XENOMAI_KERNEL fails showing the attached lines in the =
dmesg.
>=20
> Is there some additionally debug or log information of the xenomai-syst=
em?
> Or does any one have any ideas what I am doing wrong?
>=20

Please read the log carefully:

> [   34.335779] Xenomai: Local APIC absent or disabled!
> [   34.335788]          Disable APIC support or pass "lapic=3D1" as boo=
tparam.

:)

Jan


--------------enig0F3DA67EED2D737DFD12C8B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHs/MKniDOoMHTA+kRArdAAJ0REMjRnltPThh4b++7p1l80X16VACeM82r
zPXOAffUjvRU5DjRZLXFnvc=
=ZMW1
-----END PGP SIGNATURE-----

--------------enig0F3DA67EED2D737DFD12C8B6--

