Subject: Re: [PATCH] cobalt/sched-quota: Account for already consumed time on
 limit update
References: <b886e67a-66e2-c0d0-c646-65bccd58dc0f@siemens.com>
 <c1e43c4c-acec-cf03-dc16-2b7da1654aed@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bd398e23-140b-844c-f98c-acff67c37931@siemens.com>
Date: Mon, 26 Nov 2018 13:22:35 +0100
MIME-Version: 1.0
In-Reply-To: <c1e43c4c-acec-cf03-dc16-2b7da1654aed@xenomai.org>
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

On 25.11.18 18:14, Philippe Gerum wrote:
> On 11/21/18 5:59 PM, Jan Kiszka wrote:
>> If we change the quota value of thread group, we should take its already
>> consumed time during the current cycle into account. So far, we refilled
>> the budget blindly, which could have given the group an uncontrolled
>> "peak".
>>
>> This commit first update the run_budget_ns of an active group and kills
>> its limit timer. Then it refills run_budget_ns only with the remaining
>> budget of the current cycle, taking the new quota as limit.
>>
>> Accumulated credits are still dropped - not worth to deal with their
>> complexity in this scenario.
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Philippe, review would be appreciated.
>>
> 
> Looks good.

Thanks. Applied to next now.

> 
>> I'm still struggling with writing a good test case for that.
>>
> 
> Absolutely untested, but what about doing this: calibrate some number
> crunching loop to have it running for a given time you would use as the
> initial quota value (e.g. 1s). Then,
> 
> . set the initial quota value
> . run a test loop for 2/3 of the iterations spent in the calibration loop,
> . decrease the initial quota value by half
> . re-run the test loop, it should not have run more than half of the
> calibrated iterations (+/- some error margin and fluctuations). A broken
> quota implementation would have allowed 2/3 if IIUC.

I think the difference was only visible in the cycle of the adjustment. It 
should have worked fine again on the next, clean round.

> 
> Checking for the actual number of iterations performed during the second
> run could be done from a low priority thread which resumes when the test
> runner is dequeued as the quota expires.
> 
> Both the test runner and the checker should be pinned on the same CPU.
> With QUOTA_PERIOD larger and not too close to the initial quota value,
> this should leave enough time for the low priority thread to check the
> result.
> 

I will think about that. It's annoying when tests turn out to be as complex - if 
not more - as the actual code they test.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

