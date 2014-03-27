Message-ID: <53346E91.8080903@web.de>
Date: Thu, 27 Mar 2014 19:31:45 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <53316C4C.6000708@sigmatek.at>	<CANKLDmuMDpiUC7Z7dsXa5K3LYNA4LNwA7mhAicJ_Dey+2S9PCg@mail.gmail.com>	<53335D9A.9040902@xenomai.org>	<5333F22F.70805@xenomai.org>
 <CANKLDmttO4jZtRxV-bjYQwg3YkGBKwFL74ATkdM2SBH8Xby31A@mail.gmail.com>
 <53345143.7000009@xenomai.org> <53346835.4030202@web.de>
 <53346CF7.2020805@xenomai.org>
In-Reply-To: <53346CF7.2020805@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Rescnt imbalance in rtdm_mutex_timedlock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Henri Roosen <henriroosen@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 2014-03-27 19:24, Philippe Gerum wrote:
> On 03/27/2014 07:04 PM, Jan Kiszka wrote:
>> On 2014-03-27 17:26, Philippe Gerum wrote:
>>> On 03/27/2014 04:02 PM, Henri Roosen wrote:
>>>>
>>>>
>>>>
>>>> On Thu, Mar 27, 2014 at 10:41 AM, Philippe Gerum <rpm@xenomai.org
>>>> <mailto:rpm@xenomai.org>> wrote:
>>>>
>>>>      On 03/27/2014 12:07 AM, Gilles Chanteperdrix wrote:
>>>>
>>>>          On 03/26/2014 05:49 PM, Henri Roosen wrote:
>>>>
>>>>              On Tue, Mar 25, 2014 at 12:45 PM, Erwin Pranz
>>>>              <erwin.pranz@sigmatek.at
>>>>              <mailto:erwin.pranz@sigmatek.at>>__wrote:
>>>>
>>>>                  Hello,
>>>>
>>>>                  I am using rtdm_mutex_lock/rtdm_mutex___unlock in a
>>>> rtdm
>>>>                  driver and I get a
>>>>                  signal SIGDEBUG_MIGRATE_PRIOINV when I call the driver
>>>>                  from a priority-0
>>>>                  thread.The signal is sent in xnsynch_release_thread
>>>> when
>>>>                  rescnt is 0 on a
>>>>                  XNOTHER thread, which means that rescnt is not
>>>> balanced.
>>>>
>>>>                  I think the reason why rescnt is not balanced is in
>>>>                  rtdm_mutex_timedlock:
>>>>                  when the owner of the mutex is NULL, the owner is
>>>>                  changed to the calling
>>>>                  thread, but rescnt is not increased.
>>>>
>>>>                  I suggest the following fix in rtdm_mutex_timedlock:
>>>>                  -       else if
>>>>                  (likely(xnsynch_owner(&mutex->__synch_base) =3D=3D NU=
LL))
>>>>                  +       else if
>>>>                  (likely(xnsynch_owner(&mutex->__synch_base) =3D=3D
>>>> NULL)) {
>>>>
>>>>                    xnsynch_set_owner(&mutex->__synch_base,
>>>> curr_thread);
>>>>                  +               if (xnthread_test_state(curr___thread,
>>>>                  XNOTHER))
>>>>                  +                      =

>>>> xnthread_inc_rescnt(curr___thread);
>>>>                  +       }
>>>>
>>>>
>>>>              Hi Gilles,
>>>>
>>>>              Could you maybe elaborate on this? It seems the resource
>>>>              counting is not in
>>>>              balance. It would be great to know if this the correct way
>>>>              to fix it.
>>>>
>>>>              The problem should be easily reproducible by having
>>>> just one
>>>>              shadowed
>>>>              priority 0 thread that somehow calls rtdm_mutex_lock
>>>>              directly followed by
>>>>              rtdm_mutex_unlock. This will trigger the code in
>>>>              ksrc/nucleus/synch.c that
>>>>              was added by commit-486afd15, which sends
>>>>              SIGDEBUG_MIGRATE_PRIOINV on
>>>>              Xenomai v2.6.2.1. It shouldn't send any signal in that
>>>> case,
>>>>              as nothing is
>>>>              wrong.
>>>>
>>>>              Note we are on Xenomai v2.6.2.1. Xenomai v2.6.3 sends (the
>>>>              better name for
>>>>              it) SIGDEBUG_RESCNT_IMBALANCE.
>>>>
>>>>
>>>>          To be completely frank, I expected Jan to answer this mail
>>>> as this
>>>>          concerns RTDM. Anyway, I had a look into it, and:
>>>>          - the RTDM skin is not alone in this case, several skins
>>>>          implement the
>>>>          same pattern (if owner =3D=3D NULL, set owner, then return);
>>>>          - adding calls to xnthread_inc_rescnt everywhere does not seem
>>>>          right, I
>>>>          would prefer to move this inside some xnsynch_ service. The
>>>> best
>>>>          candidate I found for that is xnsynch_set_owner, though I
>>>> am not
>>>>          sure if
>>>>          this will work, especially with fastsynchs.
>>>>
>>>>
>>>>
>>>>      Indeed this wouldn't. I suspect the skins mentioned did not have
>>>>      access to xnsynch_acquire(), and were not updated when the
>>>>      auto-relax feature was introduced for XNOTHER threads.
>>>>
>>>>      We could provide a helper for fast grabbing a mutex which has no
>>>>      fast locking support shared with userland, saving a call to
>>>>      xnsynch_acquire() in the non-contended case, e.g.
>>>>
>>>>      diff --git a/include/nucleus/synch.h b/include/nucleus/synch.h
>>>>      index 7deae21..87456ea 100644
>>>>      --- a/include/nucleus/synch.h
>>>>      +++ b/include/nucleus/synch.h
>>>>      @@ -192,6 +192,22 @@ static inline void xnsynch_set_owner(struct
>>>>      xnsynch *synch,
>>>>               synch->owner =3D thread;
>>>>        }
>>>>
>>>>      +static inline int xnsynch_fast_grab(struct xnsynch *synch,
>>>>      +                                   struct xnthread *thread)
>>>>      +{
>>>>      +       XENO_BUGON(NUCLEUS, xnsynch_fastlock_p(synch));
>>>>      +
>>>>      +       if (likely(xnsynch_owner(synch) !=3D NULL))
>>>>      +               return 0;
>>>>      +
>>>>      +       xnsynch_set_owner(synch, thread);
>>>>      +
>>>>      +       if (xnthread_test_state(thread, XNOTHER))
>>>>      +               xnthread_inc_rescnt(thread);
>>>>      +
>>>>      +       return 1;
>>>>      +}
>>>>      +
>>>>        static inline void xnsynch_register_cleanup(__struct xnsynch
>>>> *synch,
>>>>                                                   void
>>>> (*handler)(struct
>>>>      xnsynch *))
>>>>        {
>>>>      diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
>>>>      index 391d45f..338005d 100644
>>>>      --- a/ksrc/skins/rtdm/drvlib.c
>>>>      +++ b/ksrc/skins/rtdm/drvlib.c
>>>>      @@ -1538,9 +1538,7 @@ int rtdm_mutex_timedlock(rtdm___mutex_t
>>>>      *mutex, nanosecs_rel_t timeout,
>>>>               if (unlikely(xnsynch_test_flags(&__mutex->synch_base,
>>>>                                               RTDM_SYNCH_DELETED)))
>>>>                       err =3D -EIDRM;
>>>>
>>>>      -       else if (likely(xnsynch_owner(&mutex->__synch_base) =3D=
=3D
>>>> NULL))
>>>>      -               xnsynch_set_owner(&mutex->__synch_base,
>>>> curr_thread);
>>>>      -       else {
>>>>      +       else if (!xnsynch_fast_grab(&mutex->__synch_base,
>>>>      curr_thread)) {
>>>>                       /* Redefinition to clarify XENO_ASSERT output */
>>>>                       #define mutex_owner
>>>> xnsynch_owner(&mutex->synch___base)
>>>>                       XENO_ASSERT(RTDM, mutex_owner !=3D curr_thread,
>>>>
>>>>      The VxWorks and VRTX skins would have to use it as well.
>>>>
>>>>
>>>> Thanks for the replies! We'll give this patch a try for the RTDM case.
>>>>
>>>
>>> Minor points, but a compiler hint above was inverted and eventually
>>> useless, and the naming not descriptive enough. Take #2:
>>>
>>> diff --git a/include/nucleus/synch.h b/include/nucleus/synch.h
>>> index 7deae21..09ebdbf 100644
>>> --- a/include/nucleus/synch.h
>>> +++ b/include/nucleus/synch.h
>>> @@ -192,6 +192,22 @@ static inline void xnsynch_set_owner(struct
>>> xnsynch *synch,
>>>       synch->owner =3D thread;
>>>   }
>>>
>>> +static inline int xnsynch_try_grab(struct xnsynch *synch,
>>> +                   struct xnthread *thread)
>>> +{
>>> +    XENO_BUGON(NUCLEUS, xnsynch_fastlock_p(synch));
>>> +
>>> +    if (xnsynch_owner(synch) !=3D NULL)
>>
>> if (unlikely(...)) - locks are generally unlikely to be contended
>> (unless something is suboptimally designed at the user site).
>>
> =

> I'm unsure we really need to take a chance at giving such hint. Modern
> CPUs tend to have branch prediction right.

Then likely/unlikely will be emptied by Linux. But I'm not aware of any
plans in the kernel community to phase out this tag.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140327/b68e562=
1/attachment.sig>
