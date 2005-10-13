Message-ID: <434E6F00.9090805@domain.hid>
Date: Thu, 13 Oct 2005 10:28:16 -0400
From: Sean McGranaghan <smm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Best way to port device driver to RTAI/fusion
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello all,

My name is Sean McGranaghan, I am a software engineer working in 
Rochester, NY. USA. I have recently been tasked with porting a standard 
Linux driver to the RTAI/fusion environment. I have RTAI/fusion 0.8.3 up 
and running with a 2.6.13 kernel. I have a couple general questions, 
followed by my specific problem. I apologize for the length of this post 
in advance, this is my first foray into RTAI/fusion. Please direct this 
message as appropriate.

When a realtime RTAI native or LXRT task performs io using a vanilla 
Linux driver, does it retain its realtime scheduling priority via the 
nucleaus scheduler or is the task demoted to the non-realtime domain 
i.e. the Linux scheduler? Assume the vanilla Linux driver uses 
wake_up_interruptible() to wake Linux tasks.

Is there a standard approach to making a driver "realtime"? I would 
assume replacing the interrupt handling, synchronization and task 
scheduling calls with RTAI/fusion equivalents would be the approach to 
take. How does this affect the file operations interface in Linux? 
(open(), close(), read(), write(), ioctl() etc.) Is this driver still 
usable by non-realtime Linux tasks?

My specific problem is to make an existing Linux driver "realtime". 
(Vague requirement I know.) The driver is for an ISA CAN bus card. The 
card contains two CAN controllers using two irqs. My first step was to 
try and get the irq handling under nucleus control. I replaced 
request_irq() and related Linux irq calls with rt_intr_create() and 
such. I was then going to look at replacing the Linux 
spin_lock_irqsave()/spin_unlock_irqrestore() and wake_interruptble() 
calls if needed. I am currently having problems with the first step.

I test the driver with a loopback cable between the two channels. In the 
pure Linux driver I send and receive datagrams with no problem. I 
receive a transmit complete interrupt immediatly followed by a message 
received interrupt for each datagram sent. When I replace the interrupt 
handling with RTAI/fusion calls I seem to be missing the receive 
interrupt. I have looked at the CAN controller register contents and 
they are consistant between the vanilla driver and realtime driver. I am 
currently trying to look at the 8259 PIC controller register contents to 
see how the interrupt handling differs. I suspect that the mixing of 
nucleaus interrupt handling and Linux spin locks (irq save/restore) is 
fouling up the PIC, but I can't prove this yet. Is there any benefit to 
moving the interrupt handling to the realtime domain?

Any help is greatly appreciated.

Thanks,
Sean McGranaghan



