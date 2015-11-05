From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 5 Nov 2015 10:02:26 -0500
Message-ID: <20151105150226.GM21923@csclub.uwaterloo.ca>
References: <20151105015114.GJ21923@csclub.uwaterloo.ca>
 <20151105110141.GC16314@hermes.click-hack.org>
 <20151105145159.GK21923@csclub.uwaterloo.ca>
 <20151105145725.GL21923@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151105145725.GL21923@csclub.uwaterloo.ca>
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

On Thu, Nov 05, 2015 at 09:57:25AM -0500, Lennart Sorensen wrote:
> On Thu, Nov 05, 2015 at 09:51:59AM -0500, Lennart Sorensen wrote:
> > Hmm, I thought I had read that as of 2.6.38 and higher arm systems were
> > supposed to not generate the fault anymore, but maybe I misunderstood
> > it and they meant it sets fixup to enabled by default.
> > 
> > I should check the SCTLR.A flag.
> 
> Of course the arm docs say it is off by default at reset, so something
> in either u-boot or the kernel seems like it must have to enable it
> explicitly.  Well once I figure out how to read it I guess I will know.
> 
> Of course if the memory happens to be flagged as something other than
> normal memory, then it should also fault.  I wonder if a page used to dma
> data to/from a network driver would be flagged as normal memory or not.

Would using this cause such a problem:

/usr/include/xenomai/native/heap.h:#define H_DMA      0x100     /* Use memory suitable for DMA. */

-- 
Len Sorensen

