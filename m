Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1161099585.5024.48.camel@domain.hid>
References: <1161099585.5024.48.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 18 Oct 2006 12:25:05 +0200
Message-Id: <1161167105.5053.34.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "=?ISO-8859-1?Q?Schl=E4gl?= Manfred jun." <manfred.schlaegl@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-10-17 at 17:39 +0200, Schl=E4gl Manfred jun. wrote:

[...]

> 1. With enabled kernel-debugging (spin_debug), while loading xeno_nativ=
e
> (built-in and as module) I get:

[...]

> Is this normal, or could this also depend on a "main-bug".
>=20

No, that's absolutely abnormal. Switching the Linux kernel debug options
on is the usual way most of us work, and no warning should be emitted
under Xenomai operations. What you get on ARM, and which I cannot
reproduce on x86, ppc or blackfin, is worrying.

[...]

>=20
> ./run -- -n 100 -p 100 (switchbench)
>=20
> Most of time the system simply stands still (no more timer-activity),
> but here i've a kernel-fault with debug-symbols:
>=20
> [   53.650000] Unable to handle kernel NULL pointer dereference at
> virtual address 00000004

We might have a stack overflow here, as a consequence of the shorter
sampling period.

[...]

> 4. cyclictest
> cyclictest runs, if i use the run script (built-in xenomai):
>=20
> -sh-3.00# ./run=20
> *
> *
> * Type ^C to stop this application.
> *
> *
> 0.10 0.04 0.01 1/26 94         =20
>=20
> T: 0 (   94) P:99 I:    1000 C:   22508 Min:      49 Act:      82 Max:
> 121
>=20
>=20
> but is broken if i call it manually:
>=20
> -sh-3.00# ./cyclictest=20
> 0.10 0.04 0.01 2/23 103         =20
>=20
> T: 0 (  103) P: 0 I:    1000 C:    1699 Min:-2660105 Act:-2660105 Max:
> -985769
>=20

It's not actually broken, it's just that we have imported this code from
the PREEMPT_RT testsuite, and their default setup does not match our
testcase. You should at least pass -n to the test.

--=20
Philippe.



