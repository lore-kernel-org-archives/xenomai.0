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
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <0e808ef5-c3b3-ec7a-fe98-f27a483462d3@grandegger.com>
Date: Tue, 12 Feb 2019 12:24:21 +0100
MIME-Version: 1.0
In-Reply-To: <0e83a1f6-e7cd-abd2-6a4f-24b3d46c0b67@compador.de>
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

Am 12.02.19 um 11:42 schrieb Johannes Holtz:
> Am 11.02.19 um 17:46 schrieb Wolfgang Grandegger:
... snip ...
>> UI suggest to write a simple test program to demonstrate the issue. It
>> should just open the socket and trying to receive messages... just the
>> necessary stuff. First with a blocking recv() and then non-blocking.
>>
>> What hardware and software are you using (arch, board, linux, xenomai)?

?

>>
>> Wolfgang.
> 
> The source code is attached:
> 
> compiled with -I/opt/xenomai/include -D_GNU_SOURCE -D_REENTRANT
> -D__XENO__ -lrtdm -L/opt/xenomai/lib -lxenomai -lpthread -lrt -lnative
> 
> can frames sent by rtcansend
> 
> Test 1: blocking:
> 
> ID:0 DLC:2hex:  81 00       <-- NMT request
> ID:709 DLC:1hex:  00        <-- answer node #9
> ID:708 DLC:1hex:  00        <-- answer node #8
> ID:703 DLC:1hex:  00        <-- answer node #3
> ID:705 DLC:0hex:             <-- here it gets weird ! DLC == 0
> ID:70400 DLC:1hex:  01
> ID:70600 DLC:1hex:  01
> ID:70100 DLC:1hex:  01
> ID:70200 DLC:1hex:  01
> ID:1010000 DLC:1hex:  08

This means that you can receive messages from the CAN bus.

> ID:53220 DLC:124 out of bounds. abort.

But that's wired.

> 
> Test 2: non blocking:
> 
> ID:0 DLC:2hex:  81 00    <-- NMT request
> ID:709 DLC:1hex:  00     <-- answer node #9
> ID:708 DLC:1hex:  00     <-- answer node #8
> ID:703 DLC:1hex:  00     <-- answer node #3
> ID:705 DLC:0hex:          <-- same issue DLC is 0
> ID:70600 DLC:1hex:  01
> ID:70400 DLC:1hex:  01
> ID:70200 DLC:1hex:  01
> ID:70100 DLC:1hex:  01
> ID:1010000 DLC:1hex:  08
> ID:53220 DLC:124 out of bounds. abort.

Looks identical.

> Also, I found another possible error source and I don't know if this
> error picture would corresponds to this.
> 
> However,  While reviewing all settings, I noticed that I made a mistake
> with the RXBUF_SIZE which is set to 8096 instead of 8192. Must have been
> asleep when writing this. I'm going to rebuild this module.

Let's try to understand why rt_dev_recv() does return bogus dlc.

What hardware and software are you using (arch, board, can controlelr,
linux, xenomai)?

Wolfgang.

