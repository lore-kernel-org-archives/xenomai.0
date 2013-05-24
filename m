MIME-Version: 1.0
In-Reply-To: <519FAAC8.4010600@nta-inc.net>
References: <519BC3CB.1020300@nta-inc.net> <519E441B.2010800@nta-inc.net>
	<CAPRPZsAQ2aucriuNSz1j4rYMo3rp6CZ_okATFnWuR7sd2+_GQQ@mail.gmail.com>
	<519E8762.3030309@nta-inc.net> <519FAAC8.4010600@nta-inc.net>
Date: Fri, 24 May 2013 16:44:13 -0400
Message-ID: <CADVgf9nmHMvm0VRqe=BPcEOEWa=ui7632K5awjHKSS+x=sRMYw@mail.gmail.com>
From: Matthew Fornero <mfornero.lists@gmail.com>
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

> (Remember, this is not the adapter on my motherboard, but just something I
> am plugging in for test purposes.)  When I'm running vanilla linux (3.5.7)
> with this configuration, everything seems to work fine (the ethernet card,
> the mouse/keyboard, and no spurious interrupts).  Under xenomai, the
> ethernet card works, but within a few seconds the mouse and keyboard become
> extremely delayed as I mentioned in a previous email.

Have you been able to look at dmesg output (or /var/log/message) after
the USB mouse and keyboard stop responding? This sounds very similar
to an issue we had where a real-time PCI device was sharing an
interrupt with one of the USB controllers.

As a workaround, is it an option to simply use a PCIe network card?
This will give you an MSI interrupt that won't conflict with any other
devices in your system. I recall seeing some concerns with using MSI
for real-time interrupts under Xenomai, but I believe it can be done
successfully on x86 if you observe a few precautions (maybe Jan Kiszka
can comment?). We've successfully used MSI for non-real time
interrupts (ethernet cards) on many of our platforms.

-Matt

