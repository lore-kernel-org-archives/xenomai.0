From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18021.58231.177931.286548@domain.hid>
Date: Wed, 6 Jun 2007 00:28:07 +0200
In-Reply-To: <46651F7D.9090702@domain.hid>
References: <46649F7E.3060104@domain.hid>
	<46651F7D.9090702@domain.hid>
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
 > Jan Kiszka wrote:
 > ...
 > > fast-tsc-to-ns-v2.patch
 > > 
 > >     [Rebased, improved rounding of least significant digit]
 > 
 > Rounding in the fast path for the sake of the last digit was silly.
 > Instead, I'm now addressing the ugly interval printing via
 > xnarch_precise_tsc_to_ns when converting the timer interval back into
 > nanos. -v3 incorporating this has just been uploaded.

Hi,

I had a look at the fast-tsc-to-ns implementation, here is how I would
rewrite it:

static inline void xnarch_init_llmulshft(const unsigned m_in,
					 const unsigned d_in,
					 unsigned *m_out,
					 unsigned *s_out)
{
	unsigned long long mult;

	*s_out = 31;
	while (1) {
		mult = ((unsigned long long)m_in) << *s_out;
		do_div(mult, d_in);
		if (mult <= INT_MAX)
			break;
		(*s_out)--;
	}
	*m_out = (unsigned)mult;
}

/* Non x86. */
#define __rthal_u96shift(h, m, l, s) ({		\
	unsigned _l = (l);			\
	unsigned _m = (m);			\
	unsigned _s = (s);			\
	_l >>= _s;				\
	_m >>= s;				\
	_l |= (_m << (32 - s));			\
	_m |= ((h) << (32 - s));		\
        __rthal_u64fromu32(_m, _l);		\
})

/* x86 */
#define __rthal_u96shift(h, m, l, s) ({		\
	unsigned _l = (l);			\
	unsigned _m = (m);			\
	unsigned _s = (s);			\
	asm ("shrdl\t%%cl,%1,%0"		\
	     : "+r,?m"(_l)			\
	     : "r,r"(_m), "c,c"(_s));		\
	asm ("shrdl\t%%cl,%1,%0"		\
	     : "+r,?m"(_m)			\
	     : "r,r"(h), "c,c"(_s));		\
	__rthal_u64fromu32(_m, _l);		\
})

static inline long long rthal_llmi(int i, int j)
{
        /* Signed fast 32x32->64 multiplication */
	return (long long) i * j;
}

static inline long long gilles_llmulshft(const long long op,
					 const unsigned m,
					 const unsigned s)
{
	unsigned oph, opl, tlh, tll, thh, thl;
	unsigned long long th, tl;

	__rthal_u64tou32(op, oph, opl);
	tl = rthal_ullmul(opl, m);
	__rthal_u64tou32(tl, tlh, tll);
	th = rthal_llmi(oph, m);
	th += tlh;
	__rthal_u64tou32(th, thh, thl);
	
	return __rthal_u96shift(thh, thl, tll, s);
}



-- 


					    Gilles Chanteperdrix.

