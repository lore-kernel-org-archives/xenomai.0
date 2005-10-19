Message-ID: <43564CC4.4070901@domain.hid>
Date: Wed, 19 Oct 2005 15:40:20 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] newbie questions
References: <489ecd0c0510182024s4fd894bavdf070cec603d8000@domain.hid>
In-Reply-To: <489ecd0c0510182024s4fd894bavdf070cec603d8000@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Luke Yang <luke.adi@domain.hid>
Cc: adeos-main@gna.org

Luke Yang wrote:
> Hi,
> 
>    I am an adeos newbie from ADI's blackfin team. I overviewed some
> papers/code from adeos. Now I have some questions:
>
>   1. Is there any guide/getting-started document on how to start an
> example of running 2 OS on adeos in an x86/arm?
>

Actually, the papers are quite misleading since they present a full 
virtualization system aimed at running possibly complex OSes side-by-side, and 
specifically Linux, but what has been implemented is only the basic mechanism 
needed to create a real-time enabling layer for Linux.

However, the interrupt pipeline described has been fully implemented (without 
the x86-specific hackery described) and extended to syscall and exception 
propagation.

We use it to run real-time extensions side-by-side with the vanilla Linux 
kernel, such as Xenomai (http://www.xenomai.org) and RTAI (http://www.rtai.org).

>    2. Besides Linux as root domain os and adeos started as a module in
> Linux, how is the other OS started? also as a module in root Linux?
> 

Typically, yes. As the root domain, Linux provides the means to load new 
domains, which in turn usually come as loadable modules.

>    3. Which RTOSes have been ported to run on adeos? I saw some
> documents about porting RTAI to adeos.

RTAI 3.0 and 3.1 can run over vanilla Adeos, respectively side-by-side with 
Linux 2.4 and 2.6. Xenomai, which continues the former RTAI/fusion effort 
independently from the RTAI project is fully based on Adeos.

  How about others?

Others are likely "under the surface", or contributions I don't know of.

  Is there any
> RTOS running on ARM adeos?
> 

RTAI 3.2 has an ARM port running over a real-time enabler which has been derived 
from the vanilla Adeos implementation to fit their specific needs, but I don't 
know the status of this port. Xenomai is currently being ported to ARM (the 
initial target is an Integrator CP featuring an ARM11 core), the vanilla Adeos 
patch for ARM the Xenomai port we will based on is going to be released by 
mid-November at the latest.

>   Thank you in advance!
> 
> Regards,
> Luke Yang
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
> 


-- 

Philippe.

