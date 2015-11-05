Date: Thu, 5 Nov 2015 18:14:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151105171419.GG16314@hermes.click-hack.org>
References: <20151105110141.GC16314@hermes.click-hack.org>
 <20151105145159.GK21923@csclub.uwaterloo.ca>
 <20151105145725.GL21923@csclub.uwaterloo.ca>
 <20151105150226.GM21923@csclub.uwaterloo.ca>
 <20151105151544.GD16314@hermes.click-hack.org>
 <20151105152427.GN21923@csclub.uwaterloo.ca>
 <20151105155549.GE16314@hermes.click-hack.org>
 <20151105161902.GO21923@csclub.uwaterloo.ca>
 <20151105162514.GF16314@hermes.click-hack.org>
 <20151105165750.GP21923@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151105165750.GP21923@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] ARM bus error due to alignment
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Thu, Nov 05, 2015 at 11:57:50AM -0500, Lennart Sorensen wrote:
> On Thu, Nov 05, 2015 at 05:25:14PM +0100, Gilles Chanteperdrix wrote:
> > I am sure. Xenomai does not use H_DMA on armv7, so, it is not used
> > if your code, it is not used at all.
> 
> Well we are using it for one allocation for talking to a network port.
> 
> If I remove it, I get a NULL pointer dereference, so it clearly matters
> to something in our code.
> 
> > > It does appear that when LPAE is enabled H_DMA does do something on arm,
> > > but only when LPAE is enabled since that enables ZONE_DMA.
> > 
> > I never said that H_DMA did nothing.
> 
> OK I misunderstood then.
> 
> Setting /proc/cpu/alignment to 0 gives the kernel message:
> alignment: ignoring faults is unsafe on this CPU.  Defaulting to fixup mode.
> 
> Apparently armv6+ with CR_U set is not allowed to turn off fixups.

If you have an armv7, you want to turn off all armv6 processors in
the kernel configuration so that the kernel does not try to be
compatible with these obsolete processors.

-- 
					    Gilles.
https://click-hack.org

