Message-ID: <44E20EEF.7000705@domain.hid>
Date: Tue, 15 Aug 2006 20:14:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Buildbot cannot compile xenoma: rtcanconfig
	refences pthread_kill
References: <200608150949.30029.niklaus.giger@domain.hid>
In-Reply-To: <200608150949.30029.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8D472981EA0F75F8C020C4BE"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8D472981EA0F75F8C020C4BE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Hi
>=20
> All my PPC based compilation fail with something like
> ...

Things start to work again, but other issues pop up now.

o The installation step of xenomai on the tqm860 is broken. For that
  reason RTnet fails to configure. Please have a look, Niklaus.

o The simulator fails in both the posix and vxworks part:
  http://ngiger.dyndns.org/buildbot/sim/builds/258/step-check_sim/0
  Could anyone have a look?

o The run test on the hcu_vx seems to cause a hang after the nucleus
  being loaded:
  http://ngiger.dyndns.org/buildbot/hcu_vx/builds/128/step-xeno-test/0

hcu3 is fine, a rebuild of "ppc" is currently pending.

A few remarks and wishes:

o Some list of the characteristics of those systems would be nice, just
  to gain overview what the differences are.

o Maybe it's useful to strip the kernel configs of some systems
  (non-related drivers etc.) to reduce the turn-around time.

o Some kind of allyesconfig for Xenomai would be nice. 2.4 doesn't seem
  to have this, but maybe one can derive that from a 2.6 .config, grab
  all XENO-related switches, and append them to the 2.4 .config. This
  way new stuff like the CAN stack now would get included faster.

On final remark I can only repeat over and over again:

Your buildbot is really great stuff! It significantly reduces the
round-trip time for detecting and fixing (often trivial) build issues as
long as there are not yet millions of Xenomai users updating their SVN
checkout every day ;)

Thanks,
Jan


--------------enig8D472981EA0F75F8C020C4BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE4g7vniDOoMHTA+kRAkeDAJ0dgdcJ5TRIohoKAMpbbrBWvyK29gCfQC6W
RXW0zp2b8ec26BYKUzK3Uzo=
=kcwl
-----END PGP SIGNATURE-----

--------------enig8D472981EA0F75F8C020C4BE--

