Message-ID: <459A2B04.5060201@domain.hid>
Date: Tue, 02 Jan 2007 10:51:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Recommendation for ARM/blackfin based buildbot
	test	machine
References: <200612301553.05588.niklaus.giger@domain.hid>
In-Reply-To: <200612301553.05588.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi
> 
> Can anybody recommend a cheap (Anything below 200 US$ will probably fit into 
> our family budget) ARM system, where I could test the ARM port of Xenomai? 
> E.g. could I buy a LinkSys NSLU2 (around 100 Euros)? It seems that at least 
> Debian is quite popular on it. 
> 
> Best regards

ARM is not like x86: every ARM processor has its own interrupt
controller and timer management, so the I-pipe patch need to be adapted
to each board. Currently, the I-pipe patch supports the Integrator, the
IMX21, SA1100 and PXA based boards and s3c2410, and there should be a
port to AT91 soon. According to linux configuration, the LinkSys NSLU2
is based on Intel IXP4XX processors, for which there is not yet an
official port. But if you are willing to do the port, we will be glad to
help.

-- 
                                                 Gilles Chanteperdrix

