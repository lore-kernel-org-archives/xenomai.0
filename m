Message-ID: <4C2B2E60.9090101@domain.hid>
Date: Wed, 30 Jun 2010 13:45:36 +0200
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
> now  my usb mouse/port does not work. 

So it is not really better, is it? Unless you do not intend to use USB.

By the way I'm running on an
> industrial SBC from Advantech model MIC-3390.

My real question was what processor you are running. I guess it is a
pentium M?

> The contents of /proc/interrupts and /proc/xenomai/irq are in
> "pro_interrupts.txt" and "xenomai_irq_2.txt" respectively
> as attached.
> 
> Something strange which I do not understand is that ran the '# lsmod | grep
> xeno_can' and look at the results in the
> attached file "lsmod_grep_xeno_can.txt". What is puzzling is that I
> configured the Xenomai CAN stuff to load as modules
> but here they are automatically loaded, how's that?

The linux kernel or the root file system did this, Xenomai is not
involved. Xenomai CAN drivers are simply declared as drivers for PCI
boards and handled by whatever does that for the version of the kernel
you are using. I think it is udev, but I could not be sure, these things
have changed many times over time, I lost track.

> 
> I'll try to enable the APIC and local APIC and see what happens.

I meant local APIC and/or IO/APIC. Yes, you should definitely try that,
as mentioned in the FAQ, using the APIC improves latencies.


-- 
					    Gilles.

