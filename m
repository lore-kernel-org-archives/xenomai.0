Resent-Message-ID: <20150317192735.GF16113@hermes.click-hack.org>
Resent-To: xenomai@xenomai.org
Date: Tue, 17 Mar 2015 20:18:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150317191841.GE16113@hermes.click-hack.org>
References: <CAEMXjGwam0jjOrUBgBY_FyFOaT15qHdobMo96G3bEsWx6rEcpA@mail.gmail.com>
 <20150317180654.GB16113@hermes.click-hack.org>
 <CAEMXjGxSMGQFfBvUG3VdepA_cRHb=6n1V_pO3QzXtofY2bUuMA@mail.gmail.com>
 <20150317183828.GD16113@hermes.click-hack.org>
 <CAEMXjGzZn3JWCsxAkC+dFL0tLWk_FZpsNzB=YkSHYzCS2QEKmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEMXjGzZn3JWCsxAkC+dFL0tLWk_FZpsNzB=YkSHYzCS2QEKmA@mail.gmail.com>
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

On Tue, Mar 17, 2015 at 12:13:07PM -0700, Steve B wrote:
> On Tue, Mar 17, 2015 at 11:38 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
> > On Tue, Mar 17, 2015 at 11:33:58AM -0700, Steve B wrote:
> > > On Tue, Mar 17, 2015 at 11:06 AM, Gilles Chanteperdrix <
> > > gilles.chanteperdrix@xenomai.org> wrote:
> > >
> > > > On Tue, Mar 17, 2015 at 09:19:29AM -0700, Steve B wrote:
> > > > > Hello all,
> > > > >
> > > > > It has come to my attention that when compiling with
> > > > arm-linux-gnueabi-gcc
> > > > > my application is using a libm that seems to be doing soft floating
> > point
> > > > > routines when I really want to be using hard float.
> > > > > I built a simple test application for now that does just one math
> > > > operation
> > > > > and measures the amount of time taken.
> > > > >
> > > > > Switching my compiler to arm-linux-gnueabihf and adding the
> > -mhard-float
> > > > > flag, I get this error immediately at runtime:
> > > > > error while loading shared libraries: libpthread_rt.so.1: cannot open
> > > > > shared object file: No such file or directory
> > > > >
> > > > > If I take away the -mhard-float flag, the program runs but the one
> > math
> > > > > operation (with a corner case argument that I found to take a long
> > time
> > > > to
> > > > > compute) takes about 3000 microseconds to run.
> > > > > If I put the -mhard-float flag back in and take away Xenomai and run
> > as a
> > > > > regular Linux application, the same operation takes around 60
> > > > microseconds.
> > > > >
> > > > > I also tried building the Xenomai on my target system with the
> > > > > arm-linux-gnueabihf compiler and the -mhard-float flag at configure
> > time,
> > > > > but this didn't fix the problem.
> > > > > Has anybody run across this before?
> > > >
> > > > The problem is probably that the libc/libm you are using is not
> > > > using hard floats, the loader will refuse to load a program using
> > > > hard floats with a soft float library. An intermediate solution may
> > > > be to use hardware floating point with soft float ABI, by passing
> > > > -mfloat-abi=softfp to gcc.
> > > >
> > > > You do not really get to choose the floating points you can use with
> > > > a given toolchain, the possibilities are fixed when the toolchain is
> > > > compiled.
> > > >
> > > > --
> > > >                                             Gilles.
> > > >
> > >
> > > Thanks! This actually doesn't work at compile time for some reason. The
> > ld
> > > step complains that the output binary uses VFP register arguments while
> > my
> > > main.o file does not... does anybody have any hints on this?
> > >
> > > If I do mfloat-abi=hard I can compile and run but my math operation still
> > > takes too long, which is counter-intuitive to me...
> >
> > As I said, you do not really get to choose any option with a given
> > toolchain. A toolchain, and the libraries it contains support only one
> > floating point type (or two, if it is using soft floating point
> > ABI), not the three possibilities.
> >
> > What is the operation that takes long ?
> >
> > --
> >                                             Gilles.
> >
> 
> It's a pow() function. I found in my actual application there are some
> times when it takes several hundred microseconds, so I captured some of the
> arguments causing it to take so long and built a quick test program to just
> call it once with those arguments.
> I will keep at it, I'm sure there must be a solution somewhere...

Sorry to insist, but, to change the type of floating points, you
need to change toolchain.

There are three ways for floating points:
1- soft floating point
2- hard floating point with soft ABI (float function arguments passed
in integer registers)
3- hard floating point with hard ABI.

The compiler can generally generate the three types, but the
libraries (libc, libm) shipped with a compiler are of one type.
Generally, binaries of one type can not be linked with those of
another type, except for types 1 and 2.

Now, what I did not get yet is: what type are your libraries ? Is
this the soft float pow or the hard float that is slow ?

-- 
					    Gilles.

