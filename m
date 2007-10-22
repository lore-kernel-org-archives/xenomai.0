Message-ID: <471CD8DD.2050601@domain.hid>
Date: Mon, 22 Oct 2007 19:07:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200710221653.l9MGrFEt012760@domain.hid>
In-Reply-To: <200710221653.l9MGrFEt012760@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

Is it the operation itself or the effect on cpudata.status? I mean, can
you safely do a __clear_bit followed by a __set_bit, which would rule
out an invalid memory access?

> 
> If I don't execute this function on the rt_task_create the system doesn't
> freeze (but my application doesn't work correctly).
> 
>  
> 
> I don't know what the problem is. Do you have an idea or a suggestion?

At least /me is lacking a full picture. So I would suggest, in order to
ease the understanding of your scenario for everyone, to

 a) post your modification in form of a patch (diff -up).
 b) catch the problematic execution path with the ipipe tracer - now
    that it no longer fails lethally. Just put an ipipe_trace_freeze at
    a point that is unique and close to the hot spot (e.g. after
    rt_task_create.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

