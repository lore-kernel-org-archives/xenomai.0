From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 8 Dec 2007 18:29:34 +0100
References: <200712072347.07847.niklaus.giger@domain.hid>
	<200712081651.09378.niklaus.giger@domain.hid>
	<475AC9D9.5080005@domain.hid>
In-Reply-To: <475AC9D9.5080005@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712081829.35063.niklaus.giger@domain.hid>
Subject: Re: [Xenomai-help] Are these results running the xeno-test on a
	Sequoia board okay?
Reply-To: niklaus.giger@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Am Samstag, 8. Dezember 2007 schrieb Philippe Gerum:
> Niklaus Giger wrote:
> > Am Samstag, 8. Dezember 2007 schrieb Philippe Gerum:
> >> Niklaus Giger wrote:
> >>> Hi
> > <...> 
> >> I built it like this using the DENX-kernel
> >>> cd /home/hcu/celsius/linux-2.6-xenomai
> >>> /home/hcu/celsius/xenomai-trunk/scripts/prepare-kernel.sh --linux=/home/hcu/celsius/linux-2.6-xenomai --adeos=/home/hcu/celsius/xenomai-trunk/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.23-powerpc-DENX-2.0-03.patch --arch=powerpc
> >> You need to use adeos-ipipe-2.6.23-ppc-1.6-00.patch for the sequoia
> >> since it still depends on the ppc/ tree, on top of DENX-v2.6.23.8.
> >> Passing --arch=ppc to prepare-kernel.sh instead of --arch=powerpc
> >> without specifying an Adeos patch would pre-select the right one.
> > 
> > However the kernel built this way (based on the git hash given in the
> > patches/README) my sequoia board just hangs after
> 
> Mm, entering the twilight zone? Here is the configuration which works here:
> 
> CPU:   AMCC PowerPC 440EPx Rev. A at 528 MHz (PLB=132, OPB=66, EBC=66 MHz)
> ...
> Board: Sequoia - AMCC PPC440EPx Evaluation Board, Rev. F, PCI=66 MHz
> 
> $ type ppc_4xxFP-gcc
> ppc_4xxFP-gcc is /opt/eldk-4.1/usr/bin/ppc_4xxFP-gcc
> (works with 4.0 and latest the same way).
> 
> From a cloned Denx's GIT baseline:
> $ git checkout -b sequoia 208aa3df8645608ff3febb65f83219173dfe4979
> $ ~/xenomai-trunk/scripts/prepare-kernel.sh --arch=ppc --linux=.
> ... accept the default suggestion, i.e. adeos-ipipe-2.6.23-ppc-1.6-00
> $ make ARCH=ppc CROSS_COMPILE=ppc_4xxFP-gcc sequoia_defconfig
> ... use all default Xenomai options
> $ make ARCH=ppc CROSS_COMPILE=ppc_4xxFP-gcc [uImage]
> 
Pretty the same here.

Which U-Boot version do you use? 
Here: U-Boot 1.3.0 (Nov 27 2007 - 08:49:04)

Thanks in advance.

-- 
Niklaus Giger

