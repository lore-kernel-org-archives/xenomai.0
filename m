Message-ID: <2ff1a98a0801160930w3b63bc5dyd89f8ec867a3ae35@domain.hid>
Date: Wed, 16 Jan 2008 18:30:37 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0801160635n2040f566mb1bdd464aaa017e4@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47891672.4050409@domain.hid>
	<2ff1a98a0801140752y5e6e47e2tb9980bfb344522a4@domain.hid>
	<478CAB5F.70208@domain.hid>
	<2ff1a98a0801150509w2dae4826r4696cd95c21aecb3@domain.hid>
	<478CBD27.4020501@domain.hid>
	<2ff1a98a0801150610n4404224bl98be4fcbccba70b7@domain.hid>
	<478DD90B.6020302@domain.hid>
	<2ff1a98a0801160249t7e4c1989i5ebde8e6b69d52e7@domain.hid>
	<478E1270.1000409@domain.hid>
	<2ff1a98a0801160635n2040f566mb1bdd464aaa017e4@domain.hid>
Subject: Re: [Xenomai-help] Xenomai problems on pxa
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bernhard Michael <michael.bernhard@domain.hid>
Cc: xenomai@xenomai.org

On Jan 16, 2008 3:35 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Jan 16, 2008 3:19 PM, Bernhard Michael <michael.bernhard@domain.hid> wrote:
> > Gilles Chanteperdrix wrote:
> > > I do not know how to solve this. From my point of view, this is a
> > > compiler bug: knowing that it uses instructions which needs 8 bytes
> > > alignment, the compiler should align stack frames on 8 bytes
> > > boundaries, period.
> >
> > Digging a bit in the mailing lists about stack alignment and EABI I find
> > that gcc *realy* should handle proper stack alignment.
> >
> > See http://gcc.gnu.org/ml/gcc/2006-07/msg00030.html
> > or http://www.codesourcery.com/archives/arm-gnu/msg01467.html
> >
> > Now, looking at the assembly code for the SWI handler, I see that ipipe
> > introduces flowing code:
>
> Of course. I found that suspicious that the kernel code could rely on
> suboptimal trap handlers to work correctly, and was about to tell you
> to run Linux without Xenomai to see if the unaligned fault counters
> incremented in /proc/cpu/alignment
>
> >
> >         #ifdef CONFIG_IPIPE
> >                 stmfd   sp!, {r0-r3, ip}
> >                 add     r1, sp, #S_OFF
>
> You could try adding:
>                    add     sp, sp, #4
> here
> >                 add     r1, r1, #20
> >                 mov     r0, scno
> >                 bl      __ipipe_syscall_root
> >                 cmp     r0, #0
> and:
>                    sub     sp, sp, #4
> here
>
> >                 ldmfd   sp!, {r0-r3, ip}
> >                 blt     __ipipe_ret_fast_syscall
> >                 bgt     __ipipe_fast_exit_syscall
> >         #endif /* CONFIG_IPIPE */

Stack goes down, so this should be the other way around, substract 4
from sp before, and add 4 to sp after.

I tested it on another arm (without EABI, so I can not know if it
works), and there is at least no regression.

-- 
                                               Gilles Chanteperdrix

