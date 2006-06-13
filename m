Message-ID: <448EBE8C.60900@domain.hid>
Date: Tue, 13 Jun 2006 15:33:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] ns vs. tsc as internal timer base
References: <448E98A3.6080707@domain.hid> <448E9E8B.70809@domain.hid>
	<448EA7F7.5000802@domain.hid> <448EB038.8070802@domain.hid>
In-Reply-To: <448EB038.8070802@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5C3DBC900FD03E92B0377009"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C3DBC900FD03E92B0377009
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> from i386/kernel/timers/timer_tsc.c. And indeed, I had x 20 performan=
ce
>>> improvements in some cases.
>>
>> Oops, that sounds like a bit too extreme optimisations. Is the origina=
l
>> version varying that much? I didn't observe this.
>>
>> Here is my current version, BTW:
>>
>> long tsc_scale;
>> unsigned int tsc_shift =3D 31;
>>
>> static inline long long fast_tsc_to_ns(long long ts)
>> {
>>     long long ret;
>>
>>     __asm__ (
>>         /* HI =3D HIWORD(ts) * tsc_scale */
>>         "mov  %%eax,%%ebx\n\t"
>>         "mov  %%edx,%%eax\n\t"
>>         "imull %2\n\t"
>>         "mov  %%eax,%%esi\n\t"
>>         "mov  %%edx,%%edi\n\t"
>>
>>         /* LO =3D LOWORD(ts) * tsc_scale */
>>         "mov  %%ebx,%%eax\n\t"
>>         "mull %2\n\t"
>>
>>         /* ret =3D (HI << 32) + LO */
>>         "add  %%esi,%%edx\n\t"
>>         "adc  $0,%%edi\n\t"
>>
>>         /* ret =3D ret >> tsc_shift */
>>         "shrd %%cl,%%edx,%%eax\n\t"
>>         "shrd %%cl,%%edi,%%edx\n\t"
>>         : "=3DA"(ret)
>>         : "A" (ts), "m" (tsc_scale), "c" (tsc_shift)
>>         : "ebx", "esi", "edi");
>>
>>     return ret;
>> }
>>
>> void init_tsc(unsigned long cpu_freq)
>> {
>>     unsigned long long scale;
>>
>>     while (1) {
>>         scale =3D do_div(1000000000LL << tsc_shift, cpu_freq);
>>         if (scale <=3D 0x7FFFFFFF)
>>             break;
>>         tsc_shift--;
>>     }
>>     tsc_scale =3D scale;
>> }
>>
>> This version will use 31 (GHz cpu_freq) to 26 (~32 MHz) shifts, i.e. a=

>> bit more than the Linux kernel's 22 bits.
>>
>=20
> Here is likely why we have different levels of accuracy and performance=
,
>  firstly my version is bluntly based on the khz freq, secondly it
> calculates the other way around, i.e. ns2tsc, so that tsc are keep in
> the inner code, but more efficiently converted from ns counts passed to=

> the outer interface:
>=20
> static unsigned long ns2cyc_scale;
> #define NS2CYC_SCALE_FACTOR 10 /* 2^10, carefully chosen */

Linux only uses 10 bits for scheduling time calculation, which is
tick-based (low-res) anyway. The tsc clock_source uses 22 bits. The
latter overflows after an hour or so, because they drop all bits > 64
after the multiplication - insignificantly faster when using optimised
code anyway.

>=20
> static inline void set_ns2cyc_scale(unsigned long cpu_khz)
> {
>     ns2cyc_scale =3D (cpu_khz << NS2CYC_SCALE_FACTOR) / 1000000;
> }
>=20
> static inline unsigned long long ns_2_cycles(unsigned long long ns)
> {
>     return ns * ns2cyc_scale >> NS2CYC_SCALE_FACTOR;
> }
>=20
>>>
>>> TSC are not the whole nucleus time base, but only the timer managemen=
t
>>> one. The motivation to use TSCs in nucleus/timer.c was to pick a unit=

>>> which would not require any conversion beyond the initial one in
>>> xntimer_start.
>>
>>
>> That helps strictly periodic application timers, not aperiodic ones li=
ke
>> timeouts.
>>
>=20
> It depends, periodic timers usually exhibit larger delays, so the gain
> is more significant with oneshot timings incurring smaller delays, henc=
e
> a higher number of calculations.
>=20
>>
>>>> Any pitfalls down the road (except introducing regressions)?
>>>
>>> Well, pitfalls expected from changing the core idea of time of the ti=
mer
>>> management code... :o>
>>>
>>
>> You mean turning
>>
>> rthal_timer_program_shot(rthal_imuldiv(delay,RTHAL_TIMER_FREQ,RTHAL_CP=
U_FREQ));
>>
>>
>> into
>>
>> rthal_timer_program_shot(rthal_imuldiv(delay,RTHAL_TIMER_FREQ,10000000=
00));
>>
>>
>=20
> Not really, it was a general remark about changing a code that might
> have some assumtions on using TSCs. Additionally, only x86 needs to
> rescale TSC values to the timer frequency, other archs use the same uni=
t
> on both sides, and such unit might even have nothing to do with any CPU=

> accounting (e.g. blackfin uses a free running timer, ppc uses the
> internal timebase, etc).

Ok, an interesting aspect I already assumed but didn't check in details
yet. That makes dealing with TSCs interesting again on !=3D x86. In
contrast, on x86, there is the aspect of frequency scaling that Anders
brought up and which would speak pro nanos.

>=20
> This said, it should not have that many assumptions, and in any case,
> they should be confined to nucleus/timers.c. I think we should give thi=
s
> kind of optimization a try.
>=20

Yep, it just needs some more brain cycles how to do this precisely.

Jan


--------------enig5C3DBC900FD03E92B0377009
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEjr6MniDOoMHTA+kRAqc9AJsGjS8Klfw4owwc99SighKt+3PTGgCeLiyT
NZBKIFtChlAhg/W/CVhNN2k=
=3gIc
-----END PGP SIGNATURE-----

--------------enig5C3DBC900FD03E92B0377009--

