Message-ID: <4648CA4E.70904@domain.hid>
Date: Mon, 14 May 2007 13:45:02 -0700
From: Jeff Koftinoff <jeffk@domain.hid>
MIME-Version: 1.0
References: <4648C077.2050003@domain.hid> <4648C26F.1020002@domain.hid>
In-Reply-To: <4648C26F.1020002@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_set_periodic and different time base
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

Jan Kiszka wrote:
>
> There exists some vague ideas to provide an infrastructure with Xenomai
> that allows to smoothly synchronise its local clock on whatever external
> (jittery) source, but note that "vague" above.
>
> Moreover, I don't think you actually want this for your scenario. You
> may rather look for a hard sync on each audio tick, no?
>
>   
correct, a hard sync on each audio tick is what I want. 166 +- 20 
Microseconds.

>> My original thought was to use rt_intr_wait() in my user mode program 
>> and do the scheduling of sub-tasks myself.
>>     
>
> Sounds what you need (or directly derive an RTDM device with appropriate
> interface for your audio-hw :)).
>
>   
90% of my CPU time needs to be spent processing audio and the control 
for this audio, at the highest priority above linux, and running in C++ 
in userspace (really!)... There is no 'audio driver' involved, really, 
as the whole point of the hardware is to process live audio in real time 
from audio in to audio out with very low latency in usermode.
>> But it would be ideal if rt_task_set_periodic() could just use the 
>> appropriate time source itself.
>>     
>
> Why?
>
>   
Because I have many layers of audio processing procedures that need to 
be scheduled at different periodic intervals, with different priorities. 
lower level audio processing procedures run every 166 microseconds and 
have highest priority, and interrupt higher level lower rate (5.3 
ms,10.66 ms and 32 ms) control processing procedures. 

I have non-xenomai usermode code right now that can use a recursive 
signal handler to manually schedule these 'layers' of processing tasks.  
But then I'm just duplicating the rt_task_set_periodic() capability that 
is already there in xenomai.

I just want the Xenomai task scheduler to be controlled directly by the 
audio tick interrupt.... Is that a problem to enable?

Regards,
Jeff koftinoff.

www.jdkoftinoff.com





