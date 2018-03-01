References: <9dee4e70-9bce-2fac-2aba-f27e65a9c1ba@tuebingen.mpg.de>
 <50805f15-f8c3-a47d-0b05-7b722d44a73e@xenomai.org>
 <9607c407-8524-0006-910d-941a07d1f9d8@tuebingen.mpg.de>
 <96be225a-62dd-0aca-91f5-d0efdd97307f@xenomai.org>
From: Julian Viereck <jviereck@tuebingen.mpg.de>
Message-ID: <31cb225a-dd40-fa3a-37e9-139691ea01f4@tuebingen.mpg.de>
Date: Thu, 1 Mar 2018 12:46:52 -0500
MIME-Version: 1.0
In-Reply-To: <96be225a-62dd-0aca-91f5-d0efdd97307f@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Xenomai] Low latency under stress, otherwise high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

> 1) disable hyperthreading and running a single core
Seems like the latency problem is due to enabled hyperthreading.

I reran the latency tests with hyperthreading disabled and the latencies 
stay below 20 microseconds now. This is with 1 and 8 cores. Sorry for 
reporting something different yesterday.

Thanks a lot for your help,
Julian


On 03/01/2018 04:24 AM, Philippe Gerum wrote:
> On 02/28/2018 10:40 PM, Julian Viereck wrote:
>> Thanks for your pointer to hwlatdetect and possible SMI issues.
>>
>> It looks like the hwlatdetect script is not working with the latest
>> kernel anymore. However, it appears the hwlat is now part of the
>> kernel's ftrace [1]. Here is the kernel documentation about how to use
>> and understand the trace loge file [2].
>>
>> Using a trace window of 1sec, trace width of 0.5 sec and tracing_thresh
>> of 20 microseconds, there are no unexpected latencies detected by the
>> hwlat tool. Therefore, I doubt the issue is due to SMI interrupts.
>>
>> In the meantime, I've also tested:
>>
>> 1) disable hyperthreading and running a single core
> 147 us is clearly pathological Xenomai-wise. This can't be a SMT/SMP
> overhead.
>
>> 2) run the xenomai latency test from the console before booting the x11
>> desktop (to rule out any graphics issues)
>>
>> In both cases, the high latencies under no-workload remains.
>>
> What are the exact settings regarding the CPU_IDLE and CPU_FREQ
> (governor) frameworks?
>
>> Any other ideas what to look into / debug / run traces on?
>>
> At this point, we'd need a pipeline trace. Could you take a snapshot
> with this tool [1] by running the latency test with the -f option?
>
> [1] http://xenomai.org/2014/06/using-the-i-pipe-tracer/
>


