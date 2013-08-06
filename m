From: Henry Bausley <hbausley@deltatau.com>
In-Reply-To: <5200B433.9000604@xenomai.org>
References: <1375743903.7948.33.camel@lx-henry> <5200B433.9000604@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Aug 2013 16:08:53 -0700
Message-ID: <1375830533.7948.40.camel@lx-henry>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Using a PowerPC Critical Interrupt Input alongside
 Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Does this give any insight Philippe?  It appears to crash at
finish_tlb_load_44x 


chine Check exception is
imprecise                                            
Oops: Machine check, sig: 7
[#1]                                                
APM862xx
vB                                                                     
Modules linked in: usralgo(O) rtpmac(O) libppmac(O) ppmachw(O) [last
unloaded: ]
NIP: 8000119c LR: 800172dc CTR:
80017730                                        
REGS: afff3f10 TRAP: 0214   Tainted: G        W  O
(3.2.21-aspen_2.01.09)      
MSR: 00021000 <ME,CE>  CR: 84f42f22  XER:
00000006                              
TASK = 8075a380[0] 'swapper' THREAD:
807a8000                                   
GPR00: 000009e0 807abe40 8075a380 0000004f 80762c98 0000004f 47868bfe
00000000  
GPR08: 00000001 b10189e0 b1018210 00000210 df41051b 00000027 3ead3600
00000000  
GPR16: 00000000 00000000 3ead3aec 00000000 00000000 3ea98644 3ead619c
0000000f  
GPR24: 00000000 00000001 00001020 80762c98 0000004f 0000004f 80762c98
af808000  
NIP [8000119c] finish_tlb_load_44x
+0x10/0x68                                    
LR [800172dc] __mpic_mask_irq
+0x18/0x46c                                        
Call
Trace:                                                                     
[807abe40] [00000001] 0x1
(unreliable)                                          
[807abe70] [80017844] mpic_hold_irq
+0x114/0x240                                 
[807abe90] [8007cf68] __ipipe_ack_fasteoi_irq+0x20/0x30   


On Tue, 2013-08-06 at 10:30 +0200, Philippe Gerum wrote:
> On 08/06/2013 01:05 AM, Henry Bausley wrote:
> > 
> > 
> > I am experimenting with powerpc critical interrupts.
> > 
> > Is it feasible  to use a powerpc Critical Interrupt along side xenomai?
> > What would I have to do in general to accomplish this?
> > 
> >    I have written to the appropiate powerpc registers to make the
> > interrupt critical.
> > 
> >    I have modified head_44x.S to call my own routine.
> > ie.
> > changed
> > 
> > CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)
> > 
> > to
> > 
> > CRITICAL_EXCEPTION(0x0100, CriticalInput, do_CIRQ)
> > 
> > 
> > My critical interrupt handler even works a few times. I can even see my
> > xenomai shared memories from my own critical interrupt handler.
> > However , after a few interrupts my xenomai application faults.
> > 
> > 
> 
> You would need at least something along these lines for returning to user (happily untested):
> 
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 18df6e1..223723f 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -1154,7 +1154,7 @@ exc_exit_restart_end:
>  	lwz	r3,_MSR(r1);						\
>  	andi.	r3,r3,MSR_PR;						\
>  	LOAD_MSR_KERNEL(r10,MSR_KERNEL);				\
> -	bne	user_exc_return;					\
> +	bne	__ipipe_user_exc_return;				\
>  	lwz	r0,GPR0(r1);						\
>  	lwz	r2,GPR2(r1);						\
>  	REST_4GPRS(3, r1);						\
> @@ -1399,6 +1399,12 @@ _GLOBAL(__ipipe_ret_from_except)
>          cmpwi   r3, 0
>          bne+ ret_from_except
>          b restore
> +_GLOBAL(__ipipe_user_exc_return)
> +        bl __ipipe_check_root
> +        cmpwi   r3, 0
> +	mfmsr	r10
> +        bne+ user_exc_return
> +        b restore_user
>  #endif /* CONFIG_IPIPE */
>  
>  /*
> 
> Since MSR_CE is not part of the disabling mask the I-pipe uses in interrupt-free sections, you should not pipeline critical irqs through __ipipe_grab_irq and friends. do_CIRQ() should be restricted to local, self-contained and safe code of your own, not calling the infrastructure.
> 





Outbound scan for Spam or Virus by Barracuda at Delta Tau


