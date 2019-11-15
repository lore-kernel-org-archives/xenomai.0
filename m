Subject: Re: RTnet sendmmsg and ENOBUFS
References: <DB8PR05MB591594C16F703FD12F088928F6760@DB8PR05MB5915.eurprd05.prod.outlook.com>
 <1510f7f0-e130-0e22-b946-d1f6d84f3608@siemens.com>
 <DB8PR05MB59155D324BA2977A60E63DADF6760@DB8PR05MB5915.eurprd05.prod.outlook.com>
 <AM0PR05MB59064885C14E3DF057F2E9E8F6710@AM0PR05MB5906.eurprd05.prod.outlook.com>
 <815b192d-7ecf-385c-058e-969da641f7a4@siemens.com>
 <VI1PR05MB59174C5543846C0507F6802DF6700@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <65c16da2-e452-5dc8-85d8-8bf1a18a1105@siemens.com>
Date: Fri, 15 Nov 2019 12:30:18 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB59174C5543846C0507F6802DF6700@VI1PR05MB5917.eurprd05.prod.outlook.com>
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

On 15.11.19 11:10, Lange Norbert via Xenomai wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Donnerstag, 14. November 2019 19:18
>> To: Lange Norbert <norbert.lange@andritz.com>; Xenomai
>> (xenomai@xenomai.org) <xenomai@xenomai.org>
>> Cc: Philippe Gerum (rpm@xenomai.org) <rpm@xenomai.org>
>> Subject: Re: RTnet sendmmsg and ENOBUFS
>>
>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> ATTACHMENTS.
>>
>>
>> On 14.11.19 18:55, Lange Norbert wrote:
>>> So, for my setup socket_rtskbs is 16, the rt_igp driver rtskbs are 256TX +
>> 256RX.
>>>
>>> As said, our software prepares packets before a timeslice, and would
>>> aim to minimize systemcalls and interrupts, packets are sent over raw
>> rtsockets.
>>>
>>> if  understand __rtdm_fd_sendmmsg and rt_packet_sendmsg correctly,
>>> sendmsg will pick one socket_rtskbs, copies data from userspace and
>>> then passes this rtskbs to rtdev_xmit.
>>> I don’t see how a free buffers gets passed back, like README.pools
>>> describes, I guess rtskb_acquire should somehow do this.
>>
>> The buffer returns (not necessarily the same one, though) when the packet
>> was truly sent, and the driver ran its TX cleanup. If you submit many packets
>> as a chunk, that may block them for a while.
>>
>>>
>>> So in short, I am using only one socket_rtskbs temporarily, as the
>>> function passes the buffer to the rtdev (rt_igp driver)?
>>
>> You are using as many rtskbs as it takes to get the data you passed down
>> forwarded as packets to the NIC, and that as long as the NIC needs to get
>> that data DMA'ed to the transmitter.
> 
> I was talking about the pools. The socket pool has 16  rtskbs, the device pool has 512.
> As I understand it, the __rtdm_fd_sendmmsg picks one rtskb from the socket pool,
> Then exchanges this buffer with a free one from the device pool (rtskb_acquire?).
> So sendmmsg requires a single "slot" from their pool, then gets that "slot" back
> when passing the rtskb down to the device.
> 
> Or In other words, I could successfully sendmmsg 100 messages, aslong there is one free
> slot in the socket pool, and the device pool has enough free slots.

Yep.

> 
>>
>>> I suppose the receive path works similarly.
>>>
>>
>> RX works by accepting a global-pool buffer (this is where incoming packets
>> first end up in) filled with data in exchange to an empty rtskb from the socket
>> pool. That filled rtskb is put into the socket pool once the data was
>> transferred to userspace.
> 
> I suppose all pools can exchange rtskb, so this is just a matter of which pool size is limiting.
> If I want to recvmmsg 100 messages, will I get at most 16 (socket pool size),
> or will a single slot be used and exchanged with the drivers?

One packet, one rtskb. So you have both the device and the socket pool 
as limiting factors.

> 
>>
>>>
>>> Now if I would want to send nonblocking, ie. as much packets as are
>>> possible, exhausting the rtskbs then I would expect the
>>> EAGAIN/EWOULDBLOCK error and getting back the number of successfully
>> queued packets (so I could  drop them and send the remaining later).
>>
>> I don't recall why anymore, but we decided to use a different error code in
>> RTnet for this back then, possibly to differentiate this "should never ever
>> happen in a deterministic network" from other errors.
> 
> Yes, I guess that makes sense in alot usecases. Mine is a bit different,
> I use a service that just tunnels a TUN to a RT Packet socket, and once someone
> connects to an IDDP socket for RT traffic, timeslices are used.
> 
> So the network is not always in "deterministic mode".
> 
>>
>>>
>>> According to the code in __rtdm_fd_sendmmsg, that’s not what happens,
>>> ENOBUFS would be returned instead, And the amount of sent packets is
>> lost forever.
>>>
>>> if (datagrams > 0 && (ret == 0 || ret == -EWOULDBLOCK)) {
>>> /* NOTE: SO_ERROR should be honored for other errors. */
>>> rtdm_fd_put(fd); return datagrams; }
>>>
>>> IMHO this condition would need to added:
>>> ((flags | MSG_DONTWAIT) && ret == -ENOBUFS)
>>>
>>> (Recvmmsg possibly similarly, havent checked yet)
>>
>> sendmmsg was only added to Xenomai 3.1. There might be room for
>> improvements, if not corrections. So, if we do not return the number of sent
>> messages or signal an error where we should not (this is how I read the man
>> page currently), this needs a patch...
> 
> Yes, seems you either need to drop the number of transmitted msgs (unlike the linux call)
> or the error condition.
> If you can pass both out of the kernel function, perhaps you could still set errno in case of an (real) error?
> (I really don’t need it, but it's worth considering)

Patches are on the list, feedback is appreciated. Just note that we try 
to follow the Linux interface.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

