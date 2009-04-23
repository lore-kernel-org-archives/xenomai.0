From: jeff angielski <jeff@domain.hid>
Content-Type: text/plain
Date: Thu, 23 Apr 2009 14:55:54 -0400
Message-Id: <1240512954.9151.13.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Mem mapped i/o in RTDM driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

A basic RTDM question:

In a normal Linux device driver you typically use request_mem_region()
and ioremap_nocache() to setup access to some memory mapped i/o.  Then
you just iowrite()/ioread() to/from that address.

Do I still do this for the XXXXX_nrt operations in my RTDM driver?

How about for the XXXX_rt operations?  

I do see that gpioirqbench uses the Linux memory management indirectly
since it relies on the OF mpc52xx_find_and_map("mpc5200-gpio") but
because the driver supports both Linux and RTDM, the requirements are
not clear.

Thanks.


-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com



