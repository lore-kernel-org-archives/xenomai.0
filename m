Message-ID: <5012A8CD.7080509@xenomai.org>
Date: Fri, 27 Jul 2012 16:42:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALH4WdYdUKfMrsJUHqQYTh84GgMWErpCYUJMmZVtxxngdNoStQ@mail.gmail.com>	<50129907.5040306@siemens.com>	<CALH4WdYGnV6hwgAtLT5pLVsFaAqT5BmZS82ueZV9LRTuby-97A@mail.gmail.com>	<50129F1F.5030205@xenomai.org>
	<5012A035.60107@xenomai.org>
In-Reply-To: <5012A035.60107@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] cpu usage
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik.bayart@triphase.com>
Cc: xenomai@xenomai.org

On 07/27/2012 04:05 PM, Gilles Chanteperdrix wrote:

> On 07/27/2012 04:01 PM, Gilles Chanteperdrix wrote:
> 
>> On 07/27/2012 03:58 PM, Frederik Bayart wrote:
>>
>>> The use case is : we are using an i7 processor. We noticed that
>>> internally, the processor is shifting frequency to minimize idle time.
>>> (This is not done by linux, we used cpufreq to avoid that but there is
>>> still some software on the processor that is shifting frequency). This
>>> has as consequence that the required rate of our realtime process,
>>> which is a periodic task, becomes to fast for the processor.
>>> To avoid downscaling of the cpu frequency, we had the  idea to run
>>> additionally a busywait loop at priority 0 so that the processor is
>>> always running at 100%, there is no idle time and the frequency will
>>> not scale down.
>>>
>>> We want only 1 core running at 100% for temperature reasons.
>>
>>
>> Then simply put the busy loop in a task not running with real-time
>> priority. A plain Linux task. You should also use the SCHED_IDLE policy
>> in order to avoid it to delay other non real-time task.
>>
> 
> 
> BTW, do you have CONFIG_CPU_IDLE enabled ? Because that could be the
> reason why you get delayed wakeups.
> 

Something else again: if the BIOS is actually modifying the cpu
frequency, it could do so using SMIs, in that case you could disable
SMIs to avoid the problem.

-- 
                                                                Gilles.

