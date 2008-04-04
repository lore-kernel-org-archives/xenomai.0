Message-ID: <2ff1a98a0804040618r2717c5efrb852bcbc76e6bd0c@domain.hid>
Date: Fri, 4 Apr 2008 15:18:26 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47F606AE.6080800@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>
	<47F37BF8.6000401@domain.hid> <47F3AD14.4090306@domain.hid>
	<2ff1a98a0804020905v7019574ai927f213ab6603e41@domain.hid>
	<47F3B348.1090102@domain.hid> <47F4CAD1.3090002@domain.hid>
	<47F4D87F.7080204@domain.hid> <47F551AD.9030509@domain.hid>
	<47F5E57C.6020309@domain.hid> <47F606AE.6080800@domain.hid>
Subject: Re: [Xenomai-core] latencys drifting into negative (Xenomai
	2.4.2/2.4.3)
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
Cc: xenomai-core <xenomai@xenomai.org>, =?ISO-8859-1?Q?Cornelius_K=F6pp?= <Cornelius.Koepp@domain.hid>

On Fri, Apr 4, 2008 at 12:45 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Sebastian Smolorz wrote:
>
> > Jan Kiszka wrote:
> >
> > > Sebastian Smolorz wrote:
> > >
> > > > Jan Kiszka wrote:
> > > >
> > > > > This patch may do the trick: it uses the inverted tsc-to-ns function
> instead of the frequency-based one. Be warned, it is totally untested inside
> Xenomai, I just ran it in a user space test program. But it may give an
> idea.
> > > > >
> > > >
> > > > Your patch needed two minor corrections (ns instead of ts in functions
> xnarch_ns_to_tsc()) in order to compile. A short run (30 minutes) of latency
> -t1 seems to prove your bug-fix: There seems to be no drift.
> > > >
> > >
> > > That's good to hear.
> > >
> > >
> > > > If I got your patch correctly, it doesn't make xnarch_tsc_to_ns more
> precise but introduces a new function xnarch_ns_to_tsc() which is also less
> precise than the generic xnarch_ns_to_tsc(), right?
> > > >
> > >
> > > Yes. It is now precisely the inverse imprecision, so to say. :)
> > >
> > >
> > > > So isn't there still the danger of getting wrong values when calling
> xnarch_tsc_to_ns()  not in combination with xnarch_ns_to_tsc()?
> > > >
> > >
> > > Only if the user decides to implement his own conversion. Xenomai with
> all its skins and both in kernel and user space should always run through
> the xnarch_* path.
> > >
> >
> > OK, would you commit the patch?
> >
>
>  Will do unless someone else has concerns. Gilles, Philippe? ARM and
> Blackfin then need to be fixed similarly, full patch attached.

Well, I am sorry, but I do not like this solution;
- the aim of scaled math is to avoid divisions, and with this patch we
end up using divisions;
- with scaled math we do wrong calculations, and making a wrong
xnarch_ns_to_tsc only works for values which should be passed to
xnarch_tsc_to_ns.

So, I would like to propose again my solution, which is exact, but use
no division. Its drawback is that it makes a few more additions and
multiplications than rthal_llimd, but has no division. If it happens
to be slower than llimd on some platforms (maybe x86 ?), I would use
llimd. After all, if the division is fast, we may be wrong to try and
avoid it.

For the records, here is the code:
typedef struct {
    unsigned long long frac;    /* Fractionary part. */
    unsigned long integ;        /* Integer part. */
} u32frac_t;

/* m/d == integ + frac / 2^64 */

static inline void precalc(u32frac_t *const f,
                           const unsigned long m,
                           const unsigned long d)
{
    f->integ = m / d;
    f->frac = div96by32(u32tou64(m % d, 0), 0, d, NULL);
}

unsigned long fast_imuldiv(unsigned long op, u32frac_t f)
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

static inline __attribute_const__ unsigned long long
mul64by64_high(const unsigned long long op, const unsigned long long m)
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

static inline __attribute_const__ unsigned long long
fast_llimd(const unsigned long long op, const u32frac_t f)
{
    const unsigned long long tmp = mul64by64_high(op, f.frac);

    if(f.integ)
        return tmp + op * f.integ;

    return tmp;
}


-- 
 Gilles

