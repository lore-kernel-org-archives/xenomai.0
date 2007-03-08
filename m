Message-ID: <45F00C03.7000604@domain.hid>
Date: Thu, 08 Mar 2007 14:13:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Mach - LPC22xx Support
References: <e45fe62b0703080135q7ec8865eg8cba0efe20102053@domain.hid>
In-Reply-To: <e45fe62b0703080135q7ec8865eg8cba0efe20102053@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Preetam Joshi <j.preetam@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Preetam Joshi wrote:
> Is there no support for Mach-LPC22xx because i have applied the patch
> adeos adeos-ipipe-2.6.14-arm-1.3-04.patch for ARM but no where in the
> patch file do i find support for mach-LPC22xx. THere is support for
> mach-integrator due to which i get  compilation errors.  I have linux
> running on ARM LPC22xx platform for which i would like to know whether
> there is any support????

Adeos I-pipe for ARM needs to be adapted to support a new machine. So,
some work is needed to have Adeos run on Mach-LPC22xx. I do not seem to
find LPC22xx in the kernel configuration, is there some separated patch
? Maybe LPC22xx is supported by ucLinux ?

-- 
                                                 Gilles Chanteperdrix

