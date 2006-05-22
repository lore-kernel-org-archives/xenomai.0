Message-ID: <44717FBA.1030207@domain.hid>
Date: Mon, 22 May 2006 11:09:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig674DB7D84E904B45C62CACC2"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] timer optimisations
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig674DB7D84E904B45C62CACC2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

while I originally only wanted to add timer abstraction to RTDM, I now
have patch series for xntimer pending on my box pushing this layer
closer to hrtimer.

But before posting it for discussion (needs further testing anyway), I
have two questions regarding some minor though not totally uninteresting
optimisation possibilities:

1. Is calling xntimer_start() with value=3DXN_INFINITE a real use case?
   It's not documented explicitly. The effect of such an invocation
   looks a bit like xntimer_stop(), but I didn't find a real caller so
   far to asses it's relevance.

   If it is not used and could rather be declared illegal, we could safe
   the related code in the do_timer_start handlers.

2. rthal_timer_program_shot() uses explicit rthal_local_irq_save_hw on
   ia64 and i386. Given the head optimisation, IRQs should already be
   disabled when calling this service. So, can this IRQ masking be made
   depending on !CONFIG_XENO_OPT_PIPELINE_HEAD?

   ARM uses an additional lock as well, but it's hidden inside the ipipe
   patch and is likely required to remain independent of the caller's
   properties.

Jan


--------------enig674DB7D84E904B45C62CACC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEcX++niDOoMHTA+kRAt68AJ4mifYQ7pNJBJhHDPindkFkZL8k7wCfUPSk
unV5Aipt036Gi646MjUL1Ac=
=cP1g
-----END PGP SIGNATURE-----

--------------enig674DB7D84E904B45C62CACC2--

