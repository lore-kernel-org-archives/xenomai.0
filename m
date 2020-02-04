Subject: Re: [RFC] simplify wait_for_rcu_grace_period
References: <1498b3cc-767f-703c-116b-ae102be3e510@siemens.com>
 <9555bd80-150f-19d2-ddac-d92ac01b0ac1@xenomai.org>
 <df780f75-e210-5c09-fa3a-ecb564868e6e@siemens.com>
 <f6a24e2d-d5ce-9013-aacb-6f097853443b@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <686faea3-6afc-91f0-1b77-975a7a7f4b57@siemens.com>
Date: Tue, 4 Feb 2020 10:09:44 +0100
MIME-Version: 1.0
In-Reply-To: <f6a24e2d-d5ce-9013-aacb-6f097853443b@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 04.02.20 09:44, Philippe Gerum wrote:
> On 2/3/20 8:00 PM, Jan Kiszka wrote:
>> On 03.02.20 19:51, Philippe Gerum wrote:
>>> On 1/31/20 9:43 PM, Jan Kiszka wrote:
>>>> Hi Philippe,
>>>>
>>>> any reason why you didn't use synchronize_rcu for
>>>> wait_for_rcu_grace_period back then?
>>>>
>>>
>>> Likely because because we might observe multiple grace periods between
>>> the moment joinee->exited is posted and the joinee eventually
>>> schedules out.
>>>
>>
>> I didn't find a difference in the logic you open-coded and what the
>> kernel does behind synchronize_rcu, therefore I'm asking.
>>
> 
> So you mean you would want to replace call_rcu() + completion with
> synchronize_rcu()? Sure you could.

Yes, that is my proposal.

> 
>>>>
>>>>
>>>> I'm currently debugging a hanging xnthread_join in
>>>> wait_for_rcu_grace_period and stumbled over this (both variants hang
>>>> equally well, though).
>>>>
>>> I'm not entirely surprised. Fully relying on RCU for this was more of a
>>> work around to address the module unload issue rather than a reliable
>>> fix.
>>>
>>
>> The lockup is on synchronize_rcu / the open-coded waiting itself. The
>> joinee is long gone. And that lockup goes away when switching to
>> HZ_PERIODIC. I still need to dig deeper to understand why we get no
>> update in that particular case.
>>
> 
> Is the joiner blocked on the completion waiting for a grace period which
> never ends? Or, is the task never unregistered from the pid table?
> 

We are stuck in the completion waiting, not on checking for the pid to 
become invalid.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

