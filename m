Message-ID: <53E3C954.4040200@xenomai.org>
Date: Thu, 07 Aug 2014 20:45:40 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <AE39D2A4-ECC3-481B-AF3B-8A67FA23D2BF@tuebingen.mpg.de>
 <44BE6908-E639-421F-B556-E7B3871402CF@gmail.com>
 <67B7E374-C4D2-4F83-BA40-B289B15867B9@tuebingen.mpg.de>
 <53E3B5E3.3090006@xenomai.org> <53E3C4A2.5090900@xenomai.org>
 <53E3C54B.4040902@xenomai.org>
In-Reply-To: <53E3C54B.4040902@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] real-time guarantee issues on xenomai 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Alexander Herzog <aherzog@tuebingen.mpg.de>, xenomai@xenomai.org

On 08/07/2014 08:28 PM, Gilles Chanteperdrix wrote:
> On 08/07/2014 08:25 PM, Philippe Gerum wrote:
>> On 08/07/2014 07:22 PM, Gilles Chanteperdrix wrote:
>>> On 08/07/2014 06:57 PM, Alexander Herzog wrote:
>>>> Hi Gilles,
>>>>
>>>
>>> Hi Alexander,
>>>
>>> we do not use top-posting on xenomai mailing list.
>>>
>>>> I haven't replied to your email for a few months. I am sorry for
>>>> that, we didn't have time to dig further into this problem. However,
>>>> now we went back to the issue and installed Xenomai 2.6.3 with Linux
>>>> kernel 3.8.13 . Now, if we do not run 'watch -n .1 cat
>>>> /proc/xeno/stat', the latency test is running just fine without
>>>
>>> You mean /proc/xenomai/stat, right?
>>>
>>>> significant latencies. However, the moment we run the watch command
>>>> in parallel, things break down and the latency goes up. Is this an
>>>> issue that other people see as well and is there a fix for it? Thanks
>>>> for your help.
>>>
>>> The problem is not watch, the problem is probably /proc/xenomai/stat,
>>> which creates large latencies by holding the nucleus lock for too long.
>>> The issue probably does not get the attention it deserves, because
>>> /proc/xenomai/stat is something people usually use during debugging
>>> phases, not really on a final system. And it also probably happens in
>>> some conditions only (with a large number of Xenomai threads for
>>> instance), because I never observed it on the systems where I run Xenomai.
>>>
>>
>> That is unlikely, reading /proc/xenomai/stat is done through a snapshot
>> vfile, which has been introduced to fix that issue precisely.
>>
> 
> Maybe I misunderstand the code completely, but it seems to me that
> taking the snapshot is done irqs off, and is proportional to the number
> of xenomai threads, so is bound to take a large time for a large number
> of xenomai threads.
> 

No, the lock is dropped between two consecutive calls to the ->next()
iterator on purpose, i.e. we don't mask for longer than what it takes to
pull the information for a single thread, regardless of how many threads
are present. The snapshot is taken again each time a change in the
thread list is detected, which might have happened while we did not hold
the nklock.

So it all depends on how much more latency is too much in the observed
case, but currently I'm seeing not more than 7 us on average, and 2 us
in the worst case, on a 52xx low end platform running a cat loop on
/proc/xenomai/stat.

-- 
Philippe.

