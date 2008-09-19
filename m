Message-ID: <48D34A49.5090202@domain.hid>
Date: Fri, 19 Sep 2008 08:44:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7ed3bc8b0809171347j6744978ck69959990435942ea@domain.hid>	
	<48D176F0.7060805@domain.hid>
	<7ed3bc8b0809181700qdcaa43dpd78d020b13afe306@domain.hid>
In-Reply-To: <7ed3bc8b0809181700qdcaa43dpd78d020b13afe306@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF2B9E40BBD7E04E28A9CAF28"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] Xenomai IRQ Disable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stuart O Anderson <soa@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF2B9E40BBD7E04E28A9CAF28
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stuart O Anderson wrote:
> Oh - I forgot to mention - when I boot the machine, about 50% of the
> time it comes up with the keyboard and mouse locked by the time it
> gets to a login screen.  The rest of the time it's fine until I run my
> rtnet program.  I suspect this is because some interrupt is randomly
> getting assigned on boot to one processor or the other, and when it's
> the wrong one things break?
>=20
> ipipe version: 2.0-08
> kernel config: attached
> varying versions: will try this when I have more time
> playing with affinities: I'm trying to find documentation for
> /proc/xenomai/affinity - do you know where it is located?

Don't think we have any, however the usage is straightforward: This is a
bitmask describing the CPUs on which Xenomai threads and IRQs that will
be created in the future shall be bound to. Just set it before firing up
RTnet and your application.

BTW, I found a hint on an "IRQ19 issue" in my archive, but I still need
to interview my colleague on details.

Jan

PS: Please keep the list in CC.


--------------enigF2B9E40BBD7E04E28A9CAF28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjTSkkACgkQniDOoMHTA+mvUgCeIM23ivxSiyXvurqAQVx5C0s9
fqIAniJgmtylw/hOcsvfseCdX+Z1pQ6r
=d+3I
-----END PGP SIGNATURE-----

--------------enigF2B9E40BBD7E04E28A9CAF28--

