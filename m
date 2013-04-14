Message-ID: <516A4497.9010801@xenomai.org>
Date: Sun, 14 Apr 2013 07:54:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <3B6652EE-A4C6-4819-B3BB-DB02EFA1B08B@mah.priv.at>
In-Reply-To: <3B6652EE-A4C6-4819-B3BB-DB02EFA1B08B@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kconfig CONFIG_XENO_OPT_TIMING_PERIODIC=y/n
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 01/29/2013 01:54 PM, Michael Haberler wrote:

> I'm testing linuxcnc with John's 3.5.7 - 2.6.2.1 kernel and found an
> issue with the deprecated linuxcnc xenomai-kernel threads version
> (the userland threads version is fine; both using native skin). I
> traced that back to rt_timer_ticks2ns(30000) returning zero.


Hi Michael,

I am unable to reproduce this issue. I have written the following 
kernel code:

#include <native/timer.h>

int init(void)
{
	rt_timer_set_mode(0);
	xnprintf("mode aperiodic, ticks2ns: %Lu\n", rt_timer_ticks2ns(30000));
	rt_timer_set_mode(1000000);
	xnprintf("mode periodic, ticks2ns: %Lu\n", rt_timer_ticks2ns(30000));
			
	return 0;
}

module_init(init);
MODULE_LICENSE("GPL");

And I get:
[   17.366373] Xenomai: mode 0, ticks2ns: 30000                                    
[   17.370918] Xenomai: mode periodic, ticks2ns: 30000000000                       

Which is the expected behaviour.

Could you send us a test case allowing to reproduce the issue you 
encountered ?


-- 
                                                                Gilles.

