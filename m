Message-ID: <485943D0.2000506@domain.hid>
Date: Wed, 18 Jun 2008 19:20:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4856B7AE.9030805@domain.hid> <4857682B.8060900@domain.hid>
	<4857BBCD.6020902@domain.hid> <48593525.2040103@domain.hid>
	<48594232.5020505@domain.hid>
In-Reply-To: <48594232.5020505@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Compile-time bug,
	and problem with PPC440 ethernet
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

Steven A. Falco wrote:
> 
>>> I am using the patch that came with Xenomai 2.4.4, namely:
>>> adeos-ipipe-2.6.25-powerpc-DENX-2.2-02.patch
>>>
>>>     
>>
>> I can't reproduce this issue on a 440EP board, but I still have to to put my
>> hands on a 440EPX to check this. However, both should be using the common 44x
>> PIC support, so I don't expect big changes here.
>>
>> Are you using the powerpc/ branch, or legacy ppc/ one for building the sequoia
>> kernel?
>>   
> 
> ARCH=powerpc.

Ah. So it's the UIC support that likely breaks. Could you try this patch?

diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index dd40f64..4eff1ab 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -111,7 +111,6 @@ static void uic_mask_ack_irq(unsigned int virq)

 	sr = 1 << (31-src);
 	spin_lock_irqsave(&uic->lock, flags);
-	ipipe_irq_lock(virq);
 	er = mfdcr(uic->dcrbase + UIC_ER);
 	er &= ~sr;
 	mtdcr(uic->dcrbase + UIC_ER, er);

In case it is not enough, try removing all the ipipe_irq_lock/unlock calls from
arch/powerpc/sysdev/uic.c. If that works eventually, I'll sort the mess out later.

  I started with the DENX-v2.6.25-stable branch from the
> DENX linux-2.6-denx git tree, then applied Xenomai-2.4.4 using its
> install script.  The toolchain is eldk-4.2 for ppc_4xxFP.
> 
> Is there some debugging I can turn on to help you track this down?  I
> can also add additional printk statements.
> 
> In a case of "bad timing", I will be going on vacation tomorrow, so I
> will do what I can to gather more data today.  Otherwise, I'll have to
> pick this up next Thursday (26th). :-(
> 
>     Thanks,
>     Steve
> 


-- 
Philippe.

