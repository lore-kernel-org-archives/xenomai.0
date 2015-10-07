Date: Wed, 7 Oct 2015 09:55:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151007075524.GA30140@hermes.click-hack.org>
References: <56139C8B.3060509@control.lth.se>
 <20151006192323.GB30765@hermes.click-hack.org>
 <5614C8E3.5090809@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5614C8E3.5090809@sigmatek.at>
Subject: Re: [Xenomai] Problems disabling SMI interrupts on MSI H87-G43
 motherboard
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johann Obermayr <johann.obermayr@sigmatek.at>
Cc: Xenomai@xenomai.org

On Wed, Oct 07, 2015 at 09:25:23AM +0200, Johann Obermayr wrote:
> Am 06.10.2015 um 21:23 schrieb Gilles Chanteperdrix:
> > On Tue, Oct 06, 2015 at 12:03:55PM +0200, Anders Blomdell wrote:
> >> Hi
> >>
> >> I have problems disabling SMI-interrupts on "MSI H87-G43 motherboard" (http://www.msi.com/product/mb/H87-G43.html)
> >>
> >> This is what msi.c says at bootup (after attached patch is applied):
> >>
> >>    kernel: [Xenomai] SMI workaround failed! (1830: 1 & ~1 -> 1)
> >>
> >> and this is what lspci says:
> >>
> >>
> >> Anybody who has a good idea how to fix this?
> > You should first check that the way smi.c retrieves the address of
> > the SMI_EN register is still valid for your chipset. If it is, then
> > try fiddling with the BIOS settings to see if some setting can
> > disable generation of SMIs. If unsuccessful, you can try contacting
> > the motherboard support to see if they have any advice.
> >
> On new Mainboards, you can't disable SMI.
> Because this is a security problem, so SMI is locked by BIOS.

Yes, there is a bit in a register to lock the SMI_EN register, and
when the SMI_EN register is locked, there is no way to unlock it.

However, the BIOS may offer you some setting to disable the
problematic SMI source. This happened to me recently. It was not
possible to modify the SMI_EN register, but with the right BIOS
setting, no SMI was generated.

-- 
					    Gilles.
https://click-hack.org

