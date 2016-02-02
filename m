Sender: Michael Welling <mwelling79@gmail.com>
Date: Tue, 2 Feb 2016 14:35:39 -0600
From: Michael Welling <mwelling@ieee.org>
Message-ID: <20160202203539.GD27804@deathstar>
References: <20160202195355.GC27804@deathstar>
 <20160202200235.GB29937@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160202200235.GB29937@hermes.click-hack.org>
Subject: Re: [Xenomai] IMX6 Quad inconsistent lock state
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

On Tue, Feb 02, 2016 at 09:02:35PM +0100, Gilles Chanteperdrix wrote:
> On Tue, Feb 02, 2016 at 01:53:55PM -0600, Michael Welling wrote:
> > The kernel otherwise appears to be functional.
> > How do I fix this?
> 
> Disable CONFIG_TRACE_IRQFLAGS. This means disabling CONFIG_LOCKDEP too.

Ah. I had to trace back the dependencies and found that I had CONFIG_PROVE_LOCKING
and CONFIG_DEBUG_LOCK_ALLOC selected.

Unselecting those made the warning go away. Good enough for me.

Thanks!

Next up is getting the rtdm driver modules to build.

Here is the error output without the UART driver selected:
ERROR: "__ipipe_smp_key" [drivers/xenomai/net/stack/rtmac/tdma/tdma.ko] undefined!
ERROR: "__ipipe_smp_key" [drivers/xenomai/ipc/xeno_rtipc.ko] undefined!
ERROR: "__ipipe_smp_key" [drivers/xenomai/can/xeno_can.ko] undefined!


Here is the error output with the UART driver selected:
/home/michael/projects/xenomai/imx_xeno/linux-3.18.20/drivers/xenomai/serial/rt_imx_uart.c:39:27: fatal error: mach/hardware.h: No such file or directory
 #include <mach/hardware.h>
                           ^
compilation terminated.

Any quick hints?

I will post patches if/when I find proper fixes.

> 
> -- 
> 					    Gilles.
> https://click-hack.org

