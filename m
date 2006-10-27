Message-ID: <454216BB.4090507@domain.hid>
Date: Fri, 27 Oct 2006 16:24:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] I-pipe patch for ARM S3C24xx
References: <E1Gapzw-0005RB-Ob@domain.hid>
	<E1GdSZr-0001Pg-BV@mailer.emlix.com>
In-Reply-To: <E1GdSZr-0001Pg-BV@mailer.emlix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

Sebastian Smolorz wrote:
> Hi,
> 
> here comes version 2 of the I-pipe patch for the S3C24xx ARM. The reported 
> problem is solved, the timer works as expected as far as I can see. Linux is 
> still there after insmod'ding the native skin. More test results will follow 
> next week after I tortured the new patch with the whole testsuite 
> arsenal. ;-)
> 
> The patch has got two suboptimal characteristics due to the generic ARM I-pipe 
> implementation which I did not want to change during the first steps:
> 
> 1. Regarding the demux of chained IRQs (See [1]). As the S3C24xx has more than 
> one chained IRQ there are two consecutive queries for them in 
> __ipipe_mach_irq_mux_p() and __ipipe_mach_demux_irq(). This could be 
> optimized.

You should use switch/case instead of if else if else if, the generated
code would be better optimized.

-- 
                                                  Gilles Chanteperdrix

