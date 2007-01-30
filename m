Message-ID: <45BF17CE.9030808@domain.hid>
Date: Tue, 30 Jan 2007 11:02:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] I-pipe patch for linux 2.6.19 on ARM.
References: <45BF08D8.5050208@domain.hid>
In-Reply-To: <45BF08D8.5050208@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Hi,
> 
> here comes the I-pipe patch for linux 2.6.19 on ARM. In addition to the
> upgrade to linux 2.6.19, the AT91 port is improved:
> - it waits for the console to be enabled or about 2 minutes before
> panicing if the configured frequency is wrong;
> - the timer counter used as time source is chosen when configuring the
> kernel;
> - it uses the kernel clock interface in order to enable the timer
> counter clock instead of tweaking directly the registers.
> 

A few more words about this patch; I had to reduce the list of files
included in asm-arm/ipipe.h and include linux/irq.h in
kernel/ipipe/core.c otherwise the kernel did not compile with
CONFIG_PREEMPT enabled. There are a few new enable_irq in entry-armv.S
and I was not sure what to do about them, so I simply leaved them.

-- 
                                                 Gilles Chanteperdrix

