Message-ID: <000601c5996c$36b29c80$6101a8c0@domain.hid>
From: "Terry" <terryac4@domain.hid>
Date: Thu, 4 Aug 2005 22:17:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] SMP for ppc64
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

I'm looking at adding SMP support for 2.6.10 kernel on a ppc64.  I'm having 
trouble scratching my way through the mpic version of using IPI's to trigger 
interrupts on the other cpu's.  In the Intel ports, an irq is assigned to 
(ADEOS_CRITICAL_VECTOR) to act as the critical sync isr, and an IPI is sent 
to "allbutself" to trigger it.  I need some advice on the best approach to 
do this on a ppc64.

I see two options to handle this one.

The first option is to use smp_call_function (or a similar adeos version) to 
send the IPI to the other cpu.  The version in smp.c says : "You must not 
call this function with disabled interrupts or from a hardware interrupt 
context or from a bottom half handler".  It looks as if I'd be doing just 
that, as the critical_enter function first does a local_irq_save_hw(flags) 
before calling the send_ipi.   So I'd need a new version of one or the other 
to prevent deadlocks.

The other option is to create a virq for the ADEOS_CRITICAL_VECTOR, and map 
that to the one unused IPI ( mpic has 4 IPI's one of which is currently 
unused).  That doesn't seem like a good plan, as ppc64 linux may decide to 
start using that one some day.

Anyone have any suggestions, or can explain how I misunderstood all of the 
above?


Thanks in advance!

Terry 



