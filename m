From: Vikesh Rambaran <vikesh.rambaran@domain.hid>
In-Reply-To: <37f89760903310217o29fe3435j286d5fa10dd6aa82@domain.hid>
References: <37f89760903310217o29fe3435j286d5fa10dd6aa82@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 31 Mar 2009 11:37:17 +0200
Message-Id: <1238492237.9965.40.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] Test xen_16500A.ko on different serial port
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marcel Soulot <msoulot@domain.hid>
Cc: xenomai@xenomai.org

Hi
On Tue, 2009-03-31 at 11:17 +0200, Marcel Soulot wrote:
> Hi 
> 
> I start with xenomai so I patch the kernel 2.6.26.7 with the version
> 2.4.6.
> 
> So I try to test the xeno_16550A.ko driver generated instead of the
> standard 16550A on serial port ttyS0 ioaddr=0x3f8 irq=4 (standard one)
> and also on serial port in PCI card ttyS6 ioaddr=0xe0000400 irq=10.
> 
> I used the following command to substitute the 16550A driver used by
> the xeno_16550A.ko:
> 
> > setserial /dev/ttyS0 uart none
> > insmod ./xeno_16550.ko ioaddr=0x3f8 irq=4
> 
> I got the error message : 
> 
> xeno_16550A: Unkonwn parameter 'ioaddr'
> insmod: error inserting './xeno_16550A.ko': -1 Unknown symbol in
> module
> 

Instead of 'ioaddr', try 'io' (without the apostrophes)

> and I got the same thing with the other port.
> 
> Can you explain me how I can load correctly the xeno_16550A.ko
> 
> Thanks for your help.
> 
> Marcel.

Thanx
Vicki

> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help



