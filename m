Date: Wed, 3 Feb 2016 02:51:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160203015139.GE18030@hermes.click-hack.org>
References: <20160202200235.GB29937@hermes.click-hack.org>
 <20160202203539.GD27804@deathstar>
 <20160202205945.GC29937@hermes.click-hack.org>
 <20160203003212.GE27804@deathstar>
 <20160203004307.GA18030@hermes.click-hack.org>
 <20160203012135.GF27804@deathstar>
 <20160203013118.GC18030@hermes.click-hack.org>
 <20160203013615.GG27804@deathstar>
 <20160203013752.GD18030@hermes.click-hack.org>
 <20160203014247.GH27804@deathstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160203014247.GH27804@deathstar>
Subject: Re: [Xenomai] IMX6 Quad inconsistent lock state
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Welling <mwelling@ieee.org>
Cc: xenomai@xenomai.org

On Tue, Feb 02, 2016 at 07:42:47PM -0600, Michael Welling wrote:
> On Wed, Feb 03, 2016 at 02:37:52AM +0100, Gilles Chanteperdrix wrote:
> > On Tue, Feb 02, 2016 at 07:36:15PM -0600, Michael Welling wrote:
> > > On Wed, Feb 03, 2016 at 02:31:18AM +0100, Gilles Chanteperdrix wrote:
> > > > On Tue, Feb 02, 2016 at 07:21:35PM -0600, Michael Welling wrote:
> > > > > On Wed, Feb 03, 2016 at 01:43:07AM +0100, Gilles Chanteperdrix wrote:
> > > > > > On Tue, Feb 02, 2016 at 06:32:12PM -0600, Michael Welling wrote:
> > > > > > > On Tue, Feb 02, 2016 at 09:59:45PM +0100, Gilles Chanteperdrix wrote:
> > > > > > > > On Tue, Feb 02, 2016 at 02:35:39PM -0600, Michael Welling wrote:
> > > > > > > > > On Tue, Feb 02, 2016 at 09:02:35PM +0100, Gilles Chanteperdrix wrote:
> > > > > > > > > > On Tue, Feb 02, 2016 at 01:53:55PM -0600, Michael Welling wrote:
> > > > > > > > > > > The kernel otherwise appears to be functional.
> > > > > > > > > > > How do I fix this?
> > > > > > > > > > 
> > > > > > > > > > Disable CONFIG_TRACE_IRQFLAGS. This means disabling CONFIG_LOCKDEP too.
> > > > > > > > > 
> > > > > > > > > Ah. I had to trace back the dependencies and found that I had CONFIG_PROVE_LOCKING
> > > > > > > > > and CONFIG_DEBUG_LOCK_ALLOC selected.
> > > > > > > > > 
> > > > > > > > > Unselecting those made the warning go away. Good enough for me.
> > > > > > > > > 
> > > > > > > > > Thanks!
> > > > > > > > > 
> > > > > > > > > Next up is getting the rtdm driver modules to build.
> > > > > > > > > 
> > > > > > > > > Here is the error output without the UART driver selected:
> > > > > > > > > ERROR: "__ipipe_smp_key" [drivers/xenomai/net/stack/rtmac/tdma/tdma.ko] undefined!
> > > > > > > > > ERROR: "__ipipe_smp_key" [drivers/xenomai/ipc/xeno_rtipc.ko] undefined!
> > > > > > > > > ERROR: "__ipipe_smp_key" [drivers/xenomai/can/xeno_can.ko] undefined!
> > > > > > > > 
> > > > > > > > An EXPORT_SYMBOL is missing in arch/arm/kernel/ipipe.c. Or you can
> > > > > > > > disable CONFIG_SMP_ON_UP.
> > > > > > > 
> > > > > > > Yeah I figured this one out.
> > > > > > 
> > > > > > Ok. On my side I believe I figured why the build-test does not
> > > > > > reproduce this issue: it has CONFIG_JUMP_LABEL disabled, which does
> > > > > > not really make sense with CONFIG_SMP_ON_UP and Xenomai, so I
> > > > > > enabled the option, and next time the build-test runs, we should
> > > > > > observe the compilation error you got.
> > > > > 
> > > > > My configuration also has CONFIG_JUMP_LABEL disabled.
> > > > > 
> > > > > I am likely using a module for something you are not.
> > > > 
> > > > the tested configuration has tdma enabled as a module. Maybe you are
> > > > not using I-pipe path version ipipe-core-3.18.20-arm-6 ?
> > > 
> > > I am using the following:
> > > xenomai-3/kernel/cobalt/arch/arm/patches/ipipe-core-3.18.20-arm-6.patch
> > 
> > Ok, could you post the .config with which you get a build failure?
> 
> It was pasted in the post two messages ago.

Indeed, I even looked at it. Sorry. It is late here, I will try and
use it tomorrow.

-- 
					    Gilles.
https://click-hack.org

