Date: Fri, 8 Apr 2011 08:05:03 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110408060503.GA6174@domain.hid>
References: <20110407170855.GA22659@domain.hid>
	<4D9E0354.4010600@domain.hid>
	<20110407190258.GA27879@domain.hid>
	<20110407201204.GA4913@domain.hid>
	<4D9E1DDA.1000503@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D9E1DDA.1000503@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] ARM IXP: ipipe regression from
 2.6.31 to .33 and .35
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

On Thu, Apr 07, 2011 at 10:26:02PM +0200, Gilles Chanteperdrix wrote:
> 
> On my side, I meant to say, the issue is in the implementation of the
> I-pipe one-shot timer, the function ipipe_mach_set_dec...

I couldn't find anything wrong there, but I did find this...

In ipipe_tsc_asm.S you have

 #ifndef CONFIG_CPU_ENDIAN_BE8
 /* Little endian */
	ldr	r0, [r0]
	cmp	r2, r0
	adc	r1, r3, #0
 #else /* Big endian */
	ldr	r1, [r0]
	cmp	r3, r1
	adc	r0, r2, #0
 #endif /* Big endian */

but my .config has

 CONFIG_ARCH_SUPPORTS_BIG_ENDIAN=y
 CONFIG_CPU_BIG_ENDIAN=y
 # CONFIG_CPU_ENDIAN_BE8 is not set
 CONFIG_CPU_ENDIAN_BE32=y

and the machine really is big endian, so that might make a difference.

Richard




