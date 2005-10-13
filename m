Message-ID: <434E77B1.8030103@domain.hid>
Date: Thu, 13 Oct 2005 17:05:21 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Best way to port device driver to RTAI/fusion
References: <434E6F00.9090805@domain.hid>
In-Reply-To: <434E6F00.9090805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai@xenomai.org

Sean McGranaghan wrote:
> Hello all,
> 
> My name is Sean McGranaghan, I am a software engineer working in 
> Rochester, NY. USA. I have recently been tasked with porting a standard 
> Linux driver to the RTAI/fusion environment. I have RTAI/fusion 0.8.3 up 
> and running with a 2.6.13 kernel. I have a couple general questions, 
> followed by my specific problem. I apologize for the length of this post 
> in advance, this is my first foray into RTAI/fusion. Please direct this 
> message as appropriate.
> 
> When a realtime RTAI native or LXRT task performs io using a vanilla 
> Linux driver, does it retain its realtime scheduling priority via the 
> nucleaus scheduler or is the task demoted to the non-realtime domain 
> i.e. the Linux scheduler? Assume the vanilla Linux driver uses 
> wake_up_interruptible() to wake Linux tasks.

Two questions in one here: 1) does a fusion/Xenomai task retains its RT priority 
when migrating to Linux in order to start a syscall: yes. The basic idea is that 
  the Linux kernel priority (seen as one global pseudo-task) tracks the priority 
of the task as controlled by the nucleus across migration. 2) does a RT task 
waiting on a Linux synchronization object keeps its RT priority as defined by 
the nucleus while sleeping: no, however it will recover it as soon as it has 
been scheduled in again.

For instance, if a low-priority Linux task is masking interrupts for a long 
period of time, it's possible that a high-priority RT task that has migrated 
under the control of the Linux kernel (i.e. in secondary mode) has to wait for 
the expected event until the low-priority task unmasks the interrupts at Linux's 
stage. However, a RT task that sleeps under the control of the Xenomai nucleus 
(i.e. in primary mode) cannot be delayed from waking up by any Linux activity, 
whatever its priority is. This is why, when high-determinism is required for 
I/O, it's better to design a RT-aware driver using Xenomai's infrastructure, and 
not a plain vanilla Linux driver. But since designing a device driver from 
scratch aside of the common kernel semantics is usually the fastest path to 
chaos (also known as PITA in this side of the universe), we provide RTDM to base 
your driver on, which is a driver model deeply integrated with the Xenomai core 
that helps you dealing seamlessly with the inherently dual-sided Linux/Xenomai 
environment.

Another solution which would allow recycling the vanilla drivers with improved 
determinism from the Linux side would be to run Xenomai over a 
PREEMPT_RT-enabled kernel, which is something we have in mind since day #1 and 
already made a few working prototypes of in the past. But this is clearly not a 
solution for low-end hw, because of the performance penalty PREEMPT_RT would 
necessarily impose on the system.

> 
> Is there a standard approach to making a driver "realtime"? I would 
> assume replacing the interrupt handling, synchronization and task 
> scheduling calls with RTAI/fusion equivalents would be the approach to 
> take. How does this affect the file operations interface in Linux? 
> (open(), close(), read(), write(), ioctl() etc.) Is this driver still 
> usable by non-realtime Linux tasks?
> 

One word: RTDM.

> My specific problem is to make an existing Linux driver "realtime". 
> (Vague requirement I know.) The driver is for an ISA CAN bus card. The 
> card contains two CAN controllers using two irqs. My first step was to 
> try and get the irq handling under nucleus control. I replaced 
> request_irq() and related Linux irq calls with rt_intr_create() and 
> such. I was then going to look at replacing the Linux 
> spin_lock_irqsave()/spin_unlock_irqrestore() and wake_interruptble() 
> calls if needed. I am currently having problems with the first step.
> 
> I test the driver with a loopback cable between the two channels. In the 
> pure Linux driver I send and receive datagrams with no problem. I 
> receive a transmit complete interrupt immediatly followed by a message 
> received interrupt for each datagram sent. When I replace the interrupt 
> handling with RTAI/fusion calls I seem to be missing the receive 
> interrupt.

Perhaps an acknowledge issue. With fusion/Xenomai, you need to explicitely 
re-enable the interrupt source after each shot (rthal_enable_irq()), or 
explicitely tell Xenomai to do it for you when creating the interrupt object if 
you do that from user-space (I_ENA flag). The reason for that is because the IRQ 
has been stolen from Linux, so unless you explictely propagate it down the 
interrupt pipeline (I_PROPAGATE), Linux will neither run its handler or 
acknowledge it.

  I have looked at the CAN controller register contents and
> they are consistant between the vanilla driver and realtime driver. I am 
> currently trying to look at the 8259 PIC controller register contents to 
> see how the interrupt handling differs. I suspect that the mixing of 
> nucleaus interrupt handling and Linux spin locks (irq save/restore) is 
> fouling up the PIC, but I can't prove this yet. Is there any benefit to 
> moving the interrupt handling to the realtime domain?
> 

Have a look there if not already done, this might help:
http://download.gna.org/xenomai/documentation/pdf/Life-with-Adeos.pdf

> Any help is greatly appreciated.
> 
> Thanks,
> Sean McGranaghan
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

