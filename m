Date: Fri, 2 Oct 2015 13:55:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151002115500.GP31137@hermes.click-hack.org>
References: <5604517A.2000602@mperpetuo.com>
 <20150925150248.GE1332@hermes.click-hack.org>
 <560580E6.6070208@mperpetuo.com>
 <20150925180137.GF1332@hermes.click-hack.org>
 <20150926112419.GH1332@hermes.click-hack.org>
 <CAPuu0=hEDw3g4pkJfWsAy-LkgwL=SrGyb1xPuU7a3-5LKYuHZg@mail.gmail.com>
 <20150929141439.GS15616@csclub.uwaterloo.ca>
 <20150929204945.GD18188@hermes.click-hack.org>
 <560DC717.9050902@mperpetuo.com>
 <20151002100142.GN31137@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151002100142.GN31137@hermes.click-hack.org>
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Oct 02, 2015 at 12:01:42PM +0200, Gilles Chanteperdrix wrote:
> On Thu, Oct 01, 2015 at 04:51:51PM -0700, Dmitriy Cherkasov wrote:
> > The following changes since commit 17095784c6d3d44dc7f1512ffab9bb957e298466:
> > 
> >    cobalt/arm64: leave mm tracking to the pipeline (2015-09-17 15:08:34 
> > +0200)
> > 
> > are available in the git repository at:
> > 
> >    http://gitlab.mperpetuo.com/it/xenomai-3.git arm64-fp
> 
> Ok, I retrieved your code, some comments inlined:
> 
> > /*
> > static void enable_fpsimd(void) {
> > 	__asm__ __volatile__("mrs x1, cpacr_el1\n\
> > 			orr x1, x1, #(0x3 << 20)\n\
> > 			msr cpacr_el1, x1\n\
> > 			isb" : : : "x1", "memory", "cc");
> > }
> 
> > static void disable_fpsimd(void) {
> > 	__asm__ __volatile__("mrs x1, cpacr_el1\n\
> > 				and x1, x1, #~(0x3 << 20)\n\
> > 				msr cpacr_el1, x1\n\
> > 				isb" : : : "x1", "memory", "cc");
> > }
> 
> Coding style: braces at the beginning of line, and you probably want to
> make these functions inline.

Also, hardcoding a register may not be a good idea. Especially x1,
since if I understand correctly, it is used as function argument, so
by using x1, you may be forcing the compiler to do some useless
register saves and load. And also, the only instructions which
requires inline assembley are msr, mrs, and isb.

So, I would do something like:

static inline long get_cpacr(void)
{
	long result;
	__asm__ ("mrs %0, cpacr_el1": "=r"(result) : /* */ : "memory", "cc");
	return result;
}

static inline set_cpacr(long val)
{
	__asm__ __volatile__ (
		"msr cpacr_el1, %0\n\"
		"isb" : /* */ : "r"(val) : "memory", "cc");
}

then define enable_fpsimd/disable_fpsimd in plain C, using these
building blocks. Also, I do not see why these instructions require
clobbering memory and cc, but here you know better than I do.

-- 
					    Gilles.
https://click-hack.org

