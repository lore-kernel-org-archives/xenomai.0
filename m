Subject: Re: RTnet vnic0 non-rt traffic bug
References: <CAPm8-H4PS0EqzKxGfaowfDeiqWD96nHB5MsZxQt6iFQ8X-pX0g@mail.gmail.com>
 <a9b3ccfa-e23e-c228-6db8-1751e011948f@siemens.com>
 <CAPm8-H7r9938OE5+zOZiKBcUV_5dGgH9PzWL4FHZKOPxZYH=0w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <20f9047a-33de-8646-91d2-bee12559de07@siemens.com>
Date: Fri, 4 Oct 2019 12:51:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAPm8-H7r9938OE5+zOZiKBcUV_5dGgH9PzWL4FHZKOPxZYH=0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 04.10.19 12:41, Laurentiu-Cristian Duca wrote:
> I have tested the nomac discipline:
> - on rteth0 ethernet traffic has ethernet type = IPv4 = 0x0800
> (tested rtping and rtt-sender <-> rtt-responder)
> - on vnic0 ethernet traffic has ethernet type 0x9021
> (tested using ping and ssh between two rtnet machines)
> I captured the traffic with wireshark.

Yes, it's tunneled traffic, that's why it has an own Ethernet type. The receiver 
has to implement this protocol as well in order to unpack the non-rt traffic and 
forward or process it. All as designed and IIRC also specified.

Jan

> 
> It is easy to see this behavior by consulting the link from my previous email.
> 
> On 10/4/19, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On 03.10.19 15:34, Laurentiu-Cristian Duca via Xenomai wrote:
>>> Hello rtnet dev,
>>>
>>>     I think I found a bug in RTnet:
>>> ping and non-rt applications (e.g. dropbear) send non-rt traffic via
>>> vnic0,
>>> but the ethernet type is 0x9021 (real-time media access control type):
>>> xenomai-3.0.9/kernel/drivers/net/stack/rtmac/rtmac_vnic.c:156:    res
>>> = rtmac_add_header(rtdev, ethernet->h_dest, rtskb,
>>> xenomai-3.0.9/kernel/drivers/net/stack/include/rtmac/rtmac_proto.h:32:#define
>>> ETH_RTMAC               0x9021
>>> xenomai-3.0.9/kernel/drivers/net/stack/include/rtmac/rtmac_proto.h:59:
>>>          (rtdev->hard_header(skb, rtdev, ETH_RTMAC, daddr,
>>> I have caught the traffic through wireshark which confirmed this info.
>>>
>>>     I succesfully can ping and ssh between qemu rtnet virtual machines on
>>> vnic0
>>> but I can not ping a non-rtnet machine from a rtnet machine via vnic0
>>> and I can not connect using ssh from a non-rtnet machine to a rtnet
>>> machine.
>>
>> This is by design: RTmac implies all participants in the network play
>> according
>> to its rule. The vnic is a non-rt tunnel between them, so the remote side
>> has to
>> use that protocol as well.
>>
>> Jan
>>
>>>
>>>     In order to reproduce the bug I have posted a qemu rtnet virtual
>>> machine and instructions to this link:
>>> https://github.com/laurentiuduca/rtnet-geek
>>>
>>>     I mention that rtping works ok.
>>>
>>> Kind regards,
>>> L-C. Duca
>>>
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>> Corporate Competence Center Embedded Linux
>>

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

