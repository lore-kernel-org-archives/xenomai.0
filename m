From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Thu, 6 Dec 2007 07:24:16 +0100
References: <200712050741.16685.niklaus.giger@domain.hid>
	<475656F0.6010603@domain.hid>
In-Reply-To: <475656F0.6010603@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712060724.16600.niklaus.giger@domain.hid>
Subject: Re: [Xenomai-help] Problems running xenomai on Yosemite PPC440 board
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Am Mittwoch, 5. Dezember 2007 schrieb Wolfgang Grandegger:
> Hi Niklaus,
> 
> Niklaus Giger wrote:
> > Hi
> > 
> > I built a xenomai kernel and the xenomai tools using a checkout of the trunk 
> > like this
> > cd /home/hcu/celsius/linux-2.6-xenomai
> > /home/hcu/celsius/xenomai-trunk/scripts/prepare-kernel.sh --linux=/home/hcu/celsius/linux-2.6-xenomai --adeos=/home/hcu/celsius/xenomai-trunk/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.23-ppc-1.6-00.patch --arch=ppc
> > make  ARCH=ppc CROSS_COMPILE=ppc_4xx- 
> > O=/home/hcu/celsius/build-linux-yosemite-ppc-DENX-v2.6.23.1 
> > yosemite_defconfig
> > make  ARCH=ppc CROSS_COMPILE=ppc_4xx-
> 
> CROSS_COMPILE=ppc_4xxFP- !?
Thanks for pointing out this trivial mistake. This fixed the problems
about bad latency output.

Best regards

Niklaus

