Message-ID: <4AC63536.2010802@domain.hid>
Date: Fri, 02 Oct 2009 19:15:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580909300343y3bf44fedh8dbc8d7e27fead4d@domain.hid>	
	<4AC346C7.4040600@domain.hid>
	<1f3e02580910020652p7bc52284p7e26573669e1a05b@domain.hid>
In-Reply-To: <1f3e02580910020652p7bc52284p7e26573669e1a05b@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Guide] To patch Linux Kernel with Xenomai for
 Unknown core
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Didenko Sergey <didenkos@domain.hid>
Cc: xenomai@xenomai.org

Didenko Sergey wrote:
>>> For now on I have done with:
>>>
>>> - prepare kernel with adeos patch
>>> - configure kernel with its original defconfig file (the original
>>> configuration is verified and working fine on target board)
>>> - building kernel (and here we are!)
>>>
>>> 2) I did add implementation for (even though the  I did not find any
>>> link to it in HOWTO, so I referred to PXA's implementation):
>>> __ipipe_check_tickdev (called from kernel\core.c)
>>>
>>> And for:
>>> mv88f6290_osmr0_set_mode
>>> mv88f6290_osmr0_set_next_event
>>> ckevt_mv88f6290_osmr0
>>> Even though all of them are required by __ipipe_mach_release_timer() I
>>> did not find in HOWTO how these functions should be implemented for
>>> MYCORE, so I referred to PXA's implementation again.
> 
> *Gilles:*
> No, you should not add these functions. They already exist if your board
> supports GENERIC_CLOCKEVENT and GENERIC_TIME.
> 
> *Sergey:*
> Unfortunately no, there is no these functions for my board, there are only
> for "arm\mach-pxa" and "arm\mach-sa1100".

Then your board does not support GENERIC_CLOCKEVENT and GENERIC_TIME,
and you should skip the section about it in the howto.

> 
> *Q1: Does the fact that these options are enabled or disabled in kernel's
> .config file effects on how kernel code has been patched?*
> *
> *
> *Q2: Could anyone please explaine more exactly what do these options
> (GENERIC_CLOCKEVENT
> and GENERIC_TIME) mean? What are they doing and how? I realy want to
> understand it, but can not find any information about it.*

ask the internet.
http://lkml.indiana.edu/hypermail/linux/kernel/0701.2/1799.html
http://www.linuxworld.com/news/2007/022807-kernel.html
http://kernelnewbies.org/Linux_2_6_21#head-8547911895fda9cdff32a94771c8f5706d66bba0
http://lwn.net/Articles/223185/

-- 
					    Gilles.

