Message-ID: <4B026454.9080604@domain.hid>
Date: Tue, 17 Nov 2009 09:52:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580911161827y4926a14fm1facd405efa44ba4@domain.hid>
In-Reply-To: <1f3e02580911161827y4926a14fm1facd405efa44ba4@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Patch to support ARM_MV
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sergey Didenko <didenkos@domain.hid>
Cc: xenomai@xenomai.org

Sergey Didenko wrote:
> Hello
> 
> This is a patch which includes the changes for xenomai-2.4.10 release,
> required to support the ARM based targets controlled by plat-orion timer,
> irq and gpio.

Ok. In __ipipe_mach_demux_irq, you must call ipipe_handle_irq, not
desc_handle_irq. ipipe_mach_get_tscinfo also needs fixing (type should
be IPIPE_TSC_TYPE_FREERUNNING_COUNTDOWN, and counter should be set to
timer0's physical address, not virtual address, and if you do that, you
can remove the FIXME comment).

-- 
					    Gilles.

