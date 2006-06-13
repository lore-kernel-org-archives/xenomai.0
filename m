Message-ID: <448EA7F7.5000802@domain.hid>
Date: Tue, 13 Jun 2006 13:56:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] ns vs. tsc as internal timer base
References: <448E98A3.6080707@domain.hid> <448E9E8B.70809@domain.hid>
In-Reply-To: <448E9E8B.70809@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB665A89C75FD98E0AC8F8476"
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
--------------enigB665A89C75FD98E0AC8F8476
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> between some football half-times of the last days ;), I played a bit
>> with a hand-optimised xnarch_tsc_to_ns() for x86. Using scaled math, I=

>> achieved between 3 (P-I 133 MHz) to 4 times (P-M 1.3 GHz) faster
>> conversions than with the current variant. While this optimisation onl=
y
>> saves a few ten nanoseconds on high-end, slow processors can gain
>> several hundreds of nanos per conversion (my P-133: -600 ns).
>>
>=20
> I did exactely the same a few weeks ago, based on Anzinger's scaled mat=
h

:) We should coordinate better.

> from i386/kernel/timers/timer_tsc.c. And indeed, I had x 20 performance=

> improvements in some cases.

Oops, that sounds like a bit too extreme optimisations. Is the original
version varying that much? I didn't observe this.

Here is my current version, BTW:

long tsc_scale;
unsigned int tsc_shift =3D 31;

static inline long long fast_tsc_to_ns(long long ts)
{
    long long ret;

    __asm__ (
        /* HI =3D HIWORD(ts) * tsc_scale */
        "mov  %%eax,%%ebx\n\t"
        "mov  %%edx,%%eax\n\t"
        "imull %2\n\t"
        "mov  %%eax,%%esi\n\t"
        "mov  %%edx,%%edi\n\t"

        /* LO =3D LOWORD(ts) * tsc_scale */
        "mov  %%ebx,%%eax\n\t"
        "mull %2\n\t"

        /* ret =3D (HI << 32) + LO */
        "add  %%esi,%%edx\n\t"
        "adc  $0,%%edi\n\t"

        /* ret =3D ret >> tsc_shift */
        "shrd %%cl,%%edx,%%eax\n\t"
        "shrd %%cl,%%edi,%%edx\n\t"
        : "=3DA"(ret)
        : "A" (ts), "m" (tsc_scale), "c" (tsc_shift)
        : "ebx", "esi", "edi");

    return ret;
}

void init_tsc(unsigned long cpu_freq)
{
    unsigned long long scale;

    while (1) {
        scale =3D do_div(1000000000LL << tsc_shift, cpu_freq);
        if (scale <=3D 0x7FFFFFFF)
            break;
        tsc_shift--;
    }
    tsc_scale =3D scale;
}

This version will use 31 (GHz cpu_freq) to 26 (~32 MHz) shifts, i.e. a
bit more than the Linux kernel's 22 bits.

>=20
>> This does not come for free: accuracy of very large values is slightly=

>> worse, but that's likely negligible compared to the clock accuracy of
>> TSCs (does anyone have any real numbers on the latter, BTW?).
>>
>=20
> We do start losing significant precision for 2 ms delays and above,
> IIRC. This could be an issue for some events in aperiodic mode, albeit
> we could use a plain divide for those. The cost of conditionally doing
> this remains to be evaluated though.

Maybe I tested (not calculated - math is too hard for me :o)) the wrong
values, but I didn't see such high regressions.

>=20
>> As we loose some bits the one way, converting back still requires "rea=
l"
>> division (i.e. the use of the existing slower xnarch_ns_to_tsc).
>> Otherwise, we would get significant errors already for small intervals=
=2E
>>
>> To avoid loosing the optimisation again in ns_to_tsc, I thought about
>> basing the whole internal timer arithmetics on nanoseconds instead of
>> TSCs as it is now. Although I dug quite a lot in the current timer
>> subsystem the last weeks, I may still oversee aspects and I'm
>> x86-biased. Therefore my question before thinking or even patching
>> further this way: What was the motivation to choose TSCs as internal
>> time base?
>=20
> TSC are not the whole nucleus time base, but only the timer management
> one. The motivation to use TSCs in nucleus/timer.c was to pick a unit
> which would not require any conversion beyond the initial one in
> xntimer_start.

That helps strictly periodic application timers, not aperiodic ones like
timeouts.

>=20
>> Any pitfalls down the road (except introducing regressions)?
>=20
> Well, pitfalls expected from changing the core idea of time of the time=
r
> management code... :o>
>=20

You mean turning

rthal_timer_program_shot(rthal_imuldiv(delay,RTHAL_TIMER_FREQ,RTHAL_CPU_F=
REQ));

into

rthal_timer_program_shot(rthal_imuldiv(delay,RTHAL_TIMER_FREQ,1000000000)=
);

e.g. ?

Jan


--------------enigB665A89C75FD98E0AC8F8476
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEjqf3niDOoMHTA+kRAshgAJkBpQ5sNuSz/7imdTn51ioQdISOMACeMoVg
fSxSruatrknZbOzkJOr0anc=
=kFsp
-----END PGP SIGNATURE-----

--------------enigB665A89C75FD98E0AC8F8476--

