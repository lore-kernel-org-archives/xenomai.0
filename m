Message-ID: <4559FA51.6050002@domain.hid>
Date: Tue, 14 Nov 2006 18:18:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Don't call __ipipe_mach_set_dec
	in	rthal_timer_release directly
References: <E1Gjcbu-0006ZA-4a@domain.hid>
In-Reply-To: <E1Gjcbu-0006ZA-4a@domain.hid>
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
> Hi,
> 
> here's a proposal for a minor change in the I-pipe implementation for ARM. 
> Since it is required for my S3C24xx patch not to call __ipipe_mach_set_dec 
> directly when the timer is released by the Xenomai domain I suggest the 
> following changes. The patch comprises the necessary modifications for PXA, 
> SA1100 and Integrator, too.
> 
> Comments or objections?

Why can not you call __ipipe_mach_set_dec directly when the timer is
released ?

-- 
                                                 Gilles Chanteperdrix

