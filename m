Subject: Re: RTCan missing frames
References: <aea6afe6-99e3-9e60-6004-05d7a3d0eb42@compador.de>
 <5f653b5a-e82f-ce42-c8c6-3fa05ccce53d@grandegger.com>
 <f6a62138-a1fa-f631-25b4-5acb1037273d@compador.de>
 <063773f9-ac33-fb9c-7cf4-7c971f882041@grandegger.com>
 <4d3e3575-e29d-0ba7-50b3-97fbc108d70d@compador.de>
 <b643dfd1-9648-ad5a-05ff-164c58574bff@grandegger.com>
 <e469590e-a04f-657d-9563-efbaa62e27c8@compador.de>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <154ddc3c-8813-14c1-53e8-61d337ab0d69@grandegger.com>
Date: Mon, 11 Feb 2019 17:46:17 +0100
MIME-Version: 1.0
In-Reply-To: <e469590e-a04f-657d-9563-efbaa62e27c8@compador.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johannes Holtz <johannes.holtz@compador.de>, xenomai@xenomai.org

Hello,

Am 11.02.19 um 16:12 schrieb Johannes Holtz:
> Am 11.02.19 um 16:07 schrieb Wolfgang Grandegger:
>> Hello,
>>
>> at a first glance, your code looks good, but you are using the native
>> api.. more inline...
>>
>> Am 11.02.19 um 14:13 schrieb Johannes Holtz:
>>> Am 11.02.19 um 13:40 schrieb Wolfgang Grandegger:
>>>> Hello,
>>>>
>>>> Am 11.02.19 um 12:55 schrieb Johannes Holtz:
>>>>> Am 11.02.19 um 12:26 schrieb Wolfgang Grandegger:
>>>>>> Hello,
>>>>>>
>>>>>> Am 11.02.19 um 10:16 schrieb Johannes Holtz via Xenomai:
>>>>>>> Hi,
>>>>>>>
>>>>>>> In my application i set up a RTCAN socket and a pair of rt-threads.
>>>>>>> One
>>>>>>> to read and one to write. Writing works perfectly and I receive
>>>>>>> answers
>>>>>>> in the initial phase of the program.
>>>>>>>
>>>>>>> In particular I send CANopen NMT messages out and receive the
>>>>>>> responses
>>>>>>> from the other Nodes in the Network.
>>>>>>>
>>>>>>> 2019-02-11 09:52:13.309[       500][    CAN TX] > NMT Node 0:0:
>>>>>>> CAN ID 0x000 FC 0x0 DLC 2
>>>>>>>            0       82 00
>>>>>>> 2019-02-11 09:52:13.310[       503][    CAN RX] > NMT Error Control
>>>>>>> Node
>>>>>>> 0:8:
>>>>>>> CAN ID 0x708 FC 0xe DLC 1
>>>>>>>            0       00
>>>>>>> 2019-02-11 09:52:13.311[       503][    CAN RX] > NMT Error Control
>>>>>>> Node
>>>>>>> 0:9:
>>>>>>> CAN ID 0x709 FC 0xe DLC 1
>>>>>>>            0       00
>>>>>>> 2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Error Control
>>>>>>> Node
>>>>>>> 0:3:
>>>>>>> CAN ID 0x703 FC 0xe DLC 1
>>>>>>>            0       00
>>>>>>> 2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Error Control
>>>>>>> Node
>>>>>>> 0:4:
>>>>>>> CAN ID 0x704 FC 0xe DLC 1
>>>>>>>            0       00
>>>>>>> 2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Error Control
>>>>>>> Node
>>>>>>> 0:5:
>>>>>>> CAN ID 0x705 FC 0xe DLC 7
>>>>>>>            0       00 06 07 00
>>>>>>>            4       00 01 01
>>>>>>> 2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Node 0:0:
>>>>>>> CAN ID 0x000 FC 0x0 DLC 3
>>>>>>>            0       07 00 00
>>>>>>> 2019-02-11 09:52:13.326[       519][    CAN RX] > TIME Node 0:1:
>>>>>>> CAN ID 0x101 FC 0x2 DLC 0
>>>>>>>
>>>>>>> As you can see, I capture 7 frames. However, the RX count from
>>>>>>> /proc/rtcan/devices is 10.
>>>>>>>
>>>>>>> If I send specific SDO requests to one of the node which have
>>>>>>> answered I
>>>>>>> don't capture a response but the RX count increases and rtcanrecv
>>>>>>> program captures the correct response. Only my application's read
>>>>>>> doesn't return.
>> What do you mean with "doesn't return". rt_can_recv(MSG_DONTWAIT) should
>> not block. What does it return?
> It only returns EAGAIN like there is nothing to read.

UI suggest to write a simple test program to demonstrate the issue. It
should just open the socket and trying to receive messages... just the
necessary stuff. First with a blocking recv() and then non-blocking.

What hardware and software are you using (arch, board, linux, xenomai)?

Wolfgang.

