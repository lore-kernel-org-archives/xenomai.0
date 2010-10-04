Date: Mon, 04 Oct 2010 12:21:09 -0400
From: Edward Hoffman <quantalgo@domain.hid>
In-reply-to: <AANLkTimZM3QJqxY0wmBf0LAdn4PCaA6t+UgbFCjm7hAw@domain.hid>
Message-id: <1286209269.5812.8.camel@domain.hid>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <AANLkTimZM3QJqxY0wmBf0LAdn4PCaA6t+UgbFCjm7hAw@domain.hid>
Subject: Re: [Xenomai-help] XENOMAI in Embedded Linux vs Ubuntu
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Warner <xenomai.start@domain.hid>
Cc: xenomai@xenomai.org

Peter,

The best system is the one that provides the most flexibility and
control.  Xenomai can be built on a number of both proprietary and GPL
licensed distributions.  I find that the that the best approach is to
use a GPL licensed version like Ubuntu, download the Linux Kernel source
from www.kernel.org and build and install Xenomai into your custom
kernel.  With this you have the freedom to reduce the size of the kernel
to the minimum for your needs.

Best Regards,

Ed

On Mon, 2010-10-04 at 21:18 +0530, Peter Warner wrote:
> Dear  Xenomai Users,
>  
> I have one question, can any of you suggets me the answer.
>  
> I have Instaled Xenomai Sucessfully in my system the detail of my
> System is as mentioned below:
>  
> processor: core2duo.
> Operating System: Ubuntu 10.4
>  
> After the installation I have checked the examples programmes I ran
> and modified it and i found it is running fine I am getting
> deterministic result here for the tasks. Now from one of the resource
> I came to know that one of the very much popular Embedded Linux called
> MontaVista Linux is also Patched with the xenomai to achive the hard
> real-time requirement.
>  
> Now I had a doubt what is the advantage of Using MontaVista or any
> Embedded Linux over Ubuntu as both the System is having xenomai layer
> and we can achive the realtime performance in ubuntu right which is a
> freeware o the other hand Montavista is Lisenced one.
>  
> So my question is which one is more better either an Embedded Linux
> patched with xenomai or ubuntu or desktop Linux with Xenomai.
>  
>  
> Thnaks to all.
>  
> Regards,
> Peter
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help



