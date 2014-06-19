Message-ID: <53A2EE7D.5040205@xenomai.org>
Date: Thu, 19 Jun 2014 16:06:53 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <53A2C543.8060706@geensyde.fr> <53A2DC06.10005@geensyde.fr>
In-Reply-To: <53A2DC06.10005@geensyde.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: Periodic high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: thierry mallard <thierry.mallard@geensyde.fr>, xenomai@xenomai.org


Hi,

On 06/19/2014 02:48 PM, thierry mallard wrote:
>
> Hi,
>
> I have installed xenomai 2.6.3 with a kernel 2.6.38.8 on my dell laptop
> using adeos-ipipe-2.6.38.8-x86-2.11-03.patch.

If using a more recent kernel is an option, then you may want to 
consider switching to 3.8+.

> CPU is i5-3230M.
>
>
> When running xeno latency, I get the following results.
> What can be the cause of the high latencies that I get periodically?
>
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
> best|--lat worst
> RTD|     17.600|     42.573|     60.172|       0|     0| 17.600|     60.172
> RTD|     17.699|     45.817|    379.512|       3|     0| 17.600|    379.512

This could be a SMI issue:

http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_the_latency_test_shows_high_latencies

As a first step, you should check the boot log for SMI-related messages 
from Xenomai, such as:

http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#SMI

-- 
Philippe.

