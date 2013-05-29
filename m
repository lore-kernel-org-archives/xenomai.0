Message-ID: <51A65A53.2040502@nta-inc.net>
Date: Wed, 29 May 2013 14:43:15 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <519BC3CB.1020300@nta-inc.net> <519E441B.2010800@nta-inc.net>
	<CAPRPZsAQ2aucriuNSz1j4rYMo3rp6CZ_okATFnWuR7sd2+_GQQ@mail.gmail.com>
	<519E8762.3030309@nta-inc.net> <519FAAC8.4010600@nta-inc.net>
	<CADVgf9nmHMvm0VRqe=BPcEOEWa=ui7632K5awjHKSS+x=sRMYw@mail.gmail.com>
In-Reply-To: <CADVgf9nmHMvm0VRqe=BPcEOEWa=ui7632K5awjHKSS+x=sRMYw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] IRQ issue (was Ethernet driver issue)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthew Fornero <mfornero.lists@gmail.com>
Cc: xenomai@xenomai.org

On 05/24/2013 03:44 PM, Matthew Fornero wrote:
>> (Remember, this is not the adapter on my motherboard, but just something I
>> am plugging in for test purposes.)  When I'm running vanilla linux (3.5.7)
>> with this configuration, everything seems to work fine (the ethernet card,
>> the mouse/keyboard, and no spurious interrupts).  Under xenomai, the
>> ethernet card works, but within a few seconds the mouse and keyboard become
>> extremely delayed as I mentioned in a previous email.
>
> Have you been able to look at dmesg output (or /var/log/message) after
> the USB mouse and keyboard stop responding?

Nothing looks unusual in dmesg or /var/log/syslog other than:

[   26.589844] I-pipe: spurious interrupt 32
[   36.596341] I-pipe: spurious interrupt 32

I get at least one of these messages (and sometimes two) every time I boot a Xenomai kernel on this machine, even if I don't see the mouse/keyboard issue, and even if the secondary PCI ethernet card works (IRQ 17).  The timing of the second spurious interrupt message could be coincident with the mouse/keyboard issue in this particular case, but I'm not sure.

> This sounds very similar
> to an issue we had where a real-time PCI device was sharing an
> interrupt with one of the USB controllers.

I'm not running any realtime code at the time of this test other than what runs when the machine is idle.  If there is something like that going on, it's not obvious to me.  I agree the behavior seems similar to the case you mentioned.  I have experienced cases like that as well in the past.

> As a workaround, is it an option to simply use a PCIe network card?
> This will give you an MSI interrupt that won't conflict with any other
> devices in your system.

I don't have a PCIe network card (other than the primary one on the motherboard), but I did try putting the PCI card in a PCIe-PCI adapter.  As you mentioned, it was assigned it's own IRQ (28).  This is the configuration I used when I experienced the mouse/keyboard issue I mentioned above, so I don't see how the problem could be due to the sharing of the network card IRQ, but it could possibly be due to the sharing of a USB IRQ.  The original problem of the PCI network card not functioning when in the IRQ 16 slot could also be due to some kind of IRQ sharing issue, though.

> I recall seeing some concerns with using MSI
> for real-time interrupts under Xenomai, but I believe it can be done
> successfully on x86 if you observe a few precautions (maybe Jan Kiszka
> can comment?). We've successfully used MSI for non-real time
> interrupts (ethernet cards) on many of our platforms.

I have used MSI for ethernet cards on other RT systems as well.  Even if I can get a PCIe network card working without the USB issues I experienced above, I will eventually need to use both PCI slots (IRQs 16 and 17) for RT serial cards, so I need figure out what's going on with those IRQ lines.

It seems to me that there's something fundamentally wrong with my system, since both USB and ethernet interrupts seem to be causing problems, depending on what IRQs are being utilized.

> -Matt

Thanks for the response, Matt!

-Jeff


