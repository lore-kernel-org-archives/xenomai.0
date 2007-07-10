Message-ID: <46938A2D.3030009@domain.hid>
Date: Tue, 10 Jul 2007 15:31:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <34174.131.173.32.74.1184072898.squirrel@domain.hid>
In-Reply-To: <34174.131.173.32.74.1184072898.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDC8FF18DE021A669985A18FD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] SMI workaround failed
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: bboese@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC8FF18DE021A669985A18FD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

bboese@domain.hid wrote:
> Hello.
>=20
> I'm very new to Xenomai and Real Time Applications, so please be indulg=
ent.
>=20
> I'm using Ubuntu 7.4 on a Pentium IV 3,2 GHz system with 512mb ram. Aft=
er
> 2 days of learning about kernel compiling, I've managed to compile a
> vanilla 2.6.20 kernel with the Xenomai nucleus.
>=20
> At first, I've checked if Adeos is working:
> dmesg | grep I-pipe
> I-pipe 1.7-03: pipeline enabled.

As you already learned how to compile, here is the next chance to
practice: we have Xenomai 2.3.2 with I-pipe 1.8-05 now. :)

> I-pipe: Domain Xenomai registered.
>=20
> Then I've checked if Xenomai works properly:
> dmesg | grep Xenomai
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/x86 started.
> Xenomai: real-time nucleus v2.3.1 (One Robot's Dream) loaded.
> Xenomai: SMI-enabled chipset found, enabling SMI workaround.
> Xenomai: SMI workaround failed!
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
>=20
> And here's a snippet of my .config file for the kernel:
> #
> # SMI workaround
> #
> # CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
> CONFIG_XENO_HW_SMI_DETECT=3Dy
> CONFIG_XENO_HW_SMI_WORKAROUND=3Dy
> CONFIG_XENO_HW_SMI_ALL=3Dy
>=20
> As you can see, I've enabled the workaround. But somehow, it fails.
>=20
> I've tried /usr/xenomai/bin/xeno-test, and my latencies are very high.
> Maximum latency circles around 10ms, and average latency is about 0.5 m=
s.

That is _very_ high and, if true, can even be problematic for an
ordinary non-RT system. Did you disable frequency scaling in your kernel
config (if not, that would break the measurement under Xenomai)?

> I don't think this is normal, I was hoping for much lower latencies for=
 my
> realtime applications. I think SMI skyrockets the latency values, any i=
dea
> why the SMI workaround won't work or how to debug this problem properly=
 ?

You could try switching off individual SMI features, either in your
kernel config or - easier for experimenting - with this userland tool:

http://www.rts.uni-hannover.de/rtaddon/#smictrl
http://www.rts.uni-hannover.de/rtaddon/smictrl.tar.bz2

Maybe just that "switch off everything" is blocked by your hardware.
Moreover, it would be interesting to know your PCI IDs (lspci; lspci -n)
for reference.

>=20
> Which latency should I expect with a system like mine (PIV 3,2 GHz) ?

What scenario are you looking for? There is no such thing as "the
latency of box X".

Anyway, the simple latency tests of Xenomai (single task under heavy
cache and IRQ load) should give timed task wakeup latencies below 20 us
or better - but that's fairly hardware setup dependent (a single stall
on PCI activity can cost more than 30 us if you have the "right"
hardware...).

Jan


--------------enigDC8FF18DE021A669985A18FD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGk4otniDOoMHTA+kRAjQ6AJ9YmhZj9083n1p27UQSagQdrrYzmACfTYjk
LqBfZ2p/bxDPM1TdDEDDAok=
=fEZj
-----END PGP SIGNATURE-----

--------------enigDC8FF18DE021A669985A18FD--

