Message-ID: <473442D8.809@domain.hid>
Date: Fri, 09 Nov 2007 12:22:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20071108155600.149430@domain.hid> <473335D0.1040502@domain.hid>
	<20071109104334.244480@domain.hid>
In-Reply-To: <20071109104334.244480@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help]
 =?utf-8?q?Error_during_make=2C_error=3A_=E2=80=98s?=
 =?utf-8?q?truct_tss=5Fstruct=E2=80=99_has_no_member_named_=E2=80=98io=5Fb?=
 =?utf-8?b?aXRtYXBfYmFzZeKAmQ==?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: MAHAVIRA@gmx.net
Cc: xenomai-help <xenomai@xenomai.org>

Please take care of all CCs.

MAHAVIRA@gmx.net wrote:
> -------- Original-Nachricht --------
>> Datum: Thu, 08 Nov 2007 17:14:08 +0100
>> Von: Jan Kiszka <jan.kiszka@domain.hid>
>> An: MAHAVIRA@gmx.net
>> CC: xenomai@xenomai.org
>> Betreff: Re: [Xenomai-help] Error during make, error: =E2=80=98struct =
tss_struct=E2=80=99 has no member named =E2=80=98io_bitmap_base=E2=80=99
>=20
>> MAHAVIRA@gmx.net wrote:
>>> Hello,=20
>>>
>>> i get an error during make of the new linux kernel with xenomai
>>> support. i use
>>> /usr/src/linux-2.6.23
>>> /usr/src/adeos-ipipe-2.6.23-i386-1.10-11.patch
>>> /usr/src/xenomai-2.3.4
>>>
>>> i patched the kernel-source with ./prepare-kernel.sh and copy a confi=
g
>>> file from my old kernel (2.6.22-14-generic) to .config, use make
>> menuconfig
>>> and sudo make. i receive this error:
>>>
>>> CC      kernel/xenomai/arch/generic/hal.o
>>> In file included from include/asm/xenomai/hal.h:40,
>>>                  from kernel/xenomai/arch/generic/hal.c:42:
>>> include/asm/xenomai/wrappers.h: In function =E2=80=98wrap_switch_iobi=
tmap=E2=80=99:
>>> include/asm/xenomai/wrappers.h:86: error: =E2=80=98struct tss_struct=E2=
=80=99 has no
>> member named =E2=80=98io_bitmap_base=E2=80=99
>>> include/asm/xenomai/wrappers.h:96: error: =E2=80=98struct tss_struct=E2=
=80=99 has no
>> member named =E2=80=98io_bitmap_base=E2=80=99
>>> make[4]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
>>> make[3]: *** [kernel/xenomai/arch/generic] Error 2
>>> make[2]: *** [kernel/xenomai/arch] Error 2
>>> make[1]: *** [kernel/xenomai] Error 2
>>> make: *** [kernel] Error 2
>>>
>>> any help?
>> Use Xenomai 2.4-rc5. Regarding i386, Xenomai 2.3.x only supports kerne=
ls
>> up to 2.6.20.x.
>>
>> Jan
>=20
>=20
> ok, i use now=20
>=20
> linux-2.6.23
> xenomai-2.4-rc5
> adeos-ipipe-2.6.23-i386-1.10-11.patch
>=20
> the error above disappears, but there is another error now:
>=20
>   CC      arch/i386/xenomai/hal.o
> arch/i386/xenomai/hal.c: In function =E2=80=98rthal_setup_8254_tsc=E2=80=
=99:
> arch/i386/xenomai/hal.c:551: error: =E2=80=98PIT_MODE=E2=80=99 undeclar=
ed (first use in this function)
> arch/i386/xenomai/hal.c:551: error: (Each undeclared identifier is repo=
rted only once
> arch/i386/xenomai/hal.c:551: error: for each function it appears in.)
> arch/i386/xenomai/hal.c:552: error: =E2=80=98PIT_CH0=E2=80=99 undeclare=
d (first use in this function)
> arch/i386/xenomai/hal.c:555: error: =E2=80=98PIT_CH2=E2=80=99 undeclare=
d (first use in this function)
> arch/i386/xenomai/hal.c: In function =E2=80=98rthal_get_8254_tsc=E2=80=99=
:
> arch/i386/xenomai/hal.c:573: error: =E2=80=98PIT_MODE=E2=80=99 undeclar=
ed (first use in this function)
> arch/i386/xenomai/hal.c:574: error: =E2=80=98PIT_CH2=E2=80=99 undeclare=
d (first use in this function)
> make[1]: *** [arch/i386/xenomai/hal.o] Error 1
> make: *** [arch/i386/xenomai] Error 2
>=20
> any idea?

The above looks like a real build issue of latest Xenomai with oldish
CPU setups. Thanks for reporting, queued for a closer look later.

In the meantime you could select a CPU type that is closer to your
hardware, thus avoiding to use that suboptimal TSC emulation.

Jan

--=20
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

