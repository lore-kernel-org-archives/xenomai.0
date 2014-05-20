Message-ID: <537B49EA.8020005@xenomai.org>
Date: Tue, 20 May 2014 14:26:18 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <537A5F9B.4040308@xenomai.org> <537B015E.5070107@xenomai.org>
 <537B27C9.9020908@xenomai.org> <537B2A5B.3090100@xenomai.org>
 <537B2D63.9030709@xenomai.org>
In-Reply-To: <537B2D63.9030709@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] timer drift
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 05/20/2014 12:24 PM, Gilles Chanteperdrix wrote:
> On 05/20/2014 12:11 PM, Philippe Gerum wrote:
>> On 05/20/2014 12:00 PM, Philippe Gerum wrote:
>>> On 05/20/2014 09:16 AM, Gilles Chanteperdrix wrote:
>>>> On 05/19/2014 09:46 PM, Gilles Chanteperdrix wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> when running the latency test modified to use timerfds on forge, I
>>>>> noticed that we have a clock vs timer drift issue (on forge, not on
>>>>> 2.6,
>>>>> and only since recent changes).
>>>>>
>>>>> What the latency test does is create a periodic timer, and when waking
>>>>> up at each tick, compare the actual wake-up time, with the expected
>>>>> wake-up time. The problem is that, on the timer side, the
>>>>> computation is
>>>>> more precise, because it is the sum of short durations computed with
>>>>> xnarch_llmulshft, whereas on the clock side, we pass larger and larger
>>>>> values to xnarch_llmulshft, so at some point, the error due to the
>>>>> approximation begins to be within the range of observable
>>>>> differences (a
>>>>> few micro-seconds after hours of tests). I have verified that
>>>>> replacing
>>>>> xnarch_llmulshft with xnarch_nodiv_llimd avoids the issue. And I
>>>>> believe
>>>>> mainline does not have the same issue because they always pass small
>>>>> durations to the multiplication + shift operation.
>>>>
>>>> The question being: what do we do to avoid this issue?
>>>>
>>>>
>>>
>>> IIUC, assuming clock_gettime() delivers ns2tsc(N * period_ns), we may
>>> have to fix the timer interval update code in xnclock_tick() which
>>> produces N * (ns2tsc(period_ns)). Aligning both could be the right path,
>>> maybe compensating for the overhead using the clock gravity?
>>>
>>
>> s/clock gravity/timer gravity/ which would then depend on the timer
>> being periodic or not. We'd need to calibrate this adjustement cost on
>> low end architectures, only to make sure this is worth the burden.
>>
> The overhead is a multiplication followed by the computation of ns2tsc,
> which is an llmulshft, so only takes a few nanoseconds. We have the
> "arith" test which measures llmulshft. The worst case I have is on
> at91rm9200 a few hundreds of nanoseconds, with latency in the 200us range.
>
> I think it is best to leave the gravity configuration to the user, as we
> have always done. Maybe having a "per timer-class" gravity would make
> sense (for user vs kernel thread vs kernel timer and periodic vs
> one-shot), but it seems it would make the tuning complicated.
>

With Cobalt, timers now have a thread affinity.

-- 
Philippe.

