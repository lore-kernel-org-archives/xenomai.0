Subject: Re: [PATCH] rtnet: Fix lifecycle management of mapped rtskbs
From: Philippe Gerum <rpm@xenomai.org>
References: <473fdfe5-e761-e51c-a54c-90a520ca7816@siemens.com>
 <a8292038-34ff-fcb5-0def-c764fd4e0b94@xenomai.org>
 <086d41ad-b4a7-b3f2-945b-96c9f6eeecfb@siemens.com>
 <CAOuPNLh-Jfow-bCbdteF9dWNH_QBhnjdPW8Qb8qY_PfxfXgOcg@mail.gmail.com>
 <8ef30c9e-8964-4f12-112e-e1ef848b9778@siemens.com>
 <98eed01f-3769-0dc9-9198-88344ac0f3c5@siemens.com>
 <350a191c-eeb4-a3b1-a9d7-0c27b9504c30@siemens.com>
 <6c43f22e-ae31-baec-03bb-a4e969735a93@siemens.com>
 <1b42bc10-f891-b6e1-bb12-a1ef2272197a@xenomai.org>
Message-ID: <7fbe5c1d-ed94-3f56-8403-47491bfd1645@xenomai.org>
Date: Fri, 18 Jan 2019 12:58:43 +0100
MIME-Version: 1.0
In-Reply-To: <1b42bc10-f891-b6e1-bb12-a1ef2272197a@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 1/17/19 1:56 PM, Philippe Gerum wrote:
> On 12/18/18 7:46 AM, Jan Kiszka via Xenomai wrote:
>> On 14.12.18 12:22, Jan Kiszka via Xenomai wrote:
>>> Do not add rtskbs to the rtskb_list which are not mappend because
>>> rtdev_unmap_rtskb will not remove such rtskbs again (buf_dma_addr ==
>>> RTSKB_UNMAPPED). In fact, rtskb_list should be called rtskb_mapped_list,
>>> so refactor this while at it.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>   kernel/drivers/net/stack/rtdev.c | 10 +++++-----
>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/drivers/net/stack/rtdev.c
>>> b/kernel/drivers/net/stack/rtdev.c
>>> index 5eb73ce1a4..7b267f2a7c 100644
>>> --- a/kernel/drivers/net/stack/rtdev.c
>>> +++ b/kernel/drivers/net/stack/rtdev.c
>>> @@ -44,9 +44,9 @@ MODULE_PARM_DESC(device_rtskbs, "Number of
>>> additional global realtime socket "
>>>   struct rtnet_device         *rtnet_devices[MAX_RT_DEVICES];
>>>   static struct rtnet_device  *loopback_device;
>>>   static DEFINE_RTDM_LOCK(rtnet_devices_rt_lock);
>>> +static LIST_HEAD(rtskb_mapped_list);
>>>     LIST_HEAD(event_hook_list);
>>> -LIST_HEAD(rtskb_list);
>>>   DEFINE_MUTEX(rtnet_devices_nrt_lock);
>>>     static int rtdev_locked_xmit(struct rtskb *skb, struct
>>> rtnet_device *rtdev);
>>> @@ -412,8 +412,8 @@ int rtdev_map_rtskb(struct rtskb *skb)
>>>       }
>>>       }
>>>   -    if (!err)
>>> -    list_add(&skb->entry, &rtskb_list);
>>> +    if (!err && skb->buf_dma_addr != RTSKB_UNMAPPED)
>>> +    list_add(&skb->entry, &rtskb_mapped_list);
>>>         mutex_unlock(&rtnet_devices_nrt_lock);
>>>   @@ -430,7 +430,7 @@ static int rtdev_map_all_rtskbs(struct
>>> rtnet_device *rtdev)
>>>       if (!rtdev->map_rtskb)
>>>       return 0;
>>>   -    list_for_each_entry(skb, &rtskb_list, entry) {
>>> +    list_for_each_entry(skb, &rtskb_mapped_list, entry) {
>>>       err = rtskb_map(rtdev, skb);
>>>       if (err)
>>>          break;
>>> @@ -474,7 +474,7 @@ static void rtdev_unmap_all_rtskbs(struct
>>> rtnet_device *rtdev)
>>>       if (!rtdev->unmap_rtskb)
>>>       return;
>>>   -    list_for_each_entry(skb, &rtskb_list, entry) {
>>> +    list_for_each_entry(skb, &rtskb_mapped_list, entry) {
>>>       rtdev->unmap_rtskb(rtdev, skb);
>>>       }
>>>   }
>>>
>>
>> Applied to master and stable.
>>
>> Jan
>>
> 
> Unfortunately, this breaks RTnet for any driver using DMA, apparently
> uncovering a pre-existing issue in the device init->registration logic
> wrt mapping skb from per-device pools.
> 
> In short, filtering skbs we can't immediately map out of the rtskb list
> in rtdev_map_rtskb() prevents rt_register_rtnetdev(dev) from finding
> @dev's skbs in rtskb_mapped_list when running rtdev_map_all_skbs().
> In turn this prevents the driver from setting up the hw's RX/TX rings
> with proper DMA mapping addresses, as none of its skbs has valid bus
> addresses for DMA.
> 
> There may be a simple fix, but the rtdev init logic is a bit too
> convoluted for my after lunch. I'll try to come up with a fix later.
> 

So there is a catch 22 situation with skb mapping for DMA operations. It
stems from the fact that creating a netdevice via a call to
rt_alloc_etherdev(dev) can't successfully map the skbs attached to that
new device, because rtdev_map_rtskb() only operates on registered
netdevices, which the new one cannot be just yet as it is only half-baked.

Prior to that change, the code worked almost by accident because
registering that new device would end up calling rtdev_map_all_rtskbs(),
which would eventually find the unmapped skbs left in the global
rtskb_list and map them through the driver's ->map_rtskb handler.

There are only two in-tree drivers using the ->map_rtskb handler, namely
igb and e1000e, I'm working on adding a 3rd one with a refactoring of
the fec for i.MX SoCs, which is why I hit this bug.

I suspect ->map_rtskb was introduced to address yet another issue with
all other DMA-capable drivers: calling dma_{map, unmap}_single() from
I/O handlers in primary mode like they all do is unsafe, and this
handler may have been intended to ensure those operations happen from
regular Linux context instead. As a matter of fact, most existing RTnet
drivers are unsafe regarding this. Generally speaking, it looks like the
process of initializing a new netdevice has evolved over time in RTnet,
leading to a lot of open coding on the driver developer's end, which is
quite error-prone.

My take on this is that the init->registration logic may need a rework
and a better API, solving the issue of skb mapping in the same move,
fixing or simply dropping obsolete driver code too. However, doing so
without breaking more stuff would require significant RTnet background I
don't have, so I'm leaving this to the grown-ups.

In the meantime, this is a workaround addressing the skb mapping bug
introduced by this commit (only lightly tested so far):

commit 31ae7b2154bc0d8df841835d699087876bec3014
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Thu Jan 17 18:17:43 2019 +0100

    net/rtdev: ensure per-device skbs get mapped at registration

    This patch works around a regression introduced by #74464ee37d0,
    causing a new device's skbs not to be passed to its ->map_rtskb()
    handler when registered, breaking further DMA inits in the driver.

diff --git a/kernel/drivers/net/stack/rtdev.c
b/kernel/drivers/net/stack/rtdev.c
index 2982740d0..c5f8c73c6 100644
--- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -45,6 +45,7 @@ struct rtnet_device
*rtnet_devices[MAX_RT_DEVICES];
 static struct rtnet_device  *loopback_device;
 static DEFINE_RTDM_LOCK(rtnet_devices_rt_lock);
 static LIST_HEAD(rtskb_mapped_list);
+static LIST_HEAD(rtskb_mapwait_list);
  LIST_HEAD(event_hook_list);
 DEFINE_MUTEX(rtnet_devices_nrt_lock);
@@ -459,8 +460,12 @@ int rtdev_map_rtskb(struct rtskb *skb)
 	}
     }
 -    if (!err && skb->buf_dma_addr != RTSKB_UNMAPPED)
