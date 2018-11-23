Subject: Re: [PATCH 1/2] cobalt: Return error from xnsched_setparam
References: <a0ae52fe-fa52-124e-b3e2-b82d2755fa10@siemens.com>
 <d90c8eb0-dce1-df0f-4e31-b4c8ba85425e@xenomai.org>
 <4f8f9e52-02a6-2df7-04b3-96a0e6bf56a2@siemens.com>
 <b9383b95-705d-3d75-139a-d07efbe00958@xenomai.org>
 <04be3111-ca5c-7a81-a52a-9f6b83d2c534@xenomai.org>
 <09ac449f-6663-1592-cbe8-9fd7a2dbe71b@siemens.com>
 <fe7d6822-0458-6bf7-a5d6-f3ac5929af64@xenomai.org>
 <e4d26e4f-6053-7096-cf09-88c325da81cb@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e55c8e54-6f5c-86de-5846-865e69378594@xenomai.org>
Date: Fri, 23 Nov 2018 18:32:45 +0100
MIME-Version: 1.0
In-Reply-To: <e4d26e4f-6053-7096-cf09-88c325da81cb@siemens.com>
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

On 11/23/18 6:23 PM, Jan Kiszka wrote:
> On 23.11.18 18:03, Philippe Gerum wrote:
>> On 11/23/18 12:41 PM, Jan Kiszka wrote:
>>> On 23.11.18 12:29, Philippe Gerum wrote:
>>>> On 11/23/18 12:26 PM, Philippe Gerum via Xenomai wrote:
>>>>> On 11/23/18 12:11 PM, Jan Kiszka wrote:
>>>>>> On 23.11.18 11:56, Philippe Gerum wrote:
>>>>>>> On 11/22/18 6:57 PM, Jan Kiszka via Xenomai wrote:
>>>>>>>> This allows to remove the user-triggerable XENO_BUG from
>>>>>>>> xnsched_quota_setparam().
>>>>>>>
>>>>>>> Could you elaborate on the user trigger point you detected in the
>>>>>>> code?
>>>>>>
>>>>>> pthread_setschedparam_ex(pthread_self(), SCHED_QUOTA, <invalid-tgid>)
>>>>>
>>>>> Ouch. That is where the bug is rooted, xnthread_set_schedparam() is a
>>>>> broken obsolete interface which must be dropped entirely. The right
>>>>> way
>>>>> to change the scheduling class and/or parameters of a thread is by
>>>>> calling xnsched_set_policy().
>>>>
>>>> Nope, that won't work either. This needs more thought.
>>>>
>>>
>>> I don't see why catching the invalid tgid down in the sched class this
>>> way is a problem, except that we need to enhance the involved callback
>>> API a bit. The benefit is that no caller needs to deal with this check
>>> and has to become sched-class-aware.
>>>
>>
>> The problem with waiting for xnsched_setparam() to detect the wrong
>> parameter values is that we may have changed the scheduler state by
>> un-readying the target thread as if the operation was poised to succeed
>> already at that point. At the same time, .sched_setparam handlers may
>> assume that the target thread is not part of any runqueue at the time of
>> the call, so there is a catch 22 situation.
>>
>> The clean way to fix this is to have a per-policy handler dedicated to
>> checking a param block early which should be called unconditionally
>> (whether the base class is changed or not) from xnsched_set_policy(). In
>> the same move, that logic should be dropped from .sched_declare handlers.
>>
>> xnthread_set_schedparam() must be kept actually unlike I first thought,
>> there are things we need to do there and nowhere else when updating the
>> sched parameters of a thread. Since xnthread_set_schedparam() relies on
>> xnsched_set_policy() and calls it early enough, we are safe.
>>
> 
> OK, makes sense now. As you have a clear idea already in mind, will you
> write that patch(es)?
> 

Sure.


-- 
Philippe.

