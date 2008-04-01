Message-ID: <2ff1a98a0804010520h7399794fy79695a1eafc2e2f3@domain.hid>
Date: Tue, 1 Apr 2008 14:20:35 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150804010441wdcdbf6cr16423c9ff30f419a@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150804010441wdcdbf6cr16423c9ff30f419a@domain.hid>
Subject: Re: [Xenomai-help] Handling interrupt, again
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

On undefined, Bosko Radivojevic <bosko.radivojevic@domain.hid> wrote:
> Hi!
>
>  [ Hardware: AT91SAM9260, Xenomai: 2.4.2, Kernel: 2.6.20.21]
>
>  I'm having problems running code based on user-irq.c example. If I try
>  to create handler for IRQ already "registered" within Linux (for
>  example, IRQ 82, for DM9000 eth controller) user_Irq example works
>  just fine. But, if I try to "catch" interrupt on some other pin (PC10)
>  I'm just getting nothing (looping inside rt_intr_wait()).
>
>  I did the same to initialize PC10 pin as it is done for DM9000 (pin
>  PB18) -> calling at91_set_gpio_input() function from kernel module
>  which I load before I start user_irq. Measuring voltage on the board,
>  I can see that pin is setup correctly.
>
>  Is there some more detailed doc about this matter? Or more complex
>  example? :) Or anyone knows what I'm doing wrong?

On past versions of Xenomai you needed to call rt_intr_enable after
rt_intr_create. But I thought this was no longer needed. You can try
this anyway.

-- 
 Gilles

