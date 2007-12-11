Message-ID: <475E8986.1010901@domain.hid>
Date: Tue, 11 Dec 2007 13:58:46 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
References: <475E76A0.4010007@domain.hid> <475E7CBA.7060300@domain.hid>
	<475E7F84.1040600@domain.hid>
In-Reply-To: <475E7F84.1040600@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Application broken 2.3.4 ---> 2.4.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org


>> Anyway, something is truly screwed up when 
>> rt_task_set_periodic(&_blink_thread, rt_timer_read(), mili2count(250)) 
>> fails to make the task periodic...
>>     
>
> That's due to the reworked timer subsystem: Starting timers (like the
> periodic task timer) in the past is reported as error - up to the
> application in this case. One may discuss if this case can be considered
> as an undocumented API change (I haven't re-read the docs in this regard
> yet).
>   
At least the rt_task_set_periodic documenations says nothing about it.

I don't know about the timer subsystem, but from the native API point of 
view, the behaviour that makes most sense is the old, that is, if I set 
a task periodic with a start time in the past, it should be scheduled 
immediately.

I hope there is a very good reason for this behaviour change, because I 
bet it is going to cause a lot of headaches to a lot of people.

For example, in a code like this:

rt_task_set_periodic(&mytask, some_time_in_the_near_future, mili2count(100))

There is always a chance that "some_time_in_the_future" is in the past 
by the time the call to rt_task_set_periodic is called (due to this task 
being delayed by some higher priority task).

WHAT am I supposed to do, check the result of each an every 
rt_task_set_periodic call???

It is clearly a case of "*better later than never*". I'd rather have the 
periodic task start scheduled a bit late than not scheduled at all.





