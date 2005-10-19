Message-ID: <4356459C.30306@domain.hid>
Date: Wed, 19 Oct 2005 15:09:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Testing the adeos-ipipe-2.6.13-ppc-1.0-00.patch
References: <1CFEB358338412458B21FAA0D78FE86D4F0E31@domain.hid>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0E31@domain.hid>
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
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

Fillod Stephane wrote:
> Philippe Gerum wrote:
> [..]
> 
> http://download.gna.org/adeos/patches/v2.6/adeos/ppc/adeos-ipipe-2.6.13-
> ppc-1.0-02.patch
> 
> Here is the result of tests with version 1.0-02 on e500:
> 
> load: ~1 minute ping -f, one run of calibrator chewing 64MiB.
> 
> $ cat /proc/ipipe/version
> 1.0-02
> 
> SWITCH without load:
> RTH|     lat min|     lat avg|     lat max|        lost
> RTD|        3660|        3690|        8070|           0    1.0-00
> RTD|        4620|        4740|        8730|           0    1.0-01
> RTD|        4620|        4740|        8190|           0    1.0-02
> 
> KLATENCY with load:
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|
> RTS|       -7350|       -5715|        6420|       0|    00:03:17 1.0-00
> RTS|       -6150|       -4384|       12180|       0|    00:03:13 1.0-01
> RTS|       -6150|       -4183|       12480|       0|    00:03:38 1.0-02
> 
> LATENCY with load:
> == Sampling period: 100 us
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|
> RTS|       -6930|       -4260|        8700|       0|    00:08:06 1.0-00
> RTS|       -5670|       -4620|       12930|       0|    00:12:39 1.0-01
> RTS|       -5700|       -3750|       11280|       0|    00:06:05 1.0-02
> 
> It looks like the char vs. long in the 1.0-0[12] patch was not the
> culprit,

The last significant change between -00 and -01 is actually the one related to 
the fork pressure (others are cosmetic ones aimed at better sharing stuff with 
the blackfin port). The patch below against -02 removes it.

--- 2.6.13/arch/ppc/kernel/entry.S~	2005-10-18 18:42:09.000000000 +0200
+++ 2.6.13/arch/ppc/kernel/entry.S	2005-10-19 15:07:54.000000000 +0200
@@ -316,10 +316,8 @@

  	.globl	ret_from_fork
  ret_from_fork:
-	STALL_ROOT_COND
  	REST_NVGPRS(r1)
  	bl	schedule_tail
-	UNSTALL_ROOT_COND
  	li	r3,0
  	b	ret_from_syscall

> at least not on e500. I'll do the bench again on 1.0-00. Man, if only we
> had that automated benchmark suite...
> 

Indeed... The positive thing being that, we now have the ultimate proof of its 
usefulness :o>

-- 

Philippe.

