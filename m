Message-ID: <53354665.10604@sigmatek.at>
Date: Fri, 28 Mar 2014 10:52:37 +0100
From: Erwin Pranz <erwin.pranz@sigmatek.at>
MIME-Version: 1.0
References: <53316C4C.6000708@sigmatek.at>	<CANKLDmuMDpiUC7Z7dsXa5K3LYNA4LNwA7mhAicJ_Dey+2S9PCg@mail.gmail.com>	<53335D9A.9040902@xenomai.org>	<5333F22F.70805@xenomai.org>
 <CANKLDmttO4jZtRxV-bjYQwg3YkGBKwFL74ATkdM2SBH8Xby31A@mail.gmail.com>
 <53345143.7000009@xenomai.org>
In-Reply-To: <53345143.7000009@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Rescnt imbalance in rtdm_mutex_timedlock
Reply-To: erwin.pranz@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Am 27.03.2014 17:26, schrieb Philippe Gerum:
> On 03/27/2014 04:02 PM, Henri Roosen wrote:
>>
>>
>> On Thu, Mar 27, 2014 at 10:41 AM, Philippe Gerum <rpm@xenomai.org
>> <mailto:rpm@xenomai.org>> wrote:
>>
>>      On 03/27/2014 12:07 AM, Gilles Chanteperdrix wrote:
>>
>>          On 03/26/2014 05:49 PM, Henri Roosen wrote:
>>
>>              On Tue, Mar 25, 2014 at 12:45 PM, Erwin Pranz
>>              <erwin.pranz@sigmatek.at
>>              <mailto:erwin.pranz@sigmatek.at>>__wrote:
>>
>>                  Hello,
>>
>>                  I am using rtdm_mutex_lock/rtdm_mutex___unlock in a rtdm
>>                  driver and I get a
>>                  signal SIGDEBUG_MIGRATE_PRIOINV when I call the driver
>>                  from a priority-0
>>                  thread.The signal is sent in xnsynch_release_thread when
>>                  rescnt is 0 on a
>>                  XNOTHER thread, which means that rescnt is not balanced.
>>
>>                  I think the reason why rescnt is not balanced is in
>>                  rtdm_mutex_timedlock:
>>                  when the owner of the mutex is NULL, the owner is
>>                  changed to the calling
>>                  thread, but rescnt is not increased.
>>
>>                  I suggest the following fix in rtdm_mutex_timedlock:
>>                  -       else if
>>                  (likely(xnsynch_owner(&mutex->__synch_base) == NULL))
>>                  +       else if
>>                  (likely(xnsynch_owner(&mutex->__synch_base) == NULL)) {
>>                                  
>>                    xnsynch_set_owner(&mutex->__synch_base, curr_thread);
>>                  +               if (xnthread_test_state(curr___thread,
>>                  XNOTHER))
>>                  +                       xnthread_inc_rescnt(curr___thread);
>>                  +       }
>>
>>
>>              Hi Gilles,
>>
>>              Could you maybe elaborate on this? It seems the resource
>>              counting is not in
>>              balance. It would be great to know if this the correct way
>>              to fix it.
>>
>>              The problem should be easily reproducible by having just one
>>              shadowed
>>              priority 0 thread that somehow calls rtdm_mutex_lock
>>              directly followed by
>>              rtdm_mutex_unlock. This will trigger the code in
>>              ksrc/nucleus/synch.c that
>>              was added by commit-486afd15, which sends
>>              SIGDEBUG_MIGRATE_PRIOINV on
>>              Xenomai v2.6.2.1. It shouldn't send any signal in that case,
>>              as nothing is
>>              wrong.
>>
>>              Note we are on Xenomai v2.6.2.1. Xenomai v2.6.3 sends (the
>>              better name for
>>              it) SIGDEBUG_RESCNT_IMBALANCE.
>>
>>
>>          To be completely frank, I expected Jan to answer this mail as this
>>          concerns RTDM. Anyway, I had a look into it, and:
>>          - the RTDM skin is not alone in this case, several skins
>>          implement the
>>          same pattern (if owner == NULL, set owner, then return);
>>          - adding calls to xnthread_inc_rescnt everywhere does not seem
>>          right, I
>>          would prefer to move this inside some xnsynch_ service. The best
>>          candidate I found for that is xnsynch_set_owner, though I am not
>>          sure if
>>          this will work, especially with fastsynchs.
>>
>>
>>
>>      Indeed this wouldn't. I suspect the skins mentioned did not have
>>      access to xnsynch_acquire(), and were not updated when the
>>      auto-relax feature was introduced for XNOTHER threads.
>>
>>      We could provide a helper for fast grabbing a mutex which has no
>>      fast locking support shared with userland, saving a call to
>>      xnsynch_acquire() in the non-contended case, e.g.
>>
>>      diff --git a/include/nucleus/synch.h b/include/nucleus/synch.h
>>      index 7deae21..87456ea 100644
>>      --- a/include/nucleus/synch.h
>>      +++ b/include/nucleus/synch.h
>>      @@ -192,6 +192,22 @@ static inline void xnsynch_set_owner(struct
>>      xnsynch *synch,
>>               synch->owner = thread;
>>        }
>>
>>      +static inline int xnsynch_fast_grab(struct xnsynch *synch,
>>      +                                   struct xnthread *thread)
>>      +{
>>      +       XENO_BUGON(NUCLEUS, xnsynch_fastlock_p(synch));
>>      +
>>      +       if (likely(xnsynch_owner(synch) != NULL))
>>      +               return 0;
>>      +
>>      +       xnsynch_set_owner(synch, thread);
>>      +
>>      +       if (xnthread_test_state(thread, XNOTHER))
>>      +               xnthread_inc_rescnt(thread);
>>      +
>>      +       return 1;
>>      +}
>>      +
>>        static inline void xnsynch_register_cleanup(__struct xnsynch *synch,
>>                                                   void (*handler)(struct
>>      xnsynch *))
>>        {
>>      diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
>>      index 391d45f..338005d 100644
>>      --- a/ksrc/skins/rtdm/drvlib.c
>>      +++ b/ksrc/skins/rtdm/drvlib.c
>>      @@ -1538,9 +1538,7 @@ int rtdm_mutex_timedlock(rtdm___mutex_t
>>      *mutex, nanosecs_rel_t timeout,
>>               if (unlikely(xnsynch_test_flags(&__mutex->synch_base,
>>                                               RTDM_SYNCH_DELETED)))
>>                       err = -EIDRM;
>>
>>      -       else if (likely(xnsynch_owner(&mutex->__synch_base) == NULL))
>>      -               xnsynch_set_owner(&mutex->__synch_base, curr_thread);
>>      -       else {
>>      +       else if (!xnsynch_fast_grab(&mutex->__synch_base,
>>      curr_thread)) {
>>                       /* Redefinition to clarify XENO_ASSERT output */
>>                       #define mutex_owner xnsynch_owner(&mutex->synch___base)
>>                       XENO_ASSERT(RTDM, mutex_owner != curr_thread,
>>
>>      The VxWorks and VRTX skins would have to use it as well.
>>
>>
>> Thanks for the replies! We'll give this patch a try for the RTDM case.
>>
> Minor points, but a compiler hint above was inverted and eventually useless, and the naming not descriptive enough. Take #2:
>
> diff --git a/include/nucleus/synch.h b/include/nucleus/synch.h
> index 7deae21..09ebdbf 100644
> --- a/include/nucleus/synch.h
> +++ b/include/nucleus/synch.h
> @@ -192,6 +192,22 @@ static inline void xnsynch_set_owner(struct xnsynch *synch,
>   	synch->owner = thread;
>   }
>   
> +static inline int xnsynch_try_grab(struct xnsynch *synch,
> +				   struct xnthread *thread)
> +{
> +	XENO_BUGON(NUCLEUS, xnsynch_fastlock_p(synch));
> +
> +	if (xnsynch_owner(synch) != NULL)
> +		return 0;
> +
> +	xnsynch_set_owner(synch, thread);
> +
> +	if (xnthread_test_state(thread, XNOTHER))
> +		xnthread_inc_rescnt(thread);
> +
> +	return 1;
> +}
> +
>   static inline void xnsynch_register_cleanup(struct xnsynch *synch,
>   					    void (*handler)(struct xnsynch *))
>   {
> diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
> index 391d45f..aa85d11 100644
> --- a/ksrc/skins/rtdm/drvlib.c
> +++ b/ksrc/skins/rtdm/drvlib.c
> @@ -1538,9 +1538,7 @@ int rtdm_mutex_timedlock(rtdm_mutex_t *mutex, nanosecs_rel_t timeout,
>   	if (unlikely(xnsynch_test_flags(&mutex->synch_base,
>   					RTDM_SYNCH_DELETED)))
>   		err = -EIDRM;
> -	else if (likely(xnsynch_owner(&mutex->synch_base) == NULL))
> -		xnsynch_set_owner(&mutex->synch_base, curr_thread);
> -	else {
> +	else if (!xnsynch_try_grab(&mutex->synch_base, curr_thread)) {
>   		/* Redefinition to clarify XENO_ASSERT output */
>   		#define mutex_owner xnsynch_owner(&mutex->synch_base)
>   		XENO_ASSERT(RTDM, mutex_owner != curr_thread,
>
Hello,

I tried this patch, but it did not compile:
In file included from include/xenomai/nucleus/registry.h:33:0,
                  from include/xenomai/nucleus/thread.h:160,
                  from include/xenomai/nucleus/sched.h:31,
                  from include/xenomai/nucleus/pod.h:34,
                  from include/xenomai/nucleus/xenomai.h:23,
                  from include/xenomai/rtdm/rtdm_driver.h:37,
                  from drivers/xenomai/can/rtcan_internal.h:30,
                  from drivers/xenomai/can/rtcan_dev.c:32:
include/xenomai/nucleus/synch.h: In function 'xnsynch_try_grab':
include/xenomai/nucleus/synch.h:205:2: error: implicit declaration of 
function 'xnthread_test_state' [-Werror=implicit-function-declaration]
include/xenomai/nucleus/synch.h:206:3: error: implicit declaration of 
function 'xnthread_inc_rescnt' [-Werror=implicit-function-declaration]

I think there is a circular dependency problem in the header files:
- thread.h includes sync.h via registry.h at a point before 
xnthread_test_state/xnthread_inc_rescnt is defined
- synch.h needs the defines from thread.h 
(xnthread_test_state/xnthread_inc_rescnt)

I could not resolve this dependency

Erwin

