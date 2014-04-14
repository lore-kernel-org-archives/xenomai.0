Message-ID: <534C4608.9090200@xenomai.org>
Date: Mon, 14 Apr 2014 22:33:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPRPZsAmXEyH4wcMeGcWPB3B-3=04DoS=K2k-QbQ+DidPcptAg@mail.gmail.com>
 <534BD82E.6080205@xenomai.org>
 <CAPRPZsCkGj=n4LJeduM5MJM0UbAcjwg+5uZkNnAn9dSGwaKeoQ@mail.gmail.com>
In-Reply-To: <CAPRPZsCkGj=n4LJeduM5MJM0UbAcjwg+5uZkNnAn9dSGwaKeoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Slow execution of RT task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/14/2014 10:18 PM, Jeroen Van den Keybus wrote:
>> Do you have CONFIG_NO_HZ_FULL enabled? If so, could you disable it and
>> retry? Next step, same question for CONFIG_NO_HZ_IDLE.
> 
> Same results, but now latency figures are somewhat higher:
> 
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> RTD|      0.035|      0.288|      7.512|       0|     0|      0.035|      7.512
> RTD|     -0.661|      0.294|      7.626|       0|     0|     -0.661|      7.626
> RTD|     -0.680|      0.293|      7.907|       0|     0|     -0.680|      7.907
> 
> rt_timer_read still requires 1.6 us (or at least that's what I get
> back from rt_timer_read).

Maybe the clocksource is no longer the tsc? What does:

cat /sys/devices/system/clocksource/clocksource0/current_clocksource

say?


-- 
                                                                Gilles.

