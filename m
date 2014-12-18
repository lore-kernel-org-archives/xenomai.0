MIME-Version: 1.0
In-Reply-To: <5492D80E.3010701@siemens.com>
References: <CAMJ=MEdh-vBm1S9cHL7Hj0Ky-RaeGCSw_xauMZoEsuegbArM1w@mail.gmail.com>
 <CAMJ=MEfDQm_ymyL8FULhqMvpwzet4aHMbQFoEjL-sVDsCTg2Hg@mail.gmail.com>
 <549072DC.1030901@xenomai.org>
 <CAMJ=MEfzrJQGYKT41F2hSirn8q0MGt-kWuT2GYQE7YTbSCNG5A@mail.gmail.com>
 <549090FA.7000901@xenomai.org>
 <CAMJ=MEc9UXa4P18kNmPeKH-SziXMj9Grbxagj7Wm_MckHcOC7Q@mail.gmail.com>
 <5492989C.9070106@siemens.com>
 <CAMJ=MEeWPyBFBbjj7_JLENZQ+xBkxbaKGiZBehKCatVa-1owqA@mail.gmail.com>
 <5492D80E.3010701@siemens.com>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Thu, 18 Dec 2014 15:17:21 +0100
Message-ID: <CAMJ=MEfHzJ7YwxAemH6sg+EvHTLweasNK2TW4s5jYYhe08m+hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] [xenomai-forge] timer-internal consume a lot of cpu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

> Philippe, Jan
>>
>> as long as this issue is not fixed in glibc, it is not OK to use
>> conditional variables
>> in application space for real-time applications in my opinion.
>
> ...when combining them with PI mutexes, right. For real-time QEMU/KVM, I
> worked around this by using prio-ceiling mutexes. That is by far not
> optimal, performance-wise, but at least you avoid random lockups or the
> other side effects of that bug.
>

Jan, to be clear:

We do not use PI mutexes in our application, we just use pSOS primitives.
Internally in the copperplate lib (see copperplate/syncobj.c), conditional vars
are used in combination with PI mutexes.

static inline
int monitor_wait_grant(struct syncobj *sobj,
                       struct threadobj *current,
                       const struct timespec *timeout)
{
        if (timeout)
                return -pthread_cond_timedwait(&current->core.grant_sync,
                                               &sobj->core.lock, timeout);

        return -pthread_cond_wait(&current->core.grant_sync, &sobj->core.lock);
}

where sobj->core.lock is a mutex with PI:

pthread_mutexattr_init(&mattr);
pthread_mutexattr_settype(&mattr, mutex_type_attribute);
pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
ret = __bt(-pthread_mutexattr_setpshared(&mattr, mutex_scope_attribute));


Ronny

