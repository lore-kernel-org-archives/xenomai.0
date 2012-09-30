Message-ID: <5068B094.3070607@xenomai.org>
Date: Sun, 30 Sep 2012 22:50:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5063141B.8070107@siemens.com>
	<1348665363-28222-1-git-send-email-wolfgang.mauerer@siemens.com>
	<50637398.3090108@xenomai.org> <50640E35.5010302@siemens.com>
	<506440BF.50001@xenomai.org> <50644ACA.5080906@siemens.com>
	<50649C10.8070809@xenomai.org> <506560B4.3010703@siemens.com>
In-Reply-To: <506560B4.3010703@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/2] Refactor ipipe_select_timers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/28/2012 10:32 AM, Wolfgang Mauerer wrote:

> On 27/09/12 20:33, Gilles Chanteperdrix wrote:
>> On 09/27/2012 02:47 PM, Wolfgang Mauerer wrote:
>>
>>> On 27/09/12 14:04, Gilles Chanteperdrix wrote:
>>>> On 09/27/2012 10:28 AM, Wolfgang Mauerer wrote:
>>>>> On 26/09/12 23:28, Gilles Chanteperdrix wrote:
>>>>>> On 09/26/2012 03:16 PM, Wolfgang Mauerer wrote:
>>> (...)
>>>
>>>>>> Talking about readability, I find a goto with a clear label name much
>>>>>> more readable than a flag. So, NACK this patch, please keep the goto.
>>>>>  
>>>>> So you're against the refactoring, or only against using the flag?
>>>>> Keeping the goto leads to something like
>>>>>
>>>>> 	if (install_pcpu_timer(cpu, hrclock_freq, t))
>>>>> 		goto found
>>>>> (...)
>>>>> found:    ;
>>>>>
>>>>> since we need a statement for the label, but nothing is left to do.
>>>>> I find this fairly ugly, but if you prefer it over a flag, then
>>>>> so be it.
>>>>
>>>> Then use return instead of goto...
>>>
>>> Won't work -- that skips the rest of the enclosing per_cpu loop and
>>> the second part of the function introduced in the follow-up commit
>>> that does the actual bugfixing.
>>>
>>> Since I take the flag is the issue and not the refactoring as such, 
>>> please find an updated patch with a goto below.
>>
>>
>> Oh boy, you love functions, do you? What I would do is: keep the test
> sure() :)
>> for evtdev->mode outside of the install_pcpu_timer function so that we
>> clearly see in the loop that it is the only reason for continuing the
>> loop. Then use the goto found, and at the found label, call the now void
>> function install_pcpu_timer. Ok for you?
>>
> okay, changed the code as desired to introduce more labels and use the 
> preprocessor more often. Please pick 23b2de46314 and b738a3b624 from 
> https://github.com/siemens/ipipe core-3.5_for-upstream (apply also
> cleanly to core-4).


Ok. Applied to my for-core-4 branch, thanks.

-- 
                                                                Gilles.

