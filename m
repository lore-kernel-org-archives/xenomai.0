Message-ID: <53335D9A.9040902@xenomai.org>
Date: Thu, 27 Mar 2014 00:07:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53316C4C.6000708@sigmatek.at>
 <CANKLDmuMDpiUC7Z7dsXa5K3LYNA4LNwA7mhAicJ_Dey+2S9PCg@mail.gmail.com>
In-Reply-To: <CANKLDmuMDpiUC7Z7dsXa5K3LYNA4LNwA7mhAicJ_Dey+2S9PCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Rescnt imbalance in rtdm_mutex_timedlock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/26/2014 05:49 PM, Henri Roosen wrote:
> On Tue, Mar 25, 2014 at 12:45 PM, Erwin Pranz <erwin.pranz@sigmatek.at>wrote:
> 
>> Hello,
>>
>> I am using rtdm_mutex_lock/rtdm_mutex_unlock in a rtdm driver and I get a
>> signal SIGDEBUG_MIGRATE_PRIOINV when I call the driver from a priority-0
>> thread.The signal is sent in xnsynch_release_thread when rescnt is 0 on a
>> XNOTHER thread, which means that rescnt is not balanced.
>>
>> I think the reason why rescnt is not balanced is in rtdm_mutex_timedlock:
>> when the owner of the mutex is NULL, the owner is changed to the calling
>> thread, but rescnt is not increased.
>>
>> I suggest the following fix in rtdm_mutex_timedlock:
>> -       else if (likely(xnsynch_owner(&mutex->synch_base) == NULL))
>> +       else if (likely(xnsynch_owner(&mutex->synch_base) == NULL)) {
>>                 xnsynch_set_owner(&mutex->synch_base, curr_thread);
>> +               if (xnthread_test_state(curr_thread, XNOTHER))
>> +                       xnthread_inc_rescnt(curr_thread);
>> +       }
>>
>>
> Hi Gilles,
> 
> Could you maybe elaborate on this? It seems the resource counting is not in
> balance. It would be great to know if this the correct way to fix it.
> 
> The problem should be easily reproducible by having just one shadowed
> priority 0 thread that somehow calls rtdm_mutex_lock directly followed by
> rtdm_mutex_unlock. This will trigger the code in ksrc/nucleus/synch.c that
> was added by commit-486afd15, which sends SIGDEBUG_MIGRATE_PRIOINV on
> Xenomai v2.6.2.1. It shouldn't send any signal in that case, as nothing is
> wrong.
> 
> Note we are on Xenomai v2.6.2.1. Xenomai v2.6.3 sends (the better name for
> it) SIGDEBUG_RESCNT_IMBALANCE.

To be completely frank, I expected Jan to answer this mail as this
concerns RTDM. Anyway, I had a look into it, and:
- the RTDM skin is not alone in this case, several skins implement the
same pattern (if owner == NULL, set owner, then return);
- adding calls to xnthread_inc_rescnt everywhere does not seem right, I
would prefer to move this inside some xnsynch_ service. The best
candidate I found for that is xnsynch_set_owner, though I am not sure if
this will work, especially with fastsynchs.


-- 
                                                                Gilles.

