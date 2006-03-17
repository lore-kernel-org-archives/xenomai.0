Message-ID: <441ADC6B.5010909@domain.hid>
Date: Fri, 17 Mar 2006 16:57:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: FW: [Xenomai-help] Xenomai thread runtime statistics
References: <067C9A1F6AFEB643895EA4513E116884178FC4@domain.hid>
In-Reply-To: <067C9A1F6AFEB643895EA4513E116884178FC4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Moser, Dan" <DMoser@domain.hid>
Cc: xenomai@xenomai.org

Moser, Dan wrote:
> Hi,
> 
> I am still searching for ways (hopefully via some API(s)) to get Xenomai
> run-time thread execution info (my original post is below).
> 
> Being a newbie, I apologize if the answer "should be obvious".  I am
> still getting up to speed with both Linux and Xenomai.
> 
> Is there a better list on which I should post this question?
>

This question is perfectly relevant to this list, the thing is that there's no 
simple, built-in way of getting execution stats for real-time threads yet. The 
best way to find out the execution time of your work cycle would be to measure it 
using the high precision clock information.

With the Xenomai-enabled POSIX API, you can use clock_gettime(CLOCK_MONOTONIC) to 
get a precise timestamp derived from the onboard TSC. With the native API, 
rt_timer_tsc() returns the same information.

e.g.

    for (;;) {
    struct timespec ts_start, ts_end;
    clock_gettime(CLOCK_MONOTONIC,&ts_start);
	<work>
    clock_gettime(CLOCK_MONOTONIC,&ts_end);
    /* work cycle consumption: ts_end - ts_start */
    }

> Hope to hear from someone.
> 
> 
> Thanks,
> Dan
> 
> 
> 
> 
>>-----Original Message-----
>>From: xenomai-help-bounces@domain.hid 
>>[mailto:xenomai-help-bounces@domain.hid] On Behalf Of Moser, Dan
>>Sent: Wednesday, March 15, 2006 4:06 PM
>>To: xenomai@xenomai.org
>>Subject: [Xenomai-help] Xenomai thread runtime statistics
>>
>>Hi,
>>
>>I am seeking whatever information is available regarding 
>>Xenomai task runtime statistics.  Things such as thread 
>>real-time usage, CPU usage, etc. and how to access that 
>>information from within an application.
>>
>>In particular, I would like to find out things such as how long (in
>>real-time) each iteration of a given periodic task takes to 
>>run.  I ultimately want to use this info to figure out how 
>>much "head room" I have left in a given rate group of a 
>>multi-rate/multi-tasking control system.
>>
>>Thanks in advance,
>>Dan
>>
>>_______________________________________________
>>Xenomai-help mailing list
>>Xenomai-help@domain.hid
>>https://mail.gna.org/listinfo/xenomai-help
>>
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

