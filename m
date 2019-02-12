Subject: Re: RTCan missing frames
References: <aea6afe6-99e3-9e60-6004-05d7a3d0eb42@compador.de>
 <5f653b5a-e82f-ce42-c8c6-3fa05ccce53d@grandegger.com>
 <f6a62138-a1fa-f631-25b4-5acb1037273d@compador.de>
 <063773f9-ac33-fb9c-7cf4-7c971f882041@grandegger.com>
 <4d3e3575-e29d-0ba7-50b3-97fbc108d70d@compador.de>
 <b643dfd1-9648-ad5a-05ff-164c58574bff@grandegger.com>
 <e469590e-a04f-657d-9563-efbaa62e27c8@compador.de>
 <154ddc3c-8813-14c1-53e8-61d337ab0d69@grandegger.com>
 <0e83a1f6-e7cd-abd2-6a4f-24b3d46c0b67@compador.de>
 <0e808ef5-c3b3-ec7a-fe98-f27a483462d3@grandegger.com>
 <8a8e8f99-f4fe-0a7c-4b50-c6737c5a7217@compador.de>
 <d7ab7bd0-84a4-cf95-aa3d-bb33fc31b94d@grandegger.com>
From: Johannes Holtz <johannes.holtz@compador.de>
Message-ID: <56a692eb-bb3b-ef07-6057-13b33770f8a4@compador.de>
Date: Tue, 12 Feb 2019 16:19:47 +0100
MIME-Version: 1.0
In-Reply-To: <d7ab7bd0-84a4-cf95-aa3d-bb33fc31b94d@grandegger.com>
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
To: Wolfgang Grandegger <wg@grandegger.com>, xenomai@xenomai.org

Am 12.02.19 um 16:00 schrieb Wolfgang Grandegger:
> Hello Johannes,
>
> Am 12.02.19 um 15:38 schrieb Johannes Holtz:
>> Am 12.02.19 um 12:24 schrieb Wolfgang Grandegger:
>>> Hello,
>>>
>>> Am 12.02.19 um 11:42 schrieb Johannes Holtz:
>>>> Am 11.02.19 um 17:46 schrieb Wolfgang Grandegger:
>>> ... snip ...
>>>>> UI suggest to write a simple test program to demonstrate the issue. It
>>>>> should just open the socket and trying to receive messages... just the
>>>>> necessary stuff. First with a blocking recv() and then non-blocking.
>>>>>
>>>>> What hardware and software are you using (arch, board, linux, xenomai)?
>>> ?
>>>
>>>>> Wolfgang.
>>>> The source code is attached:
>>>>
>>>> compiled with -I/opt/xenomai/include -D_GNU_SOURCE -D_REENTRANT
>>>> -D__XENO__ -lrtdm -L/opt/xenomai/lib -lxenomai -lpthread -lrt -lnative
>>>>
>>>> can frames sent by rtcansend
>>>>
>>>> Test 1: blocking:
>>>>
>>>> ID:0 DLC:2hex:  81 00       <-- NMT request
>>>> ID:709 DLC:1hex:  00        <-- answer node #9
>>>> ID:708 DLC:1hex:  00        <-- answer node #8
>>>> ID:703 DLC:1hex:  00        <-- answer node #3
>>>> ID:705 DLC:0hex:             <-- here it gets weird ! DLC == 0
>>>> ID:70400 DLC:1hex:  01
>>>> ID:70600 DLC:1hex:  01
>>>> ID:70100 DLC:1hex:  01
>>>> ID:70200 DLC:1hex:  01
>>>> ID:1010000 DLC:1hex:  08
>>> This means that you can receive messages from the CAN bus.
>>>
>>>> ID:53220 DLC:124 out of bounds. abort.
>>> But that's wired.
>>>
>>>> Test 2: non blocking:
>>>>
>>>> ID:0 DLC:2hex:  81 00    <-- NMT request
>>>> ID:709 DLC:1hex:  00     <-- answer node #9
>>>> ID:708 DLC:1hex:  00     <-- answer node #8
>>>> ID:703 DLC:1hex:  00     <-- answer node #3
>>>> ID:705 DLC:0hex:          <-- same issue DLC is 0
>>>> ID:70600 DLC:1hex:  01
>>>> ID:70400 DLC:1hex:  01
>>>> ID:70200 DLC:1hex:  01
>>>> ID:70100 DLC:1hex:  01
>>>> ID:1010000 DLC:1hex:  08
>>>> ID:53220 DLC:124 out of bounds. abort.
>>> Looks identical.
>>>
>>>> Also, I found another possible error source and I don't know if this
>>>> error picture would corresponds to this.
>>>>
>>>> However,  While reviewing all settings, I noticed that I made a mistake
>>>> with the RXBUF_SIZE which is set to 8096 instead of 8192. Must have been
>>>> asleep when writing this. I'm going to rebuild this module.
>>> Let's try to understand why rt_dev_recv() does return bogus dlc.
>>>
>>> What hardware and software are you using (arch, board, can controlelr,
>>> linux, xenomai)?
>>>
>>> Wolfgang.
>> I modified the program a little to send it's own requests via one single
>> socket. The output look like this.
>>
>> send succeeded
>> ID:708 DLC:1hex:  00
>> ID:709 DLC:1hex:  00
>> ID:703 DLC:1hex:  00
>> ID:706 DLC:1hex:  00
>> ID:705 DLC:7hex:  00 00 01 01 00 09 07
>> send succeeded
>> send succeeded
>> send succeeded
>> send succeeded
>> send succeeded
>>
>> And a parallel rtcanrecv output  like this:
>>
>> root@machinectrl:~# rtcanrecv rtcan0
>> #0: (1) <0x000> [2] 81 00
>> #1: (1) <0x708> [1] 00
>> #2: (1) <0x709> [1] 00
>> #3: (1) <0x703> [1] 00
>> #4: (0) <0x706> [0]
>> #5: (0) <0x500> [1] 01
>> #6: (0) <0x400> [1] 01
>> #7: (0) <0x100> [1] 01
>> #8: (0) <0x200> [1] 01
>> #9: (0) <0x000> [1] 08
>> #10: (24) <0x220> [124] 00 00 82 00 00 00 01 08 01 00 00 00 f0 84 04 08
> Why is "addr.can_ifindex = 24"? Something is broken in you build.

