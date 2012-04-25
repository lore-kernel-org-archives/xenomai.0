MIME-Version: 1.0
In-Reply-To: <4F953CD7.6030207@domain.hid>
References: <CAKvQZ_2H38BtL++2LMhnh_1YOFcia4tR-5FyuQ1SskO3er2RrA@mail.gmail.com>
	<4F951555.2070403@domain.hid>
	<CAKvQZ_3H8b_V0qvTJAQZ7xzwvLWrVGT2VaCh2A7RCpRsuXgC=A@mail.gmail.com>
	<4F953CD7.6030207@domain.hid>
Date: Wed, 25 Apr 2012 12:07:49 +0200
Message-ID: <CAKvQZ_3ZhrDO4adK_h8bQfbT7BJYt3WkMtyoi3fq8_7n6RVH4Q@mail.gmail.com>
From: Willy Lambert <lambert.willy@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Smi workaround on ICH8M
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

2012/4/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> On 04/23/2012 01:05 PM, Willy Lambert wrote:
>> 2012/4/23 Philippe Gerum <rpm@xenomai.org>:
>>> On 04/23/2012 03:51 AM, Willy Lambert wrote:
>>>>
>>>> Hi,
>>>>
>>>> I have a message =A0in dmesg about SMI workaround :
>>>> Xenomai: SMI-enabled chipset found, but SMI workaround disabled
>>>> =A0 =A0 =A0 =A0 =A0(check CONFIG_XENO_HW_SMI_WORKAROUND). You may enco=
unter
>>>> =A0 =A0 =A0 =A0 =A0high interrupt latencies!
>>>>
>>>> My kernel should be configured properly and following the "In case of
>>>> high latencies" of
>>>> http://www.xenomai.org/index.php/Configuring_x86_kernels thread, I did
>>>> some tests.
>>>>
>>>> Latency test is here (if it is us it should be ok no ?):
>>>>
>>>
>>> Yes, this looks ok, but you need to run this test longer, and try a few
>>> usual suspects like plugging in/out USB devices while doing so (e.g. mo=
use,
>>> netdev).
>>>
>>> The point of this message is to tell you that your chipset is known to
>>> create latency issues in some cases (like most Intel chipset these days=
),
>>> but you did not enable the Xenomai code which works around such issues =
by
>>> shutting down problematic SMI sources. That may be right, or even requi=
red
>>> to leave all the SMI sources enabled (e.g. thermal control), but this m=
ight
>>> also lead to unacceptable latency spots. YMMV.
>>>
>>> This is basically a heads up message.
>>>
>>> --
>>> Philippe.
>>
>> Ok, thanks for answers.
>>
>> I did the test again , playing with usb and using the stress program
>> to generate CPU load. The max latency for now is 15us in 4 mins. So I
>> think it will be ok to keep SMI on for the time. Please let me know if
>> this test is still stoo short.
>> ^C---|-----------|-----------|-----------|--------|------|--------------=
-----------
>> RTS| =A0 =A0 =A00.604| =A0 =A0 =A02.332| =A0 =A0 15.161| =A0 =A0 =A0 0| =
=A0 =A0 0| =A0 =A000:03:59/00:03:59
>>
>> Do you know by chance where I can found infos about SMI sources ? I
>> suppose it is not in the ICH8M docs, it would be in my board doc ? Or
>> have I a soft way to do this check so that I don't have to spend time
>> with my vendor which will obviously have hard time to answer that ?
>
> The list of potential SMI sources IS in the ICH8M docs. Whether these
> sources are used by your board essentially depends on the BIOS
> implementation (an SMI traps into BIOS code). So the theoretical answer
> to this question is to disassemble the the BIOS blob.
>

ok, I think I won't do this for now as it's quite tricky, but I have
the path in mind in case of problem. Thx for lighting up the way

> The practical answer is to run latency during a few hours, under stress
> using all the hardware which will be used in your target project
> (network card, disk I/Os, USB key I/Os, etc...). If an SMI is used but
> latencies remain acceptable with regard to your goals, no reason to bothe=
r.
>
> If you find unacceptable latencies, see the TROUBLESHOOTING guide, to
> see how to enable SMI workaround.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.

