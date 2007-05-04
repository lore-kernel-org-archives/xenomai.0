From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20127779.1178282801939.JavaMail.ngmail@domain.hid>
References: <1178281223.29093.83.camel@domain.hid> <463AE7D3.6030401@domain.hid>
	<24394502.1178264721982.JavaMail.ngmail@domain.hid>
	<13626574.1178266851510.JavaMail.ngmail@domain.hid>
	<20127779.1178282801939.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Fri, 04 May 2007 15:03:01 +0200
Message-Id: <1178283781.29093.98.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Fri, 2007-05-04 at 14:46 +0200, M. Koehrer wrote:
> Hi Philippe,
> 
> I patched the create_irq() function to start the search for unused interrupts not at
> NR_IRQS -1 but from 127.
> And this seems actually to work.
> It looks like the right track!
> That means, that actually the large IRQ numbers are conflicting with the system
> interrupts.

> However, I wonder why this works with a non-adeos-patched kernel...

Because the vanilla kernel does not need to map system vectors to
interrupt numbers.

> 
> Regards
> 
> Mathias
> 
> 
> > 
> > No, the trampoline code in entry.S passes us an irq actually. But there
> > is indeed a vector:irq mapping issue with IRQ numbers greater than 206,
> > which still badly conflict with system IRQs (MSI causes high numbered
> > IRQs to be allocated). I'm working on a patch. More later.
> > 
> 
> 
-- 
Philippe.



