Message-ID: <2ff1a98a0712190838n68ea4dacs9a27834e07de4939@domain.hid>
Date: Wed, 19 Dec 2007 17:38:42 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <20071219150622.GA15974@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20071219150622.GA15974@domain.hid>
Subject: Re: [Xenomai-help] PIOX irq problems with at91sam9260
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Juan Antonio Garcia Redondo <juan-antonio.garcia@domain.hid>
Cc: jagarcia@domain.hid, xenomai@xenomai.org

On Dec 19, 2007 4:06 PM, Juan Antonio Garcia Redondo
<juan-antonio.garcia@domain.hid> wrote:
> Hello list,
>
> I'm testing xenomai 2.4.0 (kernel 2.6.20, adeos-ipipe-2.6.20-arm-1.8-02)
> over a at91sam9260 based board. The initial tests runs OK but I've problems
> with the PIOX interrupts. It seems that, to work properly with the
> interrupt, I need to install first the interrupt on the linux side.
>
> Environment:
>         o A sligtly modified user_irq.c from the xenomai
>         documentation.
>         o A normal linux kernel module which does nothing except
>         catching the irq received as parameter.
>         o PIB_11 y PIOB_10 in short circuit.
>
>
> Test 1:
>         o External gpio programming as input(PIOB_11)
>         # test_irq 75
>                 Waiting for irq 75 ...
>
>         o Nothing occurs although I've set and reset the PIOB_10. The
>         first thing I see is that the PIOB_IMR is 0x000000 when I'll expect
>         0x00000800.
>
> Test 2:
>         o External gpio programming as input(PIOB_11)
>         # insmod irqena.ko gpio_in=75
>         0 Now the PIOB_IMR is 0x00000800
>         # rmmod irqena
>         # test_irq 75
>             Waiting for irq 75
>         o External gpio PIOB_10 set and reset.
>         #  ..........
>            Waiting for irq 75
>            Arrives irq -> 1
>            Arrives irq -> 1
>            ..................
>
> I've attached the tests programs.
>
> Any hints ?

There is probably a difference (in term of the irq chip callbacks
called) between request_irq, used by the Linux driver, and
ipipe_virtualize_irq, used by Xenomai interrupts management routines.
The problem is to find this difference; at first sight, it is not
obvious

-- 
                                               Gilles Chanteperdrix

