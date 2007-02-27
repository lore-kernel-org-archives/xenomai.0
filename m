Message-ID: <45E494AC.5050603@domain.hid>
Date: Tue, 27 Feb 2007 21:29:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] task not being scheduled
References: <45E478BB.40301@domain.hid> <200702271404.59477.jweber@domain.hid>
In-Reply-To: <200702271404.59477.jweber@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD539E9B27B9FEA57D4FFC8FF"
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD539E9B27B9FEA57D4FFC8FF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Weber wrote:
> trace and .config attached.

OK. Sorry for not believing in the first place :), but there are
actually timer events missing for your 10-ms-period task.

I saw in the .config that you are using the heap timer list. Already
tried the classic linked list as well? Maybe we see in issue related to
this queue implementation.

Gilles, I think the heap was your contribution. If it turns out to bite
us here, any idea where to look, what to instrument
(xntrace_special[_u64]...)?

Jan


--------------enigD539E9B27B9FEA57D4FFC8FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5JSsniDOoMHTA+kRAtozAJ9wjzUv7fcK+kUAze74Ls9BPE+C7ACfeod4
N614hdwueRicJU90pQCgg1M=
=HK/d
-----END PGP SIGNATURE-----

--------------enigD539E9B27B9FEA57D4FFC8FF--

