Message-ID: <43DF4DBC.3020303@domain.hid>
Date: Tue, 31 Jan 2006 12:45:00 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] merge powerpc fpu.S and fpu_64.S
References: <43C7877E.50509@domain.hid>
In-Reply-To: <43C7877E.50509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
> Currently the two powerpc fpu*.S assembly sections are so similar that=20
> there's really no need for two of them. Merge them into a common fpu.S.=
=20
> Tested on a G5.
>=20

Applied, thanks.

> -- Heikki Lindholm
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> diff -Nru xenomai/ksrc/arch/powerpc/fpu.S xenomai-devel/ksrc/arch/power=
pc/fpu.S
> --- xenomai/ksrc/arch/powerpc/fpu.S	2005-11-18 20:55:24.000000000 +0200
> +++ xenomai-devel/ksrc/arch/powerpc/fpu.S	2006-01-13 12:35:49.000000000=
 +0200
> @@ -19,9 +19,24 @@
> =20
>  #include <linux/config.h>=20
>  #include <asm/processor.h>
> -#include <asm/cputable.h>
>  #include <asm/ppc_asm.h>
> =20
> +#ifdef CONFIG_PPC601_SYNC_FIX
> +#define SYNC				\
> +BEGIN_FTR_SECTION			\
> +	sync;				\
> +	isync;				\
> +END_FTR_SECTION_IFSET(CPU_FTR_601)
> +#else /* !CONFIG_PPC601_SYNC_FIX */
> +#define	SYNC
> +#endif /* CONFIG_PPC601_SYNC_FIX */
> +
> +#if defined(CONFIG_PPC64) || defined(CONFIG_PPC64BRIDGE)
> +#define MTMSRD(r)	.long	(0x7c000164 + ((r) << 21))	/* mtmsrd */
> +#else
> +#define MTMSRD(r)	mtmsr	r
> +#endif /* CONFIG_PPC64 || CONFIG_PPC64BRIDGE */
> +
>  #define RTHAL_FPSAVE(n, base)	stfd n,8*(n)(base)
>  #define RTHAL_FPSAVE2(n, base)	RTHAL_FPSAVE(n, base); RTHAL_FPSAVE(n+1=
, base)
>  #define RTHAL_FPSAVE4(n, base)	RTHAL_FPSAVE2(n, base); RTHAL_FPSAVE2(n=
+2, base)
> diff -Nru xenomai/ksrc/arch/powerpc/fpu_64.S xenomai-devel/ksrc/arch/po=
werpc/fpu_64.S
> --- xenomai/ksrc/arch/powerpc/fpu_64.S	2005-11-18 20:55:24.000000000 +0=
200
> +++ xenomai-devel/ksrc/arch/powerpc/fpu_64.S	1970-01-01 02:00:00.000000=
000 +0200
> @@ -1,71 +0,0 @@
> -/*
> - * Copyright (C) 2001,2002,2003,2004 Philippe Gerum.
> - *
> - * 64-bit PowerPC adoption
> - *   copyright (C) 2005 Taneli V=C3=A4h=C3=A4kangas and Heikki Lindhol=
m
> - *
> - * This program is free software; you can redistribute it and/or modif=
y
> - * it under the terms of the GNU General Public License as published b=
y
> - * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 0213=
9,
> - * USA; either version 2 of the License, or (at your option) any later
> - * version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-130=
7, USA.
> - */
> -
> -#include <linux/config.h>=20
> -#include <asm/processor.h>
> -#include <asm/ppc_asm.h>
> -
> -#define RTHAL_FPSAVE(n, base)	stfd n,8*(n)(base)
> -#define RTHAL_FPSAVE2(n, base)	RTHAL_FPSAVE(n, base); RTHAL_FPSAVE(n+1=
, base)
> -#define RTHAL_FPSAVE4(n, base)	RTHAL_FPSAVE2(n, base); RTHAL_FPSAVE2(n=
+2, base)
> -#define RTHAL_FPSAVE8(n, base)	RTHAL_FPSAVE4(n, base); RTHAL_FPSAVE4(n=
+4, base)
> -#define RTHAL_FPSAVE16(n, base)	RTHAL_FPSAVE8(n, base); RTHAL_FPSAVE8(=
n+8, base)
> -#define RTHAL_FPSAVE32(n, base)	RTHAL_FPSAVE16(n, base); RTHAL_FPSAVE1=
6(n+16, base)
> -
> -/* r3 =3D &tcb->fpuenv */
> -_GLOBAL(rthal_save_fpu)
> -	mfmsr	r5
> -	ori	r5,r5,MSR_FP		/* Re-enable use of FPU. */
> -	mtmsrd	r5			/* Enable use of fpu. */
> -	isync
> -	RTHAL_FPSAVE32(0,r3)
> -	mffs	fr0
> -	stfd	fr0,8*32(r3)
> -	blr
> -
> -#define RTHAL_FPLOAD(n, base)	lfd n,8*(n)(base)
> -#define RTHAL_FPLOAD2(n, base)	RTHAL_FPLOAD(n, base); RTHAL_FPLOAD(n+1=
, base)
> -#define RTHAL_FPLOAD4(n, base)	RTHAL_FPLOAD2(n, base); RTHAL_FPLOAD2(n=
+2, base)
> -#define RTHAL_FPLOAD8(n, base)	RTHAL_FPLOAD4(n, base); RTHAL_FPLOAD4(n=
+4, base)
> -#define RTHAL_FPLOAD16(n, base)	RTHAL_FPLOAD8(n, base); RTHAL_FPLOAD8(=
n+8, base)
> -#define RTHAL_FPLOAD32(n, base)	RTHAL_FPLOAD16(n, base); RTHAL_FPLOAD1=
6(n+16, base)
> -
> -/* r3 =3D &tcb->fpuenv */
> -_GLOBAL(rthal_init_fpu)
> -	mfmsr	r5
> -	ori	r5,r5,MSR_FP|MSR_FE1	/* RT kernel threads always operate in */
> -	li	r4,MSR_FE0		/* imprecise non-recoverable exception mode. */
> -	andc	r5,r5,r4
> -	mtmsrd	r5
> -
> -	/* Fallback wanted. */
> -=09
> -/* r3 =3D &tcb->fpuenv */
> -_GLOBAL(rthal_restore_fpu)
> -	mfmsr	r5
> -	ori	r5,r5,MSR_FP		/* Re-enable use of FPU. */
> -	mtmsrd	r5			/* Enable use of fpu. */
> -	isync
> -	lfd	fr0,8*32(r3)
> -	mtfsf	0xff,0
> -	RTHAL_FPLOAD32(0,r3)
> -	blr
> diff -Nru xenomai/ksrc/arch/powerpc/Makefile xenomai-devel/ksrc/arch/po=
werpc/Makefile
> --- xenomai/ksrc/arch/powerpc/Makefile	2006-01-12 15:25:59.000000000 +0=
200
> +++ xenomai-devel/ksrc/arch/powerpc/Makefile	2006-01-13 12:23:00.000000=
000 +0200
> @@ -5,13 +5,12 @@
>  obj-$(CONFIG_XENOMAI) +=3D xeno_hal.o
> =20
>  xeno_hal-y :=3D hal.o
> +xeno_hal-$(CONFIG_XENO_HW_FPU) +=3D fpu.o
> =20
>  ifeq ($(CONFIG_PPC64),y)
>  xeno_hal-$(CONFIG_PPC64) +=3D switch_64.o
> -xeno_hal-$(CONFIG_XENO_HW_FPU) +=3D fpu_64.o
>  else
>  xeno_hal-$(CONFIG_PPC) +=3D switch.o
> -xeno_hal-$(CONFIG_XENO_HW_FPU) +=3D fpu.o
>  endif
> =20
>  else
> @@ -23,13 +22,12 @@
>  O_TARGET :=3D built-in.o
> =20
>  obj-y :=3D hal.o
> +obj-$(CONFIG_XENO_HW_FPU) +=3D fpu.o
> =20
>  ifeq ($(CONFIG_PPC64),y)
>  obj-y +=3D switch_64.o
> -obj-$(CONFIG_XENO_HW_FPU) +=3D fpu_64.o
>  else
>  obj-y +=3D switch.o
> -obj-$(CONFIG_XENO_HW_FPU) +=3D fpu.o
>  endif
> =20
>  export-objs :=3D hal.o
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


--=20

Philippe.

