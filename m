From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20091104111536.GA14614@domain.hid>
References: <20091103133407.GA9836@domain.hid>
	<1257259464.2210.32.camel@domain.hid>
	<20091104055659.GA5280@domain.hid>
	<1257328464.2210.66.camel@domain.hid>
	<20091104111536.GA14614@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Nov 2009 12:26:45 +0100
Message-ID: <1257334005.2210.86.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai core] Freeze on MPC8572 and P2020 with
	SMP
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2009-11-04 at 12:15 +0100, Richard Cochran wrote:
> On Wed, Nov 04, 2009 at 10:54:24AM +0100, Philippe Gerum wrote:
> > 
> > The issue is more likely in the interrupt pipeline. When Xenomai is
> > compiled as modules, does the system lock up when loading the nucleus,
> 
> Yes.
> 
> I looked at this problem using my shiny new BDI3000.
> 
> mpcl8572>select 0
>     Target CPU        : MPC8572 Core#0
>     Core state        : halted
>     Debug entry cause : COP halt
>     Current PC        : 0xc000aae4
>     Current CR        : 0x44044022
>     Current MSR       : 0x00021000
>     Current LR        : 0xc000aabc
>     Current CCSRBAR   : 0x0_ffe00000
> 
> mpc8572>select 1
>     Target CPU        : MPC8572 Core#1
>     Core state        : halted
>     Debug entry cause : COP halt
>     Current PC        : 0xc006db38
>     Current CR        : 0x22000022
>     Current MSR       : 0x00021000
>     Current LR        : 0xc006ed10
>     Current CCSRBAR   : 0x0_ffe00000
> 
> System.map:
> 
> c000a794 T __ipipe_send_ipi
> c000a968 T ipipe_critical_enter
> c000ab50 T __ipipe_enable_pipeline
> 
> c006da60 T ipipe_release_tickdev
> c006daf8 T __ipipe_check_percpu_access
> c006dbf4 T __ipipe_set_irq_pending
> 
> So, were stuck in ipipe_critical_enter() and __ipipe_check_percpu_access().
> 

Ok, this is a porting issue. The critical IPI (IPIPE_CRITICAL_IPI) does
not seem to be properly handled on this platform.

> I'll try and pull this apart some more...
> 

> Richard
> 


-- 
Philippe.



