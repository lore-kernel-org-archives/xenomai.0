Date: Tue, 18 Nov 2014 19:51:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141118185131.GB3177@sisyphus.hd.free.fr>
References: <20141117201435.GH31920@sisyphus.hd.free.fr>
 <20141117202425.GU24110@csclub.uwaterloo.ca>
 <20141117202754.GI31920@sisyphus.hd.free.fr>
 <20141117214734.GW24110@csclub.uwaterloo.ca>
 <20141117215458.GM31920@sisyphus.hd.free.fr>
 <20141117221001.GX24110@csclub.uwaterloo.ca>
 <20141117221542.GN31920@sisyphus.hd.free.fr>
 <20141118152422.GY24110@csclub.uwaterloo.ca>
 <20141118152649.GC26237@sisyphus.hd.free.fr>
 <20141118184843.GZ24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141118184843.GZ24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Tue, Nov 18, 2014 at 01:48:43PM -0500, Lennart Sorensen wrote:
> On Tue, Nov 18, 2014 at 04:26:49PM +0100, Gilles Chanteperdrix wrote:
> > Ok, there is already code in the I-pipe for turning off smartidle
> > for other peripherals (like the hardware timer, the omap specific
> > one used on omap3, and SMP omap4 and 5 when in UP mode, not the
> > cortex a9 global timer), so, any patch to toggle this bit with 
> > if (IS_ENABLED(IPIPE))
> > will be accepted.
> 
> I am just adding 'ti,no-idle' to gpio7 in the dtb.  That appears to
> be right.  Building it now to test it.
> 
> The handling is of in omap-hwmod.c, not in gpio-omap.c so not sure how
> to make ipipe know that a given gpio bank is used for irq and should
> not idle.  At least not in a clean manner.

I would take the simple approach: disable the smartidle in the probe
function for all GPIO banks if IS_ENABLED(CONFIG_IPIPE)

Otherwise, the enable_irqdesc/disable_irqdesc functions already
keep track of which bank has real-time irq handlers registered, and
it is already conditionally compiled only if CONFIG_IPIPE is
enabled. So, you can add your code there.

-- 
					    Gilles.

