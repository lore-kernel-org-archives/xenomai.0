Message-ID: <4AF68CA8.6010105@domain.hid>
Date: Sun, 08 Nov 2009 10:17:28 +0100
From: Bernhard Walle <bernhard@domain.hid>
MIME-Version: 1.0
References: <566451a98761369f757a.1257105488@domain.hid>
	<1257111269.2065.596.camel@domain.hid>
In-Reply-To: <1257111269.2065.596.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Check frequency in xnarch_init_timeconv()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

Philippe Gerum schrieb:
> 
> I agree with the conclusion, not with the fix.

Thanks for reviewing the patch and sorry for the late answer.

> - the kernel side should rather test RTHAL_CPU_FREQ for consistency in
> the generic hal init code, and bail out with an error if 0 is detected,
> since there is no way for the nucleus to operate properly with such
> setting anyway.
> 
> It turns out that no change have to be done in xnarch_init_timeconv()
> which should remain a void routine, but its argument - RTHAL_CPU_FREQ -
> should rather be tested as early as possible for consistency, directly
> from kernel space.

I'll post a new patch right now.


Regards,
Bernhard


