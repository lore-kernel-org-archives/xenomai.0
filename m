Message-ID: <51A75049.2020504@free.fr>
Date: Thu, 30 May 2013 15:12:41 +0200
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
MIME-Version: 1.0
References: <51A6F9AD.3000207@free.fr> <51A73A1A.8000404@xenomai.org>
In-Reply-To: <51A73A1A.8000404@xenomai.org>
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

On 30/05/2013 13:38, Gilles Chanteperdrix wrote:
> On 05/30/2013 09:03 AM, St=C3=A9phane ANCELOT wrote:
>
>> Hi,
>>
>> I have got some problems with an architecture, and 2 realtime tasks.
>>
>> The realtime is not always respected.
>
> Hi,
>
> a few things to check:
>
> Would there be any involuntary mode switches? See rt_task_set_mode or
> pthread_set_mode_np documentation to enable debug.
There is not any involuntary mode switches in the xenomai application.

The buggy architecture is celeron M:

Intel=C2=AE 910GMLE / ICH6M chipsets

the same disk application, if setted up in the following architecture,=20
has no problem:
Intel=C2=AE 852GM and ICH4 chipset

Are you able to reproduce the problem with the latency test? You can=20
launch several instances in parallel, if you absolutely need several=20
task. If yes, then probably the easiest solution is to enable the I-pipe=20
tracer, then run the latency test with the -f argument.

I have read more documentation in kernel tracing, and it seems I won't=20
need lttng, but it looks like only kernel tracing would be enough ?

I have not managed to reproduce it with a single instance of latency=20
test. (and I have no problem using a single rt task...) . I will try 2=20
instances.

One more thing that is surprising : I monitored the tasks delay using=20
clock_gettime() , the software does not watch any big lag !!! ...but it=20
is visible in the scopemeter using com port signals (up to 300us=20
possible !!!!) ....

I also was thinking about a problem with the high res. timers, I tried=20
the HPET timers, but this has not helped.

>> This is a very strange problem in this architecture, since it happens
>> statically almost every three reboots...
>>
>> It looks like there is something in the kernel / or setted up by bios
>> that is happening and locks the task switching context.
>
> Ok, so if it has a bios, it is an x86. Which version of the I-pipe patc=
h
> and Xenomai are you using? Can not it be an SMI issue, have you tried
> the SMI workaround?


yes, I have tried disabling SMI, but in anyway it fails as follow:

Xenomai: SMI-enabled chipset found
Xenomai: SMI workaround failed!



I have the same problem using either

kernel 2.6.34 and xenomai 2.5.6

or

kernel 3.5.7 and xenomai 2.6.2.1

Further informations on Monday.

Regards,
Steph



