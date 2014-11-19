From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 19 Nov 2014 12:12:04 -0500
Message-ID: <20141119171204.GI24110@csclub.uwaterloo.ca>
References: <20141118185131.GB3177@sisyphus.hd.free.fr>
 <20141118185657.GA24110@csclub.uwaterloo.ca>
 <20141118190014.GC3177@sisyphus.hd.free.fr>
 <20141118192437.GB24110@csclub.uwaterloo.ca>
 <20141118192846.GE3177@sisyphus.hd.free.fr>
 <20141118202833.GH3177@sisyphus.hd.free.fr>
 <20141118205303.GD24110@csclub.uwaterloo.ca>
 <20141118205624.GK3177@sisyphus.hd.free.fr>
 <20141118211713.GL3177@sisyphus.hd.free.fr>
 <20141118213931.GE24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141118213931.GE24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Nov 18, 2014 at 04:39:31PM -0500, Lennart Sorensen wrote:
> TI seems to be on a 'Get it mainlined' kick lately, so perhaps they are
> being more careful as a result.
> 
> > Anyway, this is not a good solution, this is clearly something that
> > nobody tests, thre is no reason to expect it what we would expect to
> > dot. 
> 
> I see this 'hack' in the omap timer code:
> 
> +#ifdef CONFIG_IPIPE
> +       if (ipipe) {
> +               u32 l;
> +
> +               l = __raw_readl(timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
> +               l = (0x3 << 8) | (l & (1 << 5)) | (0x1 << 3) | (1 << 2);
> +               __raw_writel(l, timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
> +       }
> +#endif
> 
> Sure would be nice if someone had actually defined what those bits are,
> although it appears to be setting wakeup on, and idle mode to 'no idle',
> and I didn't look up the 5 and 8 bits yet.
> 
> I was hoping to do something a lot cleaner than that.

Well this works for me:

Index: linux-3.12.31.rr1/arch/arm/mach-omap2/omap_hwmod.c
===================================================================
--- linux-3.12.31.rr1.orig/arch/arm/mach-omap2/omap_hwmod.c     2014-11-19 11:32:38.931715225 -0500
+++ linux-3.12.31.rr1/arch/arm/mach-omap2/omap_hwmod.c  2014-11-19 12:08:45.575792706 -0500
@@ -2587,6 +2587,8 @@
                        oh->flags |= HWMOD_INIT_NO_RESET;
                if (of_find_property(np, "ti,no-idle", NULL))
                        oh->flags |= HWMOD_INIT_NO_IDLE;
+               if (of_find_property(np, "ti,no-smart-idle", NULL))
+                       oh->flags |= HWMOD_SWSUP_SIDLE;
        }
 
        oh->_state = _HWMOD_STATE_INITIALIZED;

combined with adding to the dts:

&gpio7 {
	ti,no-smart-idle;
};

I think I like that as a simple clean solution.

Now the SYSCONFIG register is 0x0009 (no idle + autoidle) rather than
0x001d (smart idle with wakeup enabled + autoidle)

-- 
Len Sorensen

