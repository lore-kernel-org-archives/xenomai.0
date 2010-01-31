From: lux-integ <lux-integ@domain.hid>
Date: Sun, 31 Jan 2010 14:26:08 +0000
References: <201001292104.42395.lux-integ@domain.hid>
	<4B657977.6050906@domain.hid>
	<1264944150.16492.72.camel@domain.hid>
In-Reply-To: <1264944150.16492.72.camel@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <201001311426.09046.lux-integ@domain.hid>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] help with xenomai-2.5.0 on pure64bit linux x86_64
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Sunday 31 January 2010 01:22:30 pm Philippe Gerum wrote:
> This is likely our old friend CONFIG_SPARSE_IRQ which is at work. Just
> disable this, until we have introduced the required changes to support
> more than 1024 IRQs.
>
> > [ BTW, if you plan to use some PCI device with DMA under Xenomai,
> > enabling IOMMU is not a good idea. Reprogramming the IOMMU will then
> > become part of the critical path, but that code is not prepared for
> > real-time use. Better disable it during the build or on boot-up. ]

II did all of this   to .config
CONFIG_HPET_TIMER=n
CONFIG_HPET_EMULATE_RTC=n
CONFIG_SPARSE_IRQ=n

and the kernel compiled OK  unfortunately  on booting it   reported 
Kernel Panic - not syncing: VFS: Unable to mount root.....
[ 3.111473 ] Pid: 1, comm: swapper Not tainted 2.6.32.2Xen25F .... then a 
trace.

I had the same response when I disabled the IOMMU stuff

( I suspect this could be  absence  of SATA support though I think I have  
SATA enabled).   Seems  I will have to fiddle a little more with the kernel 
config.

thanks for all your help.

lux-integ

