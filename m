Date: Thu, 19 Mar 2015 17:04:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150319160403.GC787@hermes.click-hack.org>
References: <CAEMXjGwam0jjOrUBgBY_FyFOaT15qHdobMo96G3bEsWx6rEcpA@mail.gmail.com>
 <20150317180654.GB16113@hermes.click-hack.org>
 <CAEMXjGxSMGQFfBvUG3VdepA_cRHb=6n1V_pO3QzXtofY2bUuMA@mail.gmail.com>
 <20150317192431.GY25508@csclub.uwaterloo.ca>
 <CAEMXjGx6R0HtdJwU5_5AoDN=KV1T9nn5ug-ZwctJzd9B43NYSw@mail.gmail.com>
 <20150317213457.GZ25508@csclub.uwaterloo.ca>
 <CAEMXjGy3J+aFoCNdvugUKDOunzqk=sE3aSybHuL-_xK6qiea7w@mail.gmail.com>
 <20150319140703.GC25508@csclub.uwaterloo.ca>
 <20150319144041.GB787@hermes.click-hack.org>
 <20150319155939.GD25508@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150319155939.GD25508@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Building with hard float: cannot open shared object
 file libpthread_rt.so.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Mar 19, 2015 at 11:59:39AM -0400, Lennart Sorensen wrote:
> On Thu, Mar 19, 2015 at 03:40:41PM +0100, Gilles Chanteperdrix wrote:
> > I have used cortex a8 to do some moderate calculations, but only
> > operating on 2Mpixel images got me near the millisecond. Doing
> > things like polynomial fit was taking microseconds.
> > 
> > How is pow implemented anyway, exp(a * ln(b)) or is there a smarter
> > solution ? Is b an integer in your case ? What are the values of a
> > and b ?
> 
> Well from what I have read, the VFP FPU on the Cortex-A8 is 1/10 the
> speed of the VFP FPU in the Cortex-A9 and newer.  So very very slow.
> 
> Looking at glibc-2.19 in ./sysdeps/ieee754/dbl-64/e_pow.c the
> implementation involves a lot of floating point calculations.  It's 130
> lines long, and I am not having much luck understanding it.  It certainly
> has lots of checking that values aren't too small or too big and would
> cause under or over flow, and various other checks.  It calls log1, and
> exp and various other functions which may themselves be pretty big too.
> So on a slow FPU like a Cortex-A8, it looks like pow() could be very slow.

My point was, there may be some pathological values that may involve
using expm1 or logp1 instead of log or exp, and so to avoid pow
entirely. Also, I am not sure pow optimizes the case where b is an
integer. It would be interesting to know the actual values of a and
b which cause pow to explode.

-- 
					    Gilles.

