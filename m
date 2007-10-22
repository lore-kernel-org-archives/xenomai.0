Message-ID: <471C4B7B.2030103@domain.hid>
Date: Mon, 22 Oct 2007 09:04:27 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <4718C00B.9040607@domain.hid> <1192814057.6252.32.camel@domain.hid>
In-Reply-To: <1192814057.6252.32.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Replacement of taskDelay(0) call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai help <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Fri, 2007-10-19 at 16:32 +0200, Johan Borkhuis wrote:
>   
>> When using VxWorks we used "taskDelay(0)" to invoke the scheduler. 
>> Within Xenomai this call was translated into "rt_task_yield()". However,
>>     
>
> You mean xnpod_yield(), the VxWorks skin is directly based on the
> Xenomai abstract core, not on the native skin.
>   
I am not using the VxWorks skin: we were already using an OS-abstraction 
layer for our application, and the Xenomai version of this is based on 
the Native skin.

>>  
>> when using a number of tasks at the same priority using this mechanism 
>> the watchdog timeout kicks in and kills the Xenomai task(s).
>>     
>
> Well, that's the point of the watchdog. If you application does not
> reliquish enough CPU time to the regular Linux kernel activities, the
> system is wil have a problem sooner or later. taskDelay(0) will perform
> some kind of manual round-robin scheduling, therefore doing so among one
> or several real-time tasks for a long time could indeed prevent Linux to
> grab the CPU. In that case, the watchdog really notifies you from a
> problem with the dynamics of your application.
>
> IOW, what is allowed with a dedicated RTOS controlling the whole
> hardware may not be valid in the context of a GPOS and a RTOS sharing
> the same hardware, which is the case with Xenomai. You have to make sure
> Linux has some time left to perform the regular housekeeping duties
> (process non real-time device interrupts, Linux scheduler ticks and so
> on).
>   

Thank you for this extensive explanation. I am afraid that I am still 
thinking to much in terms of a one-OS system and not considering the 
problems that a dual-OS is causing. I will need to look at this problem 
more closely, and see in which way I can change the behavior.

Kind regards,
    Johan Borkhuis

