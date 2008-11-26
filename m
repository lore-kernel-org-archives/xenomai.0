Message-ID: <492D7EEE.2020808@domain.hid>
Date: Wed, 26 Nov 2008 17:53:02 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <2F8EE677D406514ABE53EF9C0934A666042ABED6@domain.hid>
In-Reply-To: <2F8EE677D406514ABE53EF9C0934A666042ABED6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt Shield Hangs
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Laurent.POYART@fr.thalesgroup.com
Cc: xenomai@xenomai.org

Laurent.POYART@fr.thalesgroup.com wrote:
> Hello,
> 
> I'm running some tests on a powerpc MPC8347 with Xenomai 2.4.1

Please don't test outdated releases. We can't afford debugging each and every
release we rolled out. The stable one we maintain is 2.4.6.1. The same goes for
the Adeos patch, especially on 83xx.

 and Linux
> 2.6.23. I use the interrupt shield. I have find one case in which my
> application hangs. 

The interrupt shield will be dropped in later Xenomai versions (3.0 for sure).
It made some sense when PREEMPT_RT was not available to allow pure Linux
operations to be shielded from normal (i.e. non-RT interrupts) especially on SMP
systems due to inter-CPU locking issues, but native preemption solves that much
better nowadays. The IRQ shield is a by-product from Adeos more than a Xenomai
feature, actually.

If you need a co-kernel, then you want to get predictability from primary mode
only. If you need to run applications with bounded latencies mostly in secondary
mode, e.g. happily calling into the glibc and/or regular Linux drivers, then you
likely want PREEMPT_RT.

> I've plugged my JTAG and it seems that I enter an infinite loop at the end
> of the function engage_irq_shield. It seems to be in the function
> rthal_local_irq_restore_hw (see the screenshot in the file below. Infinite
> loop between adresses 0xC0056110 and 0xC0056124. Registers r0 and r11 values
> are 1).
> 
> I manage to produce the problem in the following context:
> . I've got a periodic RT task of 5ms which performs a linux system calls and
> swithes to secondary mode : takes a lock, print a message , gives the lock
> and then wait for a period. It was not the initial code but I manage to get
> the problem easily with this new code.
> . In the same time, I've got a RT task which performs data transfer towards
> a FPGA FIFO using a RTDM driver. The task writes data until the Almost Full
> flag of the FPGA FIFO is set. The FPGA read the data at 200Kbits/s and
> generates an interrupt (registered in xenomai) when the Fifo is almost
> empty. Then the task continues to write data to the FPGA. 
> After a while, the system hangs. Each time, the timer task is between 2
> calls of rt_task_wait_period.
> 
> I've made the test with the interrupt shield disabled and the target doesn't
> hangs.
> 
> Do you have any idea?
> 

The shield blocks interrupt propagation beyond what it should. It could be an
Adeos issue, or more likely a secondary mode switch vs shield problem. Somebody
reported this issue is the past already, but this problem has not reached the
top of any maintainer's stack yet, probably because the shield feature is obsolete.

> Thanks in advance.
> 
> L.Poyart
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

