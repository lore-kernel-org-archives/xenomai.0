Message-ID: <4BF31C83.5070109@domain.hid>
Date: Wed, 19 May 2010 01:02:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>	<181804936ABC2349BE503168465576460EBD6239@domain.hid>	<4BF17464.5090100@domain.hid>	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>	<4BF251EC.7040605@domain.hid>
	<4BF267D3.4040500@domain.hid>	<4BF28401.6060503@domain.hid>
	<4BF28B0C.3080705@domain.hid>	<4BF2AB19.5060701@domain.hid>
	<4BF2DF77.90806@domain.hid>	<4BF2F73C.7070605@domain.hid>
	<4BF3045E.5080707@domain.hid> <4BF31010.2080003@domain.hid>
	<4BF31386.4030402@domain.hid>
In-Reply-To: <4BF31386.4030402@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig38887816DEC01DB702F25180"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Question about getting system time
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Andreas Glatz <AndreasGlatz@domain.hid>, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig38887816DEC01DB702F25180
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Wolfgang Mauerer wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Wolfgang Mauerer wrote:
>>>>>>> On the one hand you make complicated code (which will be costly o=
n low
>>>>>>> end hardware) to avoid shutting interrupts around a few assignmen=
ts, but
>>>>>>> on the other hand you leave an architecture specific function poi=
nter
>>>>>>> call where we want a fast behaviour on average (remember, we do a=
ll this
>>>>>>> to avoid a system call, which is only a few hundreds nanoseconds =
on your
>>>>>>> big iron x86), and where we have a generic fast replacement. Some=
times,
>>>>>>> I do not understand your logic.
>>>>>> But using the same argument, you could get rid of Linux vsyscall b=
ased
>>>>>> gettimeofday()...
>>>>> I do not see your point, the Linux code does not go a long way to m=
ake
>>>>> lockless code, it simply turns off interrupts around the gtod data
>>>>> update, which is really reasonable given the size of the masking
>>>>> section. The reading is lockless, the writing is not.
>>>>>
>>>> I was referring to the argument that system calls are so fast that
>>>> replacing gtod with a syscall-less version that uses function
>>>> pointer dereferencing instead does not make much of a difference.
>>> That is not what I said. I compared the weight of a function pointer
>>> call with the one of four asignments with irqs off. And yes syscalls =
are
>>> fast on x86, do the measurements yourself, you may be surprised.
>>>
>>>> Be it as it may, I need to check how far our budget can cover
>>>> the (much more comprehensive) modifications required for the
>>>> solution suggested by you. Let's see.
>>> I do not think there is that much work involved. The way I see it, we=

>>> would need to replace our tsc reading function with one returning
>>> "ntp-corrected" tsc (that is, essentially a subset of the gettimeofda=
y
>>> function you implemented, without conversion to ns and to CLOCK_REALT=
IME).
>>>
>>> Changes in this monotonic clock would trigger a recomputation of the
>>> next timer event date.
>>> Changes in monotonic to real-time conversion would trigger a call to
>>> xnpod_set_time.
>> If all works out well, it might be that simple. But this is timer/cloc=
k
>> stuff, the heart of the system, and easy to get subtly wrong.
>>
>> For that reason the plan was to gain more confidence in the externally=

>> corrected clock source, collect experience in other use cases, and the=
n
>> work on the core for its optional use.
>>
>> So far our customer is using this clock for important but not yet
>> critical jobs. Making it the RT clock source is of a different quality=
,
>> and for now without a use case.
>=20
> To be quite frank about use cases, I do not really understand in what
> use case the patch Wolfgang sent is useful. An application can not use
> the timestamps returned by this gettimeofday syscall for anything
> useful. And if we talk about things breaking subtly, an application tha=
t
> would use these timestamps with Xenomai services would be subtly broken=

> too.

Just like it seems to be the case for Steve (unless I misunderstood his
reply), it is very useful for us being able to time-stamp events in RT
context that need to be correlated with events stamped in non-RT
(including non-Xenomai) parts or even on other systems: (offline) data
fusion, logging, tracing. I even bet that this is currently the major
use case for synchronized clocks, only a smaller part already has the
need to synchronize timed activities on a common clock source. But there
is huge potential in the second part once we can provide a stable
infrastructure.

>=20
> Avoiding the drift between Xenomai clock and Linux clock by making them=

> synchronized by design, on the other hand, albeit probably solving a
> corner case, looks more useful, and some people asked for it (it looks
> to me like what Steve asked for is that, not to have a third timebase

It is surely more useful, but also more complex. Nothing unsolvable, but
asking for more care.

> accessible in real-time context, and Steve asked for a solution for
> powerpc, not for x86).

Even a "third clock" would have to be delivered for more archs than x86,
no question. We would basically need a generic but slow syscall variant
and per-arch syscall-less optimizations (where feasible).

>=20
> So, my feeling about all this is that Wolfgang's patch is not useful fo=
r
> anyone else than your customer.
>=20

I think your feeling is a bit too pessimistic on this general approach
and a bit too optimistic regarding the complexity of a complete
solution. But I wouldn't mind being proven wrong, specifically regarding
the latter. However, let's see if we can do some uncontroversial steps
in this direction.

Jan


--------------enig38887816DEC01DB702F25180
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvzHIgACgkQitSsb3rl5xRPiQCgyr0xwjv0a+WpFb3ZUxhvN1ST
iScAoII9DTb+jddqpBsUrwd7uDGeZ9+Y
=Lls/
-----END PGP SIGNATURE-----

--------------enig38887816DEC01DB702F25180--

