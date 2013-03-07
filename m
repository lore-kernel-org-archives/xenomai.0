MIME-Version: 1.0
In-Reply-To: <5138B8C4.3000708@xenomai.org>
References: <CAMJ=MEfo5EU2mnM4=JDNU4QXX00W=0aC2+m5LucPYiN39W5wcQ@mail.gmail.com>
	<512FB9B5.9040709@xenomai.org>
	<CAAXf6LXDSxU_eASbHOgQzw_2xSpZua2BaORAiJ59KoPitFNEcg@mail.gmail.com>
	<51306545.1010200@xenomai.org> <5130663F.7070209@xenomai.org>
	<51306710.5030201@xenomai.org> <5130673D.2090700@xenomai.org>
	<513069D5.1090508@xenomai.org>
	<CAMJ=MEdAfvwWhjc4SLPk5smh+vNbPDJP=kM3bBFdw6n3bJd_mg@mail.gmail.com>
	<5137496C.4090908@xenomai.org>
	<CAMJ=MEcMeQ2oj+g099xxOukwBvGaxyNwQ5dtYDCZfMOOgD8kng@mail.gmail.com>
	<5137659F.6060205@xenomai.org>
	<CAMJ=MEf-ENT3Wzo9iyHfib9zhiupoaF6Z+yZhqY-Taxj=8tq=A@mail.gmail.com>
	<51386CB1.6090701@xenomai.org> <5138B8C4.3000708@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Thu, 7 Mar 2013 20:51:14 +0100
Message-ID: <CAMJ=MEcWSfKM6eDkZDcLbd=K4xMXX=_3Wgu49rS8XE6U20oqgg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai-forge: thread using 100% cpu load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Mar 7, 2013 at 4:56 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 03/07/2013 11:32 AM, Philippe Gerum wrote:
>>
>> On 03/07/2013 11:02 AM, Ronny Meeus wrote:
>>>
>>>
>>> thanks for the patch.
>>> With this patch the test application is working fine, no cpuload is
>>> observed anymore.
>>> Our real application on the other hand aborts after some time with
>>> this reporting:
>>>
>>> ------------------------------------------------------------------------------
>>>
>>> [ ERROR BACKTRACE: thread root ]
>>>
>>>     #0  EAGAIN in t_create(), task.c:320
>>>     #1  EAGAIN in copperplate_create_thread(), internal.c:138
>>>
>>> ------------------------------------------------------------------------------
>>>
>>>
>>> I did not observe this when running with the xenomai before the patch.
>>> Do you have a clue about why I see this?
>>>
>>>
>>
>> There is likely a resource leakage hiding somewhere. I'll have a look.
>>
>
> After hours running the test case, I didn't see any sign of leakage, same
> after code inspection. Maybe this bug is visible now that your app can run
> more code. There are several potential causes for EAGAIN, however assuming
> this is not a rlimit issue, checking /proc/vmstat while your app runs may
> give some hint.
>
> --
> Philippe.

I try to debug this issue tomorrow.

Ronny

