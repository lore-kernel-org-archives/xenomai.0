Message-ID: <4B1FAF0E.2060709@domain.hid>
Date: Wed, 09 Dec 2009 15:07:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B1F9E26.7070900@domain.hid> <4B1FA901.7070903@domain.hid>
	<4B1FACFB.2010809@domain.hid>
In-Reply-To: <4B1FACFB.2010809@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Waiting w/o burning CPU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jozsef Lazar <jlazar@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Jozsef Lazar wrote:
> Gilles Chanteperdrix =EDrta:
>> Jozsef Lazar wrote:
>>  =20
>>> Hi,
>>>
>>> Could anyone tell me which Xenomai function should I use to wait (even =

>>> up to 100msecs) without burning CPU. I tried using nanosleep() but it=20
>>> was always returning with 1 (one) and analyzing my output pins with an =

>>> oscilloscope I couldn't see any time delays. Now I use rt_timer_spin() =

>>> but I'm not sure whether I'm doing any wrong to my rt threads (or anyon=
e=20
>>> else in the kernel). My environment: a kernel driver with lots of rt=20
>>> threads controlling stepper motors. The function where I want to wait i=
s=20
>>> a work_struct task (called by a schedule_work). Thanks.
>>>    =20
>>
>> A work_struct task is a Linux task, not a xenomai thread. Xenomai
>> functions work for Xenomai thread. The behaviour of nanosleep is
>> documented here:
>>
>> http://www.xenomai.org/documentation/xenomai-2.4/html/api/group__posix__=
time.html#ga9ce6a1ed91a601dee133c8b6cf8b721a
>>
>> 1 is EPERM.
>>
>>  =20
> Thank you for your answer. I thought that I have such a problem. Any
> suggestions which function should I use?

Linux provides several functions for suspending threads, such as msleep,
schedule_timeout_interruptible, wait_event_interruptible, whatever you
want. Anyway this question is related to Linux, not to Xenomai, so you
will find better answers in other places than on Xenomai mailing-lists,
I am not even sure you can suspend a work queue.

Please do not drop the CC to mailing list when replying.

Regards.

--=20
                                          Gilles


