Resent-Message-ID: <17550.44528.674284.147085@domain.hid>
Resent-To: xenomai@xenomai.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17550.43146.445745.213316@domain.hid>
In-Reply-To: <448E98A3.6080707@domain.hid>
References: <448E98A3.6080707@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] ns vs. tsc as internal timer base
Date: Tue, 13 Jun 2006 13:59:06 +0200
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

Jan Kiszka wrote:
 > Hi,
 > 
 > between some football half-times of the last days ;), I played a bit
 > with a hand-optimised xnarch_tsc_to_ns() for x86. Using scaled math, I
 > achieved between 3 (P-I 133 MHz) to 4 times (P-M 1.3 GHz) faster
 > conversions than with the current variant. While this optimisation only
 > saves a few ten nanoseconds on high-end, slow processors can gain
 > several hundreds of nanos per conversion (my P-133: -600 ns).

Some time ago, I did also some experiment on avoiding divisions. I came
to a solution that precompute fractions using a real division, and that
only use additions, multiplication and shifts for imuldiv and ullimd. I
thought there would be no loss in accuracy, but well, sometimes the last
bit is wrong.

Anyway, here is the code if you want to benchmark it, div96by32 and
u64(to|from)u32 are defined in asm-i386/hal.h or asm-generic/hal.h:

typedef struct {
    unsigned long long frac;    /* Fractionary part. */
    unsigned long integ;        /* Integer part. */
} u32frac_t;

/* m/d == integ + frac / 2^64 */
void precalc(u32frac_t *const f,
             const unsigned long m,
             const unsigned long d)
{
    f->integ = m > d ? m / d :0;
    f->frac = div96by32(u64fromu32(m % d, 0), 0, d, NULL);
}

inline unsigned long nodiv_imuldiv(unsigned long op, u32frac_t f)
{
    const unsigned long tmp = (ullmul(op, f.frac >> 32)) >> 32;

    if(f.integ)
        return tmp + op * f.integ;

    return tmp;
}

#define add64and32(h, l, s) do {                \
    __asm__ ("addl %2, %1\n\t"                  \
             "adcl $0, %0"                      \
             : "+r"(h), "+r"(l)                 \
             : "r"(s));                         \
    } while(0)

#define add96and64(l0, l1, l2, s0, s1) do {     \
    __asm__ ("addl %4, %2\n\t"                  \
             "adcl %3, %1\n\t"                  \
             "adcl $0, %0\n\t"                  \
             : "+r"(l0), "+r"(l1), "+r"(l2)     \
             : "r"(s0), "r"(s1));               \
    } while(0)

inline unsigned long long mul64by64_high(const unsigned long long op,
                                      const unsigned long long m)
{
    /* Compute high 64 bits of multiplication 64 bits x 64 bits. */
    unsigned long long t1, t2, t3;
    u_long oph, opl, mh, ml, t0, t1h, t1l, t2h, t2l, t3h, t3l;

    u64tou32(op, oph, opl);
    u64tou32(m, mh, ml);
    t0 = ullmul(opl, ml) >> 32;
    t1 = ullmul(oph, ml); u64tou32(t1, t1h, t1l);
    add64and32(t1h, t1l, t0);
    t2 = ullmul(opl, mh); u64tou32(t2, t2h, t2l);
    t3 = ullmul(oph, mh); u64tou32(t3, t3h, t3l);
    add64and32(t3h, t3l, t2h);
    add96and64(t3h, t3l, t2l, t1h, t1l);

    return u64fromu32(t3h, t3l);
}

inline unsigned long long nodiv_ullimd(const unsigned long long op,
                                   const u32frac_t f)
{
    const unsigned long long tmp = mul64by64_high(op, f.frac);

    if(f.integ)
        return tmp + op * f.integ;

    return tmp;
}

-- 


					    Gilles Chanteperdrix.

