Message-ID: <421CCC55.1010109@domain.hid>
Date: Wed, 23 Feb 2005 19:32:53 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Porting question
References: <0D21CBD1298D2C4790E2F2B86D96EC19380259@domain.hid>
In-Reply-To: <0D21CBD1298D2C4790E2F2B86D96EC19380259@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: "Reynolds, Terry (Contractor-SIMTECH)" <terry.reynolds2@domain.hid>
Cc: adeos <adeos-main@gna.org>

Reynolds, Terry (Contractor-SIMTECH) wrote:
> My apologies for being vague!  I'd never looked at the 2.4 tree & didn't know there was a ppc port there, I'm working on a ppc64, 2.6 port.
>  
> I have a newfound appreciation for everyone porting ppc drivers to ppc64, the differences are huge.
>  
> My specific problem is in using the RTAI sample test (latency), via the adeos/generic.c implementation.   In adeos_register_domain, when the root domain (linux) calls the adeos_switch_to function, the link register value stored for the RTAI_hal domain isn't set up properly to return to the register_domain function.
>  
> At least I assume that's what's happening, since my system crashes in the adeos_switch_domain function, or in returning from there.
>  
> This would be much easier to work on if there was a kdb available for ppc64!  Printk statements, with the kernel crashing every time I run the program is very time consuming.
>  
> My question is: in the process of registering a domain, when does it's stack get setup so that a call to switch domain will pull up the correct value to place in the link register so that the switch function will know where to return to?
>  
>  

__adeos_init_domain(). Really. Excerpt:

	ksp[19] = (_cpuid == cpuid); /* r3 */
	ksp[25] = (unsigned long)attr->entry; /* lr <====== */
	ksp[26] = flags & ~MSR_EE; /* msr */


PS: please ask your mail client to wrap lines. (My 2700 inches CRT does 
not fit on my office desk...)

> Thanks,
>  
>  
> Terry
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 

Philippe.

