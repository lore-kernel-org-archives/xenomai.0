Subject: Re: [PATCH] rtnet: Porting e1000e from mainline 4.14.128
References: <1852590607.83031740.1561824852049.JavaMail.zimbra@telenet.be>
 <1cda53e1-323a-add9-0a21-d6b843fb21c5@siemens.com>
 <1481907847.150013779.1562404344423.JavaMail.zimbra@telenet.be>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8f478c37-620a-8f3a-5a2b-8b064127bd72@siemens.com>
Date: Mon, 8 Jul 2019 17:43:42 +0200
MIME-Version: 1.0
In-Reply-To: <1481907847.150013779.1562404344423.JavaMail.zimbra@telenet.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: g.strobbe@telenet.be
Cc: xenomai <xenomai@xenomai.org>

On 06.07.19 11:12, g.strobbe@telenet.be wrote:
> 
> 
> ----- On Jul 2, 2019, at 4:08 PM, Jan Kiszka jan.kiszka@siemens.com wrote:
> 
>> On 29.06.19 18:14, G.Strobbe via Xenomai wrote:
>>> Hi,
>>>
>>> I ported the e1000e driver from linux-4.14.128 to the Xenomai next branch.
>>> It runs nice on my setup, an Intel NUC i3 with an Intel I219-V Ethernet
>>> Controller wired to a Beckhoff IO island.
>>
>> Thanks for updating!
> 
> My pleasure.  I learned lots of things new to me along the way.
> 
>>
>>>
>>> If someone else wants to give the driver a try, please find attached the
>>> patches.
>>>
>>> They applied both clean to the master as well as the next branch.
>>>
>>> Best Regards,
>>>
>>> Gino
>>> -------------- next part --------------
>>> A non-text attachment was scrubbed...
>>> Name: 0001-Providing-rtnetdev_alloc_rtskb_ip_align.patch
>>> Type: text/x-patch
>>> Size: 3139 bytes
>>> Desc: not available
>>> URL:
>>> <http://xenomai.org/pipermail/xenomai/attachments/20190629/0a820ef7/attachment.bin>
>>
>> Lifting inline:
>>
>>> +static inline struct rtskb *rtnetdev_alloc_rtskb_ip_align(struct rtnet_device
>>> *rtdev,
>>> +		unsigned int length, gfp_t gfp)
>>> +{
>>> +	struct rtskb *rtskb = rtnetdev_alloc_rtskb(rtdev, length + NET_IP_ALIGN);
>>> +
>>> +	if (NET_IP_ALIGN && rtskb)
>>> +		rtskb_reserve(rtskb, NET_IP_ALIGN);
>>> +	return rtskb;
>>> +}
>>
>> This should probably become a non-inline service in rtdev.c.
> 
> I will give that a try.
> 
>>
>> Eventually, it would be good to clean up existing users of this pattern as well.
> 
> You mean other drivers?

Yes. More nice-to-have, though.

> 
>>
>>> -------------- next part --------------
>>> A non-text attachment was scrubbed...
>>> Name: 0001-rtnet-Porting-e1000e-from-mainline-4.14.128.patch
>>> Type: text/x-patch
>>> Size: 823903 bytes
>>> Desc: not available
>>> URL:
>>> <http://xenomai.org/pipermail/xenomai/attachments/20190629/0a820ef7/attachment-0001.bin>
>>>
>>
>> What was the reason for picking 4.14 as baseline? 
> 
> No particular reason.
> As long as I did not have build problems I always used the latest non wip marked ipipe patch when working on the driver.
> When I thought it was in a state to offer it to others to try it, I happened to be on 4.14
> 
>> Did you check if older (minimum would be 4.4.) or newer kernels (4.19 ATM) build as well?
> 
> I just checked 4.4.y-cip, 4.9.y and 4.19.y
> None of them build but nothing looks complicated to solve.
> 
> So you actually would prefer too see the big patch appliable to 4.4.y-cip and then smaller patches as needed moving towards 4.19.y?
> 

I mean, if you want your updated driver to become Xenomai mainline, we would
need it to build against those kernels as well. It needs to be back- and
forward-compatible when living in the Xenomai tree.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

