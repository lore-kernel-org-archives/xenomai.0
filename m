Message-ID: <47F4D29F.4020500@domain.hid>
Date: Thu, 03 Apr 2008 14:50:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>	
	<47F34C0D.6090809@domain.hid> <47F37579.7080601@domain.hid>	
	<47F37BF8.6000401@domain.hid> <47F3AD14.4090306@domain.hid>	
	<2ff1a98a0804020905v7019574ai927f213ab6603e41@domain.hid>	
	<47F3B348.1090102@domain.hid> <47F4CAD1.3090002@domain.hid>
	<2ff1a98a0804030527r5d41efafg4aa6a464373711cc@domain.hid>
In-Reply-To: <2ff1a98a0804030527r5d41efafg4aa6a464373711cc@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig75ACDE2DF1B9FD667AF1EE19"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] latencys drifting into negative (Xenomai
	2.4.2/2.4.3)
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
Cc: xenomai-core <xenomai@xenomai.org>, =?ISO-8859-1?Q?Cornelius_K=F6pp?= <Cornelius.Koepp@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig75ACDE2DF1B9FD667AF1EE19
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> On Thu, Apr 3, 2008 at 2:17 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Sebastian Smolorz wrote:
>>
>>> Gilles Chanteperdrix wrote:
>>>
>>>> On Wed, Apr 2, 2008 at 5:58 PM, Sebastian Smolorz
>>>> <smolorz@domain.hid> wrote:
>>>>
>>>>> Jan Kiszka wrote:
>>>>>  > Sebastian Smolorz wrote:
>>>>>  >> Jan Kiszka wrote:
>>>>>  >>> Cornelius K=F6pp wrote:
>>>>>  >>>> I talked with Sebastian Smolorz about this and he builds his =
own
>>>>>  >>>> independent kernel-config to check. He got the same
>> drifting-effect
>>>>>  >>>> with Xenomai 2.4.2 and Xenomai 2.4.3 running latency over
>> several
>>>>>  >>>> hours. His kernel-config ist attached as
>>>>>  >>>> 'config-2.6.24-xenomai-2.4.3__ssm'.
>>>>>  >>>>
>>>>>  >>>> Our kernel-configs are both based on a config used with Xenom=
ai
>> 2.3.4
>>>>>  >>>> and Linux 2.6.20.15 without any drifting effects.
>>>>>  >>> 2.3.x did not incorporate the new TSC-to-ns conversion. Maybe =
it
>> is
>>>>>  >>> not a PIC vs. APIC thing, but rather a rounding problem of lar=
ger
>> TSC
>>>>>  >>> values (that naturally show up when the system runs for a long=
er
>> time).
>>>>>  >> This hint seems to point into the right direction. I tried out =
a
>>>>>  >> modified pod_32.h (xnarch_tsc_to_ns() commented out) so that th=
e
>> old
>>>>>  >> implementation in include/asm-generic/bits/pod.h was used. The
>> drifting
>>>>>  >> bug disappeared. So there seems so be a buggy x86-specific
>>>>>  >> implementation of this routine.
>>>>>  >
>>>>>  > Hmm, maybe even a conceptional issue: the multiply-shift-based
>>>>>  > xnarch_tsc_to_ns is not as precise as the still
>> multiply-divide-based
>>>>>  > xnarch_ns_to_tsc. So when converting from tsc over ns back to ts=
c,
>> we
>>>>>  > may loose some bits, maybe too many bits...
>>>>>  >
>>>>>  > It looks like this bites us in the kernel latency tests (-t2 sho=
uld
>>>>>  > suffer as well). Those recalculate their timeouts each round bas=
ed
>> on
>>>>>  > absolute nanoseconds. In contrast, the periodic user mode task o=
f
>> -t0
>>>>>  > uses a periodic timer that is forwarded via a tsc-based interval=
=2E
>>>>>  >
>>>>>  > You (or Cornelius) could try to analyse the calculation path of =
the
>>>>>  > involved timeouts, specifically to understand why the scheduled
>> timeout
>>>>>  > of the underlying task timer (which is tsc-based) tend to diverg=
e
>> from
>>>>>  > the calculated one (ns-based).
>>>>>
>>>>>  So here comes the explanation. The error is inside the function
>>>>>  rthal_llmulshft(). It returns wrong values which are too small - t=
he
>>>>>  higher the given TSC value the bigger the error. The function
>>>>>  rtdm_clock_read_monotonic() calls rthal_llmulshft(). As
>>>>>  rtdm_clock_read_monotonic() is called every time the latency kerne=
l
>>>>>  thread runs [1] the values reported by latency become smaller over=

>> time.
>>>>>  In contrast, the latency task in user space only uses the conversi=
on
>>>>>  from TSC to ns only once when calling rt_timer_inquire [2].
>>>>>  timer_info.date is too small, timer_info.tsc is right. So all
>> calculated
>>>>>  deltas in [3] are shifted to a smaller value. This value is consta=
nt
>>>>>  during the runtime of lateny in user space because no more convers=
ion
>>>>>  from TSC to ns occurs.
>>>>>
>>>> latency does conversions from tsc to ns, but it converts time
>>>> differences, so the error is small relative to the results.
>>>>
>>> Of course. I wasn't precise with my last statement. It should be: No =
more
>> conversions from *absolute* TSC values to ns occur.
>>>
>>  This patch may do the trick: it uses the inverted tsc-to-ns function
>> instead of the frequency-based one. Be warned, it is totally untested =
inside
>> Xenomai, I just ran it in a user space test program. But it may give a=
n
>> idea.
>>
>>  Gilles, not sure if this is related to my quickly hacked test, but wi=
th
>> RTHAL_CPU_FREQ =3D 800MHz and TSC =3D 0x7000000000000000 (or larger) I=
 get an
>> arithmetic exception with the rthal_llimd-based conversion to nanoseco=
nds.
>> Is there an input range we may have to exclude for rthal_llimd?
>=20
> rthal_llimd does a multiplication first, then a division. The
> multiplication can not overflow, but the result of the division may
> not fit on 64 bits, you then get an exception on x86. This happens
> only with m > d.

OK, for tsc-to-ns this only bites us after a few hundred years of uptime =

- or when we have settable tsc counters (does Linux tweak them beyond=20
aligning on SMP?).

But there is also the risk the other way around: ns-to-tsc with=20
frequency > 1GHz will fall apart (kernel oops!) when the user provides a =

large timeout in nanoseconds that we then try to convert to tsc. Not=20
good. Wrong values are one thing, but oopses are even worse.

Any idea how to fix this?

Jan


--------------enig75ACDE2DF1B9FD667AF1EE19
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH9NKkniDOoMHTA+kRAu17AJ43oJ0s/gScPNgB7MLnVFHH4D5R0wCcDYZP
eNVMKfc9pzulHexTtf8ggCc=
=vMi+
-----END PGP SIGNATURE-----

--------------enig75ACDE2DF1B9FD667AF1EE19--

