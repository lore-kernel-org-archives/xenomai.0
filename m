Message-ID: <4C5C83E5.9040508@domain.hid>
Date: Fri, 06 Aug 2010 14:51:33 -0700
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <AANLkTi=yDXty82va8JGzmRA453e021EvomyYitaQTCTg@domain.hid>
In-Reply-To: <AANLkTi=yDXty82va8JGzmRA453e021EvomyYitaQTCTg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] migration scenario to xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guenter Ebermann <guenter.ebermann@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> So I thought of moving this part of our communication stack which has hard-real
> time requirement (FlexRay, CAN, LIN) into a seperate process which only lives
> in the xenomai domain (it will communicate with low-prio linux processes via
> non-blocking fifo or such). But this raises two important questions: Can I
> access the FPGA registers directly from a xenomai task in the user space?  Or
> do I have to write a minimal linux or xenomai-rtdm device driver which maps
> FPGA registers from kernel to user space?

You can do direct register access from userland; we do this with several 
device drivers in our system.

We are thinking about trying to refactor a driver to use RTDM due to the 
recent discussions on losing support for userland interrupt handling, 
but for our purposes the current support for interrupts in userland has 
worked fine.

We use pci_scan_bus() and friends for finding the device, and mmap to 
get it into userland memory.

hth

                         - Tom

