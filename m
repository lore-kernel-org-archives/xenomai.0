Subject: Re: RTnet default behavior
References: <b89e46e4-45b8-1fc1-cb0d-2c4d44b07eb7@compador.de>
 <5b5bb644-2f40-dc2b-0414-a25c35ecffbd@siemens.com>
 <019c5a8c-edb1-2c8c-247e-e0fb3fb2d4fd@compador.de>
 <4aaaeafc-62f8-e37f-5235-8ad1479c30b1@siemens.com>
 <9ff3227f-2420-5ed4-17c8-9285b74e5939@compador.de>
 <be9ac02c-e54e-b9d1-0f2c-627d60463f17@siemens.com>
 <d18242f6-0e94-e212-bc0e-abeeae9b8a5d@compador.de>
 <8aef8b96-4c8d-2cd5-cacc-d26f70a24193@compador.de>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <8be919f2-51e9-1196-52ca-f603b484d8af@web.de>
Date: Thu, 24 Oct 2019 12:11:12 +0200
MIME-Version: 1.0
In-Reply-To: <8aef8b96-4c8d-2cd5-cacc-d26f70a24193@compador.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johannes Holtz <johannes.holtz@compador.de>, xenomai@xenomai.org

On 22.10.19 10:30, Johannes Holtz via Xenomai wrote:
> Am 18.10.19 um 18:00 schrieb Johannes Holtz:
>> Am 18.10.19 um 17:36 schrieb Jan Kiszka:
>>> On 18.10.19 17:13, Johannes Holtz via Xenomai wrote:
>>>> Am 18.10.19 um 16:57 schrieb Jan Kiszka:
>>>>> On 18.10.19 16:47, Johannes Holtz via Xenomai wrote:
>>>>>> Am 18.10.19 um 16:33 schrieb Jan Kiszka:
>>>>>>> On 18.10.19 16:10, Johannes Holtz via Xenomai wrote:
>>>>>>>> Hi ,
>>>>>>>>
>>>>>>>> I inherited a project where the RTnet stack is loaded manually
>>>>>>>> at boot
>>>>>>>> time. To be specific. Instead of using the rtnet command line
>>>>>>>> programs
>>>>>>>> the rtnet.ko kernel object as well as the necessary drivers are
>>>>>>>> loaded
>>>>>>>> with insmod. The devices are then brought up with rtifconfig and
>>>>>>>> rtroute.
>>>>>>>>
>>>>>>>> The network consist of 7 PCs (all with the same boot time
>>>>>>>> mechanism)
>>>>>>>> with pre-defined IPs. The setup works and initializes in an
>>>>>>>> asynchronized way (like a typical non-RT network).
>>>>>>>>
>>>>>>>> I'm investigating some performance problems and I don't know
>>>>>>>> whats is
>>>>>>>> really going on since no config is used. How is determined which
>>>>>>>> participant is acting as Master and how the slots are distributed=
?
>>>>>>>> What
>>>>>>>> are the default values?
>>>>>>> You only mentioned rtifconfig and rtroute above, no rtcfg or
>>>>>>> tdmacfg.
>>>>>>> Are you sure RTmac is involved?
>>>>>> This is the list of kernel object that are loaded:
>>>>>>
>>>>>> rtnet.ko
>>>>>>
>>>>>> rtipv4.ko
>>>>>>
>>>>>> rtpacket.ko
>>>>>>
>>>>>> rtudp.ko
>>>>>>
>>>>>> rt_e100e.ko
>>>>>>
>>>>>> rt_8139too.ko
>>>>>>
>>>>>> rt_r8169.ko
>>>>>>
>>>>>> subsequently rtifconfig and rtroute
>>>>>>
>>>>>> Nothing else is done. I don't know id that satisfies for rtmac.
>>>>>> How can
>>>>>> I check?
>>>>> Nope, there would be rtmac.ko, tdma.ko, possibly also rtcfg.ko in
>>>>> addition. And you would see the script calling tdmacfg at least.
>>>> So this means I basically run standard Ethernet with no RT benefits?
>>> The TX and RX path remain deterministic. If your application behave we=
ll
>>> and do not generate overload on the network that can cause switches or
>>> recipients to drop packets, all can still be fine.
>>
>> Since this is not synced (not TDMA) it is very well possible that
>> different nodes interfere and datagrams collide.
>>
>> What would be considered overload? Since the PCs are connected via
>> unmanaged switches=C2=A0 I can't detect if they have any problems.
>>
>>>
>>>>> So, nothing of RTmac should prevent packets from being sent or add
>>>>> size
>>>>> restrictions on them.
>>>>>
>>>>> Maybe you can specify your performance problems in more details?
>>>>>
>>>>> Jan
>>>>>
>>>> Well, In this 7 node network one node is receiving datagrams from all
>>>> other 6 containing sensor data. Each datagram has a sequence number t=
o
>>>> recognize packet loss. Each node is running a RT SW with 1ms loop. In
>>>> certain situations the receiver detects that some (between 1 and 20)
>>>> datagrams where lost. In these situations the amount of sent datagram=
s
>>>> is higher than usual.
>>> What else is on the network? Only those nodes, and they only sent RT
>>> datagrams at a well-defined rate?
>>
>> PC1,PC2 <--->Switch1<--->Switch2<---->PC3-7
>>
>> That's the whole network. Both are un-managed industry switches.
>>
>> PC2 is the receiver.
>>
>>>
>>>> At first I though this might be a throughput issue but even after I
>>>> reduced the payload size drastically I still miss datagrams. The send=
er
>>>> has no problems sending and my receive code always reads all availabl=
e
>>>> data from the queue.
>>>>
>>>> /proc/rtnet/stats doesn't show any errors or drops .
>>>>
>>>> I'm working on an example program to test this issue in detail.
>>>>
>>> OK.
>>>
>>> Jan
>>>
>>
> Ok, after a lot of testing I arrived at some sort of insight. I almost
> became crazy after all the kernel segfaults.
>
> I wrote a simple program with a sender and receiver where the sender
> sends a configurable amount of datagrams per 1ms cycle. (attached)
>
> First I noticed that I get problems when allocating a static buffer of
> several kB. So I started to play around with the stack size. If I
> increase the overall stack size I can allocate that buffer but still get
> buffer size problems on the sender side so I also increased the socket
> buffer size and as long as the increased socket buffer is smaller than
> the stack everything is OK and performance increases. If not you get
> said kernel issues. Unsurprisingly in hindsight.
>
> Obviously the size of the datagrams is also important. The smaller they
> are the smaller the buffers can be.
>
> Curious is that I wasn't able to reproduce the case where datagrams
> where missed.
>
> So plugging my insight of the stack and buffer increases into my actual
> program the overall system performance increases. The amount of missed
> datagrams is reduced dramatically. I'm not sure why though.

Did you already read xenomai/kernel/drivers/net/doc/README.pools? Also
xenomai/kernel/drivers/net/stack/include/rtskb.h may shed some light on
how buffer management works with RTnet. If one side runs out of them and
if it cannot push back (via TCP specifically), you will lose messages.

Jan

