Message-ID: <4D9EA8A4.80601@domain.hid>
Date: Fri, 08 Apr 2011 08:18:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110407170855.GA22659@domain.hid>
	<4D9E0354.4010600@domain.hid>
	<20110407190258.GA27879@domain.hid>
	<20110407201204.GA4913@domain.hid>
	<4D9E1DDA.1000503@domain.hid>
	<20110408060503.GA6174@domain.hid>
	<20110408061213.GB6174@domain.hid>
In-Reply-To: <20110408061213.GB6174@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Richard Cochran <richardcochran@domain.hid>
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

Richard Cochran wrote:
> In ipipe_tsc_asm.S you have at the end of the file...
> 
> /* User-space entry-point: r0 is the hardware counter virtual address */
> #ifndef CONFIG_CPU_BIG_ENDIAN
> /* Little endian */
> 
> ...
> 
> #else /* Big endian */
> /* Little endian */
> 1: ldr	  r1, .LCdec16_last_tsc + 4
>    ldr	  ip, [r0]
>    ldr	  r2, .Ldec16_Clast_cnt
> ---------------^
> 
> Did you mean ".LCdec16_last_tsc" here?

You do not really care about this code, since it is for 16 bit
decrementers (currently only the integrator or the S3C has this, and
they are not big endian machines). But yes.

-- 
                                                                Gilles.

