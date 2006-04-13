Message-ID: <443DFD88.4020000@domain.hid>
Date: Thu, 13 Apr 2006 09:28:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] BuildBot progress for sim, tqm860 with RTnet
References: <200604130659.23223.niklaus.giger@domain.hid>
In-Reply-To: <200604130659.23223.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF7333540314599D3184D23BD"
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF7333540314599D3184D23BD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Hi
>=20
> I was busy improving the buildbot setup and achieved the following:
> - added build slave for simulator
> - added a buildbot for a TQM860L with Denx PPC 2.4 kernel. Cannot yet b=
uild=20
> the RTnet code.
> - patched buildbot to show names for shell build steps instead of the c=
ommands
> - Hacked buildbot to improve the displayed names of the build step
>   (e.g. "configure_xenomai" instead of "configure 2".=20
>=20
> I will look at Philippe's idea about collecting xenomai statistics late=
r,=20
> because it demands more time and effort to implement.
>=20
> The following details are probably only of interest for people interest=
ed in=20
> TQM860 and/or RTnet.
>=20
> My setup for the TQM860 was the following:
> - Got Dan Kegel crosstool 0.42
> - Compiled/installed the demo-ppc860 (gcc-3.4.1-glibc-2.3.3)
> - Used linuxppc_2_4_devel-2006-04-06-1735.tar.bz whith a TQM860L_defcon=
fig
>   plus XENOMAI extensions
> - Got RTnet trunk via SVN
>=20
> Could the interested parties please comment, whether this is a good=20
> combination or whether they prefer something different? If you follow t=
he=20
> logs you are able to see each step and configuration option (except bui=
lding=20
> the crosstool).
>=20
> configure rtnet fails with the following message:
> checking for=20
> RT-extension... /home/buildslave/bin/linuxppc_2_4_devel-2006-04-06-1735=
=20
> (Xenomai 2.0.x)
> checking for Xenomai version... configure: error: *** Unsupported Xenom=
ai=20
> version 2.1.50 in /home/buildslave/bin/linuxppc_2_4_devel-2006-04-06-17=
35
> Is the error correct? Or should I build only against Xenomai 2.0?

No, the trick is to pick the correct --with-arguments - or use
interactive configuration where it is explained that you first have to
decide about the build model (classic like 2.0.x or in-kernel). When
using configure directly (I'm citing --help ;) ):

  --with-rtext=3DRT-EXTENSION
                          installation path of RTAI or Xenomai 2.0.x
  --with-linux=3DLINUX      real-time extended Linux kernel
  --with-rtext-config=3DCONFIG-PATH
                          path of the RT-extension's config tool

So, either use the first switch for 2.0.x or the two others for 2.1 and
above. But the advantage of the make *config path is that RTnet will
leave a .rtnet_config behind which can easily be reused with make oldconf=
ig.

Keep up your great work!

Jan


--------------enigF7333540314599D3184D23BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPf2NniDOoMHTA+kRAlZZAJ9hA4FyiSLS68oVI2ayOIQUpD6mvgCdHuuu
ztJCwFPUoYAnRwAYMJBJ7fA=
=LQkj
-----END PGP SIGNATURE-----

--------------enigF7333540314599D3184D23BD--

