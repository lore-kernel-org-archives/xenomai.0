MIME-Version: 1.0
In-Reply-To: <CALLqZ8SGRfcu3J=-75LkGQJR89PxS4=7zLCiojjVBzX+p=iADw@mail.gmail.com>
References: <CAOuPNLiNGpnvWcj_6xZV0FWZfqMgi3Xc61GaHfZP1N58TYFYcQ@mail.gmail.com>
 <CALLqZ8SGRfcu3J=-75LkGQJR89PxS4=7zLCiojjVBzX+p=iADw@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Thu, 8 Mar 2018 18:44:16 +0530
Message-ID: <CAOuPNLgUANCFjBjQGicdfZhEDw4EtMe2JyAh=Cskrzr0+tviwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] [NATIVE API] Xenomai native API equivalent for
	clock_gettime
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jan Kiszka <jan.kiszka@web.de>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Mar 1, 2018 at 10:32 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
> Are you using Xenomai 2.6 or 3?  If you are using 3 use this guide instead:
>

I am using xenomai-3.0.6

> https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__timer.html
>
> Post back if nothing there can help, but you may want to loot at the
> source for some of the utilities that calculate latency as a example
> to work from
>

OK thank you so much.
I replaced clock_nanosleep() with : rt_task_sleep() and
clock_gettime() with: rt_timer_read().
I think it works fine.
I also replaced: printf() with: rt_printf()

I guess these are the right replaced for xenomai.

But one doubt I still have:
I observed that I instead of using rt_task_sleep() , I can also use
the combination of: rt_task_set_periodic() and rt_task_wait_period().
Both are working as expected.
But I am confused which one is the right one to use? Will there be any
difference in measuring latency ?


> -Greg
>
> On Thu, Mar 1, 2018 at 7:37 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>> Hi,
>>
>> I have one question about Xenomai native API
>>
>> 1) What is the native API equivalent for clock_gettime() ?
>>
>> I have seen this Xenomai native API guide but I could not find it.
>> https://xenomai.org/documentation/xenomai-2.6/pdf/native-api.pdf
>>
>> I have a simple pthread based POSIX application which I converted to native API.
>> But for calculating the latency difference I using this in both case:
>> clock_gettime(CLOCK_MONOTONIC, &now);
>>
>> But I observed that if I use only NATIVE skin, I could not see any
>> latency difference.
>> However, if I use POSIX skin I see the latency difference.
>>
>> So, I want to replace clock_gettime() with native API to find the
>> exact difference with native skin.
>>
>> Or, if there is any other better way to measurement latency difference
>> between POSIX API and native API, please let me know.
>>
>>
>>
>> Thank You!
>>
>> Regards,
>> Pintu

