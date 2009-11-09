Message-ID: <4AF8125F.60009@domain.hid>
Date: Mon, 09 Nov 2009 14:00:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] task_hijacked, prepare_arch_switch and irq disabling
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

a customer just stumbled over some unclear spots in current I-pipe patches:

Why is there local_irq_enable_hw in task_hijacked? Looks like it was
once paired with prepare_arch_switch, but that call is now only used by
legacy 2.4 PPC. Can we safely drop it from all other patches (it's in
the context switch fast-path...)? Moreover, I bet the
ENABLE_INTERRUPTS_HW_COND in entry_32.S' ret_from_fork is related to
this as well, right?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

