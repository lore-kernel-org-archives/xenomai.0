Subject: Re: [PATCH 9/9] y2038: testsuite/smokey/y2038: Adding testcase for
 nanosleep64
References: <20210601094334.774394-1-florian.bezdeka@siemens.com>
 <20210601094334.774394-10-florian.bezdeka@siemens.com>
 <e7724a84-cf55-20df-d8ed-fcc79a2772f1@siemens.com>
 <ca922ed2-f24a-60e1-772d-e335b78bbc6b@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b45b901f-27f2-9770-de39-2a54396989c1@siemens.com>
Date: Fri, 4 Jun 2021 14:05:06 +0200
MIME-Version: 1.0
In-Reply-To: <ca922ed2-f24a-60e1-772d-e335b78bbc6b@siemens.com>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>
Cc: chensong@tj.kylinos.cn

On 04.06.21 13:43, Jan Kiszka via Xenomai wrote:
> On 04.06.21 13:41, Jan Kiszka via Xenomai wrote:
>> On 01.06.21 11:43, Florian Bezdeka wrote:
>>> From: chensong <chensong@tj.kylinos.cn>
>>>
>>> Add test case for clock_nanosleep64 in smokey testsuite
>>>
>>> Signed-off-by: chensong <chensong@tj.kylinos.cn>
>>> [Florian: Reword commit msg, syscall()->XENOMAI_SYSCALLx()]
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  testsuite/smokey/y2038/syscall-tests.c | 67 ++++++++++++++++++++++++++
>>>  1 file changed, 67 insertions(+)
>>>
>>> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
>>> index 840be89a5..54d529b6b 100644
>>> --- a/testsuite/smokey/y2038/syscall-tests.c
>>> +++ b/testsuite/smokey/y2038/syscall-tests.c
>>> @@ -242,6 +242,69 @@ static int test_sc_cobalt_clock_settime64(void)
>>>  	return 0;
>>>  }
>>>  
>>> +static int test_sc_cobalt_clock_nanosleep64(void)
>>> +{
>>> +	int ret;
>>> +	int sc_nr = sc_cobalt_clock_nanosleep64;
>>> +	struct xn_timespec64 next, rmt;
>>> +	struct timespec ts1, ts2, delta;
>>> +	long interval = 1;
>>> +
>>> +	/* Make sure we don't crash because of NULL pointers */
>>> +	ret = XENOMAI_SYSCALL4(sc_nr, NULL, NULL, NULL, NULL);
>>> +	if (ret == -ENOSYS) {
>>> +		smokey_note("clock_nanosleep64: skipped. (no kernel support)");
>>> +		return 0; // Not implemented, nothing to test, success
>>> +	}
>>> +	if (!smokey_assert(ret == -EFAULT))
>>> +		return ret ? ret : -EINVAL;
>>> +
>>> +	/* Providing an invalid address has to deliver EFAULT */
>>> +	ret = XENOMAI_SYSCALL4(sc_nr, CLOCK_MONOTONIC, TIMER_ABSTIME,
>>> +			       (void *)0xdeadbeefUL, &rmt);
>>> +	if (!smokey_assert(ret == -EFAULT))
>>> +		return ret ? ret : -EINVAL;
>>> +
>>> +	/* Provide a valid 64bit timespec, round 1 */
>>> +	ret = clock_gettime(CLOCK_MONOTONIC, &ts1);
>>> +	if (ret)
>>> +		return -errno;
>>> +
>>> +	next.tv_sec  = ts1.tv_sec + interval;
>>> +	next.tv_nsec = ts1.tv_nsec;
>>> +
>>> +	ret = XENOMAI_SYSCALL4(sc_nr, CLOCK_MONOTONIC, TIMER_ABSTIME,
>>> +			       &next, (void *)0xdeadbeefUL);
>>> +	if (!smokey_assert(!ret))
>>> +		return ret ? ret : -EINVAL;
>>
>> Unneeded test here - ret is != 0.
>>
>>> +
>>> +	ret = clock_gettime(CLOCK_MONOTONIC, &ts2);
>>> +	if (ret)
>>> +		return -errno;
>>> +
>>> +	timespec_sub(&delta, &ts2, &ts1);
>>> +	if (delta.tv_sec < interval)
>>> +		smokey_warning("nanosleep didn't sleep long enough.");
>>> +
>>> +	/* Provide a valid 64bit timespec, round 2*/
>>> +	next.tv_sec  = ts2.tv_sec + interval;
>>> +	next.tv_nsec = ts2.tv_nsec;
>>> +
>>> +	ret = XENOMAI_SYSCALL4(sc_nr, CLOCK_MONOTONIC, TIMER_ABSTIME, &next, &rmt);
>>> +	if (!smokey_assert(!ret))
>>> +		return ret ? ret : -EINVAL;
>>
>> Same here.
>>
>> I can fix those up - once I understood why they trigger here ATM.
>>
> 
> In fact, if we want to return the real error, errno needs to be
> consulted. What is the intention then?

Err, no, it's direct syscall invocation, no errno at this point yet.

Found the reason for the failing test meanwhile: I was on wip/dovetail
already, and there we have

static inline int pipeline_set_wallclock(xnticks_t epoch_ns)
{
	return -EOPNOTSUPP;
}

Philippe, any particular reason for this?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

