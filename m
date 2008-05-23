Message-ID: <d6c8ef150805231056n3a9ea030jada65bd5a7c2a2c0@domain.hid>
Date: Fri, 23 May 2008 19:56:34 +0200
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Interrupt priorities and handling problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hi all!

Before I ask my questions, I'll remind about my environment:
AT91SAM9260 based board (ARM), Xenomai 2.4.3, Kernel 2.6.24, I-Pipe
1.9-01. We have external interrupt source connected to PIO line (IRQ1
line) which should 'wake up' our code every 1ms. For the sake of
performances, we create interrupt handler in kernel space.

1. Two interrupts instead of one

Somehow, ISR get called twice for every single interrupt, at the
falling edge. I've tried to set interrupt source type (setting some
registers directly on the microcontroller) but whatever I set, ISR
call happens at the falling edge. The second comes right after the
first one, but not together.

When I tried to handle interrupt from the userspace, rt_intr_wait() returns
1, so it looks like "second" interrupt comes a little bit later. If I
generate more (n) interrupts during handling one, the next
rt_intr_wait() returns n*2+1. This +1 is the second interrupt that
came right after the handled one.

The quite weird thing is that sometimes (not so often, like every 1
hour) ISR is called just once. Where should I start digging?


2. Ethernet activity makes system unpredictable

Delay at interrupt reaction and, more important, duration of handling
function is pretty the same during long period of time if there is no
Ethernet activity (DM9000, GPIO IRQ 82). I can understand why we get
longer delays on interrupt reaction with Ethernet activity, but I
can't understand why exactly the same code takes more time to
complete.

We calculate ISR duration by setting one of the pins to 1 at the
beginning and setting back to 0 at the end, using at91_sys_write
macros (macros for raw_writel). We use logic port analyzer for
displaying pins status.

Without Ethernet activity irq handler lasts around 170us. With
Ethernet activity it lasts up to 280us!

That sync signal is kind of "sign of God" for us and our need is to
threat it with the highest priority possible. In one of the mails on
the list, Gilles explained that from I-Pipe 1.8 interrupt priorities
on ARM are defined at the software level. Is there a way to raise
priority of "my IRQ" over all others? Ethernet activity, timer & co
are less important than having good and predictable reactions on our
interrupt.

Thanks.

