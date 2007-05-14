Message-ID: <464839C8.8060304@domain.hid>
Date: Mon, 14 May 2007 12:28:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1178268043.5391.47.camel@domain.hid>	
	<463B086B.6060402@domain.hid> <463B5E27.7050408@domain.hid>
	<1179137384.4820.31.camel@domain.hid>
In-Reply-To: <1179137384.4820.31.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9083177F8C8A502EAFCFBB81"
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
--------------enig9083177F8C8A502EAFCFBB81
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

CAMUS Benoit wrote:
> Before all thanks for your advices
>=20
> I did some more researches, especially using ipipe tracer.
>=20
> First thing that takes me on is IRQ canals:
> / # cat /proc/interrupts=20
>            CPU0
>  11:         13          SC  pxa2xx-i2c
>  15:       1143          SC  FFUART
>  18:          0          SC  DMA
>  19:     430054          SC  PXA Timer Tick
>  27:       7335        GPIO  eth0
> Err:          0
>=20
> The tick timer seems to have IRQ's level lower than Ethernet once ?

That doesn't change the worst case scenario anyway as long as IRQ
handlers can block the execution of all others.

> I saw in ipipe code that IRQ from timer doesn't have same process than
> others (_ipipe_ack_timerirq and __ipipe_ack_irq). I'm still reading cod=
e
> to understand this.
>=20
> Second is ipipe's trace of max latency path (see file attached), you ca=
n
> see that shceduling in Linux domain have NMI noise, does it mean taht
> it's a non-preempt part ?=20

Nope, something is fishy at least with the tracer. I recall these
effects from early ARM patches with tracer support. It should be caused
by some reentrancy of the tracer when functions are called insider the
tracer core that are not marked as "notrace". Maybe some PXA-specific
function to read the TSC?

> That could explain a part of latency during http access (ie fork that
> infers scheduling).
>=20
> So i'm searching for a way in better case, to reduce this latency, in
> worst to bound it.
> For now i'm looking at interrupt handling code both in Linux, Adeos and=

> Smc driver to determine if timer IRQ is well masked by Ethernet once an=
d
> how to hack it.

Let us get the tracer right. Then we would need a full back trace of a
frozen path over the detected latency (here: about 900 us). THEN we can
see what goes on and what needs a closer look.

Jan


--------------enig9083177F8C8A502EAFCFBB81
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGSDnIniDOoMHTA+kRAjTJAJ4mBNr1w9kxggRxvq8kvFRkxnukGgCcDbmb
xZFX8CRjOW6itojGKxcfpDM=
=OgEz
-----END PGP SIGNATURE-----

--------------enig9083177F8C8A502EAFCFBB81--

