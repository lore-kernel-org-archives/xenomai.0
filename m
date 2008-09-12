Message-ID: <48CAA459.2010604@domain.hid>
Date: Fri, 12 Sep 2008 19:18:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48CA7E5D.3080608@domain.hid> <48CA8941.5030005@domain.hid>
	<48CA90E8.2080909@domain.hid>
In-Reply-To: <48CA90E8.2080909@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] __pse51_get_current_prio
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
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
>>> we've integrated your unit_mutex and our native test, but now we
>>> stumbled over that __pse51_get_current_prio special syscall to check the
>>> dynamic thread priority (during pi tests). I guess that service only
>>> exists in your private patch queue? What are your plans about this in
>>> case we want to push the mutex test into mainline? Or should we check
>>> the thread prio indirectly (by waking up a lower-prio thread)?
>> I had plan to remove this from unit_mutex. OTOH, it may come in handy if
>> we start breaking the xnsynchs...
> 
> Maybe one could invent some "pthread_inquire_np" so that the usefulness
> of this extension increases beyond unit tests.

Ok. What about splitting struct sched_param contents into two (16 bits)
members ? This way we would get the two priorities with an only
pthread_get_schedparam syscall.
On the other hand, when using pthread_inquire_np, we could get some more
insteresting information such as the task name, its current wchan, the
mutexes it holds etc...

-- 
					    Gilles.

