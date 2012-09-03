Message-ID: <504503DC.4040908@xenomai.org>
Date: Mon, 03 Sep 2012 21:24:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHue_TVRdTsre3E7NxHtb=6XfxkL7_36nsLLxSkiF3kUJAJ5Vw@mail.gmail.com>	<5022B5E4.7040101@xenomai.org>	<CAHue_TWodrVNxhsxXZ6_xcOGWHDqVGe41qbY0=R3RhFjBedG+g@mail.gmail.com>	<50339840.1070202@xenomai.org>	<CAHue_TVSGuatTqL4fRFoOABo4KTm8dFPmRFp7QJNmpk=ZU7NtQ@mail.gmail.com>
	<CAHue_TUKTiusLqfXK59O+PVoxONKAE2xQyBYOgjDh=dZZ2-b3w@mail.gmail.com>
In-Reply-To: <CAHue_TUKTiusLqfXK59O+PVoxONKAE2xQyBYOgjDh=dZZ2-b3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cortex-a9 - please fix xenomai-fix-lfs-issue.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?TWFyY2luIEt1xZtrYQ==?= <marckuska@gmail.com>
Cc: xenomai@xenomai.org

On 09/03/2012 08:04 PM, Marcin Ku=C5=9Bka wrote:

> This time i only changed the IP address and the result is different (ma=
ybe
> that seg fault was caused by unreachable host):
>=20
> */usr/xenomai/bin # ./xeno-test -l "dohell -s xx.xx.xx.117 -m /mnt -l" =
-t 2
> Started child 466: /bin/sh /usr/xenomai/bin/xeno-test-run-wrapper
> ./xeno-test -t 2
> + echo 0
> + /usr/xenomai/bin/arith
> mul: 0x79364d93, shft: 26
> integ: 30, frac: 0x4d9364d9364d9364
>=20
> signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
> inline calibration: 0x0000000000000000: 666.600 ns, rejected 9997/10000=

> inlined llimd: 0x79364d9364d9362f: 3354.500 ns, rejected 20/10000
> inlined llmulshft: 0x79364d92ffffffe1: -166.600 ns, rejected 9998/10000=

> inlined nodiv_llimd: 0x79364d9364d9362f: -166.600 ns, rejected 9998/100=
00
> out of line calibration: 0x0000000000000000: 500.000 ns, rejected 9998/=
10000
> out of line llimd: 0x79364d9364d9362f: 3542.200 ns, rejected 10/10000
> out of line llmulshft: 0x79364d92ffffffe1: 166.600 ns, rejected 9997/10=
000
> out of line nodiv_llimd: 0x79364d9364d9362f: 166.600 ns, rejected 9997/=
10000
>=20
> signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
> inline calibration: 0x0000000000000000: 800.000 ns, rejected 9995/10000=

> inlined llimd: 0x86c9b26c9b26c9d1: 3237.300 ns, rejected 16/10000
> inlined llmulshft: 0x86c9b26d0000001e: 33.300 ns, rejected 9994/10000
> inlined nodiv_llimd: 0x86c9b26c9b26c9d1: -800.000 ns, rejected 9999/100=
00
> out of line calibration: 0x0000000000000000: 750.000 ns, rejected 9996/=
10000
> out of line llimd: 0x86c9b26c9b26c9d1: 3313.200 ns, rejected 11/10000
> out of line llmulshft: 0x86c9b26d0000001e: 0.000 ns, rejected 9996/1000=
0
> out of line nodiv_llimd: 0x86c9b26c9b26c9d1: -83.400 ns, rejected 9997/=
10000
>=20
> unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
> inline calibration: 0x0000000000000000: 500.000 ns, rejected 9998/10000=

> inlined nodiv_ullimd: 0x79364d9364d9362f: 250.000 ns, rejected 9996/100=
00
> out of line calibration: 0x0000000000000000: 666.600 ns, rejected 9997/=
10000
> out of line nodiv_ullimd: 0x79364d9364d9362f: 270.900 ns, rejected
> 9984/10000
> + /usr/xenomai/bin/clocktest -C 42 -T 30
> =3D=3D Tested clock: 42 (CLOCK_HOST_REALTIME)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>   0                  3.0            0.000          0            0.0
> + /usr/xenomai/bin/switchtest -T 30
> =3D=3D Testing FPU check routines...
> d0: 1 !=3D 2
> d1: 1 !=3D 2
> d2: 1 !=3D 2
> d3: 1 !=3D 2
> d4: 1 !=3D 2
> d5: 1 !=3D 2
> d6: 1 !=3D 2
> d7: 1 !=3D 2
> d8: 1 !=3D 2
> d9: 1 !=3D 2
> d10: 1 !=3D 2
> d11: 1 !=3D 2
> d12: 1 !=3D 2
> d13: 1 !=3D 2
> d14: 1 !=3D 2
> d15: 1 !=3D 2
> =3D=3D FPU check routines: OK.
> =3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
> rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup


> Xenomai: suspending kernel thread 82922908 ('rtk5/0') at 0x8005bbc8
after exception #0x0

This looks like the same bug as in the previous mail. We desperately
would like to know what is at 0x8005bbc8

> Xenomai: zombie thread rtk3/0 (829218c8) would not die...


That is another bug, probably due to some conflict between debug
options. Try disabling the debugs.

> (...)
> And it stops here - no signs of life given.


That is because the "zombie would not die" error is a fatal error. The
trace is due to the fact that you enabled the "panic back trace" option
(IPIPE_TRACE_PANIC).

--=20
                                                                Gilles.


