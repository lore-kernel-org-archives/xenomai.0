Message-ID: <4222CE51.4060808@domain.hid>
Date: Mon, 28 Feb 2005 08:54:57 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Porting question (PPC64)
References: <0D21CBD1298D2C4790E2F2B86D96EC19380269@domain.hid>
In-Reply-To: <0D21CBD1298D2C4790E2F2B86D96EC19380269@domain.hid>
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
Cc: adeos-main@gna.org

Reynolds, Terry (Contractor-SIMTECH) wrote:
> Hello all,
>  
> I've fixed my data alignment problems, and the __adeos_init_domain function seems to have the stack set up properly for the new domain.  The next event is a switch_domain from the root domain to the new one.  This still fails.  On printing out the inputs, the root domain's stack isn't setup.  The items loaded in the initial call to __adeos_init are OK, but the stack pointer adp->esp[cpuid] is null, as is the m_link structure member.
>  
> It looks like the root domain has never been suspended prior to the real-time domain being registered.  When should the root domain's esp's pointed at stack been created / initialized?  That isn't happening in the __adeos_init function.

There is no need to init esp for root, since the Linux stack pre-exists, 
and the first switch could only occur after the first non-root domain 
has been created. Since you always switch from root to non-root for the 
first time, root's esp[] is initially saved but not read; it is only 
read when switching back to it.

m_mutex is not related; it's a link into the inter-domain mutex pending 
queue. Having it NULL at startup is thus sane.

>  
> Thanks for any help!
>  
>  
> Terry
> 
> ________________________________
> 
> From: Reynolds, Terry (Contractor-SIMTECH)
> Sent: Wed 2/23/2005 6:44 PM
> To: adeos-main@gna.org
> Subject: RE: [Adeos-main] Porting question
> 
> 
> I've been looking at the __adeos_init_domain function with printk statements.   It looks like the ppc64's 64 bits
> for unsigned long's have hosed up the positions of the structure elements.  The adp->m_link and adp->flags
> both come back as zero from the call to the init_domain function.  They were non-zero in the function. I'll have
> to re-compute the relative addresses for the structure elements.
>  
> Thanks,
>  
> Terry
>  
> 
> ________________________________
> 
> From: adeos-main-admin@domain.hid on behalf of Philippe Gerum
> Sent: Wed 2/23/2005 12:32 PM
> To: Reynolds, Terry (Contractor-SIMTECH)
> Cc: adeos
> Subject: Re: [Adeos-main] Porting question
> 
> 
> 
> Reynolds, Terry (Contractor-SIMTECH) wrote:
> 
>>My apologies for being vague!  I'd never looked at the 2.4 tree & didn't know there was a ppc port there, I'm working on a ppc64, 2.6 port.
>>
>>I have a newfound appreciation for everyone porting ppc drivers to ppc64, the differences are huge.
>>
>>My specific problem is in using the RTAI sample test (latency), via the adeos/generic.c implementation.   In adeos_register_domain, when the root domain (linux) calls the adeos_switch_to function, the link register value stored for the RTAI_hal domain isn't set up properly to return to the register_domain function.
>>
>>At least I assume that's what's happening, since my system crashes in the adeos_switch_domain function, or in returning from there.
>>
>>This would be much easier to work on if there was a kdb available for ppc64!  Printk statements, with the kernel crashing every time I run the program is very time consuming.
>>
>>My question is: in the process of registering a domain, when does it's stack get setup so that a call to switch domain will pull up the correct value to place in the link register so that the switch function will know where to return to?
>>
>>
> 
> 
> __adeos_init_domain(). Really. Excerpt:
> 
>         ksp[19] = (_cpuid == cpuid); /* r3 */
>         ksp[25] = (unsigned long)attr->entry; /* lr <====== */
>         ksp[26] = flags & ~MSR_EE; /* msr */
> 
> 
> PS: please ask your mail client to wrap lines. (My 2700 inches CRT does
> not fit on my office desk...)
> 
> 
>>Thanks,
>>
>>
>>Terry
>>
>>_______________________________________________
>>Adeos-main mailing list
>>Adeos-main@domain.hid
>>https://mail.gna.org/listinfo/adeos-main
> 
> 
> 
> --
> 
> Philippe.
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
> 
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 

Philippe.

