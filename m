From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1241099322.26544.146.camel@domain.hid>
References: <1240512954.9151.13.camel@domain.hid>
	<1241099322.26544.146.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 30 Apr 2009 15:57:22 +0200
Message-Id: <1241099842.26544.147.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mem mapped i/o in RTDM driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jeff angielski <jeff@domain.hid>
Cc: Xenomai-help@domain.hid

On Thu, 2009-04-30 at 15:48 +0200, Philippe Gerum wrote:
> On Thu, 2009-04-23 at 14:55 -0400, jeff angielski wrote:
> > A basic RTDM question:
> > 
> > In a normal Linux device driver you typically use request_mem_region()
> > and ioremap_nocache() to setup access to some memory mapped i/o.  Then
> > you just iowrite()/ioread() to/from that address.
> 
> Btw, maybe readb/w/l() and writeb/w/l() are more appropriate since
> ioread/write is a legacy interface?

i.e. in MMIO mode.

> 
> > 
> > Do I still do this for the XXXXX_nrt operations in my RTDM driver?
> > 
> > How about for the XXXX_rt operations?  
> > 
> > I do see that gpioirqbench uses the Linux memory management indirectly
> > since it relies on the OF mpc52xx_find_and_map("mpc5200-gpio") but
> > because the driver supports both Linux and RTDM, the requirements are
> > not clear.
> > 
> > Thanks.
> > 
> > 
-- 
Philippe.



