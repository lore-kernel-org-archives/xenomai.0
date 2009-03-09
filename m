Message-ID: <49B54D2C.4030600@domain.hid>
Date: Mon, 09 Mar 2009 18:09:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] __ipipe_run_isr vs. domain migration
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

as indicated on xenomai-core, there is at least a theoretical issue with
__ipipe_sync_stage/__ipipe_run_isr and non-root IRQ handlers performing
a domain migration. And it's not only limited to x86 but rather a
cross-arch thing: While __ipipe_run_isr assumes, that the domain stays
the same across a handler call

[e.g. x86-32:]
	__clear_bit(IPIPE_SYNC_FLAG, &ipipe_cpudom_var(ipd, status)); \
	ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);	\
	__set_bit(IPIPE_SYNC_FLAG, &ipipe_cpudom_var(ipd, status)); \

i.e. ipd is not updated on return, __ipipe_sync_stage interestingly
reloads the current domain

	__ipipe_run_isr(ipd, irq);
	p = ipipe_cpudom_ptr(ipipe_current_domain);

Is it forbidden for some other reasons to change the domain from within
an IRQ handler or is there a bug sleeping?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

