Message-ID: <449A5549.40104@domain.hid>
Date: Thu, 22 Jun 2006 10:31:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM driver add-on infrastructure
References: <449A3AAE.7090403@domain.hid>
In-Reply-To: <449A3AAE.7090403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig488109AEC8A074EAB52DDE22"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig488109AEC8A074EAB52DDE22
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> I'm currently implementing a RTDM real-time CAN driver, which raises th=
e
> the problem of adding the driver to the Xenomai source tree. My first
> idea was to provide RTCAN as a patch for Xenomai:

So you prefer to maintain RTCAN out-of-tree on the long term? What are
the reasons?

>=20
>   $ cd xenomai
>   $ patch -p1 < xenomai-rtcan-add-on.patch
>   $ scripts/prepare_kernel ...
>   ...
>   $ <configure and make kernel>
>   $ <configure, make and install Xenomai user space stuff>
>=20
> This does not work because of autoconf files needed to copy header file=
s
> to the installation path. Is this really necessary?
> Another issue is where to put utility and test programs. Making them
> without autoconf and friends works by using xeno-config. But they shoul=
d
> be installed with make install as well. Likely there are other issues.
>=20
> Any ideas or comments on how to provide a generic RTDM driver add-on
> infrastructure?

When you first talked about an "RTDM plugin" interface for Xenomai, I
got the idea of dragging external sources into the Xenomai kernel build
process. I haven't thought about this technically yet, but it would
allow to keep driver source packages maintained externally while still
providing them the option to become built into the kernel.

Ok, let's think about this for a while: We would need some management
script(s) to link an external source tree into the config and build
process, the remove it again, and probably to give a list of the
currently active plugins. Should be feasible without huge magic,
shouldn't it? But does this make sense, is it desirable (to me it is
when I think about making RTnet build cleanly against 2.6.17 yesterday...=
)?


This does not address your user mode utils, but I think they should
rather be distributed independently (something I have in mind for RTnet
as well once we ever switch from /dev/rtnet to some RTDM socket/device
for config work). The required rtdm/rtcan.h should be merged into
Xenomai, yet unmerged revisions could alternatively come with the
rtcan-utils packages to make it build (autoconf if your friend to detect
the available revision).

Jan


--------------enig488109AEC8A074EAB52DDE22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEmlVOniDOoMHTA+kRAriBAJoDKNRhYETEevSDRh618qg8t/jcnwCfXMZ0
NPgYBMIo36FcCbF++7Iy55s=
=qUl2
-----END PGP SIGNATURE-----

--------------enig488109AEC8A074EAB52DDE22--

