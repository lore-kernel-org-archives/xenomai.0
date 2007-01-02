Message-ID: <459A7A35.2060508@domain.hid>
Date: Tue, 02 Jan 2007 16:28:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <459A31E3.40807@domain.hid> <1167744149.30347.2.camel@domain.hid>	
	<459A5E92.6030504@domain.hid> <1167745769.30347.6.camel@domain.hid>	
	<459A64A9.4060707@domain.hid>
	<1167747223.30347.10.camel@domain.hid>	 <459A6A88.8000803@domain.hid>
	<1167749589.30347.35.camel@domain.hid>
In-Reply-To: <1167749589.30347.35.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6ADF90820CFD6E79B0B78B82"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Timer patches evaluation (was: SVN checkin #2010)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6ADF90820CFD6E79B0B78B82
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> ...
> Not that I would be particularly fond of that, mm, thing, but this woul=
d
> allow to fix the bogus x86+8254 setup relic, which is likely the only
> one which would cause any significant delay among the supported
> archs/platforms.

BTW, could we define some concrete metrics to asses all the ongoing
changes performance-wise? We have the timerbench, we have cyclictest
(for large number of timers and for POSIX tests), we have the enhanced
runtime statistics for threads and IRQs, now we just need to create
meaningful test scenarios and run them / let them run on the different
platforms.

Interesting is, e.g., how the timer subsystem scales worst case-wise and
what piece of the cake remains for Linux under high timer load.
Moreover, there is still that tsc2ns conversion improvement to work out
- and then to evaluate...

Jan


--------------enig6ADF90820CFD6E79B0B78B82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFmno1niDOoMHTA+kRAiwmAJ9aUE2xShQN5/LWvvAHRQlpXbvGewCeId2b
ihmHXaM/tayGbEH1UmgS2bo=
=Io7/
-----END PGP SIGNATURE-----

--------------enig6ADF90820CFD6E79B0B78B82--

