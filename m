Message-ID: <4E61D028.3000702@domain.hid>
Date: Sat, 03 Sep 2011 08:58:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CAG0ejMHDxOXE-UTuO-iuE-ZcsN2-bLE+tx3ik6G=t_3HrsR0NA@mail.gmail.com>
In-Reply-To: <CAG0ejMHDxOXE-UTuO-iuE-ZcsN2-bLE+tx3ik6G=t_3HrsR0NA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig70506F3510B7F872B4E9A46F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] xenomai-core ftrace
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rainbow <lvqq05@domain.hid>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig70506F3510B7F872B4E9A46F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-09-03 04:52, rainbow wrote:
> hi,all,I want to use ftrace in xenomai-2.5.6,but when I use git://
> git.kiszka.org/ipipe.git queues/2.6.35-x86-trace to get the linux
> kernel,there is no option about xenomai or ipipe . If I want to patch t=
he
> xenomai patch,there are some problem. How should I use ftrace on
> xenomai?Thanks!

First of all, make sure to read README.INSTALL in the Xenomai tree for
the basic installation procedure.

That git branch above replaces the installation step of picking a
vanilla Linux source tree and applying the ipipe patch to it (if there
is no ipipe option in the kernel config, you probably haven't check out
the right branch yet).

The next step would be running Xenomai's prepare-kernel.sh, in this case
using a Xenomai tree that has the required ftrace patches, see

http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/7966

Jan


--------------enig70506F3510B7F872B4E9A46F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5h0CsACgkQitSsb3rl5xTZKwCcCfORgYWMsn2ZAp/qjldn1rho
/McAnjq4JoxWoGPMVR1Ymqmz5+xxm8V8
=KBZ1
-----END PGP SIGNATURE-----

--------------enig70506F3510B7F872B4E9A46F--

