Message-ID: <4D8C5C8A.9090605@domain.hid>
Date: Fri, 25 Mar 2011 10:12:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTi=BBfLtXpYDzd2XxRmb58mP2M0QuBoP05_04PAH@mail.gmail.com>
In-Reply-To: <AANLkTi=BBfLtXpYDzd2XxRmb58mP2M0QuBoP05_04PAH@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6B8DED78CF774EE6D33A2177"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] help:Can xenomai cooperate with such Xen ,
 KVM or other virtual machine and work well?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: alamo hwuang <lovealamo@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B8DED78CF774EE6D33A2177
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-03-25 03:20, alamo hwuang wrote:
> hello ,every one.
>=20
> I want to use the xenomai into the virtual machine. But I havd doubt
> that xenomai works upon adeos and hardware. Can xenomai works well
> with Xen ,KVM or other virtual machine ?  Is there no any possible?

It's working fine in KVM. We also have it running under VirtualBox,
though you then have to set a fixed CPU frequency as VBox does not
support paravirtual TSC calibration. Xen in HVM mode should work as
well, but I never tested it. Anyway, the major advantages of KVM are
that it's simple to set up (it's part of Linux) and that you can debug
the Xenomai kernel or drivers (when passing PCI devices through) at
source code level.

That said, none of the solutions currently provide any real-time
guarantees. There is WIP to improve KVM, but the result will likely be
at least one order of magnitude worse than real hardware.

Jan


--------------enig6B8DED78CF774EE6D33A2177
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk2MXI4ACgkQitSsb3rl5xTL/ACeKMLG65v0BtqqXkWJAAEmJxbY
LAUAnRd+pXTfP5IjJSaWQUkLq9k7VQCe
=RjVC
-----END PGP SIGNATURE-----

--------------enig6B8DED78CF774EE6D33A2177--

