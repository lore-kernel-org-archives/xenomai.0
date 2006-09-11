Message-ID: <450596FB.3000901@domain.hid>
Date: Mon, 11 Sep 2006 19:03:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Linux + PREEMPT_RT + LTTng + Xenomai
References: <200609071445.53611.Serge.Noiraud@domain.hid>	<4500182A.6000009@domain.hid>
	<200609111418.25324.Serge.Noiraud@domain.hid>
	<1157992308.4991.34.camel@domain.hid>
In-Reply-To: <1157992308.4991.34.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig82CFF80246831D0EEE691568"
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
To: Serge Noiraud <serge.noiraud@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig82CFF80246831D0EEE691568
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2006-09-11 at 14:18 +0200, Serge Noiraud wrote:
>=20
> [...]
>=20
>> I would like Xenomai manage IRQs for some specific cards.
>> The others could be managed by linux-rt.
>> If I understand correctly how it works, I must rewrite my drivers. is =
it correct ?
>>
>=20
> "Adapt" them would be more appropriate. Xenomai's RTDM layer usually
> makes this quite straightforward.
>=20

You may want to have a look at the irqbench driver (+ user-space
front-end), both for usage reference and as a test case for what is
feasible on your hardware with Adeos/Ipipe and Xenomai.

This benchmark contains a special mode ("-t 3") to let the IRQ handler
run inside a separate high-prio Adeos domain. It will even preempt
Xenomai in this mode. If you only have to interact with hardware in your
IRQ handlers or if operations on data structures can be made lock-less,
this variant will most probably give you the ultimate latency numbers.
With this test, I recently measured worst-case latencies under heavy I/O
load of < 50 us -- on an ancient Pentium-I 133 MHz.

But one has to keep in mind that latencies below 30-40 us are heavily
influenced by hardware effects like PCI bus contention. It will require
some thorough bus design and I/O load management as well. I once ran a
user-space periodic task at 50 KHz on my notebook (P-M, 1.3 GHz). Worked
fine for hours while I continued working with that box -- until some
mail arrived that triggered a nice sound playback which raised a usual
latency spike of 40 us (i.e. an overflow here)...

Jan


--------------enig82CFF80246831D0EEE691568
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFBZb7niDOoMHTA+kRAuLlAJ9aMaeZ48UvElR2jMrcjwmJZ1XfDwCeKGlo
wlDqwj9yhU6fsi9bL3JE2QU=
=+pEz
-----END PGP SIGNATURE-----

--------------enig82CFF80246831D0EEE691568--

