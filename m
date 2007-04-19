From: Stelian Pop <stelian@domain.hid>
In-Reply-To: <1176964723.2508.9.camel@domain.hid>
References: <1176585372.15994.14.camel@domain.hid>
	<17958.43866.983944.630780@domain.hid>
	<1176964723.2508.9.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 19 Apr 2007 17:53:21 +0200
Message-Id: <1176998001.8782.30.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] Support EABI enabled kernels on ARM
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
Cc: xenomai@xenomai.org

Le jeudi 19 avril 2007 =E0 08:38 +0200, Stelian Pop a =E9crit :
> Le jeudi 19 avril 2007 =E0 01:35 +0200, Gilles Chanteperdrix a =E9crit =
:
> > Stelian Pop wrote:
> >  > Hi,
> >  >=20
> >  > The attached patch adds an option to make Xenomai userspace issue =
EABI
> >  > syscalls. This is needed to make Xenomai work with kernels compile=
d with
> >  > CONFIG_EABI.
> >  >=20
> > I get a problem with this patch: I am in the no EABI case in user-spa=
ce
> > and kernel-space, and when starting latency, I get an "Illegal
> > instruction" message. If I revert this patch, latency starts
> > correctly. Any idea ?
>=20
> Hmm, I might have screwed up here. A quick looking points me to this
> change:
>=20
> +#define __SYS_REG
> +#define __SYS_REG_LIST
> +#define __syscall "swi\t" __sys1(XENO_ARM_SYSCALL) ""
>=20
> Does replacing XENO_ARM_SYSCALL with (0x00900000 + XENO_ARM_SYSCALL)
> fixes it ?
>=20
> I may be able to mount a test platform later today if this needs furthe=
r
> debugging...

I have finally managed to get my old-ABI toolchain to work and can
confirm that the modification above fixes the problem.

The whole section of include/asm-arm/syscall.h must read:

#ifdef CONFIG_XENO_ARM_EABI
#define __SYS_REG register unsigned long __r7 __asm__ ("r7") =3D XENO_ARM=
_SYSCALL;#define __SYS_REG_LIST ,"r" (__r7)
#define __syscall "swi\t0"
#else
#define __SYS_REG
#define __SYS_REG_LIST
#define __NR_OABI_SYSCALL_BASE	0x900000
#define __syscall "swi\t" __sys1(__NR_OABI_SYSCALL_BASE + XENO_ARM_SYSCAL=
L) ""
#endif

Sorry for the annoyance.

--=20
Stelian Pop <stelian@domain.hid>


