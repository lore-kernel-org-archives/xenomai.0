Message-ID: <4A295F43.9090904@domain.hid>
Date: Fri, 05 Jun 2009 20:09:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A294F59020000F80002DC0E@msw.eppendorf.de>
	<200906051932.16827.karl.tyss@domain.hid>
In-Reply-To: <200906051932.16827.karl.tyss@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ-Latency when in idle State on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Karl Tyss wrote:
> Right before the cpu is put to sleep by cp15 the I-cache is being disabled in 
> the idle task. I took this part out. So I leave the I-cache enabled when the 
> cpu goes into the idle mode. I suppose that there is a reason for disabling 
> the cache. I will ask my wise ARM book on monday. If this issue doesn't belong 
> here (xenomai list) just say a word :)

Yes, you probably can not do that. You will find the answer in the
documentation for the arm926EJS core, since this file only concerns this
core.

On the other hand, as Bosko suggested, if you use the nohlt kernel
option, you will avoid the idle function altogether, and the I-cache
will not be disabled then re-enabled.

-- 
					    Gilles.


