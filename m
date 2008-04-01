Message-ID: <d6c8ef150804010441wdcdbf6cr16423c9ff30f419a@domain.hid>
Date: Tue, 1 Apr 2008 13:41:30 +0200
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Handling interrupt, again
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

Hi!

[ Hardware: AT91SAM9260, Xenomai: 2.4.2, Kernel: 2.6.20.21]

I'm having problems running code based on user-irq.c example. If I try
to create handler for IRQ already "registered" within Linux (for
example, IRQ 82, for DM9000 eth controller) user_Irq example works
just fine. But, if I try to "catch" interrupt on some other pin (PC10)
I'm just getting nothing (looping inside rt_intr_wait()).

I did the same to initialize PC10 pin as it is done for DM9000 (pin
PB18) -> calling at91_set_gpio_input() function from kernel module
which I load before I start user_irq. Measuring voltage on the board,
I can see that pin is setup correctly.

Is there some more detailed doc about this matter? Or more complex
example? :) Or anyone knows what I'm doing wrong?

Thanks!

