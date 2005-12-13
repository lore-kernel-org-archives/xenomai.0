Message-ID: <439F2159.4080307@domain.hid>
Date: Tue, 13 Dec 2005 20:30:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] PowerDAQ Board Under Xenomai?
References: <20051213141433.S16178@domain.hid>
In-Reply-To: <20051213141433.S16178@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB1CDF28A5A14938129CB4430"
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
To: Kent Borg <kentborg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB1CDF28A5A14938129CB4430
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Kent Borg wrote:
> Newbie here investigating whether we can use Xenomai.  Looking good so
> far, but I am wondering whether we will be able to use our PowerDAQ
> PD2-MF-16-150/16H board.  It comes with drivers for RTLinux and RTAI
> (I think with complete sources), does that do us any good for use with
> Xenomai?
>=20

Depends. Is that driver based on Comedi?

If so, the usage depends on the availability of Comedi under Xenomai.
This is not yet ported, but I'm currently trying to trigger a discussion
with the Comedi maintainers about a port of their project's real-time
subsystem over the generic driver layer RTDM. This step would provide
immediate support for all recent real-time Linux variants, from Xenomai
over RTAI 3.3 and, on the mid-term, even to RTLinux/GPL (they also plan
to adopt RTDM). Anyway, I cannot say yet if and when this port will be do=
ne.

If your driver is stand-alone at least for one of both supported
real-time Linux versions, then it should already be possible to port it
over a similar API skin of Xenomai (native for RTAI, POSIX for RTLinux).
This is not the preferred way (RTDM / Comedi would be cleaner), but it
is a pragmatic one.

Well, with the sources available and if the programming model of the
hardware is not complicated, you can still try to develop your own
specific interface - option three...

Jan


--------------enigB1CDF28A5A14938129CB4430
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDnyFZniDOoMHTA+kRApMSAJ900nWokN8dQiyAxTxyEXPgVxlIPgCdFr1i
/dQcKK9b2NRcKSx4L8kOee4=
=M3E2
-----END PGP SIGNATURE-----

--------------enigB1CDF28A5A14938129CB4430--

