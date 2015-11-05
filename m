From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 5 Nov 2015 12:24:52 -0500
Message-ID: <20151105172452.GQ21923@csclub.uwaterloo.ca>
References: <20151105145159.GK21923@csclub.uwaterloo.ca>
 <20151105145725.GL21923@csclub.uwaterloo.ca>
 <20151105150226.GM21923@csclub.uwaterloo.ca>
 <20151105151544.GD16314@hermes.click-hack.org>
 <20151105152427.GN21923@csclub.uwaterloo.ca>
 <20151105155549.GE16314@hermes.click-hack.org>
 <20151105161902.GO21923@csclub.uwaterloo.ca>
 <20151105162514.GF16314@hermes.click-hack.org>
 <20151105165750.GP21923@csclub.uwaterloo.ca>
 <20151105171419.GG16314@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151105171419.GG16314@hermes.click-hack.org>
Subject: Re: [Xenomai] ARM bus error due to alignment
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Nov 05, 2015 at 06:14:19PM +0100, Gilles Chanteperdrix wrote:
> On Thu, Nov 05, 2015 at 11:57:50AM -0500, Lennart Sorensen wrote:
> > On Thu, Nov 05, 2015 at 05:25:14PM +0100, Gilles Chanteperdrix wrote:
> > > I am sure. Xenomai does not use H_DMA on armv7, so, it is not used
> > > if your code, it is not used at all.
> > 
> > Well we are using it for one allocation for talking to a network port.
> > 
> > If I remove it, I get a NULL pointer dereference, so it clearly matters
> > to something in our code.
> > 
> > > > It does appear that when LPAE is enabled H_DMA does do something on arm,
> > > > but only when LPAE is enabled since that enables ZONE_DMA.
> > > 
> > > I never said that H_DMA did nothing.
> > 
> > OK I misunderstood then.
> > 
> > Setting /proc/cpu/alignment to 0 gives the kernel message:
> > alignment: ignoring faults is unsafe on this CPU.  Defaulting to fixup mode.
> > 
> > Apparently armv6+ with CR_U set is not allowed to turn off fixups.
> 
> If you have an armv7, you want to turn off all armv6 processors in
> the kernel configuration so that the kernel does not try to be
> compatible with these obsolete processors.

I thought I had.  Maybe not quite:

# CONFIG_ARCH_MULTI_V6 is not set
CONFIG_ARCH_MULTI_V7=y
CONFIG_ARCH_MULTI_V6_V7=y

I wonder if I can turn off CONFIG_ARCH_MULTI_V6_V7 somehow, not that I
see anything in the kernel code that would change beecause of it.
Of course LPAE being on pretty much also excludes ARMv6 support.

Certainly as far as I can tell, on any armv6+ with CR_U set (which all
armv7 have hardwired), CR_A appears to always be cleared by the kernel, so I don't think it is causing the issue.

I think our problem is that we have allocated some memory that isn't
considered normal and hence isn't allowed unaligned accesses and with
gcc-4.6 that wasn't a problem, but with 4.9 it is (since it now does
generate unaligned accesses by default)

I just have to figure out why there was any reason to allocate 'weird'
memory.  I can't figure out why that would have been neccesary, but I
didn't write that code.  I am just trying to fix it.

-- 
Len Sorensen

