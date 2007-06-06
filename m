Message-ID: <4666ACE5.7030200@domain.hid>
Date: Wed, 06 Jun 2007 14:47:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <46649F7E.3060104@domain.hid>	<46651F7D.9090702@domain.hid>
	<18021.58231.177931.286548@domain.hid>
	<46668CC3.8050002@domain.hid>
In-Reply-To: <46668CC3.8050002@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH-STACK] Updates, timerstats, rtdm-timers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> 
>>Jan Kiszka wrote:
>> > Jan Kiszka wrote:
>> > ...
>> > > fast-tsc-to-ns-v2.patch
>> > > 
>> > >     [Rebased, improved rounding of least significant digit]
>> > 
>> > Rounding in the fast path for the sake of the last digit was silly.
>> > Instead, I'm now addressing the ugly interval printing via
>> > xnarch_precise_tsc_to_ns when converting the timer interval back into
>> > nanos. -v3 incorporating this has just been uploaded.
>>
>>Hi,
>>
>>I had a look at the fast-tsc-to-ns implementation, here is how I would
>>rewrite it:
>>
>>static inline void xnarch_init_llmulshft(const unsigned m_in,
>>					 const unsigned d_in,
>>					 unsigned *m_out,
>>					 unsigned *s_out)
>>{
>>	unsigned long long mult;
>>
>>	*s_out = 31;
>>	while (1) {
>>		mult = ((unsigned long long)m_in) << *s_out;
>>		do_div(mult, d_in);
>>		if (mult <= INT_MAX)
>>			break;
>>		(*s_out)--;
>>	}
>>	*m_out = (unsigned)mult;
>>}
>>
>>/* Non x86. */
>>#define __rthal_u96shift(h, m, l, s) ({		\
>>	unsigned _l = (l);			\
>>	unsigned _m = (m);			\
>>	unsigned _s = (s);			\
>>	_l >>= _s;				\
>>	_m >>= s;				\
>>	_l |= (_m << (32 - s));			\
>>	_m |= ((h) << (32 - s));		\
>>        __rthal_u64fromu32(_m, _l);		\
>>})
>>
>>/* x86 */
>>#define __rthal_u96shift(h, m, l, s) ({		\
>>	unsigned _l = (l);			\
>>	unsigned _m = (m);			\
>>	unsigned _s = (s);			\
>>	asm ("shrdl\t%%cl,%1,%0"		\
>>	     : "+r,?m"(_l)			\
>>	     : "r,r"(_m), "c,c"(_s));		\
>>	asm ("shrdl\t%%cl,%1,%0"		\
>>	     : "+r,?m"(_m)			\
>>	     : "r,r"(h), "c,c"(_s));		\
>>	__rthal_u64fromu32(_m, _l);		\
>>})
>>
>>static inline long long rthal_llmi(int i, int j)
>>{
>>        /* Signed fast 32x32->64 multiplication */
>>	return (long long) i * j;
>>}
>>
>>static inline long long gilles_llmulshft(const long long op,
>>					 const unsigned m,
>>					 const unsigned s)
>>{
>>	unsigned oph, opl, tlh, tll, thh, thl;
>>	unsigned long long th, tl;
>>
>>	__rthal_u64tou32(op, oph, opl);
>>	tl = rthal_ullmul(opl, m);
>>	__rthal_u64tou32(tl, tlh, tll);
>>	th = rthal_llmi(oph, m);
>>	th += tlh;
>>	__rthal_u64tou32(th, thh, thl);
>>	
>>	return __rthal_u96shift(thh, thl, tll, s);
>>}
>>
>>
> 
> 
> Thanks for your suggestion.
> 
> While your generic version produces comparable code, the x86 variant is
> about twice as large as the full-assembly version. And code size
> translates into I-cache occupation, which may have latency costs.
> 
> [gcc 4.1, i386]
> -O2 -mregparm=3 -fomit-frame-pointer:
>     63: 08048490   119 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft
>     68: 08048510   121 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft_x86
>     77: 08048450    57 FUNC    GLOBAL DEFAULT   13 rthal_llmulshft
>     78: 080483c0   135 FUNC    GLOBAL DEFAULT   13 __rthal_generic_llmulshft
> 
> -Os -mregparm=3 -fomit-frame-pointer:
>     63: 0804843b    93 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft
>     68: 08048498    97 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft_x86
>     77: 08048410    43 FUNC    GLOBAL DEFAULT   13 rthal_llmulshft
>     78: 080483b4    92 FUNC    GLOBAL DEFAULT   13 __rthal_generic_llmulshft
> 
> -O2:
>     63: 08048480   120 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft
>     68: 08048500   105 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft_x86
>     77: 08048440    60 FUNC    GLOBAL DEFAULT   13 rthal_llmulshft
>     78: 080483c0   117 FUNC    GLOBAL DEFAULT   13 __rthal_generic_llmulshft
> 
> -Os:
>     63: 08048438   104 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft
>     68: 080484a0    83 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft_x86
>     77: 0804840b    45 FUNC    GLOBAL DEFAULT   13 rthal_llmulshft
>     78: 080483b4    87 FUNC    GLOBAL DEFAULT   13 __rthal_generic_llmulshft
> 
> I'm not arguing we should turn each and every Xenomai arch code into
> pure assembly. But in this case it already happened, it's less scattered
> source code-wise, and it is compacter object-wise. So I would prefer to
> keep it as is.

I would say the advantage of having a C version outperform the
advantages of the full assembly version. C is really easier to
understand and debug.

The differences between the two versions are some register moves, which
cost almost nothing, especially since each operation in the assembly
version depends on the result of the previous operation, which means
lots of pipeline stall, the register moves will just feed the pipeline.
I do not think they really matter. Look at the assembly produced for
gilles_llmulshft on ARM, a low end architecture where each instruction
really costs:
gilles_llmulshft:
        @ args = 0, pretend = 0, frame = 0
        @ frame_needed = 0, uses_anonymous_args = 0
        @ link register save eliminated.
        stmfd   sp!, {r4, r5, r6, r7}
        umull   r6, r7, r0, r2
        mov     r4, r7
        mov     r5, #0
        smlal   r4, r5, r2, r1
        rsb     ip, r3, #32
        mov     r2, r4, lsr r3
        orr     r1, r2, r5, asl ip
        mov     r2, r2, asl ip
        orr     r0, r2, r6, lsr r3
        @ lr needed for prologue
        ldmfd   sp!, {r4, r5, r6, r7}
        mov     pc, lr

pretty minimal, no ?

The full assembly version has another big drawback, it is a big block
that the optimizer can not split, whereas in a C version, the optimizer
can decide to interleave the surrounding code. So a C version will
inline better.

There is one thing I do not like with llmulshft (any implementation), it
is the rounding policy towards minus infinity. llmulshft(-1, 2/3)
returns -1 whereas llimd would return 0.

-- 
                                                 Gilles Chanteperdrix

