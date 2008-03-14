Message-ID: <47DA842E.3070305@domain.hid>
Date: Fri, 14 Mar 2008 14:57:02 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47DA7CCD.40901@domain.hid>
In-Reply-To: <47DA7CCD.40901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Moving from 2.6.14(ppc) to 2.6.20(powerpc):
 illicit calls detected by ipipe
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Johan Borkhuis wrote:
> Hello,
> 
> I am trying to move from 2.6.14(ppc) to 2.6.20(powerpc). On ppc I am 
> using Xenomai 2.4.1 and I-Pipe version 1.5-03, on powerpc I am using 
> Xenomai 2.4.1, I-Pipe version 1.7-12.
> Most of the system is working, but I am having some problems with one 
> device driver. This is a "standard" Linux driver, that I converted into 
> a Xenomai driver. This driver does a very limited initialization, the 
> main init is done when the device is opened and after some IOCTL calls.
> 
> The problem is that I am getting "Detected illicit call from domain 
> 'Xenomai' into a service reserved for domain 'Linux' and below." 
> messages from Adeos, which I did not get when using 2.6.14. The code I 
> use is identical, except for some small areas where the API kernel 
> changed between 2.6.14 and 2.6.20. Has there been a change between the 
> versions of Adeos or Xenomai which could cause this change in behavior?
> (BTW: this message is generated when the option IPIPE_DEBUG_CONTEXT is 
> on, when this option is off I get a kernel Oops in kernel/ipipe/core.c:210.
> 
> The affected calls are calls like kmalloc and kfree, but also calls like 
> check_mem_region, which uses kmem_cache_zalloc inside the function. 
> Normally these should not be used inside a RT application, but this is 
> the startup phase of the application and there are no RT restraints at 
> this point.
>

2.6.14 did not provide any invalid call context detection, so the fact that you
start getting those with 2.6.20 is just the sign that your driver had a problem
since 2.6.14, but they went unnoticed so far.

You may want to send the stack backtrace dumped by the detector, so that we
could clearly identify what the calling context is.

> Kind regards,
>     Johan Borkhuis
> 


-- 
Philippe.

