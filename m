Message-ID: <448E9E24.50207@domain.hid>
Date: Tue, 13 Jun 2006 13:14:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai integration to LTTng and LTTV
References: <448E7C42.3030504@domain.hid>
In-Reply-To: <448E7C42.3030504@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig43C1881D8CE94589A8B6BDC6"
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
To: Jean-Olivier Villemure <jean-olivier.villemure@domain.hid>
Cc: ltt-dev@domain.hid, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig43C1881D8CE94589A8B6BDC6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jean-Olivier Villemure wrote:
> Hello,
>=20
> I'm currently working on my diploma thesis which will finish in Decembe=
r
> 2006. The first goal of my project is to integrate Xenomai events to
> LTTng, a task quite simple since creating new events in LTTng is not
> very difficult.

Does this mean we will see a basic but usable LTTng over recent
I-pipe/Xenomai soon? I'm only curious... 8)

> The second goal is to create a new module in the viewer,
> LTTV, to analyse these specifics events.
>=20
> Our idea about the LTTV module is to create a new controlflow module
> representing realtime task behavior by identifying the start, end,
> suspend, resume, period, etc...The difference with the current
> controlflow is that we will not be showing the states of the process,
> but there will be a line for each task (multiple realtime tasks by
> process) and identifiers for each important events. Eventualy it will b=
e
> good to detected problems relating to periodic tasks. If I have enough
> time, it could also be a good idea to add some statistics.

Could such an extension also be interesting for the native real-time
Linux project (PREEMPT_RT)? I'm asking because, if yes, you may try to
gain input from that community as well (=3D>LKML). This doesn't mean that=

you have to implement such support, just keeping the approach open for
an integration. Finding and meeting common requirements is always a good
thing and can help even more people.

>=20
> If you have any idea relating to Xenomai or LTTng/LTTV, I will
> considerate them.
>=20
> Thank you!
> Jean-Olivier Villemure
>=20

Jan


--------------enig43C1881D8CE94589A8B6BDC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEjp4kniDOoMHTA+kRAlVKAJ9cShdQvdTLaAXIBK34500oSk8pxgCggk36
/FRnaN1oMhfJUaovhipLGzw=
=x0/9
-----END PGP SIGNATURE-----

--------------enig43C1881D8CE94589A8B6BDC6--

