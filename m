Subject: Re: [PATCH] cobalt/sched-quota: Account for already consumed time on
 limit update
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <b886e67a-66e2-c0d0-c646-65bccd58dc0f@siemens.com>
 <c1e43c4c-acec-cf03-dc16-2b7da1654aed@xenomai.org>
 <bd398e23-140b-844c-f98c-acff67c37931@siemens.com>
Message-ID: <e8cddf7c-de69-db28-12d9-e90b01bca0d7@siemens.com>
Date: Mon, 26 Nov 2018 15:22:03 +0100
MIME-Version: 1.0
In-Reply-To: <bd398e23-140b-844c-f98c-acff67c37931@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 26.11.18 13:22, Jan Kiszka wrote:
> On 25.11.18 18:14, Philippe Gerum wrote:
>> On 11/21/18 5:59 PM, Jan Kiszka wrote:
>>> If we change the quota value of thread group, we should take its already
>>> consumed time during the current cycle into account. So far, we refilled
>>> the budget blindly, which could have given the group an uncontrolled
>>> "peak".
>>>
>>> This commit first update the run_budget_ns of an active group and kills
>>> its limit timer. Then it refills run_budget_ns only with the remaining
>>> budget of the current cycle, taking the new quota as limit.
>>>
>>> Accumulated credits are still dropped - not worth to deal with their
>>> complexity in this scenario.
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> Philippe, review would be appreciated.
>>>
>>
>> Looks good.
> 
> Thanks. Applied to next now.
> 

...and it will go into stable as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

