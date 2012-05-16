Message-ID: <30154f906372933f78eb6a9f4c632782.squirrel@domain.hid>
In-Reply-To: <C7408997F5B0784C970ED53C11855FAE011112339156@domain.hid>
References: <C7408997F5B0784C970ED53C11855FAE011112339155@domain.hid>,
	<C7408997F5B0784C970ED53C11855FAE01111232AFE7@domain.hid>
	<C7408997F5B0784C970ED53C11855FAE011112339156@domain.hid>
Date: Wed, 16 May 2012 18:04:58 +0200
From: gilles.chanteperdrix@xenomai.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] IRQ latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jean-Pascal JULIEN <jean-pascal.julien@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> Hi,
>
> I installed xenomai on an overo water board (cortex A8) and performed
> latency tests.

What version of Xenomai?

> I tested two modules.
> The first module is based on an internal timer. It toggles a GPIO each
> 1ms.
> The second module waits for an external interrupt from an input GPIO
> (square signal at 1KHz). When that happens, the module toggles a GPIO pin.
>
> When i load the system and do a transfer from Ethernet to the sd card the
> first module works fine with a maximum latency less than 50us.
> But the second module, in the same context, have a maximum latency of
> several milliseconds.
>
> As the first module works fine i think i have a problem with the hardware
> configuration like the hardware irq priority.
> In the irq.c file, the irq priority level is not set for the linux domain.
>
> Should i configure the irq level at the initialization of the board ? What
> else could cause this issue ?

The error is more likely in the code of your driver. Show us the code.




