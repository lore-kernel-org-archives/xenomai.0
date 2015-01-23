Date: Fri, 23 Jan 2015 11:18:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150123101859.GA6264@hermes.click-hack.org>
References: <3022250.HiL0lpQ0bg@soho> <3479927.PcNNIgk0xm@soho>
 <20150123074403.GK29604@hermes.click-hack.org>
 <6556840.cT0vWHhSc4@soho>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6556840.cT0vWHhSc4@soho>
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

On Fri, Jan 23, 2015 at 10:44:24AM +0100, Leopold Palomo-Avellaneda wrote:
> El Divendres, 23 de gener de 2015, a les 08:44:03, Gilles Chanteperdrix va 
> escriure:
> > On Fri, Jan 23, 2015 at 08:36:14AM +0100, Leopold Palomo-Avellaneda wrote:
> > > El Dijous, 22 de gener de 2015, a les 16:09:19, Leopold Palomo-Avellaneda
> > > va> 
> > > escriure:
> > > > Hi again,
> > > > 
> > > > after made the modifications proposed by Jan Kiszka, now it doesn't
> > > > built
> > > > and the message is:
> > > > 
> > > > nvidiafb: unable to setup MTRR
> > > 
> > > Hi,
> > > 
> > > removed nvidiafb.ko module (and all the nvidia graphics stuff) and the box
> > > booted. It seems that nvidiafb (the non-free nvidia driver) doesn't like
> > > xenomai-3 or vice-versa.
> > > 
> > > Are you aware of this?
> > 
> > Were you trying to use the nvidia module compiled for the vanilla
> > kernel, or did you recompile the nvidia module for the Xenomai
> > kernel? The former will not work.
> 
> the second one. Using debian packages, when you install a new one, it 
> recompiles the modules needed (if they are packaged dkms) So, when I installed 
> the debian package, all the modules (that had sources) were recompiled.
> 
> > Other than that, the nvidia module has been reported to work with
> > Xenomai, if the I-pipe patch you use contains this patch:
> > https://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.16&id=bc5bea6f134de2e55b
> > b6014566c62fa083ed9c7b
> 
> 
> The module that failed was the nvidiafb. Not the others. For instance, now I'm 
> running 3.16 with xenomai 3.0.0 in my graphical desktop with nvidia driver. 
> It's the nvidia framebuffer that fails. 

AFAIK, nvidiafb is part of the Linux kernel, not of the nvidia
driver. According to this page:
http://wiki.gentoo.org/wiki/NVidia/nvidia-drivers

- the MTRR error is due to the fact that you disabled MTRR in the
kernel configuration, probably because you disabled IOMMU
- using the nvidiafb module with the nvidia proprietary module is
not recommended, as they are known to conflict at times.

> 
> In debian systems, adding 
> blacklist nvidiafb
> 
> to/etc/modprobe.d/nvidia-blacklists-nouveau.conf
> 
> solve the issue. 
> 
> xenomai has some kind of issue tracker?

You are using it.


-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150123/8f333ebb/attachment.sig>
