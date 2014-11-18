From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 18 Nov 2014 14:24:37 -0500
Message-ID: <20141118192437.GB24110@csclub.uwaterloo.ca>
References: <20141117214734.GW24110@csclub.uwaterloo.ca>
 <20141117215458.GM31920@sisyphus.hd.free.fr>
 <20141117221001.GX24110@csclub.uwaterloo.ca>
 <20141117221542.GN31920@sisyphus.hd.free.fr>
 <20141118152422.GY24110@csclub.uwaterloo.ca>
 <20141118152649.GC26237@sisyphus.hd.free.fr>
 <20141118184843.GZ24110@csclub.uwaterloo.ca>
 <20141118185131.GB3177@sisyphus.hd.free.fr>
 <20141118185657.GA24110@csclub.uwaterloo.ca>
 <20141118190014.GC3177@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141118190014.GC3177@sisyphus.hd.free.fr>
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

On Tue, Nov 18, 2014 at 08:00:14PM +0100, Gilles Chanteperdrix wrote:
> On Tue, Nov 18, 2014 at 01:56:57PM -0500, Lennart Sorensen wrote:
> > On Tue, Nov 18, 2014 at 07:51:31PM +0100, Gilles Chanteperdrix wrote:
> > > I would take the simple approach: disable the smartidle in the probe
> > > function for all GPIO banks if IS_ENABLED(CONFIG_IPIPE)
> > > 
> > > Otherwise, the enable_irqdesc/disable_irqdesc functions already
> > > keep track of which bank has real-time irq handlers registered, and
> > > it is already conditionally compiled only if CONFIG_IPIPE is
> > > enabled. So, you can add your code there.
> > 
> > I will consider that after doing my other test.  For me adding one flag
> > to the dtb for our board seems less invasive, but for ipipe overall it
> > would be better to make ipipe turn of smartidle on the IRQ supporting
> > gpio banks.
> 
> RT IRQs only, we do not care about NRT IRQS, they can depend on the
> dts parameter. Anyway, if you tell me where the code you are talking
> about can be found, I can propose a patch that you test, and merge
> it if it works for you.

Hmm, ti,no-idle causes a gpio bank startup failure, so that doesn't work.

The code setting it to idle is in arch/arm/mach-omap2/omap_hwmod.c:

static void _enable_sysc(struct omap_hwmod *oh)
{
        u8 idlemode, sf;
        u32 v;
        bool clkdm_act;
        struct clockdomain *clkdm;

        if (!oh->class->sysc)
                return;

        /*
         * Wait until reset has completed, this is needed as the IP
         * block is reset automatically by hardware in some cases
         * (off-mode for example), and the drivers require the
         * IP to be ready when they access it
         */
        if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
                _enable_optional_clocks(oh);
        _wait_softreset_complete(oh);
        if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
                _disable_optional_clocks(oh);

        v = oh->_sysc_cache;
        sf = oh->class->sysc->sysc_flags;

        clkdm = _get_clkdm(oh);
        if (sf & SYSC_HAS_SIDLEMODE) {
                if (oh->flags & HWMOD_SWSUP_SIDLE ||
                    oh->flags & HWMOD_SWSUP_SIDLE_ACT) {
                        idlemode = HWMOD_IDLEMODE_NO;
                } else {
                        if (sf & SYSC_HAS_ENAWAKEUP)
                                _enable_wakeup(oh, &v);
                        if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
                                idlemode = HWMOD_IDLEMODE_SMART_WKUP; <- this one
                        else
                                idlemode = HWMOD_IDLEMODE_SMART; <- or this one
                }

                /*
                 * This is special handling for some IPs like
                 * 32k sync timer. Force them to idle!
                 */
                clkdm_act = (clkdm && clkdm->flags & CLKDM_ACTIVE_WITH_MPU);
                if (clkdm_act && !(oh->class->sysc->idlemodes &
                                   (SIDLE_SMART | SIDLE_SMART_WKUP)))
                        idlemode = HWMOD_IDLEMODE_FORCE;

                _set_slave_idlemode(oh, idlemode, &v);
        }

The hwmod for the gpio bank in question is in
arch/arm/mach-omap2/omap_hwmod_7xx_data.c:

/*
 * 'gpio' class
 *
 */

static struct omap_hwmod_class_sysconfig dra7xx_gpio_sysc = {
        .rev_offs       = 0x0000,
        .sysc_offs      = 0x0010,
        .syss_offs      = 0x0114,
        .sysc_flags     = (SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
                           SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
                           SYSS_HAS_RESET_STATUS),
        .idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
                           SIDLE_SMART_WKUP),
        .sysc_fields    = &omap_hwmod_sysc_type1,
};

and later

/* gpio7 */

static struct omap_hwmod dra7xx_gpio7_hwmod = {
        .name           = "gpio7",
        .class          = &dra7xx_gpio_hwmod_class,
        .clkdm_name     = "l4per_clkdm",
        .flags          = HWMOD_CONTROL_OPT_CLKS_IN_RESET,
        .prcm = {
                .omap4 = {
                        .clkctrl_offs = DRA7XX_CM_L4PER_GPIO7_CLKCTRL_OFFSET,
                        .context_offs = DRA7XX_RM_L4PER_GPIO7_CONTEXT_OFFSET,
                        .modulemode   = MODULEMODE_HWCTRL,
                },
        },
        .dev_attr       = &gpio_dev_attr,
};

Code can be found here:

http://git.ti.com/ti-linux-kernel/ti-linux-kernel/trees/ti-linux-3.12.y

-- 
Len Sorensen

