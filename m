Message-ID: <2ff1a98a0804040632w391afda4rf30c8ca09fbb0874@domain.hid>
Date: Fri, 4 Apr 2008 15:32:32 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47F62C46.4080003@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>
	<2ff1a98a0804020905v7019574ai927f213ab6603e41@domain.hid>
	<47F3B348.1090102@domain.hid> <47F4CAD1.3090002@domain.hid>
	<47F4D87F.7080204@domain.hid> <47F551AD.9030509@domain.hid>
	<47F5E57C.6020309@domain.hid> <47F606AE.6080800@domain.hid>
	<2ff1a98a0804040618r2717c5efrb852bcbc76e6bd0c@domain.hid>
	<47F62C46.4080003@domain.hid>
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

On Fri, Apr 4, 2008 at 3:25 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
>
> > On Fri, Apr 4, 2008 at 12:45 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >
> > > Sebastian Smolorz wrote:
> > >
> > >
> > > > Jan Kiszka wrote:
> > > >
> > > >
> > > > > Sebastian Smolorz wrote:
> > > > >
> > > > >
> > > > > > Jan Kiszka wrote:
> > > > > >
> > > > > >
> > > > > > > This patch may do the trick: it uses the inverted tsc-to-ns
> function
> > > > > > >
> > > > > >
> > > > >
> > > >
> > > instead of the frequency-based one. Be warned, it is totally untested
> inside
> > > Xenomai, I just ran it in a user space test program. But it may give an
> > > idea.
> > >
> > > >
> > > > >
> > > > > > Your patch needed two minor corrections (ns instead of ts in
> functions
> > > > > >
> > > > >
> > > >
> > > xnarch_ns_to_tsc()) in order to compile. A short run (30 minutes) of
> latency
> > > -t1 seems to prove your bug-fix: There seems to be no drift.
> > >
> > > >
> > > > > That's good to hear.
> > > > >
> > > > >
> > > > >
> > > > > > If I got your patch correctly, it doesn't make xnarch_tsc_to_ns
> more
> > > > > >
> > > > >
> > > >
> > > precise but introduces a new function xnarch_ns_to_tsc() which is also
> less
> > > precise than the generic xnarch_ns_to_tsc(), right?
> > >
> > > >
> > > > > Yes. It is now precisely the inverse imprecision, so to say. :)
> > > > >
> > > > >
> > > > >
> > > > > > So isn't there still the danger of getting wrong values when
> calling
> > > > > >
> > > > >
> > > >
> > > xnarch_tsc_to_ns()  not in combination with xnarch_ns_to_tsc()?
> > >
> > > >
> > > > > Only if the user decides to implement his own conversion. Xenomai
> with
> > > > >
> > > >
> > > all its skins and both in kernel and user space should always run
> through
> > > the xnarch_* path.
> > >
> > > > OK, would you commit the patch?
> > > >
> > > >
> > >  Will do unless someone else has concerns. Gilles, Philippe? ARM and
> > > Blackfin then need to be fixed similarly, full patch attached.
> > >
> >
> > Well, I am sorry, but I do not like this solution;
> > - the aim of scaled math is to avoid divisions, and with this patch we
> > end up using divisions;
> >
>
>  Please check again, no new division due to my patch, just different
> parameters for the existing one.

I just checked your patch rapidly, but saw that xnarch_ns_to_tsc was
using llimd, so does use division. My fast_llimd could be used to
replace both the llimd calls in xnarch_tsc_to_ns and xnarch_ns_to_tsc.

>
>
>
> > - with scaled math we do wrong calculations, and making a wrong
> > xnarch_ns_to_tsc only works for values which should be passed to
> > xnarch_tsc_to_ns.
> >
>
>  IMHO, the error is within the range of the clock's precision, if not even
> below. So struggling for mathematically precise conversion of imprecise
> physical values makes no sense to me. Therefore I once proposed the
> scaled-math optimization.

Now that I have understood what really happens, I disagree with this
approach. Take the implementation of clock_gettime (or
rtdm_clock_read, for that matter). They basically do
xnarch_tsc_to_ns(ipipe_read_tsc()). The relative error may be small,
but in the very frequent use case of substracting two results of
consecutive reads of ipipe_read_tsc, the result of the substraction is
essentially garbage, because the result of the substraction may be of
the same order as the absolute error of the conversion. And I insist,
this use case of clock_gettime or rtdm_clock_read is a very realistic
use case.

-- 
 Gilles

