Message-ID: <49FF46BB.8050106@domain.hid>
Date: Mon, 04 May 2009 21:49:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0905041110140.10290@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0905041110140.10290@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Defensive IRQ allocation procedure.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai@xenomai.org

Martin Shepherd wrote:
> Am I correct in believing that an RTDM driver can safely call
> request_irq() from its non-realtime ioctl_nr() callback? I want to do
> this to verify that a non-realtime driver isn't using the same IRQ as
> my realtime device, before I attempt to use it in my RTDM driver, and
> as well as to prevent any non-realtime drivers from allocating that
> IRQ once I have started to use it. I can't do this at module
> initialization time, because I don't know which of our identical
> digital I/O boards is connected to what, until I perform I/O to them,
> and not all of them need interrupts.

Yes, this should work. Note however, that request_irq will work even if
there is another irq handler registered with IRQF_SHARED, and you pass
IRQF_SHARED too.

-- 
					    Gilles.

