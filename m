MIME-Version: 1.0
In-Reply-To: <519E441B.2010800@nta-inc.net>
References: <519BC3CB.1020300@nta-inc.net>
	<519E441B.2010800@nta-inc.net>
Date: Thu, 23 May 2013 19:39:38 +0200
Message-ID: <CAPRPZsAQ2aucriuNSz1j4rYMo3rp6CZ_okATFnWuR7sd2+_GQQ@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] IRQ issue (was Ethernet driver issue)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: xenomai@xenomai.org

> It turns out that if I switch the PCI ethernet card to another slot (IRQ
> 17 instead of 16), it works fine.  Here's another data point:  If I plug
> this card into a PCI to PCIe adapter and put it in a PCIe slot, the card
> works, but almost immediately the mouse and keyboard become almost
> non-responsive.  By that, I mean most keystrokes are missed and the mouse
> position is only updated every second or two.  I have seen this behavior
> under Xenomai on this machine a couple times before after running for a
> much longer time.  Maybe there's an issue related to USB and interrupts?
>
> Does the difference in the last character of the status line mentioned in
> my previous email indicate that the card may be requesting an interrupt,
> but never serviced?
>
>
If you mean INTx+, yes. In combination with DisINT- it indicates a pending
interrupt.

Any ideas?
>
>
Check with lspci what your PCI-PCIe bridge is. I once had serious issues
with an ASMedia bridge that did not send an PCIe IRQ deassert message.
Could be a mainboard issue as well.

Since you experience very slow response with another PCI-PCIe bridge, also
check the number of IRQs in /proc/interrupts and proc/xenomai/irq.

Also check very thoroughly that the issue does not occur in plain Linux
(check dmesg for 'Nobody cared'). It can take hours of testing to trigger
the problem and maybe the I-pipe exposes it more quickly. My personal
feeling on the problem back then was that it could have something to do
with the interrupt being serviced very fast.


Jeroen


-Jeff
>
> ______________________________**_________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/**mailman/listinfo/xenomai<http://www.xenomai.org/mailman/listinfo/xenomai>
>
