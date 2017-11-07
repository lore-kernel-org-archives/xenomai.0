References: <0c161e7a-7bc3-1a06-4ccc-2386440a51d2@jan-melcher.de>
 <5c46cfa0-c696-928e-f5d4-356989d7a797@xenomai.org>
 <a7624c9a-9bf2-5912-517a-7a11584856b8@siemens.com>
From: Jan Melcher <mail@jan-melcher.de>
Message-ID: <bc62d172-0a71-b285-9474-5632c22235fe@jan-melcher.de>
Date: Wed, 8 Nov 2017 00:49:55 +0100
MIME-Version: 1.0
In-Reply-To: <a7624c9a-9bf2-5912-517a-7a11584856b8@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Docker / PID Namespaces in Cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com, rpm@xenomai.org

On 07.11.2017 13:06, Jan Kiszka wrote:
> On 2017-11-07 09:23, Philippe Gerum wrote:
>> On 11/07/2017 12:10 AM, Jan Melcher wrote:
>>> However, rt_task_set_periodic/rt_task_wait_period does not work
>>> (rt_task_wait_period just never returns). I figured this is because
>>> Cobalt does not support PID namespaces. Can someone confirm this? Some
>>> log outputs I added suggest that Cobalt is confusing namespace-local and
>>> global PIDs.
>>>
>>
>> Correct.

Thanks.

>>
>>> My question is if you think that fixing PID namespaces would be
>>> sufficent to support Docker with Cobalt.
>>>
>> No idea. I have zero experience in Docker unfortunately.
>>
>
> Maybe it's "just" about using the right kernel functions to resolve
> PIDs.

Yes, we just need to convert from virtual (namespace) vpid to regular 
pid on user-supplied pid values, and vice-versa when we send pids to 
userspace. I did not find a predefined function that does exactly this, 
but there is find_task_by_vpid() which returns the task_struct* where we 
can easily extract the pid.

 > In which details did you debug the topic already, Jan?

I think I got it working now, at least it works for my simple use case 
with a 1s timer. See this [diff] for my patch. It still is cluttered 
with extensive debug output and has a function duplicated, but the 
functionality is there. However, I'm not sure about the part in udd.c 
though (I guess signfy.pid is user-supplied?). I also did not do any 
pid->vpid converting as I did not look for places where pids are sent to 
the userspace.

Regards,
Jan

[diff]: https://github.com/Yogu/xenomai/compare/5ddd81d...e60e2c7

