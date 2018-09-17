References: <c152b2c4-d6a6-930a-3f6f-2fff032da08e@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ff2a8ac1-4054-bbbb-cfea-1277a926e498@siemens.com>
Date: Mon, 17 Sep 2018 07:03:22 +0200
MIME-Version: 1.0
In-Reply-To: <c152b2c4-d6a6-930a-3f6f-2fff032da08e@gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] NRT send/recv with rtpacket
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Edouard Tisserant <edouard.tisserant@gmail.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hi Edouard,

On 15.09.18 15:02, Edouard Tisserant wrote:
> Hi all,
> 
> When using EtherLAB-RTDM-Net adapter [1], EtherCAT master directly calls
> RTDM RAW socket kernel API to send and receive Ethernet packets.
> 
> Depending on operational state, EtherCAT master can be executed as a
> real-time or non-real-time kernel thread.
> 
> RTpacket did not support non-real-time sendmsg and recvmsg. Attached
> patches fix this problem.
> 
> 0004-xenomai_allow_nrt_operation_in_rtpacket.patch :
>      patch against xenomai-3.0.6 - TESTED OK
> 
> 0001-Add-non-RT-sendmsg-and-recvmsg-in-rtpacket.patch :
>      same patch, "git-formated" against stable-3.0.x UNTESTED

Can you send the patches as separate emails, inlined (git send-email)? This is 
not easily reviewable because...

> 
> Regards,
> 
> Edouard
> 
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: 0004-xenomai_allow_nrt_operation_in_rtpacket.patch
> Type: text/x-patch
> Size: 2388 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20180915/ccc1fa60/attachment.bin>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: 0001-Add-non-RT-sendmsg-and-recvmsg-in-rtpacket.patch
> Type: text/x-patch
> Size: 2945 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20180915/ccc1fa60/attachment-0001.bin>

...these attachments are not forwarded to the list.

Also note that features should first be in next/master before we decide whether 
pushing them to stable as well is OK (generally, only fixes should go there). 
Patches should therefore target the next branch.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

