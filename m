Message-ID: <44BFFC73.9080603@domain.hid>
Date: Thu, 20 Jul 2006 23:58:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
In-Reply-To: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6DCD6906A56045ABA5F85806"
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
To: Julien Heyman <bidsonux@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DCD6906A56045ABA5F85806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Julien Heyman wrote:
> Hi,
>=20
> I am currently trying to evaluate Xenomai, and my current setup is :
> VIA C3 533Mhz processor, Kubuntu 6.06 Linux distribution.
> I am using Xenomai-2.1.0 over a 2.6.17.4 kernel.

General advice: especially when starting new, try to pick the latest
version, at least the latest from the preferred series (here 2.1.2). But
2.2 is even better. :)

> When I run the latency part of the testsuite (in a console under KDE), =
I
> get
> results that I cannot understand, so I probably did something wrong
> (execution trace included below).
> I get reasonable values during the first seconds, then all of a sudden
> latencies begin to rise, continuously, to very large values.
> - I did check that DMA transfer is activated on my HD.
> - I did select "Enable SMI workaround" + "Globally disable SMI" in the
> Xenomai
> options while configuring the kernel.
> - I have disabled power management at BIOS level and disabled ACPI supp=
ort
> and
> CPU frequency scaling during kernel configuration.
> - I checked that I don't have anything called "legacy USB" in my BIOS. =
I do
> have an "OnChip USB" option enable in the BIOS though.
>=20
> Any advice would be appreciated !

Maybe it's related to some other weird on-chip hardware. At work we run
Xenomai only on a head-less VIA C3 box, i.e. without X. No problems so
far. I would suggest to try stopping X and run the test from the text mod=
e.

A further tool to analyse such effects in details is the I-pipe tracer.
It's an additional patch you have to apply to your kernel (see
http://download.gna.org/adeos/patches/v2.6/i386/tracer). Enable this
I-pipe option, rebuild your kernel, and start the latency test with -f.
The test will then capture on every new worst-case delay a backtrace to
/proc/ipipe/trace/frozen. You may want to play with the number of
back-trace points or the verbose mode (see /proc/ipipe/trace/*) even
after the capturing.

Unless you find something obvious immediately, feel free to post a
backtrace that includes the problematic delay period before the freeze
(compress when too large).

Jan


--------------enig6DCD6906A56045ABA5F85806
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEv/xzniDOoMHTA+kRAo66AJ43V6Hzxfxxabg8ftIydmGn4G2R8ACfQ+6a
nVDLvANB6MfcIrfN13qG30M=
=nll7
-----END PGP SIGNATURE-----

--------------enig6DCD6906A56045ABA5F85806--

