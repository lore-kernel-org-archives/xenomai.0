Subject: Re: RTnet sendmmsg and ENOBUFS
References: <DB8PR05MB591594C16F703FD12F088928F6760@DB8PR05MB5915.eurprd05.prod.outlook.com>
 <1510f7f0-e130-0e22-b946-d1f6d84f3608@siemens.com>
 <DB8PR05MB59155D324BA2977A60E63DADF6760@DB8PR05MB5915.eurprd05.prod.outlook.com>
 <AM0PR05MB59064885C14E3DF057F2E9E8F6710@AM0PR05MB5906.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <815b192d-7ecf-385c-058e-969da641f7a4@siemens.com>
Date: Thu, 14 Nov 2019 19:18:17 +0100
MIME-Version: 1.0
In-Reply-To: <AM0PR05MB59064885C14E3DF057F2E9E8F6710@AM0PR05MB5906.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 14.11.19 18:55, Lange Norbert wrote:
> So, for my setup socket_rtskbs is 16, the rt_igp driver rtskbs are 256TX + 256RX.
> 
> As said, our software prepares packets before a timeslice, and would aim to minimize systemcalls and interrupts,
> packets are sent over raw rtsockets.
> 
> if  understand __rtdm_fd_sendmmsg and rt_packet_sendmsg correctly,
> sendmsg will pick one socket_rtskbs, copies data from userspace and
> then passes this rtskbs to rtdev_xmit.
> I don’t see how a free buffers gets passed back, like README.pools describes,
> I guess rtskb_acquire should somehow do this.

The buffer returns (not necessarily the same one, though) when the 
packet was truly sent, and the driver ran its TX cleanup. If you submit 
many packets as a chunk, that may block them for a while.

> 
> So in short, I am using only one socket_rtskbs temporarily, as the function passes
> the buffer to the rtdev (rt_igp driver)?

You are using as many rtskbs as it takes to get the data you passed down 
forwarded as packets to the NIC, and that as long as the NIC needs to 
get that data DMA'ed to the transmitter.

> I suppose the receive path works similarly.
> 

RX works by accepting a global-pool buffer (this is where incoming 
packets first end up in) filled with data in exchange to an empty rtskb 
from the socket pool. That filled rtskb is put into the socket pool once 
the data was transferred to userspace.

> 
> Now if I would want to send nonblocking, ie. as much packets as are possible,
> exhausting the rtskbs then I would expect the EAGAIN/EWOULDBLOCK error and getting
> back the number of successfully queued packets (so I could  drop them and send the remaining later).

I don't recall why anymore, but we decided to use a different error code 
in RTnet for this back then, possibly to differentiate this "should 
never ever happen in a deterministic network" from other errors.

> 
> According to the code in __rtdm_fd_sendmmsg, that’s not what happens, ENOBUFS would be returned instead,
> And the amount of sent packets is lost forever.
> 
> if (datagrams > 0 && (ret == 0 || ret == -EWOULDBLOCK)) {
> /* NOTE: SO_ERROR should be honored for other errors. */
> rtdm_fd_put(fd);
> return datagrams;
> }
> 
> IMHO this condition would need to added:
> ((flags | MSG_DONTWAIT) && ret == -ENOBUFS)
> 
> (Recvmmsg possibly similarly, havent checked yet)

sendmmsg was only added to Xenomai 3.1. There might be room for 
improvements, if not corrections. So, if we do not return the number of 
sent messages or signal an error where we should not (this is how I read 
the man page currently), this needs a patch...

Jan

