Subject: Re: RTCan missing frames
References: <aea6afe6-99e3-9e60-6004-05d7a3d0eb42@compador.de>
 <867c0044-d27d-8f86-2534-6e8f71b2c2f4@xenomai.org>
From: Johannes Holtz <johannes.holtz@compador.de>
Message-ID: <44ca8ea8-61a3-0088-60e0-bd85c0ff404d@compador.de>
Date: Mon, 11 Feb 2019 15:18:48 +0100
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

I tried the same code with recvmsg() instead and get sometimes EINVAL 
back but no MSG_OOB flag is set. The iov_len is always 16 and thus 
presumably doesn't exceed ssize_t.

Weird.

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
>
>> I rather hope there is something wrong with my
>> approach.
>>
>> I'm thankful for every hint
> Enabling the *DRIVERS_CAN_DEBUG Kconfig switch may give you more hints.
>



