Message-ID: <42e7a155-acb3-5501-c9ab-5a132d07efbd@siemens.com>
Date: Tue, 15 Mar 2022 07:35:57 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] cobalt/sched: Use nr_cpumask_bits instead of BITS_PER_LONG
Content-Language: en-US
References: <20220314203841.28925-1-richard@nod.at>
 <421920084991b71be00040eb54d09518a9fc21a9.camel@siemens.com>
 <e7429d0af3506cc26ad9e62586bdf93db8e00bf1.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <e7429d0af3506cc26ad9e62586bdf93db8e00bf1.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "richard@nod.at" <richard@nod.at>

On 14.03.22 22:13, Bezdeka, Florian via Xenomai wrote:
> On Mon, 2022-03-14 at 21:05 +0000, Bezdeka, Florian via Xenomai wrote:
>> Hi Richard,
>>
>> On Mon, 2022-03-14 at 21:38 +0100, Richard Weinberger via Xenomai
>> wrote:
>>> BITS_PER_LONG is too broad, the max number of usable bits is limited
>>> by nr_cpumask_bits.
>>
>> I agree, BITS_PER_LONG seems wrong. But couldn't it be too small as
>> well? It depends on NR_CPUS which might be > BITS_PER_LONG.
> 
> Sorry that was unclear. I assume that the size of the cpumask depends
> somehow on NR_CPUS, which might be > BITS_PER_LONG. So BITS_PER_LONG
> might be too small AND might be too broad.
> 

Good hint, I've adjusted this on merge.

Thanks,
Jan

>>
>> Regards,
>> Florian
>>
>>> Found while debugging a system with CONFIG_DEBUG_PER_CPU_MAPS enabled.
>>>
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> ---
>>>  kernel/cobalt/sched.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
>>> index 88c4951ed814..aa65fd7f5d63 100644
>>> --- a/kernel/cobalt/sched.c
>>> +++ b/kernel/cobalt/sched.c
>>> @@ -1370,7 +1370,7 @@ static int affinity_vfile_show(struct xnvfile_regular_iterator *it,
>>>  	unsigned long val = 0;
>>>  	int cpu;
>>>  
>>> -	for (cpu = 0; cpu < BITS_PER_LONG; cpu++)
>>> +	for (cpu = 0; cpu < nr_cpumask_bits; cpu++)
>>>  		if (cpumask_test_cpu(cpu, &cobalt_cpu_affinity))
>>>  			val |= (1UL << cpu);
>>>  
>>> @@ -1395,7 +1395,7 @@ static ssize_t affinity_vfile_store(struct xnvfile_input *input)
>>>  		affinity = xnsched_realtime_cpus; /* Reset to default. */
>>>  	else {
>>>  		cpumask_clear(&affinity);
>>> -		for (cpu = 0; cpu < BITS_PER_LONG; cpu++, val >>= 1) {
>>> +		for (cpu = 0; cpu < nr_cpumask_bits; cpu++, val >>= 1) {
>>>  			if (val & 1) {
>>>  				/*
>>>  				 * The new dynamic affinity must be a strict
>>
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

