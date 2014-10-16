From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 16 Oct 2014 14:17:11 -0400
Message-ID: <20141016181711.GB24110@csclub.uwaterloo.ca>
References: <543E4B9F.60602@cgglobal.com> <543E5380.3080700@cgglobal.com>
 <543F70C5.1090005@xenomai.org> <543F7ED2.2080201@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <543F7ED2.2080201@xenomai.org>
Subject: Re: [Xenomai] First call to rt_timer_tsc() causes an unexpected
 switch to secondary mode.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Oct 16, 2014 at 10:16:18AM +0200, Gilles Chanteperdrix wrote:
> Also, vfpv3-d16 looks suspicious to me: you may be uselessly limiting
> the number of vfp registers available to the compiler. If cat
> /proc/cpuinfo tells you vfpv3 and not vfpv3-d16, you can use
> -mfpu=vfpv3, if it tells you neon, you can use -mfpu=neon. I am almost
> sure the beaglebone processor has 32 double vfp registers, not 16.
> 
> This page:
> http://www.ti.com/product/AM3358/datasheet
> 
> Seems to imply that the beaglebone processor has NEON.

Neon is mandetory on Cortex-A8.  Only Cortex-A9 made it optional
(unfortunately) and I believe nvidia was pretty much the only one to
not include Neon.  Of course non Cortex designs don't have it either
(Marvell JP4 cores for example), but those are pretty rare.  I have no
idea if qualcomm's designs have it or not.

> And this page:
> http://en.wikipedia.org/wiki/ARM_architecture#Floating-point_.28VFP.29
> 
> Seems to imply that since it is a cortex a8, it has 32 double vfp
> registers and not 16.
> 
> It would seem among arm processors of the "A" family and the armv7
> architecture, only cortex A5 and cortex A7 may have 16 double vfp
> registers (the atmel sama5d3 for instance is in this case).

-- 
Len Sorensen

