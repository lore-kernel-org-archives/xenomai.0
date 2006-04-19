Date: Wed, 19 Apr 2006 17:29:14 +0200
From: Luotao Fu <l.fu@domain.hid>
Subject: Re: [Xenomai-help] strangeness at kernel configuration
Message-ID: <20060419152914.GB13542@domain.hid>
References: <20060418144146.GA4482@domain.hid>
	<20060418153508.GB4482@domain.hid>
	<44450DDF.9080205@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <44450DDF.9080205@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philipe,

On Tue, Apr 18, 2006 at 06:03:43PM +0200, Philippe Gerum wrote:
> Luotao Fu wrote:
> Your configuration works perfectly here over #944. You might want to=20
> restart building from a freshly patched kernel anew, there seems to be=20
> something badly broken in your current tree, perhaps some mismatching=20
> modules that have not been recompiled properly?
>=20
> --=20
>=20
> Philippe.
Thanx for testing. I, however could locate the problem at the APIC
Timer function in the kernel: With=20
=2E.....
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
=2E.....
I could reproduce the problem (loading rtdm driver causes oops, cannot run
any application using native or posix skin) reliably on my machine.=20
(Celeron 733MHz. 256MB RAM...a normal PC) Shutting off the APIC stuffs,
however, solves the problem........ Have I overlooked
anything or does Xenomai have problems with the apic controller on
celeron (since it seems to work for you)?

regards
Luotao Fu

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFERldKiruQY+UyUmERAiDuAJ4n4YurnbIypgYMQB4q8EvMZQKAUACfa6hp
wQqzFFiU4EbtEXAhxIrqW4c=
=s/y1
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--

