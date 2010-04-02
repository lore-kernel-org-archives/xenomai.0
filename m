Message-ID: <4BB5B7B1.3030601@domain.hid>
Date: Fri, 02 Apr 2010 11:24:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100401230843.GF3755@domain.hid>
	<4BB53566.3010601@domain.hid> <4BB53643.2080604@domain.hid>
	<4BB5AA44.6000006@domain.hid> <4BB5AACE.7020602@domain.hid>
	<4BB5B1BD.6020903@domain.hid> <4BB5B2D3.80708@domain.hid>
In-Reply-To: <4BB5B2D3.80708@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Andreas Glatz wrote:
>>>>>>> Hi Philippe,
>>>>>>>
>>>>>>> At the Xenomai Users Meeting last year I asked you if Xenomai would offer a possibility to lower the priority of certain Xenomai tasks below that of Linux. We need this feature since we have tasks in our RT application which should only run when Linux is idle (A statistics collection task which part of the RT application and hard to isolate from this application).
>>>>>>>
>>>>>> What prevents using a borderline thread (if you need to interact with
>>>>>> blocking Xenomai services) with SCHED_OTHER and a Linux nice level of 19?
>>>>> Well, this does not really guarantee that the thread will run only when
>>>>> linux is idle. The thread will eat some cpu time, the nice level is not
>>>>> a strict priority, as you know.
>>>> Where do you really need anything stricter? It's the opposite of "I need
>>>> true 100% CPU for my task, and that forever."
>>>>
>>>>> But in fact, I wonder why Andreas wants
>>>>> a new scheduling policy for xenomai, what is needed, is simply a
>>>>> SCHED_IDLE (maybe it exists ?!) policy for Linux.
>>>>>
>>>> There is no such thing AFAIK. If you are concerned that some CPU
>>>> intensive low prio job eats too much CPU, you normally reduce its
>>>> nice-level and/or confine its CPU bandwidth via cgroups.
>>> SCHED_IDLE exists.
>>>
>> Ah, as "nice 20". Same mechanism, just another level.
>>
> 
> ...and before trying something else:
> 
> "SCHED_IDLE: This is even weaker than nice 19, but its not a true
> idle timer scheduler in order to avoid to get into priority
> inversion problems which would deadlock the machine."

Mmmm, priority inversion? I thought the kernel had priority inheritance?

-- 
					    Gilles.

