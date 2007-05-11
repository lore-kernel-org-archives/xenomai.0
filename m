Message-ID: <464476AE.3060805@domain.hid>
Date: Fri, 11 May 2007 15:59:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <46446ee66e467@domain.hid>
In-Reply-To: <46446ee66e467@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] realtime with mx27ads
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: r k <radokx@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

r k wrote:
> I have purchased i.MX27ads board and I am using
> imx27_ads_20070210-rel1b-ltib.iso
> 
> We have been trying to adapt real-time patch from Xenomai 2.3.1 for the
> kernel 2.6.19.
> The solution is based on trigger from General Purpose Timer, which lets
> periodically check interrupts.

It is a bit unusual.

> Interrupts from processor are handled
> without obstacles but interrupts from CPLD cause problems.
> Our main modification is in file mx27ads.c (added code is in attachment)
> The result was printed as low level debug info via console(also in
> attachment). Our remark is that just after initialization of MMC card,
> which is handled by CPLD, is invoked our function. Then our code tries
> to handle interrupt no 15 port no 2 and from this moment we got
> problems. Function tries to handle this interrupt twice and then fail.
> 
> Does anybody tried already to add real-time extension to i.MX27
> processor (board)? Do you have somebody who could help us to modify
> mx27ads.c?

Do you have the same problem if you avoid __ipipe_mach_demux_irq by
#defining __ipipe_mach_irq_mux_p to 0 ? If no, then your problem is in
the __ipipe_mach_demux_irq. But the iMX27ads does not seem to be
included into mainline, I have no clue of what could be wrong.

-- 
                                                 Gilles Chanteperdrix

