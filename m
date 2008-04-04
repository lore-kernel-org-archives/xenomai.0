Message-ID: <47F63C37.60307@domain.hid>
Date: Fri, 04 Apr 2008 16:33:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>	
	<47F4CAD1.3090002@domain.hid> <47F4D87F.7080204@domain.hid>	
	<47F551AD.9030509@domain.hid> <47F5E57C.6020309@domain.hid>	
	<47F606AE.6080800@domain.hid>	
	<2ff1a98a0804040618r2717c5efrb852bcbc76e6bd0c@domain.hid>	
	<47F62C46.4080003@domain.hid>	
	<2ff1a98a0804040632w391afda4rf30c8ca09fbb0874@domain.hid>	
	<47F633B7.70003@domain.hid>
	<2ff1a98a0804040709m51a8db6lc23e1714497f824c@domain.hid>
In-Reply-To: <2ff1a98a0804040709m51a8db6lc23e1714497f824c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2FAE8B6BE6C7E544E2977FB5"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] latencys drifting into negative (Xenomai
	2.4.2/2.4.3)
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
Cc: xenomai-core <xenomai@xenomai.org>, =?ISO-8859-1?Q?Cornelius_K=F6pp?= <Cornelius.Koepp@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2FAE8B6BE6C7E544E2977FB5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Right. We are approximating a fraction with another fraction. But my
> first impression remains: I do not like the idea of making
> xnarch_ns_to_tsc wrong because xnarch_tsc_to_ns is wrong.

Well, my first impression was originally the same: If we still need=20
llimd in the ns-to-tsc patch, then we should keep the precise way. But=20
that was wrong as this thread demonstrated. We have to ensure that=20
ns_to_tsc(tsc_to_ns(x)) remains x with only minor last-digit errors. So=20
either use scaled math parameters in both ways or fall back to the=20
original calculation.

However the final decision for 2.5 is (pro or contra scaled math), at=20
least for 2.4.x we have to fix things now without turning the upside=20
down. That means apply my patch or revert scaled-math optimizations for=20
all archs.

Jan


--------------enig2FAE8B6BE6C7E544E2977FB5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH9jw8niDOoMHTA+kRAmSlAJ9mKTXXkFYMrDf1U1hK33S+7RdOZACeMGdb
ic5t/PIu1CJKTlWa/gn5FFg=
=2UJH
-----END PGP SIGNATURE-----

--------------enig2FAE8B6BE6C7E544E2977FB5--

