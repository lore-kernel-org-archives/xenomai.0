Message-ID: <2ff1a98a0707160128h37312a6and595d0b9a92312c1@domain.hid>
Date: Mon, 16 Jul 2007 10:28:29 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2862c2c80707160043w581aa4c5i20c2c7de1e0e2412@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2862c2c80707152040v1cc27cb2kc33f1cbf21932cba@domain.hid>
	<18075.3438.734938.482223@domain.hid>
	<2862c2c80707160043w581aa4c5i20c2c7de1e0e2412@domain.hid>
Subject: Re: [Xenomai-help] Enable I-PIPE - kernel boot hangs in the
	AT91RM9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

On 7/16/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> On 7/16/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > Yeoh Chun Yeow wrote:
> > > > Dear all,
> > > >
> > > > I have applied the
> adeos-ipipe-2.6.20-arm-1.7.03.patch for kernel
> 2.6.20(patches with
> > > > 2.6.20-at91.patch) on my AT91RM9200 board from kwikbyte.
> >
> > this patch is booting fine here on an AT91RM9200 board, booting with
> > NFS. But I had similar problems when enabling the I-pipe tracer, so be
> > sure that the tracer is disabled. Also, could you try without the
> > 2.6.20-at91 patch ? If it still does not boot without the I-pipe tracer
> > and without the 2.6.20-at91 patch, please send us your .config.
>
> Dear Gilles,
>
> I have recompiled the kernel either with or without the 2.6.20-at91 patch,
> but the result remains the same. But this time with more kernel log
> messages:
>
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> eth0: Link now 100-FullDuplex
> eth0: Link now 100-FullDuplex
> IP-Config: Guessing netmask 255.255.0.0
> IP-Config: Complete:
>       device=eth0, addr= 172.16.6.203, mask=255.255.0.0, gw=255.255.255.255,
>      host=172.16.6.203, domain=, nis-domain=(none),
>      bootserver= 255.255.255.255, rootserver=172.16.6.174, rootpath=
> Looking up port of RPC 100003/2 on 172.16.6.174
> Looking up port of RPC 100005/1 on 172.16.6.174
> VFS: Mounted root (nfs filesystem).
> Freeing init memory: 104K
> -- HANG
>
> Attach my config file. I check the 2.6.20-at91 patch and found out that it
> is simply adding USB gadget support and SPI device.

Thanks for the .config, could you also send us the full logs ?

>
> Is that possible that the interrupts overflow? My master clock frequency is
> 60MHz. How to determine the delay in __ipipe_mach_set_dev?

I-pipe uses an AT91 timer counter, with a frequency which is a sub-multiple of
the master clock frequency. The timer frequency is deduced from the master
clock frequency in include/asm-arm/arch-at91rm9200/timex.h

Please, avoid dropping the mailing list from the CC.

-- 
                                               Gilles Chanteperdrix

