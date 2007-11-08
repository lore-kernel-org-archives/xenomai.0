Message-ID: <473335D0.1040502@domain.hid>
Date: Thu, 08 Nov 2007 17:14:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20071108155600.149430@domain.hid>
In-Reply-To: <20071108155600.149430@domain.hid>
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
Cc: xenomai@xenomai.org

MAHAVIRA@gmx.net wrote:
> Hello,=20
>=20
> i get an error during make of the new linux kernel with xenomai
> support. i use
> /usr/src/linux-2.6.23
> /usr/src/adeos-ipipe-2.6.23-i386-1.10-11.patch
> /usr/src/xenomai-2.3.4
>=20
> i patched the kernel-source with ./prepare-kernel.sh and copy a config
> file from my old kernel (2.6.22-14-generic) to .config, use make menuco=
nfig
> and sudo make. i receive this error:
>=20
> CC      kernel/xenomai/arch/generic/hal.o
> In file included from include/asm/xenomai/hal.h:40,
>                  from kernel/xenomai/arch/generic/hal.c:42:
> include/asm/xenomai/wrappers.h: In function =E2=80=98wrap_switch_iobitm=
ap=E2=80=99:
> include/asm/xenomai/wrappers.h:86: error: =E2=80=98struct tss_struct=E2=
=80=99 has no member named =E2=80=98io_bitmap_base=E2=80=99
> include/asm/xenomai/wrappers.h:96: error: =E2=80=98struct tss_struct=E2=
=80=99 has no member named =E2=80=98io_bitmap_base=E2=80=99
> make[4]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
> make[3]: *** [kernel/xenomai/arch/generic] Error 2
> make[2]: *** [kernel/xenomai/arch] Error 2
> make[1]: *** [kernel/xenomai] Error 2
> make: *** [kernel] Error 2
>=20
> any help?

Use Xenomai 2.4-rc5. Regarding i386, Xenomai 2.3.x only supports kernels
up to 2.6.20.x.

Jan

--=20
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

