Message-ID: <48776124.7030600@domain.hid>
Date: Fri, 11 Jul 2008 15:33:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4876C37B.70205@domain.hid> <4876F7CC.6010808@domain.hid>
	<0C9896A4B6D338488AD6FFFE58BAEF1002A3A100@domain.hid>
In-Reply-To: <0C9896A4B6D338488AD6FFFE58BAEF1002A3A100@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ on USB
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: DOURNES Guillaume <Guillaume.DOURNES@lgm.fr>
Cc: xenomai@xenomai.org

DOURNES Guillaume wrote:
> Hello,
> 
> I developp a software under Xenomai. My software acquire information
> from pci boards (serial link, digital input, analog input, etc ...).
> Each driver board is under Xenomai. My problem is that my keyboard
> and my mouse irq are in conflict with another pci board. My BIOS
> doesn't allow to affect the IRQ. And so when I want to use the
> keyboard or my mouse, the software freeze because an IRQ is shared
> beetwen Linux (Keyboard and Mouse) and Xenomai (an PCI board). My
> keyboard and my mouse are USB, under a KVM switch. So, Is it possible
> to change (affect) an USB IRQ ? Or Is it possible to pass the usb
> driver under Xenomai to have the IRQ shared into the same world :
> Xenomai ? If everybody has another solution, it will be wellcome.

Hi,

I do not see what this has to do with rtai-lab.

Now about the IRQ conflict issue, try the FAQ, come back when you have 
done it.

Regards.

-- 
                                                  Gilles.

