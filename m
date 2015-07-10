Message-ID: <559F91C3.8090005@sigmatek.at>
Date: Fri, 10 Jul 2015 11:34:59 +0200
From: Johann Obermayr <johann.obermayr@sigmatek.at>
MIME-Version: 1.0
References: <559E65FB.8080904@sigmatek.at>
 <20150709141922.GG20176@hermes.click-hack.org> <559E9687.6020109@sigmatek.at>
 <20150709155115.GK20176@hermes.click-hack.org>
In-Reply-To: <20150709155115.GK20176@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] usage of rtdm_task_sleep_abs
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Am 09.07.2015 um 17:51 schrieb Gilles Chanteperdrix:
> On Thu, Jul 09, 2015 at 05:43:03PM +0200, Johann Obermayr wrote:
>> Am 09.07.2015 um 16:19 schrieb Gilles Chanteperdrix:
>>> On Thu, Jul 09, 2015 at 02:15:55PM +0200, Johann Obermayr wrote:
>>>> Hello,
>>>>
>>>> we have follow situation
>>>>
>>>> u64 lrtdrv_time_of_irq_ns ;
>>>> void worker_task()
>>>> {
>>>> while(1)
>>>>      {
>>>>      rtdm_task_sleep_abs(lrtdrv_time_of_irq_ns + 950000ull,
>>>> RTDM_TIMERMODE_ABSOLUTE);
>>>>      do_something();
>>>>      }
>>>> }
>>>>
>>>> _kernel_rtdm_irq_handler()
>>>> {
>>>>      lrtdrv_time_of_irq_ns = rtdm_clock_read_monotonic();
>>>> }
>>>>
>>>> the  _kernel_irq_callback() is called every 1ms.
>>>> we will , that the worker_task begin 50us before next irq
>>>>
>>>> But sometime, the worker task start ~50us after irq. Why ?
>>> Best way to know, enable the I-pipe tracer, setup sufficient back
>>> trace points, and when the wrong wake up happens, trigger an I-pipe
>>> trace.
>>>
>> i will enable i-pipe tracer.
>> found out, that
>>
>> rtdm_task_sleep_abs(xxx, RTDM_TIMERMODE_ABSOLUTE);
>> u64 calc = rtdm_clock_read_monotonic();
>>
>> sometime the diff between xxx & calc is biger than 61000ns.
> This is called "kernel task scheduling latency". It can be measured by
> the latency -t 1 test.

Ok, i will test it with this test.
Here a simple list of measure from  rtdm_task_sleep_abs(xxx) calc = 
rtdm_clock_read_monotonic
Need = xxx - calc;
Need: -1189
Need: -1433
Need: -1703
Need: -2244
Need: -2330
Need: -2295
Need: -2321
Need: -2252
Need: -2313
Need: -2264
Need: -2306
Need: -2267
Need: -2280
Need: -2245
Need: 27177
Need: 26705
Need: 27497
Need: -2250
Need: -2230
Need: -481
Need: -1723
Need: -1412
Need: -716
Need: -1662
Need: -2369
Need: -2384
Need: -585
Need: -1407
Need: -769
Need: -2253
Need: 26571
Need: 87642
Need: 28411
Need: 41489
Need: -2264
Need: -1638
Need: -435
Need: -492
Need: -2424
Need: -1658
Need: -686
Need: -552
Need: -746
Need: -780
Need: -1655
Need: -1435
Need: -2234
>> forget to say.
>> worker_task run on Core1
>> irq_handler run on Core0
> Are you sure that the tsc is synchronized on both cores (you did not
> give us much information, in particular we do not know on what
> hardware you have this issue).
>
tsc must be sync, because most time it is correct.
It's a Fujitsu Mainboard with Interl 8 Series C220 with dual core
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 60
model name      : Intel(R) Celeron(R) CPU G1820 @ 2.70GHz
stepping        : 3
microcode       : 0x1c
cpu MHz         : 2693.915
cache size      : 2048 KB

Regards
  Johann

