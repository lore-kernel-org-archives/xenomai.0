Message-ID: <422DE6F2.30300@domain.hid>
Date: Tue, 08 Mar 2005 18:54:58 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] ppc64 switch_domain problem
References: <0D21CBD1298D2C4790E2F2B86D96EC19380271@domain.hid>
In-Reply-To: <0D21CBD1298D2C4790E2F2B86D96EC19380271@domain.hid>
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
> Hi All,
>  
> Are there any ppc64 gurus lurking out there?  My port to ppc64 has a severe problem.  When attempting to register a new domain, as in the RTAI testsuite's latency example, the switch to the new domain fails on the branch to rthal_domain_entry.  It suffers an "unrecoverable FP unavailable exception 800 at 0xd0000..." which is the location of the attr.entry for the link to that function.
>  
> The code has no floating point code in it, so it must be pulling up some garbage instruction that isn't actually at that location.  I made a new function rthal_domain_entry2 which is included in the kernel, it's in the same file as the __adeos_init_domain function (/adeos/ppc64.c for my port).  It's address is a kernel code 'like' 0xc0000...  The switch domain to that function works fine!
>  
> I think the branch to lr works for the kernel address, but not the loaded module one because of some problem with the SLB.  The ppc64 _switch function does modify the memory management hardware if the ESID is different for the task being switched to.
>  
> Anyone have an idea on how to correct this problem?
>  

Since it switches stacks, __adeos_switch_domain() should probably be 
updated to switch the SLB appropriately then.

>  
> TIA!
>  
> Terry Reynolds.
>  
>  
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 

Philippe.

