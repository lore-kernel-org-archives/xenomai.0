From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Don't call __ipipe_mach_set_dec in
	rthal_timer_release directly
Date: Wed, 15 Nov 2006 11:25:31 +0100
References: <E1Gjcbu-0006ZA-4a@domain.hid>
	<E1GkGzN-0000BF-EJ@mailer.emlix.com> <455AE6D8.8020008@domain.hid>
In-Reply-To: <455AE6D8.8020008@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1GkHxT-0002G8-RJ@mailer.emlix.com>
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
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Sebastian Smolorz wrote:
> > Gilles Chanteperdrix wrote:
> >>You can avoid this problem by adding LATCH or
> >>__ipipe_mach_ticks_per_jiffy to the current value of the match register
> >>in the timer interrupt, as it is done for the SA and PXA architectures.
> >
> > Unfortunately, this solution is not applicable. The timers of PXA and SA
> > are counting up whereas the S3C24xx timers are counting down to zero.
> > There is no match register for the next interrupt. In contrast, the timer
> > must be programmed with the new dec value directly, thus stopping it for
> > the time of re-programming.
>
> Right, you are in the same case as the integrator platform.

Yes. But I cannot adopt the integrator's re-programming of the timer in the 
Linux timer interrupt handler because this would lead to lost ticks or rather 
to longer periods. Therefore I proposed the patch.

--
Sebastian

