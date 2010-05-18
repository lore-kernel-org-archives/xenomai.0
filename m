Message-ID: <4BF31010.2080003@domain.hid>
Date: Wed, 19 May 2010 00:09:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>	<181804936ABC2349BE503168465576460EBD6239@domain.hid>	<4BF17464.5090100@domain.hid>	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>	<4BF251EC.7040605@domain.hid>
	<4BF267D3.4040500@domain.hid>	<4BF28401.6060503@domain.hid>
	<4BF28B0C.3080705@domain.hid>	<4BF2AB19.5060701@domain.hid>
	<4BF2DF77.90806@domain.hid>	<4BF2F73C.7070605@domain.hid>
	<4BF3045E.5080707@domain.hid>
In-Reply-To: <4BF3045E.5080707@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig511E4A9392D5D9D6829AD0B2"
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
--------------enig511E4A9392D5D9D6829AD0B2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Wolfgang Mauerer wrote:
>> Gilles Chanteperdrix wrote:
>>> Wolfgang Mauerer wrote:
>>>>> On the one hand you make complicated code (which will be costly on =
low
>>>>> end hardware) to avoid shutting interrupts around a few assignments=
, but
>>>>> on the other hand you leave an architecture specific function point=
er
>>>>> call where we want a fast behaviour on average (remember, we do all=
 this
>>>>> to avoid a system call, which is only a few hundreds nanoseconds on=
 your
>>>>> big iron x86), and where we have a generic fast replacement. Someti=
mes,
>>>>> I do not understand your logic.
>>>> But using the same argument, you could get rid of Linux vsyscall bas=
ed
>>>> gettimeofday()...
>>> I do not see your point, the Linux code does not go a long way to mak=
e
>>> lockless code, it simply turns off interrupts around the gtod data
>>> update, which is really reasonable given the size of the masking
>>> section. The reading is lockless, the writing is not.
>>>
>> I was referring to the argument that system calls are so fast that
>> replacing gtod with a syscall-less version that uses function
>> pointer dereferencing instead does not make much of a difference.
>=20
> That is not what I said. I compared the weight of a function pointer
> call with the one of four asignments with irqs off. And yes syscalls ar=
e
> fast on x86, do the measurements yourself, you may be surprised.
>=20
>> Be it as it may, I need to check how far our budget can cover
>> the (much more comprehensive) modifications required for the
>> solution suggested by you. Let's see.
>=20
> I do not think there is that much work involved. The way I see it, we
> would need to replace our tsc reading function with one returning
> "ntp-corrected" tsc (that is, essentially a subset of the gettimeofday
> function you implemented, without conversion to ns and to CLOCK_REALTIM=
E).
>=20
> Changes in this monotonic clock would trigger a recomputation of the
> next timer event date.
> Changes in monotonic to real-time conversion would trigger a call to
> xnpod_set_time.

If all works out well, it might be that simple. But this is timer/clock
stuff, the heart of the system, and easy to get subtly wrong.

For that reason the plan was to gain more confidence in the externally
corrected clock source, collect experience in other use cases, and then
work on the core for its optional use.

So far our customer is using this clock for important but not yet
critical jobs. Making it the RT clock source is of a different quality,
and for now without a use case. I personally do want this feature
long-term, definitely, but I do not see ATM it's going to be something
we can deliver for 2.6. Maybe we can split out the lower bits and
prepare I-pipe as well as the hal already.

Jan


--------------enig511E4A9392D5D9D6829AD0B2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvzEBMACgkQitSsb3rl5xTGqACgvQbpbX98wfqKy6r0jCOLA3UI
PQ4An0UliVsDQM+p7mJLXLALfQO/O+KA
=bAep
-----END PGP SIGNATURE-----

--------------enig511E4A9392D5D9D6829AD0B2--