-	list_add(&skb->entry, &rtskb_mapped_list);
+    if (!err) {
+	    if (skb->buf_dma_addr != RTSKB_UNMAPPED)
+		    list_add(&skb->entry, &rtskb_mapped_list);
+	    else
+		    list_add(&skb->entry, &rtskb_mapwait_list);
+    }
      mutex_unlock(&rtnet_devices_nrt_lock);
 @@ -471,19 +476,31 @@ int rtdev_map_rtskb(struct rtskb *skb)
  static int rtdev_map_all_rtskbs(struct rtnet_device *rtdev)
 {
-    struct rtskb *skb;
-    int err = 0;
+    struct rtskb *skb, *n;
+    int err;
      if (!rtdev->map_rtskb)
-	return 0;
+	    return 0;
 -    list_for_each_entry(skb, &rtskb_mapped_list, entry) {
-	err = rtskb_map(rtdev, skb);
-	if (err)
-	   break;
+    if (!list_empty(&rtskb_mapped_list)) {
+	    list_for_each_entry(skb, &rtskb_mapped_list, entry) {
+		    err = rtskb_map(rtdev, skb);
+		    if (err)
+			    return err;
+	    }
     }
 -    return err;
+    if (!list_empty(&rtskb_mapwait_list)) {
+	    list_for_each_entry_safe(skb, n, &rtskb_mapwait_list, entry) {
+		    err = rtskb_map(rtdev, skb);
+		    if (err)
+			    return err;
+		    list_del(&skb->entry);
+		    list_add(&skb->entry, &rtskb_mapped_list);
+	    }
+    }
+
+    return 0;
 }


-- 
Philippe.

