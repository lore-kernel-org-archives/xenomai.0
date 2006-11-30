Message-ID: <456EF9F8.6080409@domain.hid>
Date: Thu, 30 Nov 2006 16:34:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] measuring context switch primary<->secondary mode
References: <456D5075.1060905@domain.hid>	<200611301119.01173.schwab@domain.hid>
	<456EE120.5060003@domain.hid>
	<456EE4EC.5050305@domain.hid>
	<456EE9C4.6000203@domain.hid>
In-Reply-To: <456EE9C4.6000203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig30F605258A02D711E8BF51CA"
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
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig30F605258A02D711E8BF51CA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Markus Franke wrote:
> Jan Kiszka wrote:
>> CONFIG_PREEMPT helps here to reduce the worst case (PREEMPT_RT even
>> more, but it currently collides with patching the kernel). On the othe=
r
>> hand, it increases the overhead for your Linux subsystem (check with
>> lmbench e.g.). Still, depending on what you need, you are able to tune=

>> Linux'es own preemption model freely when using Xenomai and I-pipe.
>=20
> So at the moment it is not possible to use PREEMPT_RT-Patch and
> Xenomai/Adeos together?

[adding the list to CC again]

If you browse the Xenomai and I-pipe code, you will find some hints that
this once worked and Xenomai is basically prepared for it.

To combine both patches today, we would have to adopt I-pipe not only to
genirq (which is almost done for 2.6.19), but also to the full
hrtimer+dyntick (clocksource/clockevent) infrastructure. Moreover, quite
some time has passed since the last I-pipe/-rt combo patch, and both
PREEMPT_RT and I-pipe changed since then. Do there might be more subtle
issues hidden for a combination.


Still, this is technically feasible and will come over the time when
PREEMPT_RT continues to "leak" into mainline. The question is if using
the result (CONFIG_IPIPE+CONFIG_PREEMPT_RT) is also what you want:
Combining both strategies also means adding overhead of I-pipe's
paravirtualisations and PREEMPT_RT's IRQ threading & sleeping locks.

The future development, Xenomai 3, therefore aims at rebasing the
nucleus over the -rt patch while keeping its ability to run
alternatively over vanilla + I-pipe. Depending on your requirements -
full system preemptibility vs. focused RT-subsystem - you will then be
able to switch the model without application or driver rewrites.

Jan


--------------enig30F605258A02D711E8BF51CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbvn4niDOoMHTA+kRAoBhAJ9FMXl4UFfMbQopebZXcgeoDArGIQCfS7HY
FB/Vuy2plKaaz3g2tsWEmik=
=7bwt
-----END PGP SIGNATURE-----

--------------enig30F605258A02D711E8BF51CA--

