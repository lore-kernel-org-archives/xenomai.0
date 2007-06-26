Message-ID: <468116FE.4090402@domain.hid>
Date: Tue, 26 Jun 2007 15:39:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <467CD519.1060802@domain.hid>
	<1182594345.6000.9.camel@domain.hid>	<467D0684.7030604@domain.hid>
	<1182623858.6000.139.camel@domain.hid>	<467E2E9C.90905@domain.hid>
	<18046.42783.829807.333066@domain.hid>
In-Reply-To: <18046.42783.829807.333066@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4662B91F5D43DBA930B605E4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Monotonic, realtime, and other timers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4662B91F5D43DBA930B605E4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> IMO, the only advantage of having absolute timers is to be able to appl=
y
> the posix scheme. So, if I followed correctly your discussion, what we
> need is:
> - an XNTBISOL flag with a service xntbase_isol which set this flag and
>   unshare the target timebase if it is shared (IOW, if aperiodic)
> - the service xntbase_adjust_time to walk all the absolute timers of th=
e
>   non isolated timebases and adjust their expiry date or play their
>   handler the posix way.

Two questions came up here regarding item #2:

 - Shouldn't we also adjust the non-monotonic timers of an isolated base
   if it asks for wallclock tuning? I think so.

 - We don't have a service to walk the list of all pending timers, do
   we? As that touches all of our timer queue variants and I'm not
   familiar with their details (except for plain lists...), I would
   welcome any support on this.

Jan


--------------enig4662B91F5D43DBA930B605E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgRb+niDOoMHTA+kRAnm5AJ0W3Ip1A3S55H/jB5yn8wtgAR/kpwCfb8D8
ASY7SiyvtllGXCHYYW2ve4s=
=jHvT
-----END PGP SIGNATURE-----

--------------enig4662B91F5D43DBA930B605E4--

