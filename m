Message-ID: <45D2CE27.5040303@domain.hid>
Date: Wed, 14 Feb 2007 09:53:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CONFIG_PREEMPT & irqbench
References: <45D25145.3000407@domain.hid>
In-Reply-To: <45D25145.3000407@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig64E1D2B612514E16B17A0891"
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
To: Markus.Franke@domain.hid
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig64E1D2B612514E16B17A0891
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Markus Franke wrote:
> Dear all,
>=20
> I am running some latency tests with irqbench/irqloop. I am wondering
> whether it would be possible to achieve better results when activating
> CONFIG_PREEMPT and CONFIG_PREEMPT_VOLUNTARILY during the kernel
> configuration and running irqloop in User Mode over this kernel?

Nope.

> Does it make any sense?

Nope. :)

> I think in theory it should give better results because
> this irqloop runs in secondary(linux) domain when started, right? An
> increasing preemptibility of the linux kernel should be better for the
> irqloop-task.

The Linux kernel is already fully preemptible by Xenomai once you
applied the I-pipe patch. Therefore, you are free to pick the Linux
preemption strategy according to your *Linux* load, independent of what
the real-time part needs.

Unless you have interactive Linux programs running, I can suggest to
pick PREEMPT_VOLUNTARILY or even PREEMPT_NONE, specifically on low-end
hardware.

> All tests were made under heavy I/O and CPU load by means of "dd",
> "pingflood" and "cpuburn". Nevertheless, I can only achieve worse
> results when activating CONFIG_PREEMPT.

Do you have CONFIG_DEBUG_PREEMPT set as well then? This option still as
a small but measurable impact on Xenomai due to micro-dependencies that
as scheduled to be removed in the near future.

Jan


--------------enig64E1D2B612514E16B17A0891
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0s4oniDOoMHTA+kRAla7AJ928fCeyr0e3Lz8WLTYVNpsSagljwCePcky
7xZ/7XftLPL7gVcW3MLEk1Y=
=uNLS
-----END PGP SIGNATURE-----

--------------enig64E1D2B612514E16B17A0891--

