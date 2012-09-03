Message-ID: <5044F5CA.4030707@xenomai.org>
Date: Mon, 03 Sep 2012 20:24:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHue_TVRdTsre3E7NxHtb=6XfxkL7_36nsLLxSkiF3kUJAJ5Vw@mail.gmail.com>	<5022B5E4.7040101@xenomai.org>	<CAHue_TWodrVNxhsxXZ6_xcOGWHDqVGe41qbY0=R3RhFjBedG+g@mail.gmail.com>	<50339840.1070202@xenomai.org>
	<CAHue_TVSGuatTqL4fRFoOABo4KTm8dFPmRFp7QJNmpk=ZU7NtQ@mail.gmail.com>
In-Reply-To: <CAHue_TVSGuatTqL4fRFoOABo4KTm8dFPmRFp7QJNmpk=ZU7NtQ@mail.gmail.com>
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

On 09/03/2012 07:58 PM, Marcin Ku=C5=9Bka wrote:

> I used standard ipipe-core-3.2.21-arm-1.patch, I made no corrections to=
 it.


Then it can not work, at least in multi-processor mode. See:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting

> (...)

> I-pipe, 1.000 MHz clocksource


A Cortex-A9 (in MP mode) should use the "global timer" clock source,
somewhere around 400 MHz, given that your processor runs at 800 MHz, so,
you are definitely lacking some code.

> (...)

> smsc911x smsc911x: eth0: MAC Address: 00:02:f7:00:40:9c
> ------------[ cut here ]------------
> WARNING: at mm/slab.c:2264 kmem_cache_create+0x690/0x6dc()


I would investigate this first. This looks scary.

> worst
> RTD|     61.000|     63.000|     74.000|       0|     0|     61.000|
> 74.000


High latencies for a cortex-A9. Maybe you enabled all xenomai debug optio=
ns?

> =3D=3D FPU check routines: OK.
> =3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
> rtk_fp_ufpp0-5 rtk_fp_ufppXenomai: suspending kernel thread 829210a8
> ('rtk2/0') at 0x8005bbc8 after exception #0x0
> 0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10 rtus0-11 rtus0-12
> rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16 rtuo_ufpp0-17 rtuo_ufpp0-=
18
> rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22
> Xenomai: RTDM: closing file descriptor 0.
> Segmentation fault
> *
>=20
> Do you have any clues what might be the problem? Btw, the example
> applications are working fine.


Well without a disassembly of the faulting code and the values of the
the registers, we have no idea. Could you post your kernel configuration?=


Also, if you have all Xenomai and I-pipe debug options enabled, could
you try disabling them?

--=20
                                                                Gilles.


