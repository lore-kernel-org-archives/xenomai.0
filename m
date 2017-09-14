References: <CAB6vvjke_16vivYH6+6QJiDR__5zcUBihvAe5+0S+CVKt1Qx8g@mail.gmail.com>
 <cda6fe24-2a17-03af-b6b0-58b63dc82a82@xenomai.org>
 <CAB6vvjno8Ysd6k7fKpEkyfU-S+myKNd517ju0-X0nAOiQPJMPw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <16d2a2b6-388b-bbe8-6196-397735d5b2cb@xenomai.org>
Date: Thu, 14 Sep 2017 18:29:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAB6vvjno8Ysd6k7fKpEkyfU-S+myKNd517ju0-X0nAOiQPJMPw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Can't wait on conditions on 3.0.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Hoarau <hoarau.robotics@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/14/2017 06:08 PM, Antoine Hoarau wrote:
> Le jeu. 14 sept. 2017 à 16:30, Philippe Gerum <rpm@xenomai.org> a écrit :
> 
>> On 09/14/2017 02:03 PM, Antoine Hoarau wrote:
>>> Hello,
>>> I'm porting a library that uses Xenomai 2.6.5 native to 3.0.5 alchemy on
>> an
>>> x64 Ubuntu 16.04 + Cobalt kernel 4.9.38.
>>>
>>> I'm stuck on conditions that do not wait signals to be emitted :
>>>
>>> int ret = rt_cond_wait_until(cond, mutex, rt_timer_ns2ticks(abs_time) )
>>> returns -ETIMEDOUT immediately.
>>>
>>> >From the documentation : -ETIMEDOUT is returned if abs_timeout is reached
>>> before the condition variable is signaled. But I verified that
>>> rt_timer_ns2ticks(abs_time)  > rt_timer_read(), so it should wait.
>>>
>>
>> You may want to check your calling args, e.g. wait for a second before
>> timeout:
>>
>>         ret = rt_cond_wait_until(&cond, &mutex, rt_timer_read() +
>> 1000000000ULL);
>>         if (ret)
>>                 error(1, -ret, "rt_cond_wait_until");
>>
>> Same. It returns directly with -ETIMEDOUT.

This code works as expected here. You may want to provide a simple test
case illustrating the bug on your end.

> 
> 
>>> This lead me to beleive that something was wrong with the mutex.
>>>
>>
>> I'm unsure to understand why.
>>
>> If I look at the code, the return value can be the return of the mutex if
> something is wrong :
> https://git.xenomai.org/xenomai-3.git/tree/lib/alchemy/cond.c#n382

You must have locked the mutex before calling rt_cond_wait*(), so if you
did so, then such mutex has to be valid at the time of the call. The
code you refer to can only return -EINVAL if invalid, so this can't be.

-- 
Philippe.

