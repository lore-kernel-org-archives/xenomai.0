Message-ID: <4C87BFA3.5040207@domain.hid>
Date: Wed, 08 Sep 2010 18:53:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] x86-32: Unpreemptible return from __ipipe_handle_irq
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

Hi Philippe,

__ipipe_handle_irq:

#if defined(CONFIG_X86_32) && defined(CONFIG_SMP)
	/*
	 * Prevent a spurious rescheduling from being triggered on
	 * preemptible kernels along the way out through
	 * ret_from_intr.
	 */
	if ((long)regs->orig_ax < 0)
		__set_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status));
#endif	/* CONFIG_SMP */

But this defeats any preemption of kernel contexts on CONFIG_PREEMPT,
doesn't it? __ipipe_test_preemption should now always fail.

What kind of spurious rescheduling has to be prevented?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

