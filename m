Message-ID: <43DE29B3.5000005@domain.hid>
Date: Mon, 30 Jan 2006 15:58:59 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [BUG?] dead code in ipipe_grab_irq
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

In the following code (ppc), shouldn't first be either declared static or 
deleted? To me it looks like first is always equal to one when the else clause 
is evaluated.

asmlinkage int __ipipe_grab_irq(struct pt_regs *regs)
{
         extern int ppc_spurious_interrupts;
         ipipe_declare_cpuid;
         int irq, first = 1;

         if ((irq = ppc_md.get_irq(regs)) >= 0) {
                 __ipipe_handle_irq(irq, regs);
                 first = 0;
         } else if (irq != -2 && first)
                 ppc_spurious_interrupts++;

         ipipe_load_cpuid();

         return (ipipe_percpu_domain[cpuid] == ipipe_root_domain &&
                 !test_bit(IPIPE_STALL_FLAG,
                           &ipipe_root_domain->cpudata[cpuid].status));
}


Regards

Anders Blomdell



