Date: Thu, 18 Aug 2011 11:30:54 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1108180933150.27510@domain.hid>
Message-ID: <alpine.DEB.1.10.1108181127560.27787@domain.hid>
References: <alpine.DEB.1.10.1108171557300.25850@domain.hid>
	<1313591180.18802.9.camel@domain.hid>
	<alpine.DEB.1.10.1108180933150.27510@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] Freeze with gpio-keys with Xenomai on Blackfin
Reply-To: Kolja Waschk <xenoka09@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

>> Backtrace stopped: previous frame inner to this frame (corrupt stack?)

Sorry, I had FP off. Now, when pressing any key (irq 79) and then attaching gdb it says

handle_IRQ_event (irq=79, action=0x0) at kernel/irq/handle.c:427
427		local_irq_disable();
(gdb) bt
#0  handle_IRQ_event (irq=79, action=0x0) at kernel/irq/handle.c:427
#1  0x000392ee in handle_level_irq (irq=79, desc=0x6e6be4) at kernel/irq/chip.c:500
#2  0xffa00378 in asm_do_IRQ (irq=79, regs=<value optimized out>) at include/linux/irq.h:320
#3  0x0003beee in __ipipe_sync_stage () at kernel/ipipe/core.c:1213
#4  0x0000653c in ___ipipe_sync_pipeline () at arch/blackfin/kernel/ipipe.c:322
#5  0x000065b4 in __ipipe_sync_root () at arch/blackfin/kernel/ipipe.c:311
#6  0xffa01016 in __ipipe_call_irqtail () at include/linux/thread_info.h:86


I'm curious why it uses "handle_level_irq" although they should be configured as edge-triggered. I'll have a look.


Kolja

