Subject: Re: [PATCH] rtnet: Fix lifecycle management of mapped rtskbs
References: <473fdfe5-e761-e51c-a54c-90a520ca7816@siemens.com>
 <a8292038-34ff-fcb5-0def-c764fd4e0b94@xenomai.org>
 <086d41ad-b4a7-b3f2-945b-96c9f6eeecfb@siemens.com>
 <CAOuPNLh-Jfow-bCbdteF9dWNH_QBhnjdPW8Qb8qY_PfxfXgOcg@mail.gmail.com>
 <8ef30c9e-8964-4f12-112e-e1ef848b9778@siemens.com>
 <98eed01f-3769-0dc9-9198-88344ac0f3c5@siemens.com>
 <350a191c-eeb4-a3b1-a9d7-0c27b9504c30@siemens.com>
 <6c43f22e-ae31-baec-03bb-a4e969735a93@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1b42bc10-f891-b6e1-bb12-a1ef2272197a@xenomai.org>
Date: Thu, 17 Jan 2019 13:56:42 +0100
MIME-Version: 1.0
In-Reply-To: <6c43f22e-ae31-baec-03bb-a4e969735a93@siemens.com>
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

On 12/18/18 7:46 AM, Jan Kiszka via Xenomai wrote:
> On 14.12.18 12:22, Jan Kiszka via Xenomai wrote:
>> Do not add rtskbs to the rtskb_list which are not mappend because
>> rtdev_unmap_rtskb will not remove such rtskbs again (buf_dma_addr ==
>> RTSKB_UNMAPPED). In fact, rtskb_list should be called rtskb_mapped_list,
>> so refactor this while at it.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   kernel/drivers/net/stack/rtdev.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/drivers/net/stack/rtdev.c
>> b/kernel/drivers/net/stack/rtdev.c
>> index 5eb73ce1a4..7b267f2a7c 100644
>> --- a/kernel/drivers/net/stack/rtdev.c
>> +++ b/kernel/drivers/net/stack/rtdev.c
>> @@ -44,9 +44,9 @@ MODULE_PARM_DESC(device_rtskbs, "Number of
>> additional global realtime socket "
>>   struct rtnet_device         *rtnet_devices[MAX_RT_DEVICES];
>>   static struct rtnet_device  *loopback_device;
>>   static DEFINE_RTDM_LOCK(rtnet_devices_rt_lock);
>> +static LIST_HEAD(rtskb_mapped_list);
>>     LIST_HEAD(event_hook_list);
>> -LIST_HEAD(rtskb_list);
>>   DEFINE_MUTEX(rtnet_devices_nrt_lock);
>>     static int rtdev_locked_xmit(struct rtskb *skb, struct
>> rtnet_device *rtdev);
>> @@ -412,8 +412,8 @@ int rtdev_map_rtskb(struct rtskb *skb)
>>       }
>>       }
>>   -    if (!err)
>> -    list_add(&skb->entry, &rtskb_list);
>> +    if (!err && skb->buf_dma_addr != RTSKB_UNMAPPED)
>> +    list_add(&skb->entry, &rtskb_mapped_list);
>>         mutex_unlock(&rtnet_devices_nrt_lock);
>>   @@ -430,7 +430,7 @@ static int rtdev_map_all_rtskbs(struct
>> rtnet_device *rtdev)
>>       if (!rtdev->map_rtskb)
>>       return 0;
>>   -    list_for_each_entry(skb, &rtskb_list, entry) {
>> +    list_for_each_entry(skb, &rtskb_mapped_list, entry) {
>>       err = rtskb_map(rtdev, skb);
>>       if (err)
>>          break;
>> @@ -474,7 +474,7 @@ static void rtdev_unmap_all_rtskbs(struct
>> rtnet_device *rtdev)
>>       if (!rtdev->unmap_rtskb)
>>       return;
>>   -    list_for_each_entry(skb, &rtskb_list, entry) {
>> +    list_for_each_entry(skb, &rtskb_mapped_list, entry) {
>>       rtdev->unmap_rtskb(rtdev, skb);
>>       }
>>   }
>>
> 
> Applied to master and stable.
> 
> Jan
> 

Unfortunately, this breaks RTnet for any driver using DMA, apparently
uncovering a pre-existing issue in the device init->registration logic
wrt mapping skb from per-device pools.

In short, filtering skbs we can't immediately map out of the rtskb list
in rtdev_map_rtskb() prevents rt_register_rtnetdev(dev) from finding
@dev's skbs in rtskb_mapped_list when running rtdev_map_all_skbs().
In turn this prevents the driver from setting up the hw's RX/TX rings
with proper DMA mapping addresses, as none of its skbs has valid bus
addresses for DMA.

There may be a simple fix, but the rtdev init logic is a bit too
convoluted for my after lunch. I'll try to come up with a fix later.

-- 
Philippe.

