Message-ID: <2ff1a98a0803180723i17d6d6e1p619b9c8948b6e542@domain.hid>
Date: Tue, 18 Mar 2008 15:23:38 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150803180527h71adc568o612fec284f8d096@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150803180527h71adc568o612fec284f8d096@domain.hid>
Subject: Re: [Xenomai-help] Handling irq
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

On Tue, Mar 18, 2008 at 1:27 PM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> Hi,
>
>  First of all, is there any example for enabling, requesting & handling
>  IRQ from Xenomai (user-task or kernel-thread, nevermind)?

There is an example in user-space, in ksrc/skins/native/snippets/user_irq.c

>
>  I'm using AT91SAM9260 based board. I have one peripheral connected to
>  PC12 pin of microcontroller. If wanted to do it from kernel module I
>  would do something like:
>  [..]
>  at91_set_gpio_input(AT91_PIN_PC12, 1);  // I want pullup
>  [..]
>  platform_device_register(..)
>  request_irq(irq, &myhandler, ...);
>
>  I quess it is OK to do at91_set_gpio_input() from kernel, but latter
>  should be done from Xenomai?

You can probably call at91_set_gpio_input from Xenomai context if it
does not use Linux spinlocks or fiddles with local interruptions, as
Philippe told you in a previous mail. platform_device_register is not
related with Xenomai, at all. request_irq should be replaced with a
Xenomai call, you have the choice to use any skin, but rtdm is the
preferred one.

-- 
 Gilles Chanteperdrix

