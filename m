From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.1.10.1108171557300.25850@domain.hid>
References: <alpine.DEB.1.10.1108171557300.25850@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Aug 2011 16:26:20 +0200
Message-ID: <1313591180.18802.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Freeze with gpio-keys with Xenomai on Blackfin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

On Wed, 2011-08-17 at 16:04 +0200, Kolja Waschk wrote:
> Hi,
> 
> I was just trying to use the gpio-keys driver on a Blackfin BF537 in
> uClinux environment with Xenomai integrated. However, whenever a key
> is pressed (regardless whether anyone reads from input event dev),
> the whole system freezes. No more communication, no network access.
> Without Xenomai however, I was able to use the driver.
> 
> Before I set up my JTAG interface to get more details (need to make a new
> cable...) I'd like to ask if anyone else has experienced this (and remedy..)?

Most likely the low level interrupt path for gpios is not ipipe-aware in
this kernel, arch/blackfin/kernel/bfin_gpios.c might be at fault. You
may want to check with 2.6.35.9 first, to make sure this has not been
solved during the latest update, in which case you could backport the
fixes.

The bottom line is that interrupts should always be handled according to
the level policy (i.e. masked while pending handling), and
hard_local_irq_disable/save should be in effect for code that might be
traversed over both the linux and xenomai domains (typically anything
triggered from __ipipe_grab_irq).

> 
> - Linux version 2.6.34.7-ADI-2010R1
> - I-pipe 1.15-01
> - Xenomai: real-time nucleus v2.5.5.2
> 
> Thanks,
> Kolja
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



