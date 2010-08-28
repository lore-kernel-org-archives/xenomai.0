From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100828090856.24882@domain.hid>
References: <20100828090856.24882@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 28 Aug 2010 15:46:19 +0200
Message-ID: <1283003179.1709.217.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Ubuntu packages
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: C Robinson <starknight__@domain.hid>
Cc: xenomai@xenomai.org

On Sat, 2010-08-28 at 09:08 -0400, C Robinson wrote:
> Hi Gilles,
> 
> Thanks for the quick response.   I saw this page earlier today, but must have missed the part in brackets, where it says the packages are necessary along with an appropriately patched and compiled kernel. 
>   
> Also, cheers for the additional tip regarding the use of the Debian packages as opposed to Ubuntu.  I was using a more convoluted approach to the installation, and the one you linked to is appearing much more efficient so far (kernel currently compiling).
> 

Sidenote: the kernel patches for 2.6.32/x86 shipped with Xenomai 2.5.4
have a serious issue, which may cause a random lockup during early boot.
You may want to use one of these instead: 
http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.32.15-x86-2.7-02.patch
http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.32.20-x86-2.7-02.patch

> Best wishes,
> Charles
> 
> 
> 
> 
> -----Original Message-----
> From: "Gilles Chanteperdrix" [gilles.chanteperdrix@xenomai.org]
> Date: 08/28/2010 05:42 AM
> To: "C Robinson" <starknight__@domain.hid>
> CC: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Ubuntu packages
> 
> C Robinson wrote:
> > Hi,
> > 
> > I'm seeking some clarification on a few points.   The background is
> > that I have some software I need to install which requires Xenomai on
> > Ubuntu.   Being fairly recent on the Linux scene, following the
> > installation guide for Xenomai has been something of a voyage of
> > exploration, as yet unfinished - and somewhat more complicated as I'm
> > doing this on a bootable usb key.
> > 
> > In any case, a colleague mentioned there was an easier way using the
> > available packages in the Ubuntu repositories, i.e. the
> > xenomai-runtime and associated packages.  It was implied that with a
> > straight-forward 'aptitude install xenomai-runtime' and voila I have
> > a RTOS ready to use.   Given the descriptions of these packages (and
> > no mention of patching of the kernel for example), I don't think that
> > this is their purpose, particularly when I tried downloading the
> > xenomai examples where the second step is :
> > 
> > make XENO=<xenomai-installation-path> KSRC=<xenomai-kernel-source>
> > 
> > Could someone confirm (or refute) this suspicion (that the packages
> > do not provide access to a RTOS) and perhaps explain the intended use
> > of the xenomai packages available on the ubuntu repositories - I've
> > not seen any detailed reference as to why one would download and
> > install these packages (say, in addition to having already gone
> > through the long process of kernel patching + compilation + user
> > space setup).
> > 
> > Thanks for any assistance, Charles
> 
> See:
> http://www.xenomai.org/index.php/Building_Debian_packages
> 
> Please pay attention to the version of the packages available on Ubuntu.
> As far as I understood, they are outdated, so, you would probably better
> use the Debian package and install them on Ubuntu.
> 

-- 
Philippe.



