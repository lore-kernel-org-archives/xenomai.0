Date: Thu, 19 Mar 2015 15:40:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150319144041.GB787@hermes.click-hack.org>
References: <CAEMXjGwam0jjOrUBgBY_FyFOaT15qHdobMo96G3bEsWx6rEcpA@mail.gmail.com>
 <20150317180654.GB16113@hermes.click-hack.org>
 <CAEMXjGxSMGQFfBvUG3VdepA_cRHb=6n1V_pO3QzXtofY2bUuMA@mail.gmail.com>
 <20150317192431.GY25508@csclub.uwaterloo.ca>
 <CAEMXjGx6R0HtdJwU5_5AoDN=KV1T9nn5ug-ZwctJzd9B43NYSw@mail.gmail.com>
 <20150317213457.GZ25508@csclub.uwaterloo.ca>
 <CAEMXjGy3J+aFoCNdvugUKDOunzqk=sE3aSybHuL-_xK6qiea7w@mail.gmail.com>
 <20150319140703.GC25508@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150319140703.GC25508@csclub.uwaterloo.ca>
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

On Thu, Mar 19, 2015 at 10:07:03AM -0400, Lennart Sorensen wrote:
> On Wed, Mar 18, 2015 at 05:42:02PM -0700, Steve B wrote:
> > Hello again, all.
> > It turns out that when I ran without Xenomai and with the -mhard-float
> > option enabled, the pow() function was only returning one of the original
> > arguments as a result, and thus wasn't working properly!
> > 
> > Without the -mhard-float option in my compile, it seems that the gnueabihf
> > case actually has worse timing than the regular gnueabi, which is kind of
> > puzzling. This is definitely not a Xenomai issue though so I will check
> > with some other software folks on site and see if they have any thoughts.
> 
> Well it is possible the FPU is so bad at that function, that the software
> implementation using intergers only can be faster.
> 
> Which CPU are you running this on?  I remember the Cortex-A8 is known for
> having a horribly slow FPU (neon code generally runs quite a bit faster,
> which isn't true of later Cortex-A designs, where the FPU is usually
> faster than neon or at least equal).

I have used cortex a8 to do some moderate calculations, but only
operating on 2Mpixel images got me near the millisecond. Doing
things like polynomial fit was taking microseconds.

How is pow implemented anyway, exp(a * ln(b)) or is there a smarter
solution ? Is b an integer in your case ? What are the values of a
and b ?

-- 
					    Gilles.

