MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18204.64448.275579.386964@domain.hid>
Date: Mon, 22 Oct 2007 21:36:32 +0200
In-Reply-To: <200710221653.l9MGrFEt012760@domain.hid>
References: <200710221653.l9MGrFEt012760@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Xenomai on Xscale (Linux 2.6.20)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

Patrick wrote:
 > Please ignore my first wrong mail ;-)
 > 
 >  
 > 
 > Hi,
 > 
 >  
 > 
 > I am trying to found the bug in xenomai for PXA270 machine (xenomai 2.3.4,
 > ipipe 1.7-06 and kernel 2.6.20).
 > 
 >  
 > 
 > I have localised that the problem is coming when rt_task_create call
 > __ipipe_restore_pipeline_head (called by xnlock_put_irq_restore) in
 > ipipe/core.c.
 > 
 > I think that the problem is the call to __clear_bit(IPIPE_STALL_FLAG,
 > &head->cpudata[cpuid].status); 
 > 
 > If I don't execute this function on the rt_task_create the system doesn't
 > freeze (but my application doesn't work correctly).

This point (xnlock_put_irqrestore in rt_task_create) is the point where
the escalation virq is handled in Xenomai domain and xnpod_schedule
switches to the new task. So, by not clearing the stall bit, you prevent
this virq from being handled. What comes after xnlock_put_irqrestore
should be xnpod_schedule_handler in pod.c.

-- 


					    Gilles Chanteperdrix.

