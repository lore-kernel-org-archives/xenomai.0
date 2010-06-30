Message-ID: <4C2BB5C0.3020407@domain.hid>
Date: Wed, 30 Jun 2010 23:23:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimKEFqaOGLrvLhpf0FqqdTkAPraazAnbuUGMa0V@mail.gmail.com>	<4C289319.4050807@domain.hid>	<AANLkTin9R46PUKwDQw_nXck_RkL9TH01Qqhuw-7YwmDT@mail.gmail.com>	<4C2A1B0A.3000204@domain.hid>
	<AANLkTilr3TVOW5mLVTfIYW33TpkiIFuPStuO_TxgmMrS@mail.gmail.com>
In-Reply-To: <AANLkTilr3TVOW5mLVTfIYW33TpkiIFuPStuO_TxgmMrS@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ conflict issues with and ESD PMC card.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nape Ibrahim Lentsoane <nape.lentsoane@domain.hid>
Cc: xenomai@xenomai.org

Nape Ibrahim Lentsoane wrote:
> Okay, we updated the BIOS with a custom made version from Advantech. At
> least we are able too boot now but
> now  my usb mouse/port does not work. By the way I'm running on an
> industrial SBC from Advantech model MIC-3390.
> The contents of /proc/interrupts and /proc/xenomai/irq are in
> "pro_interrupts.txt" and "xenomai_irq_2.txt" respectively
> as attached.
> 
> Something strange which I do not understand is that ran the '# lsmod | grep
> xeno_can' and look at the results in the
> attached file "lsmod_grep_xeno_can.txt". What is puzzling is that I
> configured the Xenomai CAN stuff to load as modules
> but here they are automatically loaded, how's that?
> 
> I'll try to enable the APIC and local APIC and see what happens.

Ok. Now we can see things more clearly. First: the APIC is already
enabled in your kernel configuration, and seems not to be used, the ACPI
is broken, I do not know if this is the problem, but it seems your APIC
is not used. This is bad news. If that is possible, you should try and
use a BIOS with ACPI. I mean, come on, this has been the standard for
over 10 years now. See:
http://en.wikipedia.org/wiki/ACPI

Second, your kernel is not really well configured:
- you have enabled multi-processor support whereas you have a single
CPU, disable it
- you probably use the generic IDE driver, whereas you should use the
one for the hardware you really have, use lspci to find out what the
hardware you use is.
- you enabled Xenomai SMI workaround, at this stage, this is a bad idea,
you should follow the guidelines in the "TROUBLESHOOTING" guide in order
to enable it. But this is too early, please keep it disabled for now.

And now, the really bad news: you have the IRQ shared between Xenomai
driver and Linux driver issue. IRQ 12 is used both by the Xenomai CAN
driver and by the Linux USB controller. This is probably the reason why
the USB is not working. See the FAQ for suggestions on how you may solve
this issue.

-- 
					    Gilles.

