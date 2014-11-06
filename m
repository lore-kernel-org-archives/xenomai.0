Date: Thu, 6 Nov 2014 15:51:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141106145130.GA30908@sisyphus.hd.free.fr>
References: <20141106125217.GC29228@sisyphus.hd.free.fr>
 <2121666186.108134765.1415284907675.JavaMail.root@zimbra90-e16.priv.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2121666186.108134765.1415284907675.JavaMail.root@zimbra90-e16.priv.proxad.net>
Subject: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
 adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: tbultel@free.fr
Cc: xenomai@xenomai.org

On Thu, Nov 06, 2014 at 03:41:47PM +0100, tbultel@free.fr wrote:
> 
> 
> ----- Mail original -----
> > De: "Gilles Chanteperdrix" chanteperdrix@xenomai.org>
> > À: tbultel@free.fr
> > Cc: xenomai@xenomai.org
> > Envoyé: Jeudi 6 Novembre 2014 13:52:17
> > Objet: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 + adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
> > 
> > On Thu, Nov 06, 2014 at 01:34:55PM +0100, Gilles Chanteperdrix wrote:
> > > On Thu, Nov 06, 2014 at 12:47:35PM +0100, Gilles Chanteperdrix
> > > wrote:
> > > > On Thu, Nov 06, 2014 at 11:57:20AM +0100, tbultel@free.fr wrote:
> > > > > Hi Gilles,
> > > > > I can't afford going on that commit, it is a too old kernel and
> > > > > my BSP
> > > > > patch does not apply on it.
> > > > > Meanwhile, I have fixed the slowness issue, I had not payed
> > > > > enough
> > > > > attention to some rejections when applying the ipipe patch.
> > > > > 
> > > > > But this leads to the reason why I was interested in taking
> > > > > your latest
> > > > > ipipe patch.
> > > > > We used to work with the previous one, which was in 3 pieces
> > > > > (pre-x-post).
> > > > 
> > > > Yes, it is one piece now, because only mx6 users use the I-pipe
> > > > patch for Linux 3.0, so this reduces the maintenance cost.
> > > > 
> > > > I am surprised to hear that you are using this I-pipe patch as I
> > > > had
> > > > heard it caused over-heating issue with your setup.
> > > > 
> > > > > 
> > > > > We are facing random kernel crashes when using the eth
> > > > > intensively.
> > > > > (ping -i 0.01 -s 65000)
> > > > > That crashs happen with both ipipe patches versions.
> > > > > 
> > > > > That random freeze only happen on some machines ( 3 machines on
> > > > > a total
> > > > > of 17 are impacted), that first had let us think about an
> > > > > hardware bug.
> > > > > (There are no CPU revs differences between those machines)
> > > > > But after some testing, the crash does not happen with a
> > > > > non-patched
> > > > > 3.0.35_4.1.0 kernel, or with a patched kernel that has
> > > > > CONFIG_IPIPE
> > > > > disabled.
> > > > > The freeze sometimes gives a backtrace on the serial port,
> > > > > sometimes not.
> > > > > See a backtrace sample below. It has rarely the same shape.
> > > > > 
> > > > > By doing some code re-reading, and performing some dichotomy,
> > > > > I found out that removing the mb() call in
> > > > > bufdesc_read_status() ....
> > > > > 
> > > > > static inline unsigned short bufdesc_read_status(struct bufdesc
> > > > > *bdp)
> > > > > {
> > > > > #if 0
> > > > > #ifdef CONFIG_ARCH_MX6
> > > > >         mb();
> > > > > #endif /* CONFIG_ARCH_MX6 */
> > > > > #endif /* 0 */
> > > > >         return bdp->cbd_sc;
> > > > > 
> > > > > }
> > > > > 
> > > > > ... makes the freeze less reproducible (a machine that froze in
> > > > > less
> > > > > than 10 secs stayed alive for 2h30)
> > > > > 
> > > > > I noticed that the call mb() is not done on more recent
> > > > > kernels.
> > > > > It is introduced by the Ipipe patch.
> > > > > I do not understand neither why it makes the freeze happen,
> > > > 
> > > > I believe I know why this happens. In order to workaround some
> > > > hardware issue, the imx6 idle loop is issuing calls to mb(), and
> > > > they cause starvation if a non-idle cpu is attempting to call
> > > > mb().
> > > > The first fix that was posted on the lakml is to add a bunch of
> > > > "nops" in front of the mb() in the idle loop, I have not followed
> > > > how this got fixed finally. I would not be surprised if the fix
> > > > for
> > > > this issue has not been backported to 3.0 kernels.
> > > 
> > > Actually, I remembered incorrectly. The problem is not in the idle
> > > loop (unless it calls cpu_relax() when CONFIG_IPIPE is on, instead
> > > of wfi), but in cpu_relax(). And this happens only if you have
> > > enabled support for armv6 processors (like imx31) like the
> > > imx_v6_v7
> > > defconfig does, or if you enable CONFIG_ARM_ERRATA_754327.
> > > 
> > > If that is the case, please try the patch here:
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/114646.html
> > 
> > I already backported this patch:
> > http://git.xenomai.org/ipipe-gch.git/commit/?h=ipipe-3.0-imx6q&id=803f75460e99d4b4dbf029f57cc7cf5eb8dd7338
> > 
> > So, now, if we assume what is causing the problem is the fact that
> > the FEC patch is causing the lockup, you could try and add the magic
> > 5 nops before the mb() in the bufdesc_read_status() function
> > 
> > --
> 
> Gilles, we do not have CONFIG_ARM_ERRATA_754327 enabled

It should not be a problem, since the I-pipe patch contains the nop
workaround. 

> It is -not- enabled in the evaluation kernel that is provided by the 
> manufacturer.
> That errata is said to be for CPU revs < r2p0
> 
> I am a little bit puzzled about the naming conventions for the CPU revision,
> uboot says rev1.2, the kernel says
> 
> Processor	: ARMv7 Processor rev 10 (v7l)
> ...
> 
> CPU implementer	: 0x41
> CPU architecture: 7
> CPU variant	: 0x2
> CPU part	: 0xc09
> CPU revision	: 10
> 
> how can I do the matching ?

I would say this is an r2p10.

Looking at the linux boot logs for omap4, I get:

CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=50c53c7d

This is split as:
41 1 fc09 2

41 is the vendor, it is ARM
and for ARM processors, fc09 identifies a cortex a9
the remaining 1 and 2, mean r1p2 from what I understand. This looks
similar to what u-boot is telling you.

> 
> Meanwhile, we noticed that compared to the evaluation kernel, we were missing
> CONFIG_ARM_ERRATA_754322 and CONFIG_PL310_ERRATA_769419
> 
> Adding them helps a lot, but the freeze still happens on one machine
> 
> We are currently trying with 754322 + 769419 + 754327 + 5 nops in fec ... 
> but not sure if we need 754327.

Normally, the workarounds are only enabled if the processor requires
them, but there are exceptions, with 754327 being one.

-- 
			
		    Gilles.

