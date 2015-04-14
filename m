Date: Tue, 14 Apr 2015 10:04:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150414080410.GB1589@hermes.click-hack.org>
References: <299A38B133279A4EBA47BCB60993FEAF858030C89D@xs203433.MELINDA.LOCAL>
 <20150414073454.GA1589@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150414073454.GA1589@hermes.click-hack.org>
Subject: Re: [Xenomai] RTNET
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: romain.perier@scle.fr
Cc: xenomai@xenomai.org

On Tue, Apr 14, 2015 at 09:34:54AM +0200, Gilles Chanteperdrix wrote:
> On Tue, Apr 14, 2015 at 09:17:59AM +0200, romain.perier@scle.fr wrote:
> > Hi all,
> > 
> > We're deploying Xenomai 3.0-rc4 (3.16.7 mainline kernel, in dual-kernel
> > mode) on a Zynq ZC702. Everything works fine except when we try to use
> > ethernet in the xenomai mode. The driver is called "macb" and it is
> > already ported to RTDM. macb is correctly loaded and initialized, the
> > mac controller is correctly connected to the phy, BUT, when I play a bit
> > with rtifconfig , the systems hangs.
> > 
> > # rtifconfig rteth0 up
> >  [  495.846877] macb e000b000.ethernet eth0: link up (1000/Full)
> >  # and now everything is freezed (only when the cable is plugged)
> > 
> > After some investigations, if I disable the call to rtdm_irq_request(),
> > the systems no longer freezes. So, It seems to be an issue caused by
> > interrupts handling.
> > I use the devicetree to tells to linux which driver I want to use for
> > the corresponding mac controller, I just change the "compatible" string.
> > I renamed xeno-macb compatible string to "cdns,rtgem" instead of
> > "cdns,gem" .In this way I can use the first mac controller in linux and
> > the second one in xenomai, each one with a different device driver. Both
> > interrupts are from Cortex-A9 GIC.
> > (I already tested to use only one mac controller at a time, same problem)
> 
> This is a bad way to use devicetree go, the devicetree is a
> description of the hardware, not of the software handling it, so the
> rtnet driver should use exactly the same compatible device as linux
> driver. If you need to bind a device to a driver, use the
> bind/unbind files in the /sys filesystem:
> https://lwn.net/Articles/143397/
> 
> 
> > 
> > I have two questions :
> > 
> > 1. Have you any ideas about the problem described above ?
> 
> No, the macb driver has been tested on AT91, and was working. Have
> you tried loading rtipv4 and passing an IP address to rtifconfig (in
> that order)?

Actually, I believe I only tested the macb driver, not the gem one.
The AT91 I have has both, but my ethernet cable is plugged on the
macb.

-- 
					    Gilles.

