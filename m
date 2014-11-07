Message-ID: <545C93E8.3060206@xenomai.org>
Date: Fri, 07 Nov 2014 10:42:00 +0100
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
> RT_TASK Test_Task_descriptor;
> volatile unsigned long long counter_ms;
> 
> void Test_Task(void *arg)
> {
>     rt_task_set_mode(0, 0, NULL);
> 
>     RTIME t1, t2;
>     counter_ms = 0;
> 
>     while(1) {
>         t1 = rt_timer_tsc();
>         t2 = t1 + 24000;        // 24000 tsc = 1 ms
>         rt_task_sleep_until(rt_timer_tsc2ns(t2));

rt_task_sleep_until() refers to the real-time clock for applying delays,
i.e. adjusted with the wallclock offset. You can't pass it a value based
on the monotonic clock. This is why using timevals based on
rt_timer_read() works, but using rt_timer_tsc() doesn't.

-- 
Philippe.

