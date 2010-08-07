Message-ID: <4C5D0F40.1070104@domain.hid>
Date: Sat, 07 Aug 2010 09:46:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=yDXty82va8JGzmRA453e021EvomyYitaQTCTg@domain.hid>
In-Reply-To: <AANLkTi=yDXty82va8JGzmRA453e021EvomyYitaQTCTg@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
Cc: xenomai@xenomai.org

Guenter Ebermann wrote:
> Hi,
> 
> At the moment I am thinking about a possible migration of a automotive bus
> measuring/simulation application and some drivers from eCos to Linux/Xenomai.
> The move is primarily motivated by the huge software and device driver support
> under linux.
> 
> However some device drivers which interfaces our custom devices in FPGA must be
> ported to linux or xenomai user-space or xenomai-rtdm.
> 
> But I dont want to write device drivers in kernel-space, because this would
> involve some serious restructuring of our current drivers and software
> structure and a possible performance penalty because of unneeded data copying.
> It is also harder to debug a kernel-driver. In eCos there is no
> user/kernel space
> seperation and our custom device drivers access the registers based in FPGA
> directly. The interface of these drivers to the application is not via a device
> file but over direct function invocation.
> 
> So I thought of moving this part of our communication stack which has hard-real
> time requirement (FlexRay, CAN, LIN) into a seperate process which only lives
> in the xenomai domain (it will communicate with low-prio linux processes via
> non-blocking fifo or such). But this raises two important questions: Can I
> access the FPGA registers directly from a xenomai task in the user space?  Or
> do I have to write a minimal linux or xenomai-rtdm device driver which maps
> FPGA registers from kernel to user space?

You can access hardware registers in user-space by mmaping the memory
mapped ones with /dev/mem, or using iopl/ioperm and in[lwb]/out[lwb] for
the old x86 I/O registers.

However, if this can help for a first order port to Xenomai,
implementing an RTDM driver later is better on the long run. By limiting
the interface between the application and low-level code to a well
defined interface, it will make it possible to use different
applications with the same drivers, or use different hardware with the
same application at will, things that are often hard when the low-level
code is mixed with the application code.

And you could even get the drivers you develop merged into Xenomai, if
you are willing to publish them.

-- 
					    Gilles.

