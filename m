From: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Date: Thu, 8 Nov 2007 13:35:43 +0100
References: <200711061807.26236.lepalom@domain.hid>
	<200711081041.57506.lepalom@domain.hid> <4732FC4F.1060301@domain.hid>
In-Reply-To: <4732FC4F.1060301@domain.hid>
MIME-Version: 1.0
Message-Id: <200711081335.44725.lepalom@domain.hid>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Subject: Re: [Xenomai-help] IRQ issues in xenomai and rtnet
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, mathias_koehrer@domain.hid

A Dijous 08 Novembre 2007, Jan Kiszka va escriure:
> Leopold Palomo-Avellaneda wrote:
> > A Dijous 08 Novembre 2007, Roland Tollenaar va escriure:
> >> so your system hanging on
> >> boot strikes me as a bit odd. Unless of course you start rtnet in one of
> >> the rc bootscrips of course?
> >
> > no, the hanging at boot time is when I don't put the noapic option in the
> > 2.6.22 kernels (it's known bug) with 2.6.23 depends of irqpoll, or the
> > manual assignment in the bios.
>
> You mean this is a known mainline issue, or does it only happen with
> I-pipe applied or additionally Xenomai loaded?

No exactly, I unplug the pci network cards and the box boots ok, without 
irqpoll. Maybe it's a problem of compatibility of this old pci network cards.

> In the former case, I 
> would suggest trying your scenario on a different box, as you may suffer
> from at least tricky if not unfixable hardware/BIOS problems.

well it's the problem of the latest mobos. You have to deal with unknowns 
issues. I can try, but I would like to have my new amd64 hardware running 
xenomai and rtnet ... I'm optimist in this :-)

Leo


