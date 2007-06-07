Message-ID: <4667FF8E.2000207@domain.hid>
Date: Thu, 07 Jun 2007 14:52:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46649F7E.3060104@domain.hid>
	<46651F7D.9090702@domain.hid>	<18021.58231.177931.286548@domain.hid>	<46668CC3.8050002@domain.hid>
	<4666ACE5.7030200@domain.hid>	<4666AFB3.6040602@domain.hid>
	<4666B4C7.6020308@domain.hid>	<4666B716.6010909@domain.hid>
	<18022.64424.836736.431121@domain.hid>
	<46670109.7070408@domain.hid>
In-Reply-To: <46670109.7070408@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBBC3FE03C6391B794366E852"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH-STACK] Updates, timerstats, rtdm-timers
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
--------------enigBBC3FE03C6391B794366E852
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> So, Ok, I will try to do something for x86 (either reduce the numbers =
of
>> registers used by the C code, or reduce the assembly to the bare
>> minimum). But, please, pick my generic implementation of llmulshft, it=

>> was carefully written.
>=20
> Yes, it is the better choice for 32 bit archs (my previous tests didn't=

> reflect the usage in Xenomai truely, redoing them made my generic
> version fall behind yours). Will include it.

Done, see -v6. Then I added that two-liner for x86_64 rthal_llmulshft,
fixed the BITS_PER_LONG bug, and enabled generic-based support for ARM
(testing welcome!).

At this chance: My series now also includes rthal_llimd for x86_64,
another two-liner.

Jan


--------------enigBBC3FE03C6391B794366E852
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZ/+OniDOoMHTA+kRAmOBAJ41y67J06GRAu1/d7I6txufLueARwCfcKfZ
qigd0Zz12s1JAMlurbwayl0=
=BJjw
-----END PGP SIGNATURE-----

--------------enigBBC3FE03C6391B794366E852--