>> -----Original Message-----
>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Lange
>> Norbert via Xenomai
>> Sent: Mittwoch, 13. November 2019 18:53
>> To: Jan Kiszka <jan.kiszka@siemens.com>; Xenomai
>> (xenomai@xenomai.org) <xenomai@xenomai.org>
>> Subject: RE: RTnet sendmmsg and ENOBUFS
>>
>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> ATTACHMENTS.
>>
>>
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: Mittwoch, 13. November 2019 18:39
>>> To: Lange Norbert <norbert.lange@andritz.com>; Xenomai
>>> (xenomai@xenomai.org) <xenomai@xenomai.org>
>>> Subject: Re: RTnet sendmmsg and ENOBUFS
>>>
>>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> ATTACHMENTS.
>>>
>>>
>>> On 13.11.19 16:10, Lange Norbert via Xenomai wrote:
>>>> Hello,
>>>>
>>>> for one of our applications, we have (unfortunatly) a single ethernet
>>> connection for Realtime and Nonrealtime.
>>>>
>>>> We solve this by sending timeslices with RT first, then filling up the
>>>> remaining space. When stressing the limits (quite possibly beyond if
>>> accounting for bugs), the sendmmsg call over a raw socket returns
>> ENOBUFS
>>> (even with a single small packet).
>>>> I was expecting this call to just block until the resouces are available.
>>>
>>> Blocking would mean that the sites which make buffers available again had
>> to
>>> signal this. The original design idea was to avoid such overhead and rather
>>> rely on the applications to schedule their submissions properly and
>>> preallocate resources accordingly.
>>
>> Ok.
>> In other words, this is the same behaviour as using MSG_DONTWAIT
>> (with a different errno value)
>>
>>>
>>>>
>>>> Timeslices are 1 ms, so that could be around 12Kbyte total or ~190 60Byte
>>> packets (theoretical max).
>>>>
>>>> What variables are involved (whats the xenomai buffer limits, are they
>>> shared or per interface) and choices do I have?
>>>>
>>>> - I could send the packages nonblocking and wait or drop the remaining
>>>> myself
>>>> - I could deal with ENOBUFS the same way as EAGAIN (is there any
>>>> difference actually)
>>>> - I could raise the amount of internal buffer somehow
>>>
>>> Check kernel/drivers/net/doc/README.pools
>>>
>>>>
>>>> Also while stresstesting I get these messages:
>>>>
>>>> [ 5572.044934] hard_start_xmit returned 16 [ 5572.054989]
>>>> hard_start_xmit returned 16 [ 5572.064007] hard_start_xmit returned 16
>>>> [ 5572.067893] hard_start_xmit returned 16 [ 5572.071739]
>>>> hard_start_xmit returned 16 [ 5572.075586] hard_start_xmit returned 16
>>>> [ 5575.096116] hard_start_xmit returned 16 [ 5579.377038]
>>>> hard_start_xmit returned 16
>>>
>>> This likely comes from NETDEV_TX_BUSY signaled by the driver. Check the
>>> one you use for reasons. May include "I don't have buffers left".
>>
>> Yes it does, I was afraid this would indicate some leaked buffers.
>>
>> Norbert
>> ________________________________
>>
>> This message and any attachments are solely for the use of the intended
>> recipients. They may contain privileged and/or confidential information or
>> other information protected from disclosure. If you are not an intended
>> recipient, you are hereby notified that you received this email in error and
>> that any review, dissemination, distribution or copying of this email and any
>> attachment is strictly prohibited. If you have received this email in error,
>> please contact the sender and delete the message and any attachment from
>> your system.
>>
>> ANDRITZ HYDRO GmbH
>>
>>
>> Rechtsform/ Legal form: Gesellschaft mit beschränkter Haftung / Corporation
>>
>> Firmensitz/ Registered seat: Wien
>>
>> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
>>
>> Firmenbuchnummer/ Company registration: FN 61833 g
>>
>> DVR: 0605077
>>
>> UID-Nr.: ATU14756806
>>
>>
>> Thank You
>> ________________________________
> ________________________________
> 
> This message and any attachments are solely for the use of the intended recipients. They may contain privileged and/or confidential information or other information protected from disclosure. If you are not an intended recipient, you are hereby notified that you received this email in error and that any review, dissemination, distribution or copying of this email and any attachment is strictly prohibited. If you have received this email in error, please contact the sender and delete the message and any attachment from your system.
> 
> ANDRITZ HYDRO GmbH
> 
> 
> Rechtsform/ Legal form: Gesellschaft mit beschränkter Haftung / Corporation
> 
> Firmensitz/ Registered seat: Wien
> 
> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
> 
> Firmenbuchnummer/ Company registration: FN 61833 g
> 
> DVR: 0605077
> 
> UID-Nr.: ATU14756806
> 
> 
> Thank You
> ________________________________
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

