Subject: Re: RTCan missing frames
References: <aea6afe6-99e3-9e60-6004-05d7a3d0eb42@compador.de>
 <867c0044-d27d-8f86-2534-6e8f71b2c2f4@xenomai.org>
From: Johannes Holtz <johannes.holtz@compador.de>
Message-ID: <edcfd091-d95e-97f9-2f84-608e24a0c7b3@compador.de>
Date: Mon, 11 Feb 2019 12:53:19 +0100
MIME-Version: 1.0
In-Reply-To: <867c0044-d27d-8f86-2534-6e8f71b2c2f4@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Am 11.02.19 um 12:14 schrieb Philippe Gerum:
> On 2/11/19 10:16 AM, Johannes Holtz via Xenomai wrote:
>> Hi,
>>
>> In my application i set up a RTCAN socket and a pair of rt-threads. One
>> to read and one to write. Writing works perfectly and I receive answers
>> in the initial phase of the program.
>>
>> In particular I send CANopen NMT messages out and receive the responses
>> from the other Nodes in the Network.
>>
>> 2019-02-11 09:52:13.309[       500][    CAN TX] > NMT Node 0:0:
>> CAN ID 0x000 FC 0x0 DLC 2
>>          0       82 00
>> 2019-02-11 09:52:13.310[       503][    CAN RX] > NMT Error Control Node
>> 0:8:
>> CAN ID 0x708 FC 0xe DLC 1
>>          0       00
>> 2019-02-11 09:52:13.311[       503][    CAN RX] > NMT Error Control Node
>> 0:9:
>> CAN ID 0x709 FC 0xe DLC 1
>>          0       00
>> 2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Error Control Node
>> 0:3:
>> CAN ID 0x703 FC 0xe DLC 1
>>          0       00
>> 2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Error Control Node
>> 0:4:
>> CAN ID 0x704 FC 0xe DLC 1
>>          0       00
>> 2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Error Control Node
>> 0:5:
>> CAN ID 0x705 FC 0xe DLC 7
>>          0       00 06 07 00
>>          4       00 01 01
>> 2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Node 0:0:
>> CAN ID 0x000 FC 0x0 DLC 3
>>          0       07 00 00
>> 2019-02-11 09:52:13.326[       519][    CAN RX] > TIME Node 0:1:
>> CAN ID 0x101 FC 0x2 DLC 0
>>
>> As you can see, I capture 7 frames. However, the RX count from
>> /proc/rtcan/devices is 10.
>>
>> If I send specific SDO requests to one of the node which have answered I
>> don't capture a response but the RX count increases and rtcanrecv
>> program captures the correct response. Only my application's read
>> doesn't return.
>>
> You mean recvmsg() does not return, correct?
No, I have used rt_dev_recv() as I thought it would suffice. I short 
test with a different call hasn't shown any difference.
>
>> I have not altered the filters and the RX and TX timeouts are at
>> 100micro sec. I also don't get error frames. The RX_BufFull indicator
>> from /proc/rtcan/sockets keeps growing.
>>
> RX_BufFull increasing means that the (raw) socket's ring buffer is
> overflowing, which makes sense if it is not emptied by reading from it
> on the other end.
>
>> Also the rtcanrecv utility shows garbage if i let it run but if I
>> restart it after each request the first response is printed correctly.
>>
>>
>> Can you give me any advice? I followed every example and documentation
>> about rtcan but I'm running out of ideas what the cause could be.
>>
> We have no idea of the CPU architecture you are working on, your target
> kernel is undefined, just like the CAN chip you have been using which
> makes it impossible to find out which RTCAN driver is involved. This
> does not help.
root@machinectrl:~# uname -a

Linux machinectrl 3.8.13-intel-atom #3 SMP Wed Jan 2 11:56:35 CET 2019 
i686 GNU/Linux

root@machinectrl:~# xeno-config --version
2.6.4
root@machinectrl:~# cat /proc/rtcan/rtcan0/info
Device     rtcan0
Controller SJA1000
Board      EMS-CPC-PCI
Clock-Hz   8000000
Baudrate   1000000
Bit-time   brp=1 prop_seg=2 phase_seg1=3 phase_seg2=2 sjw=1 sam=1
Ctrl-Mode
State      active
TX-Counter 27
RX-Counter 167
Errors     0
Refcount   0

[    3.171332] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development 
Team
[    3.172383] RTCAN SJA1000 driver initialized
[    3.173287] rtcan: registered rtcan0
[    3.173351] EMS-CPC-PCI-CAN 0000:07:02.0: Channel #1 at 0xf84fa400, 
irq 17 registered as rtcan0
[    3.173450] rtcan: registered rtcan1
[    3.173508] EMS-CPC-PCI-CAN 0000:07:02.0: Channel #2 at 0xf84fa600, 
irq 17 registered as rtcan1

>
>> I'm still using the "old" 2.6.3 xenomai but I sincerely hope this is not
> Not only old (2013), but officially EOL.
>
>> an old known issue.
> Looking into the commit logs from the Xenomai git tree regarding any
> change in the RTCAN stack since 2.6.3 would be a good start.
>
> https://gitlab.denx.de/Xenomai/xenomai/tree/eol/v2.6.x
> https://gitlab.denx.de/Xenomai/xenomai/tree/next
Thank you for the references.
>> I rather hope there is something wrong with my
>> approach.
>>
>> I'm thankful for every hint
> Enabling the *DRIVERS_CAN_DEBUG Kconfig switch may give you more hints.
>



