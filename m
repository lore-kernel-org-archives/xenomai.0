Message-ID: <454931D5.4050507@domain.hid>
Date: Wed, 01 Nov 2006 17:46:29 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Propagating interrupts
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>


I have read that propagating interrupts to Linux is a bad idea for RT applications.  I am trying to understand what happens when I install an interrupt handler via the userspace POSIX skin like this:

  pthread_intr_attach_np (&ctr_intr, irq_number, PTHREAD_IPROPAGATE);

My RT thread waits on this interrupt using:

  pthread_intr_wait_np(ctr_intr, NULL);

Here is my understanding of what happens when I get an interrupt on this IRQ.  The Xenomai interrupt handler is executed, which wakes up my RT thread.  The interrupt remains masked until the Linux interrupt handler is executed.  The linux interrupt handler processes the interrupt, and then re-enables the IRQ.  Now the RT thread can receive more interrupts.

Is this basically correct?

-Jeff

