Message-ID: <5200B433.9000604@xenomai.org>
Date: Tue, 06 Aug 2013 10:30:43 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1375743903.7948.33.camel@lx-henry>
In-Reply-To: <1375743903.7948.33.camel@lx-henry>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Henry Bausley <hbausley@deltatau.com>
Cc: xenomai@xenomai.org

On 08/06/2013 01:05 AM, Henry Bausley wrote:
> 
> 
> I am experimenting with powerpc critical interrupts.
> 
> Is it feasible  to use a powerpc Critical Interrupt along side xenomai?
> What would I have to do in general to accomplish this?
> 
>    I have written to the appropiate powerpc registers to make the
> interrupt critical.
> 
>    I have modified head_44x.S to call my own routine.
> ie.
> changed
> 
> CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)
> 
> to
> 
> CRITICAL_EXCEPTION(0x0100, CriticalInput, do_CIRQ)
> 
> 
> My critical interrupt handler even works a few times. I can even see my
> xenomai shared memories from my own critical interrupt handler.
> However , after a few interrupts my xenomai application faults.
> 
> 

You would need at least something along these lines for returning to user (happily untested):

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 18df6e1..223723f 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1154,7 +1154,7 @@ exc_exit_restart_end:
 	lwz	r3,_MSR(r1);						\
 	andi.	r3,r3,MSR_PR;						\
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL);				\
-	bne	user_exc_return;					\
+	bne	__ipipe_user_exc_return;				\
 	lwz	r0,GPR0(r1);						\
 	lwz	r2,GPR2(r1);						\
 	REST_4GPRS(3, r1);						\
@@ -1399,6 +1399,12 @@ _GLOBAL(__ipipe_ret_from_except)
         cmpwi   r3, 0
         bne+ ret_from_except
         b restore
+_GLOBAL(__ipipe_user_exc_return)
+        bl __ipipe_check_root
+        cmpwi   r3, 0
+	mfmsr	r10
+        bne+ user_exc_return
+        b restore_user
 #endif /* CONFIG_IPIPE */
 
 /*

Since MSR_CE is not part of the disabling mask the I-pipe uses in interrupt-free sections, you should not pipeline critical irqs through __ipipe_grab_irq and friends. do_CIRQ() should be restricted to local, self-contained and safe code of your own, not calling the infrastructure.

-- 
Philippe.

