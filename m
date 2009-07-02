Message-ID: <0c82df0dd948df7bce6df51115e217cf.squirrel@domain.hid>
In-Reply-To: <4A4C5EE0.6050900@domain.hid>
References: <4A48FB71.6070506@domain.hid> <4A49CD81.4060706@domain.hid>
	<4A49CFF0.7070202@domain.hid> <1246353623.7803.21.camel@domain.hid>
	<4A49D935.3060900@domain.hid> <1246353913.7803.24.camel@domain.hid>
	<4A49DA4E.2020604@domain.hid> <1246354047.7803.25.camel@domain.hid>
	<4A49DC0A.5000208@domain.hid> <4A4A391B.8000700@domain.hid>
	<4A4B4ED4.6020208@domain.hid> <4A4B558D.20307@domain.hid>
	<4A4B58E9.4050407@domain.hid> <4A4B5985.3070504@domain.hid>
	<4A4B8617.5000704@domain.hid> <4A4B8851.9070005@domain.hid>
	<4A4B8912.1060700@domain.hid> <4A4BA334.8090701@domain.hid>
	<1246472157.7803.62.camel@domain.hid> <1246472833.7803.67.camel@domain.hid>
	<4A4C15DC.80106@domain.hid> <4A4C52B2.9070000@domain.hid>
	<4A4C5ADB.5080602@domain.hid> <4A4C5EE0.6050900@domain.hid>
Date: Thu, 2 Jul 2009 09:44:18 +0200 (CEST)
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] x86: Endless minor faults
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>


Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> On archs with non-atomic switch_mm(), use_mm() will require a different
>>> strategy. I'm thinking about something like
>>>
>>> use_mm():
>>> 	set_some_flag();
>>> 	barrier();
>>> 	current->mm = new_mm;
>>> 	current->active_mm = new_mm;
>>> 	switch_mm(old_active_mm, new_mm, current);
>>> 	clear_some_flag();
>>>
>>> and switch_mm():
>>> 	...
>>> 	if (likely(prev != next) || some_flag_set()) {
>>> 		clear_some_flag();
>>> 		...
>>>
>>> ie. enforce mm switch if we may have interrupted use_mm at an
>>> unpleasant
>>> time. I just don't know yet where to attach that some_flag to. Should
>>> be
>>> the current task, but can we always access it from switch_mm?
>>
>> These mechanisms are already in place. All you have to do is:
>>
>> use_mm()
>> 	ipipe_active_mm = NULL;
>> 	barrier();
>> 	current->mm = new_mm;
>> 	current->active_mm = new_mm;
>> 	switch_mm(old_active_mm, new_mm, current);
>>
>
> As far as I understand, ipipe_active_mm has different semantics on ARM.
> Specifically, it has no relation to the initial "next != prev" check.
> The test we need is likely orthogonal to this.

Well except that prev is ipipe_active_mm, so if NULL next != prev is
always true. ipipe_active_mm set to NULL means that the mm state is
currently unknown, what it triggers is that if Xenomai switches at this
moment, it will forcibly reload the mm state, and when switching back to
Linux it will not touch the mm state, but mark the MMSWITCHINT flag in the
current thread state, switch_mm will detect the flag and restart the mm
switch. This mechanism is well tested and we would have had problems
before if it was not working (the mm switch on ARM does a full cache flush
which stands for about 100us, so the chances to be preempted at this
moment are in fact pretty high).

So, I still think that setting ipipe_active_mm to NULL at the beginning of
use_mm is all what is needed, else I do not understand what you are
talking about.

-- 
                    Gilles.


