Date: Fri, 23 Jan 2015 14:55:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150123135507.GA9521@hermes.click-hack.org>
References: <3022250.HiL0lpQ0bg@soho> <6556840.cT0vWHhSc4@soho>
 <20150123101859.GA6264@hermes.click-hack.org>
 <8468176.WAFPJMNP3d@soho>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8468176.WAFPJMNP3d@soho>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-3 booting problems (2)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On Fri, Jan 23, 2015 at 12:30:02PM +0100, Leopold Palomo-Avellaneda wrote:
> El Divendres, 23 de gener de 2015, a les 11:18:59, Gilles Chanteperdrix va 
> escriure:
> > On Fri, Jan 23, 2015 at 10:44:24AM +0100, Leopold Palomo-Avellaneda wrote:
> > > El Divendres, 23 de gener de 2015, a les 08:44:03, Gilles Chanteperdrix va
> > > 
> > > escriure:
> > > > On Fri, Jan 23, 2015 at 08:36:14AM +0100, Leopold Palomo-Avellaneda 
> wrote:
> > > > > El Dijous, 22 de gener de 2015, a les 16:09:19, Leopold
> > > > > Palomo-Avellaneda
> > > > > va>
> > > > > 
> > > > > escriure:
> > > > > > Hi again,
> > > > > > 
> > > > > > after made the modifications proposed by Jan Kiszka, now it doesn't
> > > > > > built
> > > > > > and the message is:
> > > > > > 
> > > > > > nvidiafb: unable to setup MTRR
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > removed nvidiafb.ko module (and all the nvidia graphics stuff) and the
> > > > > box
> > > > > booted. It seems that nvidiafb (the non-free nvidia driver) doesn't
> > > > > like
> > > > > xenomai-3 or vice-versa.
> > > > > 
> > > > > Are you aware of this?
> > > > 
> > > > Were you trying to use the nvidia module compiled for the vanilla
> > > > kernel, or did you recompile the nvidia module for the Xenomai
> > > > kernel? The former will not work.
> > > 
> > > the second one. Using debian packages, when you install a new one, it
> > > recompiles the modules needed (if they are packaged dkms) So, when I
> > > installed the debian package, all the modules (that had sources) were
> > > recompiled.> 
> > > > Other than that, the nvidia module has been reported to work with
> > > > Xenomai, if the I-pipe patch you use contains this patch:
> > > > https://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.16&id=bc5bea6f134de2
> > > > e55b b6014566c62fa083ed9c7b
> > > 
> > > The module that failed was the nvidiafb. Not the others. For instance, now
> > > I'm running 3.16 with xenomai 3.0.0 in my graphical desktop with nvidia
> > > driver. It's the nvidia framebuffer that fails.
> > 
> > AFAIK, nvidiafb is part of the Linux kernel, not of the nvidia
> > driver. According to this page:
> > http://wiki.gentoo.org/wiki/NVidia/nvidia-drivers
> 
> Not exactly. The nvidia driver has two parts: one for the kernel and another 
> for the X server.


> The kernel part has public source (no open source?), and 
> it's recompiled as module. The other is closed, binary. 

No the kernel part contains some glue with a big pre-compiled
proprietary binary.

> 
> AFAIK, the frame buffer is to have console in booting time, or console in 
> general. It's used when you switch from graphic mode to console mode. But

You are mistaken. The nvidiafb driver is part of the Linux kernel,
see:
http://git.xenomai.org/ipipe.git/tree/drivers/video/fbdev/nvidia/Makefile

In this file, you can see the copyright:
http://git.xenomai.org/ipipe.git/tree/drivers/video/fbdev/nvidia/nvidia.c

Not by Nvidia. Yes nvidiafb is a framebuffer driver, I knew that,
only by the name. But no, it is not part of the (binary) drivers
made by nvidia, so it is a third thing in addition to the nvidia.ko
kernel-space support provided by Nvidia, and the user-space
distribution (which contains a module for the X server, but also an
opengl implementation).

And the gentoo page seems to indicate that the framebuffer driver
may conflict with the nvidia stuff (whether kernel-space or
user-space does not really matter).

> 
> > - the MTRR error is due to the fact that you disabled MTRR in the
> > kernel configuration, probably because you disabled IOMMU
> 
> No, I have it activated.
> 
> $ grep CONFIG_MTRR /boot/config-3.16.0-xenomai-3.0.0 
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1

You have not read the page I sent you. It clearly indicates that on
the amd64 architecture, you have to enable IOMMU to get MTRR working
with the nvidiafb module. I do not know whether this is true, but
this is what the page says.

> 
> 
> > - using the nvidiafb module with the nvidia proprietary module is
> > not recommended, as they are known to conflict at times.
> 
> It could have conflicts, it's true. Because the two modules try to claim the 
> same device. I should have the test installing only one and see what happens.
> 

Obviously.



-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150123/c323b4f7/attachment.sig>
