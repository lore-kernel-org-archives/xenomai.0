Message-ID: <455AE6D8.8020008@domain.hid>
Date: Wed, 15 Nov 2006 11:07:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Don't call __ipipe_mach_set_dec in
	rthal_timer_release directly
References: <E1Gjcbu-0006ZA-4a@domain.hid>
	<E1GkGSD-0007Z8-0a@domain.hid> <455AD828.4040801@domain.hid>
	<E1GkGzN-0000BF-EJ@mailer.emlix.com>
In-Reply-To: <E1GkGzN-0000BF-EJ@mailer.emlix.com>
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

Sebastian Smolorz wrote:
> Gilles Chanteperdrix wrote:
>>You can avoid this problem by adding LATCH or
>>__ipipe_mach_ticks_per_jiffy to the current value of the match register
>>in the timer interrupt, as it is done for the SA and PXA architectures.
> 
> 
> Unfortunately, this solution is not applicable. The timers of PXA and SA are 
> counting up whereas the S3C24xx timers are counting down to zero. There is no 
> match register for the next interrupt. In contrast, the timer must be 
> programmed with the new dec value directly, thus stopping it for the time of 
> re-programming.

Right, you are in the same case as the integrator platform.

-- 
                                                 Gilles Chanteperdrix

