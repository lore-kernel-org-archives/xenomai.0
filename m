Subject: Re: RTnet vnic0 non-rt traffic bug
References: <CAPm8-H4PS0EqzKxGfaowfDeiqWD96nHB5MsZxQt6iFQ8X-pX0g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a9b3ccfa-e23e-c228-6db8-1751e011948f@siemens.com>
Date: Fri, 4 Oct 2019 09:34:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAPm8-H4PS0EqzKxGfaowfDeiqWD96nHB5MsZxQt6iFQ8X-pX0g@mail.gmail.com>
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
To: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>, xenomai <xenomai@xenomai.org>

On 03.10.19 15:34, Laurentiu-Cristian Duca via Xenomai wrote:
> Hello rtnet dev,
> 
>    I think I found a bug in RTnet:
> ping and non-rt applications (e.g. dropbear) send non-rt traffic via vnic0,
> but the ethernet type is 0x9021 (real-time media access control type):
> xenomai-3.0.9/kernel/drivers/net/stack/rtmac/rtmac_vnic.c:156:    res
> = rtmac_add_header(rtdev, ethernet->h_dest, rtskb,
> xenomai-3.0.9/kernel/drivers/net/stack/include/rtmac/rtmac_proto.h:32:#define
> ETH_RTMAC               0x9021
> xenomai-3.0.9/kernel/drivers/net/stack/include/rtmac/rtmac_proto.h:59:
>         (rtdev->hard_header(skb, rtdev, ETH_RTMAC, daddr,
> I have caught the traffic through wireshark which confirmed this info.
> 
>    I succesfully can ping and ssh between qemu rtnet virtual machines on vnic0
> but I can not ping a non-rtnet machine from a rtnet machine via vnic0
> and I can not connect using ssh from a non-rtnet machine to a rtnet machine.

This is by design: RTmac implies all participants in the network play according 
to its rule. The vnic is a non-rt tunnel between them, so the remote side has to 
use that protocol as well.

Jan

> 
>    In order to reproduce the bug I have posted a qemu rtnet virtual
> machine and instructions to this link:
> https://github.com/laurentiuduca/rtnet-geek
> 
>    I mention that rtping works ok.
> 
> Kind regards,
> L-C. Duca
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

