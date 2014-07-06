Message-ID: <53B91D72.8030503@xenomai.org>
Date: Sun, 06 Jul 2014 11:57:06 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1404638402.36454.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B91595.9060604@xenomai.org>
 <1404639382.8763.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53B91C45.8090802@xenomai.org>
In-Reply-To: <53B91C45.8090802@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question about threadobj_irq_prio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/06/2014 11:52 AM, Philippe Gerum wrote:
> On 07/06/2014 11:36 AM, Matthias Schneider wrote:
>> ----- Original Message -----
>>
>>> From: Philippe Gerum <rpm@xenomai.org>
>>> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org"
>>> <xenomai@xenomai.org>
>>> Cc:
>>> Sent: Sunday, July 6, 2014 11:23 AM
>>> Subject: Re: [Xenomai] Question about threadobj_irq_prio
>>>
>>> On 07/06/2014 11:20 AM, Matthias Schneider wrote:
>>>>   Hi all,
>>>>
>>>>   I was under the expression that the max cobal scheduling prio in
>>>>   forge was now 256 and that SCHED_COBALT had been replaced with
>>>>   SCHED_FIFO. Is this correct?
>>>>
>>>
>>> Yes.
>>>
>>>>   Anyway,
>>>>
>>>>   threadobj_pkg_init(void) initializes
>>>>   threadobj_irq_prio = __RT(sched_get_priority_max(SCHED_CORE));
>>>>   which is still mapping to 258 - however I would rather expect
>>>>   256...
>>>>
>>>
>>> 256 regular FIFO levels, +2 special levels for scheduler lock (mercury
>>> only) and interrupt service emulation (both cores).
>>>
>>>
>>>>   Thanks for clarification,
>>>>
>>>>   regards,
>>>>   Matthias
>>>>
>>
>> I get
>>
>> threadobj_high_prio = 258
>> threadobj_irq_prio = 259
>> threadobj_agent_prio = 258
>>
>> and
>>
>> e.g. int psos_task_normalize_priority(unsigned long psos_prio)
>>
>> clips the prio to threadobj_high_prio. However it should
>> clip prio at threadobj_high_prio - 2, shouldnt it?
>>
>
> Even 256 explicitly, since pSOS specifies this limit.
>

No, we can't do that over Mercury, where we only have the limited 1-97 
range available. So that would be high_prio -2 for Cobalt, but high_prio 
for Mercury. copperplate should be fixed on the Cobalt side.

-- 
Philippe.

