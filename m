Message-ID: <48BEAC77.9020504@domain.hid>
Date: Wed, 03 Sep 2008 17:25:43 +0200
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
References: <48BD5968.6050309@domain.hid> <48BD7ACC.7060100@domain.hid>
	<48BD905A.2080008@domain.hid>
In-Reply-To: <48BD905A.2080008@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Veenker, Theo wrote:
> 
> 
> Gilles Chanteperdrix wrote:
>  > Theo Veenker wrote:
>  >> Hi,
>  >>
>  >> I'm trying to access a pcmcia parallel port (Trans Digital TDC303)
>  >> from a kernel space module. When I insert the card into the laptop
>  >> pcmcia_cs recognizes it and reports I/O address 0x3378. I tried
>  >> to access the device at that address like you would access LPT1
>  >> at 0x378. That didn't work; I assume the card is not actually at
>  >> that address or not enabled or something.
>  >>
>  >> Does anyone have a clue how to use a pcmcia parallel port card
>  >> with xenomai (or any other pcmcia card for that matter)?
>  >
>  > I would think your problem is not the pcmcia card (after all, nowadays,
>  > a pcmcia driver is probably just a special kind of pci driver), your
>  > problem is likely that you try to access this PCMCIA parallel port as if
>  > it was the classical builtin ISA based parallel port, and it is not.
>  > Does linux use the same driver for this parallel port as for the vanilla
>  > parallel port ?
>  >
> 
> Thanks. So modern PC cards are not ISA like?
> 
> I believe the vanilla port requires parport or parport_pc (a guess, I
> never used this) and the particular pcmcia card I have is handled by
> parport_cs (also handles the similar Quatech SPP-100).
> 
> Meanwhile I investigated a little further and found out by peeking at
> the target I/O address (0x3378) and above/below, that the card is indeed
> visible at that address. When card not inserted I see 0xFF, when inserted
> I see data looking similar to what I see at 0x378. Maybe you are right
> and the device cannot be accessed this way; in that case I hope someone
> can hint me where to go. But first I'm going to try to find out if the
> device isn't simply in the wrong mode (mode other than SPP). I'll let
> you know.

I'm glad to say from a linux test program I can access this pcmcia card
just like the regular parallel port. Apparently the card doesn't have
internal pull-ups on the status lines (like the regular port does) so
my switches to ground connected to the status lines had little effect.
Adding external pull-ups fixed that.

Theo


