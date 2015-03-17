Date: Tue, 17 Mar 2015 21:02:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150317200238.GG16113@hermes.click-hack.org>
References: <CAEMXjGwam0jjOrUBgBY_FyFOaT15qHdobMo96G3bEsWx6rEcpA@mail.gmail.com>
 <20150317180654.GB16113@hermes.click-hack.org>
 <CAEMXjGxSMGQFfBvUG3VdepA_cRHb=6n1V_pO3QzXtofY2bUuMA@mail.gmail.com>
 <20150317192431.GY25508@csclub.uwaterloo.ca>
 <CAEMXjGx6R0HtdJwU5_5AoDN=KV1T9nn5ug-ZwctJzd9B43NYSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEMXjGx6R0HtdJwU5_5AoDN=KV1T9nn5ug-ZwctJzd9B43NYSw@mail.gmail.com>
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
To: Steve B <sbattazzo@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Tue, Mar 17, 2015 at 12:57:43PM -0700, Steve B wrote:
> On Tue, Mar 17, 2015 at 12:24 PM, Lennart Sorensen <
> lsorense@csclub.uwaterloo.ca> wrote:
> 
> > On Tue, Mar 17, 2015 at 11:33:58AM -0700, Steve B wrote:
> > > Thanks! This actually doesn't work at compile time for some reason. The
> > ld
> > > step complains that the output binary uses VFP register arguments while
> > my
> > > main.o file does not... does anybody have any hints on this?
> > >
> > > If I do mfloat-abi=hard I can compile and run but my math operation still
> > > takes too long, which is counter-intuitive to me...
> >
> > Your entire system (all libs you use, etc) and your program all have to
> > be compiled with the same ABI.  So either you use gnueabi or gnueabihf.
> > You don't get to mix and match.
> >
> > So if you use debian or ubuntu armhf, then your system is gnueabihf,
> > and if you use armel, then your system is gnueabi (which uses softfloat
> > for argument passing).
> >
> > Of course if you use a multiarch system you could have libs built and
> > installed for both methods at the same time and each program would load
> > the libraries that matched its ABI.  That's probably too complicated to
> > deal with in general though.
> >
> > But if your libc and such are built with gnueabi, then you can not build
> > a single program with gnueabihf unless it requires no libraries from
> > the system at all (so a staticly linked binary could still run as long
> > as the kernel is built to run both ABIs).
> >
> > ARM has unfortunately gone through a number of ABIs over the years that
> > are not entirely compatible (especially when it comes to floating point
> > where they are pretty much entirely incompatible).
> >
> > --
> > Len Sorensen
> >
> 
> Thanks guys,
> Originally some other engineers on my project specified that we use
> Angstrom Linux which seems to only work with gnueabi.
> I noticed that the pow() function was causing problems so I looked at the
> disassembly of the libm.so with that toolchain and it looks suspiciously
> like soft floating point routines.
> 
> So I'm trying to run my simple test program on a Debian distribution which
> is built with gnueabihf. Seems like the issue is that if I use the
> -mhard-float option, I can't run with Xenomai, even if I built the Xenomai
> libraries with -mhard-float enabled.
> If I don't add in -mhard-float when I compile the program, the pow()
> function still takes much too long... if I enable -mhard-float and take
> away the Xenomai libs, then the pow() function executes in a reasonable
> amount of time.
> I guess there still may be something wrong in making sure everything is
> built the same.
> 
> Hopefully that makes more sense?

With a hard float toolchain, you normally do not need to pass
-mhard-float, it should always generate hard float code. Are you
sure you do not have some other flags on the compiler command line?

FWIW, xenomai has been tested for years on omap3, omap4, and now
at91sama5d3 with hard float toolchains.

-- 
					    Gilles.

