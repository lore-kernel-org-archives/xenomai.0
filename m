MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18487.5656.377471.470581@domain.hid>
Date: Fri, 23 May 2008 21:08:08 +0200
In-Reply-To: <d6c8ef150805231056n3a9ea030jada65bd5a7c2a2c0@domain.hid>
References: <d6c8ef150805231056n3a9ea030jada65bd5a7c2a2c0@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Interrupt priorities and handling problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Bosko Radivojevic wrote:
 > Hi all!
 > 
 > Before I ask my questions, I'll remind about my environment:
 > AT91SAM9260 based board (ARM), Xenomai 2.4.3, Kernel 2.6.24, I-Pipe
 > 1.9-01. We have external interrupt source connected to PIO line (IRQ1
 > line) which should 'wake up' our code every 1ms. For the sake of
 > performances, we create interrupt handler in kernel space.
 > 
 > 2. Ethernet activity makes system unpredictable
 > 
 > Delay at interrupt reaction and, more important, duration of handling
 > function is pretty the same during long period of time if there is no
 > Ethernet activity (DM9000, GPIO IRQ 82). I can understand why we get
 > longer delays on interrupt reaction with Ethernet activity, but I
 > can't understand why exactly the same code takes more time to
 > complete.
 > 
 > We calculate ISR duration by setting one of the pins to 1 at the
 > beginning and setting back to 0 at the end, using at91_sys_write
 > macros (macros for raw_writel). We use logic port analyzer for
 > displaying pins status.
 > 
 > Without Ethernet activity irq handler lasts around 170us. With
 > Ethernet activity it lasts up to 280us!

Due to the way you measure the interrupt duration, and since preemption
of interrupt handler by another interrupt handler is completely
excluded (unless you mistakenly re-enable interrupts in your interrupt
handler), what you observe is probably an indirect effect
such as cache thrashing. The best way to know is either to measure some
short sections with rt_timer_tsc, or to do some measurements with the
I-pipe tracer.

 > 
 > That sync signal is kind of "sign of God" for us and our need is to
 > threat it with the highest priority possible. In one of the mails on
 > the list, Gilles explained that from I-Pipe 1.8 interrupt priorities
 > on ARM are defined at the software level. Is there a way to raise
 > priority of "my IRQ" over all others? Ethernet activity, timer & co
 > are less important than having good and predictable reactions on our
 > interrupt.

Interrupt priority only matters when two interrupts are pending at the
same time. If ethernet interrupt is treated at Linux level, then it is
fully preemptible by Xenomai, if it is a real-time interrupt, then it
may well trigger before you receive your periodic interrupt, so the
worst case interrupt latency of the periodic interrupt is at least the
duration of the ethernet interrupt (and vice-versa). Changing the
interrupt priority, will not change interrupt latency. What you can do
to improve situation is:
- re-enable interrupts in the ethernet interrupt handler
- rewrite the ethernet driver to only poll periodically hardware to
  handle any pending packet instead of being interrupt driven, and
  arrange for this not to happen at the same time as when the
  periodic interrupt is triggered.
But as far as I understood, your problem is not the interrupt latency,
but rather the ISR duration, and changing the interrupt priority will
not change this at all.

-- 


					    Gilles.

