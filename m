Message-ID: <4EE343DA.6050703@domain.hid>
Date: Sat, 10 Dec 2011 12:34:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E981AFB.40106@domain.hid>
In-Reply-To: <4E981AFB.40106@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig130866644318FDF830CFD298"
Subject: Re: [Xenomai-core] [PULL] KVM awareness / tiny cleanup
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig130866644318FDF830CFD298
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-10-14 13:20, Jan Kiszka wrote:
> The following changes since commit 31bdadef9018de586bc3fe8de0f37b62b250=
7785:
>=20
>   testsuite: fix regression tests location (2011-10-14 01:46:08 +0200)
>=20
> are available in the git repository at:
>   git://git.xenomai.org/xenomai-jki.git for-upstream
>=20
> Jan Kiszka (2):
>       nucleus: Privatize __xnpod_reset_thread
>       x86: Fire root preemption notifier
>=20
>  include/asm-generic/hal.h     |    5 +++++
>  include/asm-x86/bits/pod_32.h |    2 ++
>  include/asm-x86/bits/pod_64.h |    2 ++
>  include/nucleus/pod.h         |    2 --
>  ksrc/nucleus/pod.c            |    8 ++++----
>  5 files changed, 13 insertions(+), 6 deletions(-)
>=20
> Two trivial changes, though the second one actually adds a noteworthy
> feature to Xenomai: co-location of KVM guests on x86. That feature
> depends on I-pipe changes posted in [1].
>=20
> Jan
>=20
> [1] http://thread.gmane.org/gmane.linux.kernel.adeos.general/1898
>=20

Ping?

I've just pushed a trivial rebase.

Jan


--------------enig130866644318FDF830CFD298
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7jQ9sACgkQitSsb3rl5xRbIwCfcbh3wwAzikL2MTrdFYa7CaPi
8CgAoL/sHQvbyHIDx4mq0AFI561X60VO
=EYBh
-----END PGP SIGNATURE-----

--------------enig130866644318FDF830CFD298--

