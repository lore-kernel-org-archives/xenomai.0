Message-ID: <fb404ffa94aa6c14f7840621092dbdda.squirrel@www.xenomai.org>
In-Reply-To: <A34DBFCB-9CC6-42D6-91E7-58A92F4C3CA4@mah.priv.at>
References: <22700C72-58CD-4B92-B397-43DFC7943F14@mah.priv.at>
	<c5618ea63b6ec1da7d2fa937467d9f4c.squirrel@www.xenomai.org>
	<FC582130-25A2-4C10-BD94-1034E2768B8D@mah.priv.at>
	<b6692aadc37f290753041c6a07ba76f4.squirrel@www.xenomai.org>
	<A34DBFCB-9CC6-42D6-91E7-58A92F4C3CA4@mah.priv.at>
Date: Sat, 3 Nov 2012 16:08:06 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Question on rt_timer_tsc() vs rt_timer_read()
 semantics
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org


Michael Haberler wrote:
> sorry to be a pain..
>
>>> that's all, and I'll be happy ever after even after the merge with
>>> RT_PREEMPT ;-?
>>
>> Yes, that is the point, the port of RTDM over the Linux kernel API
>> already
>> exists, though AFAIK it is not merged yet in the xenomai-forge tree.
>
> porting native->RTDM: mapping the task and timer RTDM API is fairly clear
> to me
>
> the fuzzy part: I need shared memory segments and semaphores allocated in
> kernel space which eventually are picked up in/used from userland between
> kernel and user process
>
> so far I used the rt_heap API for shm, and
> rt_sem_create/rt_sem_delete/rt_sem_p/rt_sem_v, which worked fine
>
> I'm completely at loss how to make that work with rtdm_sem* and
> rtdm_mmap_to_user
>
> any decent examples or hints how to do this? the examples in the xenomai
> tree dont help me with that

With the RTDM API, what you implement is a driver, so, the communication
with user-space happens through the standard open/read/write/ioctl services.
So, for instance, to get user-space to wait for a semaphore, you would
implement a read or ioctl method in your driver which waits for an RTDM
event.

In the same vein, rtdm_mmap_to_user is meant to be used in the
implementation of a driver ioctl.


-- 
                    Gilles.


