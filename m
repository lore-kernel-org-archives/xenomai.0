Message-ID: <448808E2.3050900@domain.hid>
Date: Thu, 08 Jun 2006 13:24:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xenomai and ppc issues
References: <756DFD3DE8F1D411A59A00306E06E84704707D02@domain.hid>
In-Reply-To: <756DFD3DE8F1D411A59A00306E06E84704707D02@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9FB95DC9ECFE4623DD6D736F"
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
To: GUARDIOLA-FALCO Sebastien 204282 <Sebastien.GUARDIOLA-FALCO@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9FB95DC9ECFE4623DD6D736F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

GUARDIOLA-FALCO Sebastien 204282 wrote:
> Hello,
>=20
> I'm involved in a real-time project for a PPC mvme2700 target, and I ne=
ed hard real-time tasks that can be executed in user-space. Seems that on=
ly Xenomai can meet the requirements.
> My first question is to have confirmation that RTAI or LXRT are x86 bas=
ed and can not help me.

RTAI used to support other archs as well, but the situation has changed
AFAIK.

> The second issue is to know how I can install Xenomai (do I need to ins=
tall Adeos kernel first? which version should I download?)

Start with the latest stable release (2.1.2) and follow README.INSTALL.

> and to know how far Xenomai goes in hard real-time (better preemption l=
atency that RTAI?).

Cannot comment on this as I do not have comparable numbers for PPC. Once
you have 2.1.2 running, check the testsuite (xeno-test script or
individual tests) to get an impression of what is possible. You are
invited to post results here in order to let other PPC user
cross-check/comment (an automated test with online result database is
under development).

Xenomai constantly improves with respect to worst-case latency and
overall performance. Upcoming version 2.2 will introduce, e.g.,
additional optimisations which can reduce user space scheduling
latencies by ~20%. But, of course, the closer your design requirements
get to the benchmark results, the more careful and intensive your
performance analysis of the final system has to be.

Jan


--------------enig9FB95DC9ECFE4623DD6D736F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEiAjiniDOoMHTA+kRAugYAJ95efUSwE6m2eCnTsMBmaiNpqcFcACfUXEt
2IqpRo8LOi82/KvBtllriz0=
=2090
-----END PGP SIGNATURE-----

--------------enig9FB95DC9ECFE4623DD6D736F--

