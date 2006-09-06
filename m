Message-ID: <44FEA7F5.6090409@domain.hid>
Date: Wed, 06 Sep 2006 12:50:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai + PREEMPT_RT
References: <1157501591.22250.25.camel@domain.hid>
In-Reply-To: <1157501591.22250.25.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig64A2670DE9DAADAEE9706554"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: dwalker@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig64A2670DE9DAADAEE9706554
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Daniel Walker wrote:
> Hi all!
>=20
> With PREEMPT_RT getting more and more mature, it seems natural that
> PREEMPT_RT could be used with Xenomai. Has anyone considered this
> already?

A clear yes: this is part of the long-term roadmap we are currently
preparing, just stay tuned. In fact, Philippe expressed this goal
already in earlier announcements.

Having native (patch-less) real-time will indeed be an interesting
option for the future, besides co-scheduling.

> Or even better, is anyone already doing work with these two
> technologies combined?

There once existed a combo patch (that I don't find ATM) of an ancient
-rt version + old Adeos, a combination that will more or less
automatically come again when PREEMPT_RT is mainline. Porting the
nucleus over PREEMPT_RT so that the skins can run "natively" is another
task yet to begin. Anyway, we are already including this perspective in
current design decisions when subsystems are revised or enhanced.

Jan


--------------enig64A2670DE9DAADAEE9706554
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/qf4niDOoMHTA+kRArRIAJ94E7YugDOVT4iVObrPRYm8w8cr2ACePpQs
O8CTBGqcBnVi9vtNSy6mId0=
=yvJs
-----END PGP SIGNATURE-----

--------------enig64A2670DE9DAADAEE9706554--

