Message-ID: <2ff1a98a0805190536q5bb3be8dg9b35265bc5b1b618@domain.hid>
Date: Mon, 19 May 2008 14:36:49 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <48316FCF.3030706@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1168701330@domain.hid>
	<2ff1a98a0805190239x5f8c8445h47d8ca3070dded1c@domain.hid>
	<4831626B.9080208@domain.hid>
	<2ff1a98a0805190506g10f8c1bx781434f8bc73d9a1@domain.hid>
	<48316FCF.3030706@domain.hid>
Subject: Re: [Xenomai-help] at91sam9263 and user-space support compile fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: paradoxxa <paradoxxa2001@domain.hid>
Cc: xenomai@xenomai.org

On Mon, May 19, 2008 at 2:17 PM, paradoxxa <paradoxxa2001@domain.hid> wrote:
> Gilles Chanteperdrix schrieb:
>>
>> On Mon, May 19, 2008 at 1:20 PM, paradoxxa <paradoxxa2001@domain.hid> wrote:
>>
>>>
>>> Gilles Chanteperdrix schrieb:
>>>
>>>>
>>>> On Mon, May 19, 2008 at 8:26 AM,  <Paradoxxa2001@domain.hid> wrote:
>>>>
>>>>
>>>>>
>>>>> God Morning,
>>>>>
>>>>> I tried "make uImage" already.
>>>>> I got the messages like:
>>>>>
>>>>> uncompressing kernel---
>>>>> crc error
>>>>> --System halted
>>>>>
>>>>>
>>>>
>>>> Yes, uImage is compressed, but contains the decompression code, it is
>>>> not supposed to be decompressed by uboot. Maybe what you want is "make
>>>> Image".
>>>>
>>>>
>>>>
>>>
>>> I will check this.
>>>
>>>>>
>>>>> [<c00236b0>] [<c00236b0>] (name_to_dev_t+0x0/0x28c)
>>>>> (name_to_dev_t+0x0/0x28c) from [<c0009328>] from
>>>>>  [<c0009328>] (prepare_namespace+0x94/0x16c)
>>>>> (prepare_namespace+0x94/0x16c)
>>>>>  r7:c001c070 r7:c001c070 r6:00000000 r6:00000000 r5:c001d85c
>>>>> r5:c001d85c
>>>>> r4:c001d86c r4:c001d86c
>>>>>
>>>>> [<c0009294>] [<c0009294>] (prepare_namespace+0x0/0x16c)
>>>>> (prepare_namespace+0x0/0x16c) from [<c0008a9
>>>>> 8>] from [<c0008a98>] (kernel_init+0x230/0x290)
>>>>> (kernel_init+0x230/0x290)
>>>>>  r5:00000000 r5:00000000 r4:c036a4e0 r4:c036a4e0
>>>>>
>>>>> [<c0008868>] [<c0008868>] (kernel_init+0x0/0x290)
>>>>> (kernel_init+0x0/0x290)
>>>>> from [<c003ddbc>] from [<c
>>>>> 003ddbc>] (do_exit+0x0/0x790)
>>>>> (do_exit+0x0/0x790)
>>>>> Code: Code: 20000220 20000220 e2833001 e2833001 e50b3020 e50b3020
>>>>> e51b2020 e51b2020 (e5d21000) (e5d2
>>>>> 1000)
>>>>>
>>>>>
>>>>
>>>> This does not seem to be related to Xenomai or the compiler. Maybe you
>>>> selected a wrong kernel option ? Have you tried compiling with the
>>>> defconfig for your board ?
>>>>
>>>>
>>>>
>>>
>>> I used all the time the defconfig for my board. Without the ipipe patch
>>> the
>>> kernel works. If i use the vendor compiler and the ipipe patched
>>> kernel i can boot it, too!
>>>
>>
>> No, you are not using the defconfig since you have CONFIG_DEBUG_INFO
>> enabled and it is not enabled in the defconfigs. So, you made at least
>> one change.
>>
>>
>
> Thats  all what i changed!  Without it, nothing happens.

No, you are talking about CONFIG_DEBUG_LL, I am talking about
CONFIG_DEBUG_INFO. These are two different options. So, this make at
least two options that you changed. Could you check if a kernel with
an unmodified defconfig boots ?

-- 
 Gilles

