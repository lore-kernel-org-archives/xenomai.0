Message-ID: <2ff1a98a0708160122p5240b432m2952ec6ae414a42b@domain.hid>
Date: Thu, 16 Aug 2007 10:22:41 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <46C40706.5060804@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <46C3FFD8.7010105@domain.hid>
	<18116.537.895227.330587@domain.hid>
	<46C40706.5060804@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] fls() not available in Linux 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 8/16/07, Wolfgang Grandegger <wg@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
> > Wolfgang Grandegger wrote:
> >  > Hello,
> >  >
> >  > the attached patch fixes the following compilation error with Xenomai's
> >  > head of trunk under Linux 2.4:
> >  >
> >  > kernel/kernel.o(.text+0x135a4): In function `__rthal_generic_full_divmod64':
> >  > /temp/rtcan/devel/linuxppc_2_4_devel-xenomai/kernel/xenomai/arch/generic/hal.c:918:
> >  > undefined reference to `fls'
> >  > kernel/kernel.o(.text+0x135b4):/temp/rtcan/devel/linuxppc_2_4_devel-xenomai/kernel/xenomai/arch/generic/hal.c:918:
> >  > undefined reference to `fls'
> >
> > Should not this implementation go to asm-powerpc/wrappers.h instead of
> > asm-generic/wrappers.h ?
>
> Ah, yes, of course, because it uses PowerPC assembler. But it might be
> missing for other archs as well, e.g. I did not find it for i386 in the
> DENX Linux 2.4.25 tree.

We will add it to asm-i386/wrappers.h as well then.

-- 
                                               Gilles Chanteperdrix

