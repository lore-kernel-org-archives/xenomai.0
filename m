Message-ID: <51AC9B33.4070504@free.fr>
Date: Mon, 03 Jun 2013 15:33:39 +0200
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
MIME-Version: 1.0
References: <51A6F9AD.3000207@free.fr> <51A73A1A.8000404@xenomai.org>
	<51A75049.2020504@free.fr> <51A79835.1090609@xenomai.org>
In-Reply-To: <51A79835.1090609@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Context switching kernel tracing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi,


The SMI is the source of my problems. the global SMI bit in the ICH6 can=20
not be disabled .

However, I used a 32 bits mask trying to disable any bits and managed to=20
reduce the latency (worst : 15us )


refer to paragraph 10.8.3.12 for ICH6 chipset :
http://www.intel.com/content/www/us/en/io/io-controller-hub-6-datasheet.h=
tml



Regards,
Steph

On 30/05/2013 20:19, Gilles Chanteperdrix wrote:
> On 05/30/2013 03:12 PM, St=C3=A9phane ANCELOT wrote:
>
>> On 30/05/2013 13:38, Gilles Chanteperdrix wrote:
>>> On 05/30/2013 09:03 AM, St=C3=A9phane ANCELOT wrote:
>>>
>>>> Hi,
>>>>
>>>> I have got some problems with an architecture, and 2 realtime tasks.
>>>>
>>>> The realtime is not always respected.
>>> Hi,
>>>
>>> a few things to check:
>>>
>>> Would there be any involuntary mode switches? See rt_task_set_mode or
>>> pthread_set_mode_np documentation to enable debug.
>> There is not any involuntary mode switches in the xenomai application.
>>
>> The buggy architecture is celeron M:
>>
>> Intel=C2=AE 910GMLE / ICH6M chipsets
>>
>> the same disk application, if setted up in the following architecture,
>> has no problem:
>> Intel=C2=AE 852GM and ICH4 chipset
>>
>> Are you able to reproduce the problem with the latency test? You can
>> launch several instances in parallel, if you absolutely need several
>> task. If yes, then probably the easiest solution is to enable the I-pi=
pe
>> tracer, then run the latency test with the -f argument.
>>
>> I have read more documentation in kernel tracing, and it seems I won't
>> need lttng, but it looks like only kernel tracing would be enough ?
>>
>> I have not managed to reproduce it with a single instance of latency
>> test. (and I have no problem using a single rt task...) . I will try 2
>> instances.
>>
>> One more thing that is surprising : I monitored the tasks delay using
>> clock_gettime() , the software does not watch any big lag !!! ...but i=
t
>> is visible in the scopemeter using com port signals (up to 300us
>> possible !!!!) ....
>
> I would say it means that the tsc (and APIC) stop during some idle
> states of the system. I suppose you have CONFIG_CPU_IDLE turned off?
>
> Could you try booting with nohlt or idle=3Dpoll ?
>
>> I also was thinking about a problem with the high res. timers, I tried
>> the HPET timers, but this has not helped.
>
> I do not believe Xenomai is able to use the HPET timers with Linux 2.6.=
34.
>
>>>> This is a very strange problem in this architecture, since it happen=
s
>>>> statically almost every three reboots...
>>>>
>>>> It looks like there is something in the kernel / or setted up by bio=
s
>>>> that is happening and locks the task switching context.
>>> Ok, so if it has a bios, it is an x86. Which version of the I-pipe pa=
tch
>>> and Xenomai are you using? Can not it be an SMI issue, have you tried
>>> the SMI workaround?
>>
>> yes, I have tried disabling SMI, but in anyway it fails as follow:
>>
>> Xenomai: SMI-enabled chipset found
>> Xenomai: SMI workaround failed!
>
> Ok then, your BIOS vendor does not want you to disable the SMI global
> bit, have you tried other bits?
>


