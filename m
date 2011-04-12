Message-ID: <4DA46DA4.8070007@domain.hid>
Date: Tue, 12 Apr 2011 17:20:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTikTWM75UZknkYRt=MeOUDJVsNmLAA@mail.gmail.com>	<4DA463D2.9030502@domain.hid>
	<BANLkTi=YMQzg9943duUB2kdvawpYs7Z8KQ@mail.gmail.com>
In-Reply-To: <BANLkTi=YMQzg9943duUB2kdvawpYs7Z8KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread exit and PTHREAD_WARNSW
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

Jeff Weber wrote:
> Gilles:
> 
> On Tue, Apr 12, 2011 at 9:38 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> Jeff Weber wrote:
>>
>> Hi Jeff,
>>
>> any news about the hostrt patch I sent you for x86_32? Does it work?
>>
> 
> Yes it works.  However my call to clock_gettime(CLOCK_HOST_REALTIME) takes
> too long (110 nsec on my CPU) for my ISR, so I will read the TSC instead,
> and convert the TSC to host time in another thread.  Thanks for your help
> though.

Wow, it makes me wonder what kind of ISR with a multi-us latency can not
handle a 110ns service. But I admit that the hostrt clock_gettime
service is a bit heavy. I am afraid there is not much we can do. Could
you get me disassembly of the kernel-space clock.o file, so that I
verify that we do not end up using divisions? For instance
clock_gettime(CLOCK_MONOTONIC) is wrong, and uses the real division.

> 
> 
>>> From testing, I found that if I enable PTHREAD_WARNSW for a pthread, I
>> must
>>> explicitly disable this mode before the thread terminates, or the thread
>>> draws a signal 24 SIGXCPU.
>> Yes, the problem is that we can put such migration if the thread
>> function returns, but it will not work in case pthread_exit is called.
>>
> 
> I'm interested if there is a way to automatically disable PTHREAD_WARNSW as
> threads terminate, using return from the entry function.  I was only using
> pthread_exit() to leverage the thread cleanup stack capability, and queue a
> call to pthread_set_mode_np(PTHREAD_WARNSW, 0) .

You can do that in the trampoline in src/skins/posix/thread.c, right
after the call to entry(cookie). I will send a patch tonight if you prefer.

> 
>>> I've tried to simplify my thread terminations by pushing a function which
>>> calls pthread_set_mode_np(PTHREAD_WARNSW, 0) onto the thread cleanup
>> stack,
>>> and always terminating the thread via pthread_exit().  However, this
>> method
>>> still draws a signal 24 SIGXCPU.    Here's a sample backtrace:
>> ... and pthread_exit is basically a Linux service, so, we can not
>> guarantee that it does not make any syscall before executing the cleanup
>> handlers.
>>
> 
> Right, I saw there was no  __wrap_pthread_exit
> in /usr/xenomai/lib/libpthread_rt.so

That is something else we can do, add a __wrap_pthread_exit which
removes the bit before calling __read_pthread_exit. Neither of the two
methods will work for pthread_cancel though.

> 
> Jeff
> 
>> --
>>                                             Gilles.
>>
> 


-- 
					    Gilles.

