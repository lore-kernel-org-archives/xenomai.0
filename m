Subject: Re: [PATCH 1/3] net/cap: fix non-rt signal overflow
References: <20191130183929.11034-1-rpm@xenomai.org>
 <49116397-83cb-2837-9df0-50ff5cf73b7a@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6f5556ef-2564-4e01-a17e-4334d894f994@xenomai.org>
Date: Mon, 2 Dec 2019 16:17:33 +0100
MIME-Version: 1.0
In-Reply-To: <49116397-83cb-2837-9df0-50ff5cf73b7a@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 12/2/19 7:46 AM, Jan Kiszka wrote:
> On 30.11.19 19:39, Philippe Gerum via Xenomai wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>>
>> rtdm_nrtsig_pend() is based on ipipe_post_root_work(), which keeps a
>> copy of every request descriptor internally until it is consumed by
>> the secondary mode handler. Triggering rtdm_nrtsig_pend() every time a
>> packet is relayed from the stack to the tap device may cause such
>> request buffer to overflow under pressure.
>>
>> To address this issue, trigger the non-rt signal only when the RX
>> queue transitions from empty to non-empty state as a result of
>> enqueuing the next skb.
>>
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>   kernel/drivers/net/addons/cap.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/drivers/net/addons/cap.c b/kernel/drivers/net/addons/cap.c
>> index 5f83e19e3..293fcc84b 100644
>> --- a/kernel/drivers/net/addons/cap.c
>> +++ b/kernel/drivers/net/addons/cap.c
>> @@ -59,6 +59,7 @@ void rtcap_rx_hook(struct rtskb *rtskb)
>>   {
>>       int                     ifindex;
>>       int                     active;
>> +    bool            trigger = false;
>>         if (rtskb->cap_flags & RTSKB_CAP_SHARED)
>>           return;
>> @@ -81,9 +82,10 @@ void rtcap_rx_hook(struct rtskb *rtskb)
>>           return;
>>       }
>>   -    if (cap_queue.first == NULL)
>> +    if (cap_queue.first == NULL) {
>>           cap_queue.first = rtskb;
>> -    else
>> +        trigger = true;
>> +    } else
>>           cap_queue.last->cap_next = rtskb;
>>       cap_queue.last = rtskb;
>>       rtskb->cap_next = NULL;
>> @@ -91,13 +93,15 @@ void rtcap_rx_hook(struct rtskb *rtskb)
>>       rtskb->cap_flags |= RTSKB_CAP_SHARED;
>>       rtskb->cap_dev = rtskb->rtdev;
>>   -    rtdm_nrtsig_pend(&cap_signal);
>> +    if (trigger)
>> +        rtdm_nrtsig_pend(&cap_signal);
>>   }
>>     int rtcap_xmit_hook(struct rtskb *rtskb, struct rtnet_device *rtdev)
>>   {
>>       struct tap_device_t *tap_dev = &tap_device[rtskb->rtdev->ifindex];
>>       rtdm_lockctx_t context;
>> +    bool trigger = false;
>>       int active;
>>         active = tap_dev->present & XMIT_HOOK;
>> @@ -121,15 +125,17 @@ int rtcap_xmit_hook(struct rtskb *rtskb, struct rtnet_device *rtdev)
>>         rtdm_lock_get_irqsave(&rtcap_lock, context);
>>   -    if (cap_queue.first == NULL)
>> +    if (cap_queue.first == NULL) {
>>           cap_queue.first = rtskb;
>> -    else
>> +        trigger = true;
>> +    } else
>>           cap_queue.last->cap_next = rtskb;
>>       cap_queue.last = rtskb;
>>         rtdm_lock_put_irqrestore(&rtcap_lock, context);
>>   -    rtdm_nrtsig_pend(&cap_signal);
>> +    if (trigger)
>> +        rtdm_nrtsig_pend(&cap_signal);
>>   done:
>>       return tap_dev->orig_xmit(rtskb, rtdev);
>>   }
>>
> 
> Doesn't apply to next - what's your baseline?
> 

Mm, sorry. That one went on top of the multicast+VLAN support which is pending in my rtnet queue. A patch rebased on -next is on its way.

-- 
Philippe.

