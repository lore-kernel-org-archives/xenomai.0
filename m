Message-ID: <47F633B7.70003@domain.hid>
Date: Fri, 04 Apr 2008 15:57:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>	
	<2ff1a98a0804020905v7019574ai927f213ab6603e41@domain.hid>	
	<47F3B348.1090102@domain.hid> <47F4CAD1.3090002@domain.hid>	
	<47F4D87F.7080204@domain.hid> <47F551AD.9030509@domain.hid>	
	<47F5E57C.6020309@domain.hid> <47F606AE.6080800@domain.hid>	
	<2ff1a98a0804040618r2717c5efrb852bcbc76e6bd0c@domain.hid>	
	<47F62C46.4080003@domain.hid>
	<2ff1a98a0804040632w391afda4rf30c8ca09fbb0874@domain.hid>
In-Reply-To: <2ff1a98a0804040632w391afda4rf30c8ca09fbb0874@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3BD3A3C2CD98257ADE8414B3"
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
--------------enig3BD3A3C2CD98257ADE8414B3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> On Fri, Apr 4, 2008 at 3:25 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Gilles Chanteperdrix wrote:
>>
>>> On Fri, Apr 4, 2008 at 12:45 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote=
:
>>>
>>>> Sebastian Smolorz wrote:
>>>>
>>>>
>>>>> Jan Kiszka wrote:
>>>>>
>>>>>
>>>>>> Sebastian Smolorz wrote:
>>>>>>
>>>>>>
>>>>>>> Jan Kiszka wrote:
>>>>>>>
>>>>>>>
>>>>>>>> This patch may do the trick: it uses the inverted tsc-to-ns
>> function
>>>> instead of the frequency-based one. Be warned, it is totally unteste=
d
>> inside
>>>> Xenomai, I just ran it in a user space test program. But it may give=
 an
>>>> idea.
>>>>
>>>>>>> Your patch needed two minor corrections (ns instead of ts in
>> functions
>>>> xnarch_ns_to_tsc()) in order to compile. A short run (30 minutes) of=

>> latency
>>>> -t1 seems to prove your bug-fix: There seems to be no drift.
>>>>
>>>>>> That's good to hear.
>>>>>>
>>>>>>
>>>>>>
>>>>>>> If I got your patch correctly, it doesn't make xnarch_tsc_to_ns
>> more
>>>> precise but introduces a new function xnarch_ns_to_tsc() which is al=
so
>> less
>>>> precise than the generic xnarch_ns_to_tsc(), right?
>>>>
>>>>>> Yes. It is now precisely the inverse imprecision, so to say. :)
>>>>>>
>>>>>>
>>>>>>
>>>>>>> So isn't there still the danger of getting wrong values when
>> calling
>>>> xnarch_tsc_to_ns()  not in combination with xnarch_ns_to_tsc()?
>>>>
>>>>>> Only if the user decides to implement his own conversion. Xenomai
>> with
>>>> all its skins and both in kernel and user space should always run
>> through
>>>> the xnarch_* path.
>>>>
>>>>> OK, would you commit the patch?
>>>>>
>>>>>
>>>>  Will do unless someone else has concerns. Gilles, Philippe? ARM and=

>>>> Blackfin then need to be fixed similarly, full patch attached.
>>>>
>>> Well, I am sorry, but I do not like this solution;
>>> - the aim of scaled math is to avoid divisions, and with this patch w=
e
>>> end up using divisions;
>>>
>>  Please check again, no new division due to my patch, just different
>> parameters for the existing one.
>=20
> I just checked your patch rapidly, but saw that xnarch_ns_to_tsc was
> using llimd, so does use division. My fast_llimd could be used to
> replace both the llimd calls in xnarch_tsc_to_ns and xnarch_ns_to_tsc.
>=20
>>
>>
>>> - with scaled math we do wrong calculations, and making a wrong
>>> xnarch_ns_to_tsc only works for values which should be passed to
>>> xnarch_tsc_to_ns.
>>>
>>  IMHO, the error is within the range of the clock's precision, if not =
even
>> below. So struggling for mathematically precise conversion of imprecis=
e
>> physical values makes no sense to me. Therefore I once proposed the
>> scaled-math optimization.
>=20
> Now that I have understood what really happens, I disagree with this
> approach. Take the implementation of clock_gettime (or
> rtdm_clock_read, for that matter). They basically do
> xnarch_tsc_to_ns(ipipe_read_tsc()). The relative error may be small,
> but in the very frequent use case of substracting two results of
> consecutive reads of ipipe_read_tsc, the result of the substraction is
> essentially garbage, because the result of the substraction may be of
> the same order as the absolute error of the conversion. And I insist,
> this use case of clock_gettime or rtdm_clock_read is a very realistic
> use case.

This use case is valid, but I don't see the error scenario you sketch:=20
The error of the conversion is only relevant for large deltas,=20
tsc_to_ns(B)-tsc_to_ns(A)=3DB-A for any small B-A. Cornelius' test nicely=
=20
showed constantly increasing deviation, not something that jumped=20
around. Essentially, we are just replacing

	xnarch_llimd(ts, 1000000000, RTHAL_CPU_FREQ);

with

	xnarch_llimd(ts, xnarch_tsc_scale, 1<<xnarch_tsc_shift);

which introduces a linearly increasing error of the _absolute_ results,=20
not of relative ones. But if you can prove me wrong, I would take=20
everything back and agree on kicking out the scaled math immediately!

Jan


--------------enig3BD3A3C2CD98257ADE8414B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH9jO6niDOoMHTA+kRAh+lAJ9mXi5pLp5PjYtw/8jecVmXok/fKACfaxqN
zzDkZNX5LzawEPHOnN1DMI4=
=t4DA
-----END PGP SIGNATURE-----

--------------enig3BD3A3C2CD98257ADE8414B3--

