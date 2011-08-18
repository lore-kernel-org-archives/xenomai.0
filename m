Date: Thu, 18 Aug 2011 09:34:09 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1313591180.18802.9.camel@domain.hid>
Message-ID: <alpine.DEB.1.10.1108180933150.27510@domain.hid>
References: <alpine.DEB.1.10.1108171557300.25850@domain.hid>
	<1313591180.18802.9.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] Freeze with gpio-keys with Xenomai on Blackfin
Reply-To: xenoka09@domain.hid
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

> Most likely the low level interrupt path for gpios is not ipipe-aware in
> this kernel, arch/blackfin/kernel/bfin_gpios.c might be at fault. You
> may want to check with 2.6.35.9 first, to make sure this has not been

Hi,

Thanks for your quick answer!

The "only" relevant change in bfin_gpio.c since my 2.6.34 seems to be replacement of all occurences of local_irq_save_hw with hard_local_irq_save/restore. Also, there may be relevant code in mach-common/ints-priority.c. It will take some time until I understand what happens when a GPIO interrupt occurs...

Would it help if I could set up an environment for JTAG debugging? ATM, I just was able to observe that "pressing a key" triggers this in gdb:

> info: bfin: [1] EMUIN pin was asserted: PC [0x00032720] FP [0x001E2000]

> Program received signal SIGTRAP, Trace/breakpoint trap.
> ipipe_suspend_domain () at kernel/ipipe/core.c:814
> 814			ln = next_domain->p_link.next;
> (gdb) bt
> #0  ipipe_suspend_domain () at kernel/ipipe/core.c:814
> #1  0x95ffffff in ?? () at /opt/uClinux-2010R1-RC4/blackfin-linux-dist/linux-2.6.x/arch/blackfin/include/asm/thread_info.h:75
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)


Now I'm not sure whether observing via JTAG can get me any further. Do any scripts or macros for bfin-gdb exist that would help in debugging I-pipe/Xenomai?

Kolja

