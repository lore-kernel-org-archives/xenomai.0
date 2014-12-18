Message-ID: <5492FB8E.2050800@siemens.com>
Date: Thu, 18 Dec 2014 17:06:38 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <549072DC.1030901@xenomai.org>
 <CAMJ=MEfzrJQGYKT41F2hSirn8q0MGt-kWuT2GYQE7YTbSCNG5A@mail.gmail.com>
 <549090FA.7000901@xenomai.org>
 <CAMJ=MEc9UXa4P18kNmPeKH-SziXMj9Grbxagj7Wm_MckHcOC7Q@mail.gmail.com>
 <5492989C.9070106@siemens.com>
 <CAMJ=MEeWPyBFBbjj7_JLENZQ+xBkxbaKGiZBehKCatVa-1owqA@mail.gmail.com>
 <20141218141248.GN2012@hermes.click-hack.org> <5492EBAC.10502@siemens.com>
 <20141218150435.GP2012@hermes.click-hack.org>
 <CAMJ=MEc2V0P4nLXVwmxn7LNuY92PrPg=TnPa6UJi=0oCRz=w0g@mail.gmail.com>
 <20141218153001.GT2012@hermes.click-hack.org> <5492F43E.6070701@siemens.com>
 <CAMJ=MEf1uFy1uLBK-r0CnL_sZONuxZ5dYUrMq4+cfJvqQEzSOQ@mail.gmail.com>
In-Reply-To: <CAMJ=MEf1uFy1uLBK-r0CnL_sZONuxZ5dYUrMq4+cfJvqQEzSOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [xenomai-forge] timer-internal consume a lot of cpu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 2014-12-18 16:49, Ronny Meeus wrote:
> On Thu, Dec 18, 2014 at 4:35 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On 2014-12-18 16:30, Gilles Chanteperdrix wrote:
>>> On Thu, Dec 18, 2014 at 04:25:40PM +0100, Ronny Meeus wrote:
>>>> On Thu, Dec 18, 2014 at 4:04 PM, Gilles Chanteperdrix
>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>> On Thu, Dec 18, 2014 at 03:58:52PM +0100, Jan Kiszka wrote:
>>>>>> On 2014-12-18 15:12, Gilles Chanteperdrix wrote:
>>>>>>> Otherwise, have you tried some alternate libc, such as musl:
>>>>>>> http://www.musl-libc.org/
>>>>>>>
>>>>>>> The following blog:
>>>>>>> http://ewontfix.com/
>>>>>>>
>>>>>>> Seems to show that the musl maintainers try and report glibc bugs
>>>>>>> and avoid them in their implementation.
>>>>>>>
>>>>>>> I have not tried xenomai with musl at all, so, maybe it does not
>>>>>>> even compile. But maybe just compiling a testcase for the condvar
>>>>>>> issue with that libc would help know if it has the same issue or
>>>>>>> not.
>>>>>>
>>>>>> Well, like with many of those "light-weight" re-implementations, the are
>>>>>> "small" issues with bits required for real-time:
>>>>>>
>>>>>> http://git.musl-libc.org/cgit/musl/tree/src/thread/pthread_mutexattr_setprotocol.c
>>>>>
>>>>> On the other hand, no implementation with a clear ENOTSUPP is better
>>>>> than a partial and buggy implementation that can not be trusted anyway.
>>>>>
>>>>> --
>>>>>                                             Gilles.
>>>>
>>>> Gilles I agree.
>>>>
>>>> In the meantime I tried it already.
>>>>
>>>> This is indeed the trace I get when running my test application with musl.
>>>> # ./cond_test_arm
>>>> # hread_mutexattr_setprotocol: Not supported
>>>>
>>>> Cobalt is not an option for us either since in that case all Linux
>>>> applications will run in low-priority. Next to that we also have a
>>>> huge priority inversion each time a Linux system call is done.
>>>>
>>>> Do we have other options to fix forge?
>>>
>>> Well, three options have been proposed if I followed this thread
>>> correctly:
>>> - stop using priority inheritance for these internal mutexes, at the
>>> risk of creating priority inversions
>>> - switch to priority ceiling (but what will be the ceiling? 99?)
>>
>> Likely - part of the reason why that is no general solution.
>>
>>> - use cobalt.
>>
>> - use a patched glibc
> 
> I tried to apply the patch on glibc 2.20 but it looks like the issue is still
> present.

You will need to extend to existing condvar users and tell glibc that
those vars will be used in combination with PI mutexes
(pthread_condattr_setprotocol_np).

> Even if it would be solved with the patch, we force all users
> of forge to work with a patched version of glibc and to go to 2.20.
> This might not always be easy.

Yes, that is unhandy.

> 
>> - fix upstream glibc - non-trivial, as history shows, but long overdue
> 
> Another option is to implement the priority boost in the copperplate lib.
> Before the signal is done, change the priority to an equal priority as
> the task signaling the conditional variable (in case the prio or the
> waiting task is lower).
> Once the thread is unblocked, restore the original priority (from the
> thread that receives the signal).

That implies you know the prios of the involved threads. Doesn't sound
like a generic solution either.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

