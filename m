Message-ID: <48762746.4040009@domain.hid>
Date: Thu, 10 Jul 2008 17:14:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48760BCD.3080505@domain.hid> <48761DC0.3080901@domain.hid>
	<48762472.3000901@domain.hid>
In-Reply-To: <48762472.3000901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/2] Provide owner name
	via	rt_mutex_inquire
Reply-To: rpm@xenomai.org
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
>>> This can be helpful for debugging the (futile) release attempts of
>>> mutexes by tasks that do not own them.
>>>
>>> Returning the RT_TASK reference may appear more consistent on first
>>> sight, but it cannot be guaranteed that the owner is actually a native
>>> task. Therefore this patch uses the symbolic name.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>> ---
>>>  include/native/mutex.h    |    3 +++
>>>  ksrc/skins/native/mutex.c |    5 +++++
>>>  2 files changed, 8 insertions(+)
>>>
>>> Index: b/include/native/mutex.h
>>> ===================================================================
>>> --- a/include/native/mutex.h
>>> +++ b/include/native/mutex.h
>>> @@ -38,6 +38,9 @@ typedef struct rt_mutex_info {
>>>  
>>>      char name[XNOBJECT_NAME_LEN]; /**< Symbolic name. */
>>>  
>>> +    char owner[XNOBJECT_NAME_LEN]; /**< Symbolic name of the current
>>> owner,
>>> +                        empty if unlocked. */
>>> +
>>>  } RT_MUTEX_INFO;
>>>  
>>>  typedef struct rt_mutex_placeholder {
>>> Index: b/ksrc/skins/native/mutex.c
>>> ===================================================================
>>> --- a/ksrc/skins/native/mutex.c
>>> +++ b/ksrc/skins/native/mutex.c
>>> @@ -597,6 +597,11 @@ int rt_mutex_inquire(RT_MUTEX *mutex, RT
>>>      strcpy(info->name, mutex->name);
>>>      info->lockcnt = mutex->lockcnt;
>>>      info->nwaiters = xnsynch_nsleepers(&mutex->synch_base);
>>> +    if (mutex->lockcnt)
>>> +        strcpy(info->owner,
>>> +               xnthread_name(xnsynch_owner(&mutex->synch_base)));
>> xnthread_name is not necessarily null terminated, so I would suggest to
> 
> In fact, that is lethal for other users as well (trace points and proc
> dumps come to my mind) and should be fixed ASAP.
> 

xnthread_name() shall be considered as null terminated, the payload area is
actually XNOBJECT_NAME_LEN - 1. Users who do not assume this are the ones that
need fixing (like xnobject_copy_name).

-- 
Philippe.

