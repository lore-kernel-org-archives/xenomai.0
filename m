Subject: Re: [PATCH v2 1/1] cobalt/rtdm: allow for device teardown
References: <20190621094922.17558-1-rpm@xenomai.org>
 <20190621094922.17558-2-rpm@xenomai.org>
 <5b247b68-11b9-2ad3-a0a5-ac69f09b9e22@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <097e66df-a550-d39b-080e-d30660a17281@xenomai.org>
Date: Sun, 21 Jul 2019 17:57:00 +0200
MIME-Version: 1.0
In-Reply-To: <5b247b68-11b9-2ad3-a0a5-ac69f09b9e22@siemens.com>
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

On 7/4/19 12:11 PM, Jan Kiszka wrote:
> On 21.06.19 11:49, Philippe Gerum via Xenomai wrote:
>> @@ -534,6 +536,8 @@ EXPORT_SYMBOL_GPL(rtdm_dev_register);
>>   void rtdm_dev_unregister(struct rtdm_device *dev)
>>   {
>>       struct rtdm_driver *drv = dev->driver;
>> +    struct rtdm_fd *fd, *n;
>> +    spl_t s;
>>         secondary_mode_only();
>>   @@ -542,6 +546,19 @@ void rtdm_dev_unregister(struct rtdm_device *dev)
>>       /* Lock out any further connection. */
>>       dev->magic = ~RTDM_DEVICE_MAGIC;
>>   +    xnlock_get_irqsave(&nklock, s);
>> +    list_for_each_entry_safe(fd, n, &dev->openfd_list, next) {
> 
> Is this really safe?

No, that's not.

> What if two teardowns run in parallel or, for some
> other reason, the next saved in n here become invalid while dropping the
> lock for close? It's probably better to always delete the first element
> and repeat that until the list is empty.
>

Yes, we should be protected against live-locking since no other fd can
be attached to the device at this point.

> 
> Except for the list iteration, this looks good.
> 

Patch v3 will follow.

-- 
Philippe.

