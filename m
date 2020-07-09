Subject: Re: How can I investigate the cause of "watchdog: BUG: soft lockup"?
References: <CAAvDm6bA37PeCYST66hZniEFFLG1e7Sry408RyGxryhD2iehQA@mail.gmail.com>
 <f569108e-bd2e-5c45-7164-69539360923e@web.de>
 <CAAvDm6a_HsbNGJiUoWsdy+C+wVJn3toHcYKV+nF-q80bhPcf3w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <bcc4f5b9-33ca-035d-8255-2a79cb488066@web.de>
Date: Thu, 9 Jul 2020 16:16:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6a_HsbNGJiUoWsdy+C+wVJn3toHcYKV+nF-q80bhPcf3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 09.07.20 15:02, =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong wrote:
> Hi, Jan
> Thank you for taking the time to respond to me.
>
>> In general, system-level tracing can help in such scenarios to gain an
>> overview about what is going on.
> I googled and found many tools and methods.
> I am a little confused about which method(or tool) is the most
> suitable one for this matter(which one should I try firstly).
> Could you please give me some suggestions?
>

Have a look at trace-cmd. Possibly also kernelshark, just note that it
may not visualize all task switches correctly when there are Xenomai
tasks involved.

Jan

> Thank you for your attention to this matter.
> Best Regards.
>
>
> Jan Kiszka <jan.kiszka@web.de> =E4=BA=8E2020=E5=B9=B47=E6=9C=889=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=881:15=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On 04.07.20 03:56, =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong via Xenomai w=
rote:
>>> Hi, list
>>> I encountered the error of "watchdog: BUG: soft lockup" when I sent
>>> data through the can bus.
>>> Could you please give me some hint on how to investigate the cause dee=
ply?
>>> Thank you for your attention to this matter.
>>
>>   From the backtrace, it is not yet clear to me which role Xenomai/I-pi=
pe
>> plays here. Furthermore, it points to an out-of-tree CAN dri (advcan)
>> which makes it even harder to tell cause and effect apart.
>>
>> In general, system-level tracing can help in such scenarios to gain an
>> overview about what is going on.
>>
>> Jan

