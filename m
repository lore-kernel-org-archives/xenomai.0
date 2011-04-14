Message-ID: <4DA6E57B.9080600@domain.hid>
Date: Thu, 14 Apr 2011 14:15:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTikTWM75UZknkYRt=MeOUDJVsNmLAA@mail.gmail.com>	<4DA463D2.9030502@domain.hid>	<BANLkTi=YMQzg9943duUB2kdvawpYs7Z8KQ@mail.gmail.com>	<4DA46DA4.8070007@domain.hid>
	<BANLkTi=0JqnSnWzj34nk1-4ufRt-sEnr7A@mail.gmail.com>
In-Reply-To: <BANLkTi=0JqnSnWzj34nk1-4ufRt-sEnr7A@mail.gmail.com>
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
> On Tue, Apr 12, 2011 at 10:20 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> Jeff Weber wrote:
>>> Gilles:
>>>
>>> On Tue, Apr 12, 2011 at 9:38 AM, Gilles Chanteperdrix <
>>> gilles.chanteperdrix@xenomai.org> wrote:
>>>
>>>> Jeff Weber wrote:
>>>>
>>>> Hi Jeff,
>>>>
>>>> any news about the hostrt patch I sent you for x86_32? Does it work?
>>>>
>>> Yes it works.  However my call to clock_gettime(CLOCK_HOST_REALTIME)
>> takes
>>> too long (110 nsec on my CPU) for my ISR, so I will read the TSC instead,
>>> and convert the TSC to host time in another thread.  Thanks for your help
>>> though.
>> Wow, it makes me wonder what kind of ISR with a multi-us latency can not
>> handle a 110ns service. But I admit that the hostrt clock_gettime
>> service is a bit heavy. I am afraid there is not much we can do. Could
>> you get me disassembly of the kernel-space clock.o file, so that I
>> verify that we do not end up using divisions? For instance
>> clock_gettime(CLOCK_MONOTONIC) is wrong, and uses the real division.
>>
> 
> See attached.  Let me know if attachment gets stripped off along the way.
> 
>>>
>>>>> From testing, I found that if I enable PTHREAD_WARNSW for a pthread, I
>>>> must
>>>>> explicitly disable this mode before the thread terminates, or the
>> thread
>>>>> draws a signal 24 SIGXCPU.
>>>> Yes, the problem is that we can put such migration if the thread
>>>> function returns, but it will not work in case pthread_exit is called.
>>>>
>>> I'm interested if there is a way to automatically disable PTHREAD_WARNSW
>> as
>>> threads terminate, using return from the entry function.  I was only
>> using
>>> pthread_exit() to leverage the thread cleanup stack capability, and queue
>> a
>>> call to pthread_set_mode_np(PTHREAD_WARNSW, 0) .
>> You can do that in the trampoline in src/skins/posix/thread.c, right
>> after the call to entry(cookie). I will send a patch tonight if you prefer.
>>
> 
> Yes, a patch would be appreciated at your earliest convenience.  No need to
> rush it tonight. Do you consider this a candidate for released code, or
> should I consider this a 1-off?

Ok. Here it comes. Sorry for the delay.
diff --git a/src/skins/posix/thread.c b/src/skins/posix/thread.c
index 109650c..c913ac4 100644
--- a/src/skins/posix/thread.c
+++ b/src/skins/posix/thread.c
@@ -235,6 +235,7 @@ static void *__pthread_trampoline(void *arg)
 		if (policy != SCHED_OTHER)
 			XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
 		status = start(cookie);
+		XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
 	} else
 		status = (void *)-err;
 
Since it does not fix the issue completely, I am not sure it is the right
solution. I guess doing something in kernel-space would be better.

-- 
					    Gilles.