In the xenomai build? how do I find out what? it all compiled well.

I patched the driver  before building tkernel with 
0001-rtcan-ems_pci-driver-update-to-support-more-devices.patch.gz

I used the ipipe patch from the stable release,

and then build it normally.

Might the RX buf size that I changed a problem?


>
>> 00 af 04 08 c0 68 91 bf 00 00 00 00 00 00 00 00 c0 06 60 b7 18 68 91 bf
>> 78 69 91 bf 80 0d 7c b7 ce 68 91 bf c0 68 91 bf 00 9b 04 08 60 69 91 bf
>> 78 69 91 bf cf 8e 04 08 00 af 04 08 c0 68 91 bf 00 00 00 00 00 00 00 00
>> 00 00 00 00 68 00 0f c1 e0 b8 7a b7 00 00 00 00 01 00 00 00 30 ae 10 f7
>> 04 5e 60 b7 e0 68 91 bf b0 68 91 bf
>> #11: (24) <0x220> [124] 00 00 05 07 00 00 01 07 01 00 00 00 f0 84 04 08
>> 00 af 04 08 c0 68 91 bf 00 00 00 00 00 00 00 00 c0 06 60 b7 18 68 91 bf
>> 78 69 91 bf 80 0d 7c b7 ce 68 91 bf c0 68 91 bf 00 9b 04 08 60 69 91 bf
>> 78 69 91 bf cf 8e 04 08 00 af 04 08 c0 68 91 bf 00 00 00 00 00 00 00 00
>> 00 00 00 00 68 00 0f c1 e0 b8 7a b7 00 00 00 00 01 00 00 00 30 ae 10 f7
>> 04 5e 60 b7 e0 68 91 bf b0 68 91 bf
>> #12: (32) <0x000> [50] 05 05 07 00 00 01 07 00 01 00 00 00 f0 84 04 08
>> 00 af 04 08 c0 68 91 bf 00 00 00 00 00 00 00 00 c0 06 60 b7 18 68 91 bf
>> 78 69 91 bf 80 0d 7c b7 ce 68
>> #13: (9) <0x100> [7] 05 07 00 00 01 07 00
>> #14: (0) <0x100> [0]
>> #15: (1) <0x705> [7] 00 00 01 01 00 09 07
>>
>> None of this makes sense to me.
> I'm really puzzled what's going on. The CAN controller you use is well
> supported.
That is not a good sign.
> Wolfgang.




