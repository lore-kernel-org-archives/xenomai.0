Message-ID: <51386CB1.6090701@xenomai.org>
Date: Thu, 07 Mar 2013 11:32:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
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
In-Reply-To: <CAMJ=MEf-ENT3Wzo9iyHfib9zhiupoaF6Z+yZhqY-Taxj=8tq=A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-forge: thread using 100% cpu load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 03/07/2013 11:02 AM, Ronny Meeus wrote:
> On Wed, Mar 6, 2013 at 4:49 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 03/06/2013 03:32 PM, Ronny Meeus wrote:
>>>
>>> si_code=SI_TIMER, si_pid=51, si_uid=0, si_value={int=273724880,
>>> ptr=0x1050b5d0}}, NULL, 16) = 32
>>> 11309     15.442127 +++ killed by SIGKILL +++
>>>
>>> I'm not an expert in this, but to me it looks like the create_timer
>>> call, executed in the context of the 11308 thread, gets interrupted
>>> because a signal is received by thread 11309. This signal is generated
>>> because of a timer expiry which creates a new thread and processes the
>>> callback function.
>>>
>>> Is it not possible to disable all signals of the process during the
>>> creation of the timer in xenomai. In this way we can avoid the race
>>> condition in the library. This might be not a clean solution but would
>>> it work as a temporary one until you finish the timer handling you
>>> talk about in one of your earlier mails.
>>
>>
>> Fiddling with signal masks to work around an underlying bug would be asking
>> for more trouble. Time is a scarce enough resource.
>>
>>
>> BTW can I have some
>>>
>>> information about what you are planning to change?
>>>
>>
>> This one:
>> http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=cf30fb5e22a1a3d66412f1024be1ba86260904cc
>>
>> This implementation passes the psos testsuite in -forge, and runs your
>> testcase fine. Please pull this change and let me know if the situation
>> improves.
>>
>> --
>> Philippe.
>
> Philippe
>
> thanks for the patch.
> With this patch the test application is working fine, no cpuload is
> observed anymore.
> Our real application on the other hand aborts after some time with
> this reporting:
> ------------------------------------------------------------------------------
> [ ERROR BACKTRACE: thread root ]
>
>     #0  EAGAIN in t_create(), task.c:320
>     #1  EAGAIN in copperplate_create_thread(), internal.c:138
> ------------------------------------------------------------------------------
>
> I did not observe this when running with the xenomai before the patch.
> Do you have a clue about why I see this?
>
>

There is likely a resource leakage hiding somewhere. I'll have a look.

-- 
Philippe.

