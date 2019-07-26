Subject: Re: [PATCH v2] derivers/autotune: Fix UBSAN warnings
References: <b7202c1c-436f-3ae6-b648-b703da5dcf14@siemens.com>
 <179f5463-27eb-b6e0-f59f-d24a130b70d8@xenomai.org>
 <0140e116-90fc-bf61-7136-fa477daa0f5f@siemens.com>
 <4e765512-9a0c-d25e-945a-1733e471d9c8@xenomai.org>
 <b8f8d916-9096-d6f4-757c-76bbd114f0fa@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <63dc1e0f-7fad-3b23-b88a-87f7f328d693@xenomai.org>
Date: Fri, 26 Jul 2019 19:05:14 +0200
MIME-Version: 1.0
In-Reply-To: <b8f8d916-9096-d6f4-757c-76bbd114f0fa@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 7/26/19 7:01 PM, Jan Kiszka wrote:
> On 26.07.19 18:51, Philippe Gerum wrote:
>> On 7/26/19 5:49 PM, Jan Kiszka wrote:
>>> On 26.07.19 17:28, Philippe Gerum via Xenomai wrote:
>>>> On 7/26/19 5:23 PM, Jan Kiszka via Xenomai wrote:
>>>>> The calculations in add_sample can overflow into undefined behavior - or
>>>>> even generate wrong results. Address that by giving related fields in
>>>>> tuner_state more space.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>>  - Use long long to account for int=long on 32-bit archs
>>>>>
>>>>>  kernel/drivers/autotune/autotune.c | 6 +++---
>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/kernel/drivers/autotune/autotune.c b/kernel/drivers/autotune/autotune.c
>>>>> index 2629bf9d47..6476550822 100644
>>>>> --- a/kernel/drivers/autotune/autotune.c
>>>>> +++ b/kernel/drivers/autotune/autotune.c
>>>>> @@ -56,9 +56,9 @@ struct tuner_state {
>>>>>  	xnticks_t step;
>>>>>  	int min_lat;
>>>>>  	int max_lat;
>>>>> -	int prev_mean;
>>>>> -	int prev_sqs;
>>>>> -	int cur_sqs;
>>>>> +	long long prev_mean;
>>>>> +	long long prev_sqs;
>>>>> +	long long cur_sqs;
>>>>>  	unsigned int sum;
>>>>>  	unsigned int cur_samples;
>>>>>  	unsigned int max_samples;
>>>>>
>>>>
>>>> Ack.
>>>>
>>>
>>> Self-nack: Breaks on 32-bit ARM at least, needs v3.
>>>
>>
>> This is only a divmod issue, right? We can use Xenomai's optimized arith
>> ops for that.
>>
> 
> Yes. But it seems it also works if we only prev/cur_sqs, leaving prev_mean with
> int and, thus, resolving the need to dived a large number.
> 

Ok. If UBSAN does not bark at prev_mean, we should not either.

-- 
Philippe.

