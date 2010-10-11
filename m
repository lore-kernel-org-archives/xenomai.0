Message-ID: <4CB36116.8090507@domain.hid>
Date: Mon, 11 Oct 2010 21:10:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=6d4sZN11G0TfDXZPfwS8dDkhgE=LjnGcS4AG1@domain.hid>	<1286611432.13186.200.camel@domain.hid>	<AANLkTinfQTmC=165zLerDF1JsYnS-XHaUtWrMuOGmN4D@mail.gmail.com>	<AANLkTi=uCSYFazTzxLQWBhJgkmcoeJbLkd4Wv-O=tzb=@mail.gmail.com>	<4CB2B98A.8010605@domain.hid>
	<AANLkTinrw0yUPApypmaN4L+Auv4WtE+BRJr-wkDjiAE-@domain.hid>
In-Reply-To: <AANLkTinrw0yUPApypmaN4L+Auv4WtE+BRJr-wkDjiAE-@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and PEAK can bus card problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

Peter Pastor wrote:
> Hey Gilles,
> 
> Thanks for the hint. I "fixed" this problem by loading the nvidia driver
> (instead of nv) as default. Now the graphic cards uses IRQ 24 which does not
> collide with IRQ 11 of the CAN bus card (see attached lspci.txt).
> 
> The only other device that uses IRQ 11 is
> # 00:00.0 Host bridge [0600]: Intel Corporation 5520 I/O Hub to ESI Port
> [8086:3406] (rev 13)
> 
> But I guess that is ok, is it ? I checked the FAQs and went through the list
> but I feel I can't do much. I will try a few things and disable everything
> that is unneeded. The FAQ list also suggests to enable CONFIG_PCI_MSI which
> is disabled right now. What would now be a reasonable thing to do ?

Keep PCI_MSI disabled. The FAQ is wrong and should be fixed.

> 
> How can I find out and about which device is causing the address space
> collision ?
> 
> # address space collision: host bridge window [mem 0xd7f00000-0xe0000000]
> conflicts with PCI Bus 0000:00 [mem 0xe0000000-0xf7ffffff]
> 
> I attached the syslog of the latest boot. I enabled some debugging infos
> which hopefully allow to trace down the problem. Interestingly, this time,
> the kernel spit out
> 
> # RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
> 
> right before it froze.

You should try and put some printks in RTCan code to see how far it
goes. But I guess Wolfgang may be of more help.

-- 
                                                                Gilles.

