Message-ID: <4B757BC8.7020305@domain.hid>
Date: Fri, 12 Feb 2010 17:03:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B757217.3060406@domain.hid> <4B757306.5070102@domain.hid>
	<4B7575B9.2060707@domain.hid>
In-Reply-To: <4B7575B9.2060707@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Yet another ((weak)) bug
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
>>> Hi Gilles,
>>>
>>> this one requires some fixing too:
>>>
>>> xeno_sem_heap is marked weak. xeno_init_sem_heaps is called once per
>>> initialized skin. It unmaps any existing heap and creates a new one.
>>> That's already fragile during constructor run, but it's lethal during
>>> process runtime, ie. when using dlopen.
>>>
>>> I think the solution is to handle forks separately and only remap in
>>> that case. Digging in this direction now.
>>>
>>> BTW, what triggers the re-run of xeno_init_sem_heaps after a fork so far?
>> It must be done for the child process to get a private heap different
>> from the parent process. I would guess it is handled by pthread_atfork.
> 
> Ah, only the POSIX skin does that. However, sem-heaps must not be
> POSIX-only. OK, patch in the make.

Ok. I am thinking more and more that you are right about making
libxeno_common a standalone library. Only the name stinks, we should
find a better one.


-- 
					    Gilles.

