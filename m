Message-ID: <4A5EF277.8090304@domain.hid>
Date: Thu, 16 Jul 2009 11:27:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c30907130031v9ec9618r46bd28b494ac3417@domain.hid>	
	<4A5CC870.3030208@domain.hid>	
	<b88603c30907160058n55d9a49eq644a2e326626bc01@domain.hid>	
	<4A5EE47E.5000507@domain.hid>
	<b88603c30907160224o7a0ebde0w6d52016dc40fccbe@domain.hid>
In-Reply-To: <b88603c30907160224o7a0ebde0w6d52016dc40fccbe@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ARM: userspace apps result in Segmentation fault
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> Hi Gilles,
> 
> Sorry I forgot to mention that I use the following kernel config,
> which would match compiling xenomai userspace with --enable-arm-eabi:
> 
> CONFIG_AEABI=y
> # CONFIG_OABI_COMPAT is not set
> 
> Please find the information you asked for below.
> 
> root@domain.hid:~# cat /proc/interrupts
>            CPU0
>   1:       1733         AIC  rtc0, ttyS0
>  11:         11         AIC  mmc0
>  14:          6         AIC  atmel_spi.0
>  19:     345827         AIC  at91_tick
>  21:         23         AIC  eth0
>  24:        164         AIC  at91_udc
>  26:          0         AIC  atmel_lcdfb
>  29:          0         AIC  ohci_hcd:usb1
>  31:          0         AIC  ads7846
>  57:          1        GPIO  at91_udc
> 178:          0        GPIO  mmc0
> Err:          0
> 
> root@domain.hid:~# cat /proc/xenomai/irq
> IRQ         CPU0
>  19:      373801         [timer]
> 194:           0         [virtual]
> 
> I was also able to load an RTDM kernel module and receive irq's from
> it in kernel space. This module was not loaded at the time of the
> cat's.
> 
> The userspace apps are the problem. Probably already at the init of
> the xenomai libraries that are linked with them, while
> /usr/xenomai/bin/cyclictest -? already makes the system hang.

Ok. Could you post your full .config ?

-- 
                                          Gilles


