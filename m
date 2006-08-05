Message-ID: <44D4E38D.9060007@domain.hid>
Date: Sat, 05 Aug 2006 20:29:33 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <44CF6EB1.1010808@domain.hid> <44D36389.3030706@domain.hid>
	<44D4A0E4.5070703@domain.hid> <44D4CAE9.9000800@domain.hid>
In-Reply-To: <44D4CAE9.9000800@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] [ANNOUNCE] RTDM driver for CAN
	devices
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Jan Kiszka wrote:
>>> Hi Wolfgang,
>>>
>>> Wolfgang Grandegger wrote:
>>>> Hello,
>>>>
>>>> at "ftp://ftp.denx.de/pub/xenomai/rtcan" you can find a first version of
>>>> RTCAN, an Open Source hard real-time protocol stack for CAN devices
>>>> based on BSD sockets. It is based on the SJA1000 socket-based CAN driver
>>>> for RTDM by Sebastian Smolorz (see CREDITS file).
>>> I started a review of the patch, and here are some first results. A
>>> deeper look into critical paths is pending. But given that your
>>> driver(s) already proved to work fine for us here and for your own
>>> scenarios, only very sneaking issues can persist - if at all. :)
>> Puh, still plenty of issues. I wanted to make RTCAN public a.s.a.p.
>> because a few people already ask for it.
> 
> Most of my points are either small changes or just notes for future
> cleanups, i.e. no show stoppers. The name, that one is critical.

See below.

> 
>>> - AF_CAN is still set to 30 which meanwhile became TIPC. The Socket-CAN
>>> project moved to 29 now. However, this could become a nice race until
>>> Socket-CAN is upstream and reserved a final ID. How to cope with this?
>>> We just had some fun here after moving our AF_TIMS from 0 to 27,
>>> breaking many installation on our robots due to the ABI change. Should
>>> we better move the ID beyond AF_MAX for now? Also a question for the
>>> socketcan-core list...
>> For the time being I fixed it to 29.
> 
> Ok.
> 
>>> - Out-commented debug messages: If they can be useful for driver
>>> development / hardware testing, I would say make them selectable via
>>> some CONFIG-switch. The rest should be removed.
>> OK, I'm going to implement a general "debug" option selectable via
>> kernel parameter and proc filesystem during run time some time later.
> 
> Fine with me, but I would skip the work for a /proc switch.

There will be no separate switch for the PROC output. I was thinking
about one global debug option.

> 
>>> - Private data alignment in rtcan_dev_alloc(): you tapped on something
>>> that looks ugly in RTnet as well. We copied this from Linux which still
>>> does magic 32-byte alignment (encapsulated by NETDEV_ALIGN today). But
>>> it also uses a smarter priv lookup now:
>>>
>>> #define NETDEV_ALIGN            32
>>> #define NETDEV_ALIGN_CONST      (NETDEV_ALIGN - 1)
>>>
>>> static inline void *netdev_priv(struct net_device *dev)
>>> {
>>>         return (char *)dev + ((sizeof(struct net_device)
>>>                                         + NETDEV_ALIGN_CONST)
>>>                                 & ~NETDEV_ALIGN_CONST);
>>> }
>>>
>>> Maybe something that should be adopted as well (for both stacks).
>>> Nothing critical though.
>> I removed alignment because I think it's better to have all data close
>> together. What's the benefit of such an alignment. Note that the priv
>> structures are normally small.
> 
> This needs a closer look indeed. We adopted what Linux does without
> checking if it makes sense for RTnet. The CAN devices' private data
> structures are different from RT-NICs, so a different alignment may make
> sense as well. Let's keep it as it is and push it on the to-do list.

IMHO, the alignment makes sense, if the private structure is used in a
different context. This is not true for RTCAN. I will put it to the TODO 
list.

> 
>>> - rtcan_dev_unregister() looks racy: down(&rtcan_devices_nrt_lock) comes
>>> after the device state check. Is this ok?
>> That's copied from rtdev.c. Indeed, it should be:
>>
>>     RTCAN_ASSERT(atomic_read(&dev->refcount) == 0,
>>          printk("RTCAN: dev reference counter < 0!\n"););
>>     rtdm_lock_put_irqrestore(&rtcan_devices_rt_lock, context);
>>     up(&rtcan_devices_nrt_lock);
> 
> Argh, that locking is indeed like RTnet. And it makes me sick though I'm
> likely responsible for most of this mess, thus also for this confusion
> here. Please revert it for now until I sorted things in RTnet. The
> locking must be simplified - and documented...

OK.

> In any case, we may only suffer from theoretical races between
> rtcanconfig and rmmod here. Uncritical.

Dito.

>>> - struct rtcan_rb_frame differs from struct can_frame in the type of
>>> can_dlc. The VW guys find __u8 for this nicer than a natural unsigned
>>> int, but I stopped arguing on this. If we follow or not, it should be
>>> consistent.
>> I don't like the __u8 either. What do you mean with the last sentence?
>> What should be consistent?
> 
> The types for can_dlc in both of our own structures. If can_frame uses
> unsigned int, rtcan_rb_frame should do so as well.

Ah, of course, will fix that.

>>> - Well known issue: the RTCAN name. This should definitely get resolved
>>> before we merge. Any feedback already?
>> I contacted the author. If I will not get an answer soon, I tend
>> changing the global name to RT-Socket-CAN (rtsocketcan).
> 
> I would really hate to have a drivers/rtsocketcan or a
> rtdm/rtsocketcan.h. The short name is so much nicer.

He did not say, that we cannot use the name RTCAN but he prefers that we 
use a different name to avoid confusion. Therefore I suggest to use the 
offical name "RT-Socket-CAN" for the project, but leave almost all 
internal rtcan prefixes as they are apart from:

   drivers/rtsocketcan
   rtdm/rtsocketcan.h

Note that the API does use the Linux naming in most cases (with the 
prefix can).

Another possibility would be to use rtscan as short form for rtsocketcan 
as prefix.

What do you think? Well, it's just a name.

> 
>>> - Low prio (as long as my own code doesn't follow this ;)): Linux coding
>>> style.
>> Thanks ;-).
>>
>>> No guarantee that I found every critical point (most of the stuff above
>>> is nitpicking anyway). I will try to repeat this more in details when
>>> time permits. Hope my comments help nevertheless.
>> Thanks a lot for your time. I'm going to provide a revised patch a.s.a.p.
> 
> Again, the naming should be resolved, but then I think we could merge.
> Philippe, ok for you as well?
> 
>> A few other issues:
>>
>> Till now I do not use rt_owner. Is it necessary?
> 
> That's for locking the driver module against removal. I guess this is
> not needed for RTCAN if you can unregister a device at any time, maybe
> just by spinning on the reference counter release.

Yep.

Wolfgang.


