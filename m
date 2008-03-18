Message-ID: <d6c8ef150803180527h71adc568o612fec284f8d096@domain.hid>
Date: Tue, 18 Mar 2008 13:27:01 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Handling irq
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

Hi,

First of all, is there any example for enabling, requesting & handling
IRQ from Xenomai (user-task or kernel-thread, nevermind)?

I'm using AT91SAM9260 based board. I have one peripheral connected to
PC12 pin of microcontroller. If wanted to do it from kernel module I
would do something like:
[..]
at91_set_gpio_input(AT91_PIN_PC12, 1);  // I want pullup
[..]
platform_device_register(..)
request_irq(irq, &myhandler, ...);

I quess it is OK to do at91_set_gpio_input() from kernel, but latter
should be done from Xenomai?

Kind regards,
Bosko

