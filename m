Message-ID: <46488839.4060801@domain.hid>
Date: Mon, 14 May 2007 18:03:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1178268043.5391.47.camel@domain.hid>	
	<463B086B.6060402@domain.hid> <463B5E27.7050408@domain.hid>
	<1179137384.4820.31.camel@domain.hid> <464839C8.8060304@domain.hid>
In-Reply-To: <464839C8.8060304@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig64851AE2A20913A29EA2DDCB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Latencies while ethernet access
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: CAMUS Benoit <benoit.camus@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig64851AE2A20913A29EA2DDCB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Let us get the tracer right.
> ...

And here is the issue already when having a second look:

> / # cat /proc/ipipe/trace/frozen=20
> I-pipe frozen back-tracing service on 2.6.19.2/ipipe-1.6-04
> ------------------------------------------------------------
> Freeze: 9187269471 cycles, Trace Points: 30 (+10)
> Calibrated minimum trace-point overhead: 3.000 us
>=20
>  +----- Hard IRQs ('|': locked)
>  |+---- <unused>
>  ||+--- Xenomai
>  |||+-- IShield
>  ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)=

>  |||||                        +---------- Delay flag ('+': > 1 us, '!':=
 > 10 us)
>  |||||                        |        +- NMI noise ('N')
>  |||||                        |        |
>       Type    User Val.   Time    Delay  Function (Parent)
> :| #  begin   0x80000001  -190+   4.250N __ipipe_mach_get_tsc+0x48 (xnt=
imer_do_tick_aperiodic+0x40)

__ipipe_mach_get_tsc() must never pop up in trace, it has to be marked
"notrace". I guess you ported that service for your board? Please fix
and retry the test.

Jan


--------------enig64851AE2A20913A29EA2DDCB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGSIg5niDOoMHTA+kRAmNYAJsEpeiPtGbMBeHQAeVtIJu1QKO3ZACfSpHa
UVtXcHyqbD9u7AgNYsRaioU=
=2jNA
-----END PGP SIGNATURE-----

--------------enig64851AE2A20913A29EA2DDCB--

