Message-ID: <559E9687.6020109@sigmatek.at>
Date: Thu, 09 Jul 2015 17:43:03 +0200
From: Johann Obermayr <johann.obermayr@sigmatek.at>
MIME-Version: 1.0
References: <559E65FB.8080904@sigmatek.at>
 <20150709141922.GG20176@hermes.click-hack.org>
In-Reply-To: <20150709141922.GG20176@hermes.click-hack.org>
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
Cc: Xenomai@xenomai.org

Am 09.07.2015 um 16:19 schrieb Gilles Chanteperdrix:
> On Thu, Jul 09, 2015 at 02:15:55PM +0200, Johann Obermayr wrote:
>> Hello,
>>
>> we have follow situation
>>
>> u64 lrtdrv_time_of_irq_ns ;
>> void worker_task()
>> {
>> while(1)
>>      {
>>      rtdm_task_sleep_abs(lrtdrv_time_of_irq_ns + 950000ull,
>> RTDM_TIMERMODE_ABSOLUTE);
>>      do_something();
>>      }
>> }
>>
>> _kernel_rtdm_irq_handler()
>> {
>>      lrtdrv_time_of_irq_ns = rtdm_clock_read_monotonic();
>> }
>>
>> the  _kernel_irq_callback() is called every 1ms.
>> we will , that the worker_task begin 50us before next irq
>>
>> But sometime, the worker task start ~50us after irq. Why ?
> Best way to know, enable the I-pipe tracer, setup sufficient back
> trace points, and when the wrong wake up happens, trigger an I-pipe
> trace.
>
i will enable i-pipe tracer.
found out, that

rtdm_task_sleep_abs(xxx, RTDM_TIMERMODE_ABSOLUTE);
u64 calc = rtdm_clock_read_monotonic();

sometime the diff between xxx & calc is biger than 61000ns.

forget to say.
worker_task run on Core1
irq_handler run on Core0

Regards
   Johann

