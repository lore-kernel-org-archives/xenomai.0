Message-ID: <44770814.5040009@domain.hid>
Date: Fri, 26 May 2006 15:52:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Porting xeno-{info|load|test} to a busybox system
References: <200605252134.08614.niklaus.giger@domain.hid>
In-Reply-To: <200605252134.08614.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9C55CCB38432B4BA7688766E"
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
--------------enig9C55CCB38432B4BA7688766E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> ...
> If anybody has a working target with a Xenomai + BusyBox combination an=
d would=20
> be willing to test drive my changes, I would appreciate a feedback=20
> enormously.

Did so, and here comes the result: :)

> Index: scripts/xeno-info
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- scripts/xeno-info	(Revision 1135)
> +++ scripts/xeno-info	(Arbeitskopie)
> @@ -1,31 +1,51 @@
> -#!/bin/sh
> +#! /bin/sh
>  #
>  # This file has been lifted 'as is' from linux/scripts/ver_linux.
> -#
> +# Adapted to be run also under the BusyBox. If you want to test it und=
er the BusyBox use
> +# busybox sh xeno-info=20
> =20
>  PATH=3D/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:$PATH
>  echo 'If some fields are empty or look unusual you may have an old ver=
sion.'
>  echo 'Compare to the current minimal requirements in Documentation/Cha=
nges.'
>  echo ' '
> =20
> +withBusybox=3D0
> +if test -L $SHELL ; then # is sh a logical link to busybox
> +    exeName=3D`ls -l $SHELL|cut -d\>  -f2`
> +    if test "`basename $exeName`" =3D "busybox";  then
> +	withBusybox=3D1; else echo 2.3
> +    fi
> +elif test -n "$_" -a "`basename $_`" =3D "busybox"; then
> +    withBusybox=3D1;
> +# else running a real /bin/sh (bash) shell
> +fi

This may become fragile (and it already is on my hacked system). The
reason: plans exist to allow compiling bb into multiple binaries again,
thus sh will not be linked to busybox, but to ash e.g.

What about this:

withBusybox=3D0
if sh --help 2>&1| grep -q BusyBox; then
    withBusybox=3D1;
# else running a real /bin/sh (bash) shell
fi
echo withBusybox is $withBusybox


When using this variant, I get the following messages:

> /bin/xeno-test: /bin/xeno-test: 177: zgrep: not found

What about zcat | grep instead? Moreover, I failed to find a zgrep bb
applet. Did you copy that stuff on your box?

> /bin/xeno-test: /bin/xeno-test: 264: getopts: not found

getopts is off by default in bb. Is this essential for xeno-test? Then
you should state this requirement somewhere.

> /bin/xeno-test: shift: 267: Illegal number: -1

I guess this comes from the missing getopts...


Regarding workload: I typically run the cache calibrator [1] in a look,
together with some I/O load (hard disk where available, flood ping). The
loop looks like

while true; do calibrator <box-MHz> 8M /tmp/; done

<box-MHz> should be derivable from /proc/cpuinfo with some scripting. We
may just check if an inclusion of the calibrator source code is possible
(license terms...).


Lacking time right now, otherwise I would have hacked further to make
the test run. This test could be quite interesting for us here to
quickly check our processing boxes' hardware and to test new Xenomai
versions for elementary regressions when upgrading production systems
(fortunately only their CF-cards). Looking forward!

Jan


[1] http://homepages.cwi.nl/~manegold/Calibrator


--------------enig9C55CCB38432B4BA7688766E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEdwgUniDOoMHTA+kRAnckAJ9WiapO2l1cV1867zXyghEVWZSbBACcC34m
Su6L25F/oqgON/xaDV4GVSs=
=cPRO
-----END PGP SIGNATURE-----

--------------enig9C55CCB38432B4BA7688766E--

