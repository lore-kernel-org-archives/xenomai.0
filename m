Message-ID: <456EE4EC.5050305@domain.hid>
Date: Thu, 30 Nov 2006 15:04:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] measuring context switch primary<->secondary mode
References: <456D5075.1060905@domain.hid>	<200611301119.01173.schwab@domain.hid>
	<456EE120.5060003@domain.hid>
In-Reply-To: <456EE120.5060003@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig33CAF02E137C27E132B114BB"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig33CAF02E137C27E132B114BB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Markus Franke wrote:
> Ulrich Schwab wrote:
>> I think that CONFIG_PREEMPT should reduce the jitter of Your measureme=
nt, most=20
>> importantly the worst case switch time, for wich You need a long test =
run=20
>> under heavy load.
>> CONFIG_PREEMPT is there to provide more determinism, which usually has=
 a price=20
>> in performance.
>> Realtime is about determinism not performance (or speed).
>> Its not maximum speed but guaranteed minimum speed.
>=20
> You are absolutely right. I put my system under some load (dd) and made=

> two tests. One was with CONFIG_PREEMPT and one without. The worst case
> switch time jitter was about 30% lower in the CONFIG_PREEMPT case, so
> your prediction was right.
>=20
>> Since the probability of a preemption during the mode switch without=20
>> CONFIG_PREEMPT is lower, it might take a long time until the worst cas=
e mode=20
>> switch time is observed.
>=20
> Sorry but I don't understand what you are meaning. Let me explain my
> point of view. When a realtime task in the Xenomai-Domain makes a
> linux-systemcall the task is migrated fully automatically to the
> Linux-Domain as soon as we reach the next preemption point in the
> Linux-Kernel. Due to the fact that preemptability of the linux-kernel
> increase when using CONFIG_PREEMPT, the time to the next preemption
> point should decrease, right? I don't get the point of your last senten=
ce.

Exactly. We see several preemption issues in secondary mode: first to
get the requested service running (i.e. preempt the currently executed
Linux job), second to avoid that it is involuntarily preempted, and
third to get over potentially congested locks quickly.

CONFIG_PREEMPT helps here to reduce the worst case (PREEMPT_RT even
more, but it currently collides with patching the kernel). On the other
hand, it increases the overhead for your Linux subsystem (check with
lmbench e.g.). Still, depending on what you need, you are able to tune
Linux'es own preemption model freely when using Xenomai and I-pipe.

Jan


--------------enig33CAF02E137C27E132B114BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbuTsniDOoMHTA+kRAr8/AJ4v6lwoI2baFB5HeZ3QdlHI/PNy9wCdGySX
SqXUekirvEh4Hq/pfws4sN4=
=InGJ
-----END PGP SIGNATURE-----

--------------enig33CAF02E137C27E132B114BB--

