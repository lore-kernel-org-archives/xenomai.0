Message-ID: <BAY14-F198BE7F001241582B02E46C0460@domain.hid>
From: =?gb2312?B?1cUgvrI=?= <zhang_jing_bit@domain.hid>
Date: Mon, 12 Dec 2005 16:05:35 +0800
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Subject: [Adeos-main] Why is __adeos_irq_regs only updated when a timer IRQ
	is caught?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi, all,

I have no idea about why __adeos_irq_regs is only updated when a timer IRQ 
is caught. Does it means its value doesn't matter to other irq handlers? 
I'am working on version 2.4r12 for ARM.

Below is the snippet to update the __adeos_irq_regs in __adeos_handle_irq:

if (likely(irq == ADEOS_TIMER_IRQ))
{
    __adeos_irq_regs.ARM_cpsr = regs->ARM_cpsr;
    __adeos_irq_regs.ARM_pc = regs->ARM_pc;
} 

Thanks!



