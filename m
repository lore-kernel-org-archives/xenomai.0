Subject: Re: RTnet sendmmsg and ENOBUFS
References: <DB8PR05MB591594C16F703FD12F088928F6760@DB8PR05MB5915.eurprd05.prod.outlook.com>
 <1510f7f0-e130-0e22-b946-d1f6d84f3608@siemens.com>
 <DB8PR05MB59155D324BA2977A60E63DADF6760@DB8PR05MB5915.eurprd05.prod.outlook.com>
 <AM0PR05MB59064885C14E3DF057F2E9E8F6710@AM0PR05MB5906.eurprd05.prod.outlook.com>
 <815b192d-7ecf-385c-058e-969da641f7a4@siemens.com>
 <VI1PR05MB59174C5543846C0507F6802DF6700@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <65c16da2-e452-5dc8-85d8-8bf1a18a1105@siemens.com>
 <VI1PR05MB5917B2A3A41FA364C6326488F6700@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <63f7c728-c943-d811-ea69-85856c7c4348@siemens.com>
Date: Fri, 15 Nov 2019 14:35:54 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917B2A3A41FA364C6326488F6700@VI1PR05MB5917.eurprd05.prod.outlook.com>
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

On 15.11.19 13:37, Lange Norbert wrote:
> 
> 
>>
>>>
>>>>
>>>>> I suppose the receive path works similarly.
>>>>>
>>>>
>>>> RX works by accepting a global-pool buffer (this is where incoming packets
>>>> first end up in) filled with data in exchange to an empty rtskb from the
>> socket
>>>> pool. That filled rtskb is put into the socket pool once the data was
>>>> transferred to userspace.
>>>
>>> I suppose all pools can exchange rtskb, so this is just a matter of which pool
>> size is limiting.
>>> If I want to recvmmsg 100 messages, will I get at most 16 (socket pool size),
>>> or will a single slot be used and exchanged with the drivers?
>>
>> One packet, one rtskb. So you have both the device and the socket pool
>> as limiting factors.
> 
> I guess this is different to the sendpath as the device "pushes up" the rtskb's,

Actually, commit 91b3302284fd "aligned" TX to RX path. But the documents 
still state something else. And I doubt now that this commit was going 
in the right direction.

In fact, it introduced a way for competing transmitters to starve each 
other by exhausting the now shared device pool for TX.

> And the recvmmsg call then picks up the packets that are available?
> (having some trouble following the path in the kernel sources)

The point of the ownership transfer on RX is that, when receiving only 
with one queue (RTnet can't handle more in fact, though it should by 
now...), we first need to parse the packet content in order to dispatch 
it. That makes the packet first owned by the device (formerly the RX 
pool), and once the actual owner is known, it is transferred - or 
dropped if the recipient has no free buffer.

> 
> We have some legacy application that ran on an imx28, and we have to keep the protocols for now,
> They are almost exclusively UDP/IP4 but there's one message for distributing timestamps with a 802.2 SNAP packet.
> (had some technical/implementation reasons, cant remember now).
> Currently I use an ETH_P_ALL packet socket for that reason, but looking at the code it seems beneficial to drop that.
> 
> -   there seems to be copies of rtskb made
> -   the packets are not consumed, but kicked up further in the stack

ETH_P_ALL is a kind of snooping mode, therefore the copies. You rather 
want to register on the desired (non-IP) type(s).

> 
> What I would want is a socket that simply drains everything, packets in use are ETH_P_IP,
> ETH_P_ARP and whatever is necessary to send/receive those 802.2 SNAP packets.

IP and ARP will be handled by RTnet, the other types is what you need 
packet sockets for.

> 
> I see ETH_P_802_EX1 used for such packets in examples, but I don’t see how your stack identifies such packets?

rt_packet_bind -> rtdev_add_pack. Dispatching is done in 
rt_stack_deliver, in rt-kernel thread context.

> 
> -   I don’t know which ETH_P type to use, theres ETH_P_802_2, ETH_P_802_EX1, ETH_P_SNAP potentially others.
> -   Those constants seems to be largely missing in xenomais sources, so I don’t know how you would test for a match.

You can register any value you like with AF_PACKET, just like in Linux. 
Matching is not done by a switch-case, rather via a hashed list via the 
values.

> -   Easiest for me would be a ETH_P_ALL_CONSUME type, buffers just end there when such a socket is open (feasible, would be accepted upstream?)

I think you are better of with target subscriptions. Then all unknown 
packets will simply be dropped, and that much earlier.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

