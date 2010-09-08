Message-ID: <4C87418D.1090601@domain.hid>
Date: Wed, 08 Sep 2010 09:55:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C8605E6.4000400@domain.hid> <4C862A3B.2050300@domain.hid>
	<4C8713A2.9010705@domain.hid>
In-Reply-To: <4C8713A2.9010705@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How do I force a core dump on a page fault event?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
>   Comments inline...
> 
> On 9/7/2010 5:04 AM, Gilles Chanteperdrix wrote:
>> Bob Feretich wrote:
>>>    I am seeing various Oops reports referencing my rt user task, but they
>>> don't provide any useful information regarding my program's state at the
>>> time of the Oops.
>>>
>>> The most common Oops is...
>>> Unable to handle kernel NULL pointer dereference at virtual address 0000000c
>>> ... snipped...
>> This tells us that a bug happens in kernel-space for some reason, while
>> trying to handle a user-space fault.
>>
>> Do you have a simple piece of code which I can run to reproduce this issue?
>>
> No. This problem started occurring when I integrated the whole system 
> together. I'm going to have to work on it a bit to reduce it to a 
> suitable code segment .
> The Xenomai content of the loop is:
> while (!end) {
>      ...
>      rc = rt_event_wait(&event1,..);
>      ...
>      rc = rt_event_clear(&event1,..);
>      ...
>      rc = rt_event_wait(&event2,..);
>      ...
>      rc = rt_event_clear(&event2,..);
>      ...
>      rc = rt_event_wait(&event3, TM_NONBLOC, ...);
>      if (rc==0) end = 1;
> }

Is this is a loop using all the CPU (all the events with TM_NONBLOCK) ?

-- 
					    Gilles.

