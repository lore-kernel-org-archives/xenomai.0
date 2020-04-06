Subject: Re: How to use the rtdm udd?
References: <CAAvDm6bGS6agUeAEUMVR5cu=wAYJJkQ7_ZPQPBoKGzZPj3Ts4A@mail.gmail.com>
 <24efb99e-bf45-8265-3ad5-d6ad4d90a4a1@siemens.com>
 <e046611c-9104-81ff-49a1-5883b064f503@grandegger.com>
 <2dbe0d6e-e1c5-01ac-1e8b-8b4a156ed43d@grandegger.com>
 <a844de66-b5f7-9f31-952f-f75ac3768715@siemens.com>
 <70d4a409-b6f6-112f-e499-862463741e01@grandegger.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e3303212-c994-450c-abd6-17f99f9a8961@siemens.com>
Date: Mon, 6 Apr 2020 13:51:03 +0200
MIME-Version: 1.0
In-Reply-To: <70d4a409-b6f6-112f-e499-862463741e01@grandegger.com>
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
To: Wolfgang Grandegger <wg@grandegger.com>, xenomai@xenomai.org

On 06.04.20 13:47, Wolfgang Grandegger wrote:
> Hello Jan,
> 
> Am 06.04.20 um 10:10 schrieb Jan Kiszka:
>> On 06.04.20 10:02, Wolfgang Grandegger via Xenomai wrote:
>>> Hello,
>>>
>>> Am 06.04.20 um 09:58 schrieb Wolfgang Grandegger via Xenomai:
>>>> Hello,
>>>>
>>>> Am 06.04.20 um 09:47 schrieb Jan Kiszka via Xenomai:
>>>>> On 06.04.20 09:31, 孙世龙 via Xenomai wrote:
>>>>>> How to use the rtdm udd?
>>>>>> Is there some examples to show how to use it?Is there some material on
>>>>>> how
>>>>>> to use it?
>>>>>> Thanks.Looking forward to your replay.
>>>>>>
>>>>>
>>>>> In fact, we lack an example driver. However, the usage is analoguous to
>>>>> the kernel's UIO framework, and details a documented in
>>>>> https://gitlab.denx.de/Xenomai/xenomai/-/blob/master/include/cobalt/kernel/rtdm/udd.h
>>>>>
>>>>
>>>> Some time ago, Philippe posted a simple UDD driver:
>>>>
>>>> https://xenomai.org/pipermail/xenomai/2017-February/037121.html
>>>
>>> Ah, sorry, that's a driver example but I also remember a user-space
>>> example program. Start digging now...
>>>
>>
>> TIA! If someone could create the content for wiki entry, I would add
>> that under "Programming".
> 
> OK, I can prepare some doc including a user-space example. Should be in
> the "asciidoc" format, right?

Or markdown - whatever gitlab accepts. I've granted you access to the wiki.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

