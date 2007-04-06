Message-ID: <46167E01.3080600@domain.hid>
Date: Fri, 06 Apr 2007 19:06:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Getting the clock model right
References: <46163817.3060007@domain.hid> <46164F5D.4080301@domain.hid>
	<46165943.3050706@domain.hid> <461677BB.1090301@domain.hid>
	<46167B46.6010902@domain.hid>
In-Reply-To: <46167B46.6010902@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3BC095931647F1EFF512991B"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3BC095931647F1EFF512991B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> What about emitting Adeos events when receiving NTP corrections ? This=

>> way, we would avoid reinventing NTP ?
>>
>=20
> IIRC, NTP was designed to synchronise clocks over unreliable and slow
> media. The math behind it /may/ be useful (though it may also turn out
> to be too heavy), but beyond that... Already seen a NTP-over-CAN
> realisation, e.g.?
>=20
> And what would NTP over standard network buy us on a Xenomai system whe=
n
> the accuracy of NTP time stamps taken under Linux gets additionally
> degraded by Xenomai activity? I thought about NTP for our problem for a=

> short while, but then quickly dropped the idea due to lacking guarantee=
s.
>=20
> Likely, we rather need something like IEEE 1588, but there are
> unfortunate patents around that protocol.
>=20

Hmm, I think I just got distracted from my original idea.

IEEE 1588, NTP, whatever, those are synchronisation protocols, designed
for specific media. What we probably need in the Xenomai nucleus is a
generic infrastructure to tune the local clock based on some offset and
drift factor, however those were obtained. That leaves the door open for
any protocol and communication media to exchange the required sync
information.

Jan


--------------enig3BC095931647F1EFF512991B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGFn4BniDOoMHTA+kRApxnAJsFtZwUh6QO6Jl7yvI09OlBdkqU1ACff3Y7
7pSV1xOpwaSYinVCa6h2W5A=
=9anj
-----END PGP SIGNATURE-----

--------------enig3BC095931647F1EFF512991B--

