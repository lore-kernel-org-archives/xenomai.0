Message-ID: <4B8E97FC.5060502@domain.hid>
Date: Wed, 03 Mar 2010 18:10:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B8D0EEA.3090409@domain.hid> <4B8D10C5.9050108@domain.hid>
	<4B8D156F.7000604@domain.hid> <4B8D535A.10209@domain.hid>
	<4B8E9649.1060902@domain.hid>
In-Reply-To: <4B8E9649.1060902@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Which process synchronization primitive?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Daniele Nicolodi wrote:
> Gilles Chanteperdrix wrote:
>> Daniele Nicolodi wrote:
>>> Gilles Chanteperdrix wrote:
>>>>> I think message queues can work well but I'm not sure they are the best
>>>>> choice when I do not have to communicate any message. Would be
>>>>> semaphores best suited to my needs?
>>>> You can use process-shared mutexes or semaphores.
>>> There is somewhere a comparison of the overhead of the different
>>> solutions? Do I need to do my own benchmarks? Is the API the only
>>> difference?
>> Mutexes have the lowest overhead, since they can be handled in
>> user-space starting with the 2.5 branch.
>>
>> Differences betwenn mutexes and semaphores are the same with Xenomai
>> than with any other known API: mutexes are binary semaphores with a
>> notion of ownership.
> 
> Thanks for the clarification. I have been reviewing the documentation
> and I think that what I need is a mutex with a condition variable shared
> between processes, or a semaphore.
> 
> The reason is that in my application I have processes that consume data
> produced by other processes, and I need to suspend the execution of the
> consumer until the producer has new data to handle.
> 
> Are condition variables also implemented in user space, so that their
> overhead is smaller compared to semaphores?

No. Condition variables imply scheduler decisions and context switches,
which can only occur in kernel-space, so, it would not really make sense
to implement them in user-space. The only case for which it would be
interesting is when you are signaling a condition while no thread is
waiting for it, but this case, is not really interesting in practice.

Please do not forget to C the mailing list.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

