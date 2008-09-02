Message-ID: <48BD7ACC.7060100@domain.hid>
Date: Tue, 02 Sep 2008 19:41:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48BD5968.6050309@domain.hid>
In-Reply-To: <48BD5968.6050309@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] using a pcmcia parallel port card
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Theo Veenker <Theo.Veenker@domain.hid>
Cc: xenomai@xenomai.org

Theo Veenker wrote:
> Hi,
> 
> I'm trying to access a pcmcia parallel port (Trans Digital TDC303)
> from a kernel space module. When I insert the card into the laptop
> pcmcia_cs recognizes it and reports I/O address 0x3378. I tried
> to access the device at that address like you would access LPT1
> at 0x378. That didn't work; I assume the card is not actually at
> that address or not enabled or something.
> 
> Does anyone have a clue how to use a pcmcia parallel port card
> with xenomai (or any other pcmcia card for that matter)?

I would think your problem is not the pcmcia card (after all, nowadays,
a pcmcia driver is probably just a special kind of pci driver), your
problem is likely that you try to access this PCMCIA parallel port as if
it was the classical builtin ISA based parallel port, and it is not.
Does linux use the same driver for this parallel port as for the vanilla
parallel port ?

-- 
					    Gilles.

