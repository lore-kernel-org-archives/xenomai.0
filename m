Message-ID: <545BD88B.3030700@xenomai.org>
Date: Thu, 06 Nov 2014 21:22:35 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <545B9297.2090003@cgglobal.com>
 <20141106153738.GC30908@sisyphus.hd.free.fr> <545B994D.1080008@cgglobal.com>
 <20141106155503.GD30908@sisyphus.hd.free.fr> <545BA5D0.7010907@cgglobal.com>
In-Reply-To: <545BA5D0.7010907@cgglobal.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_sleep_until() miss release point?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alberto.ozalla@cgglobal.com, "gilles.chanteperdrix@xenomai.org" <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/06/2014 05:46 PM, ZIV-Alberto Ozalla Cantabrana wrote:
> Hi,
> 
> These are the simplest examples:
> There are no MSW for Test_Task.
> The goal is to increment counter_ms each millisecond.
> 
> Given that:
> 1000000 nanoseconds = 24000 tsc.
> 1 tsc = 41 ns
> 

Is rt_timer_ns2tsc(1000000) actually returning 24000 on your platform?

> void Test_Task(void *arg)
> {
>    rt_task_set_mode(0, 0, NULL);

This is useless and not recommended. A newly created task always starts
in primary mode.

>     while (1) {
> 
>             unsigned long long before = counter_ms;
>             usleep(1000000);    // 1 second.

Although this would rather cause higher count values, this non-rt main
using a non-rt sleep service won't give you an accurate delay for the
measurement.

-- 
Philippe.

