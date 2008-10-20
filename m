Message-ID: <48FC4F14.5020903@domain.hid>
Date: Mon, 20 Oct 2008 11:27:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] x86: Fix-up for 2.6.26.5+
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Philippe,

ipipe-2.0-15 does not apply to 2.6.26.5 and later. Hunk below might be
non-trivial to resolve for normal users, so please merge soon
(specifically into Xenomai):

Index: linux-2.6.26-xeno_64/arch/x86/kernel/traps_64.c
===================================================================
--- linux-2.6.26-xeno_64.orig/arch/x86/kernel/traps_64.c
+++ linux-2.6.26-xeno_64/arch/x86/kernel/traps_64.c
@@ -1140,17 +1148,20 @@ asmlinkage void math_state_restore(void)
 		local_irq_disable();
 	}
 
+	local_irq_save_hw_cond(flags);
 	clts();			/* Allow maths ops (or we recurse) */
  	/*
  	 * Paranoid restore. send a SIGSEGV if we fail to restore the state.
  	 */
  	if (unlikely(restore_fpu_checking(&me->thread.xstate->fxsave))) {
  		stts();
+		local_irq_restore_hw_cond(flags);
  		force_sig(SIGSEGV, me);
  		return;
  	}
 	task_thread_info(me)->status |= TS_USEDFPU;
 	me->fpu_counter++;
+	local_irq_restore_hw_cond(flags);
 }
 EXPORT_SYMBOL_GPL(math_state_restore);
 

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

