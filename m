MIME-Version: 1.0
In-Reply-To: <711430923.3726721.1520873818863.JavaMail.zimbra@triolcorp.com.ua>
References: <466115005.3631078.1520863793122.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8QkmhLRL+T=QmMDctCdrpQ+xw=7ntR0Pj5Pgt1nq4HNFQ@mail.gmail.com>
 <724564032.3685392.1520869318586.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8RWkkFLbt6=bYvEPP_BKCKcAwS0rU_+JCYAAMhFhkyQYg@mail.gmail.com>
 <1182515752.3725277.1520873109725.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8RH5oguZ0eazPNDX_2XYM-mjpQCnPkhHOLSOTVQfHnerQ@mail.gmail.com>
 <711430923.3726721.1520873818863.JavaMail.zimbra@triolcorp.com.ua>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 15 Mar 2018 15:53:14 -0400
Message-ID: <CALLqZ8T9tUKHC5cDw0AfOO_u1z9_zpAmSPq=0G32ywTy39uc8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] simple rtdm driver x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?0KjQtdCy0YfQtdC90LrQviDQotCw0YDQsNGBINCT0YDQuNCz0L7RgNGM0LXQstC40Yc=?= <shevchenko.taras@triolcorp.com.ua>
Cc: xenomai <xenomai@xenomai.org>

I had time to test this on a Zynq microzed board using the new 4.14
ipipe and it works without issue.  What branch are you using from the
Xenomai repo?

On Mon, Mar 12, 2018 at 12:56 PM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=
=BA=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=
=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
<shevchenko.taras@triolcorp.com.ua> wrote:
> sad, to hear it
> it is possible to remind you if I get fail with gpio?
>
> Yes I able to build from repo , I wrote about , today earlier
>
> I used some different way   - like in your instruction
>
> make bzImage modules
> make install
>
>
> ----- Original Message -----
> From: "Greg Gallagher" <greg@embeddedgreg.com>
> To: "=D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2=D0=B0=D1=80=
=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=
=D1=87" <shevchenko.taras@triolcorp.com.ua>
> Cc: "xenomai" <xenomai@xenomai.org>
> Sent: Monday, March 12, 2018 6:50:47 PM
> Subject: Re: [Xenomai] simple rtdm driver x86
>
> No that shouldn't have an impact on it.  I have a couple theories
> about what is happening but I don't have time to test them out at the
> moment.  Hopefully I'll have some time closer to the end of the week
> to look into it.  Where you able to build from the git repo?
>
> -Greg
>
> On Mon, Mar 12, 2018 at 12:45 PM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=
=BA=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=
=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
> <shevchenko.taras@triolcorp.com.ua> wrote:
>>
>> could be the problem in loading out-of-tree module taints kernel.
>>
>> yeti@yeti-UDOO-x86:~/develop/rtdm_hello$ dmesg|grep rtdm
>> [ 1536.073433] rtdm_hello: loading out-of-tree module taints kernel.
>> [ 1536.073532] rtdm_hello: module verification failed: signature and/or =
required key missing - tainting kernel
>> yeti@yeti-UDOO-x86:~/develop/rtdm_hello$ dmesg|grep RTDM
>> [ 1536.075500] RTDM gpio init.
>> [ 1536.075617] RTDM numero 266:
>>
>>
>>
>> ----- Original Message -----
>> From: "Greg Gallagher" <greg@embeddedgreg.com>
>> To: "=D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2=D0=B0=D1=80=
=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=
=D1=87" <shevchenko.taras@triolcorp.com.ua>
>> Cc: "xenomai" <xenomai@xenomai.org>
>> Sent: Monday, March 12, 2018 5:46:05 PM
>> Subject: Re: [Xenomai] simple rtdm driver x86
>>
>> Use this https://xenomai.org/documentation/xenomai-3/html/xeno3prm/index=
.html
>> for rtdm references going forward.  You are running Xenomai 3, but
>> using the docs for 2.6.
>>
>> -Greg
>>
>> On Mon, Mar 12, 2018 at 11:41 AM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=
=D0=BA=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=
=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
>> <shevchenko.taras@triolcorp.com.ua> wrote:
>>> Xenomai 3
>>> It is work! Perfect!
>>> Now i have the same problem as below
>>> http://xenomai.org/pipermail/xenomai/2017-May/037361.html by Nitin Kulk=
arni    and x86
>>>
>>> interrupt registered cat /proc/xenomai/irq
>>>
>>>
>>>   IRQ         CPU0        CPU1        CPU2        CPU3
>>>   266:           0           0           0           0         rtdm_hel=
lo
>>>
>>> but the handler is not invoked when I trigger the gpio pin.
>>> I found http://xenomai.org/documentation/xenomai-2.6/html/api/group__rt=
dmirq.html#gaf4e76db13d7f7aac4be2cae59e0097bc
>>> only RTDM_IRQTYPE_EDGE  option
>>> is there another trigger or another way to do it ?
>>>
>>>
>>> ----- Original Message -----
>>> From: "Greg Gallagher" <greg@embeddedgreg.com>
>>> To: "=D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2=D0=B0=D1=
=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=D1=8C=D0=B5=D0=B2=D0=
=B8=D1=87" <shevchenko.taras@triolcorp.com.ua>
>>> Cc: "xenomai" <xenomai@xenomai.org>
>>> Sent: Monday, March 12, 2018 4:16:03 PM
>>> Subject: Re: [Xenomai] simple rtdm driver x86
>>>
>>> Are you using Xenomai 3 or 2?  I believe from your previous posts you
>>> are using Xenomai 3, include rtdm/driver.h , not rtdm_driver.h.
>>>
>>> -Greg
>>>
>>> On Mon, Mar 12, 2018 at 10:09 AM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=
=D0=BA=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=
=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
>>> <shevchenko.taras@triolcorp.com.ua> wrote:
>>>> Hi,
>>>> could somebody share simple rtdm driver for begginers
>>>> better fo x86
>>>> I try to find it but almost for arm
>>>> and i have no such rtdm_driver.h
>>>> give an advice please should I start from ?
>>>> _______________________________________________
>>>> Xenomai mailing list
>>>> Xenomai@xenomai.org
>>>> https://xenomai.org/mailman/listinfo/xenomai

