Message-ID: <423AEE12.7080801@domain.hid>
Date: Fri, 18 Mar 2005 16:04:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] ppc64 port questions
References: <0D21CBD1298D2C4790E2F2B86D96EC1938028C@amr-ex5.ds.amrdec.army.mil>
In-Reply-To: <0D21CBD1298D2C4790E2F2B86D96EC1938028C@amr-ex5.ds.amrdec.army.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: "Reynolds, Terry (Contractor-SIMTECH)" <terry.reynolds2@domain.hid>
Cc: adeos <adeos-main@gna.org>

Reynolds, Terry (Contractor-SIMTECH) wrote:
> Hi All,
>  
> I apologize for the long posting, but wanted to give sufficient detail for folks to see what's going on.
>  
> I have made a good bit of progress on the ppc64 port.  I'm trying to get the RTAI example test latency to work.  
> Things fail in a way that looks like I've missed a function somewhere.   I've added quite a few printk statements
> in trying to track down the problem.
>  
> What I'm seeing is:
>  
> Root domain registered.
> Pipeline started.
>  
> Start latency test:
>  
> RTAI[hal] domain registered:
>    switch from root to RTAI[hal].
>    calls suspend.
>    switches back to root.
>  
> Domain IShield registered.
>    root switches to IShield
>   IShield suspends & switches back to root.
>  
> RTAI[nucleus] RTAI/fusion v0.6.9 started
>   all initialization routines seem to run OK.
>  __fusion_skin_init processes all the way through and exits without error.
>  
> THEN
>  
> In Root:
>    sched.c's need_resched: calls -
>    adeos_schedule_tail, which calls __adeos_handle_event with  ADEOS_SCHEDULE_TAIL
>  
>    __adeos_handle_event does a switch_to RTAI[hal] domain.
>    it resumes in suspend_domain, from which it returns to rthal_domain_entry.
>    At that point it is in a loop constantly calling suspend_domain.
>    So, RTAI[hal] instantly suspends again, switching back to root. 
>    Root ends up back in need_resced, and this process repeats several hundred times,
>    until the latency test gives up and exits with a "failed to create display task, code -38"
>  
> IShield is unregistered.
> RTAI/fusion stops.
> RTAI is unregistered.
> RTAI[hal] is unloaded.
>  
> At least things seem to exit gracefully!
>  
> So, my questions are:
>  
>   Did any of that description look totally wrong?  
>

The behaviour described above looks sane.

>    What is suppose to cause RTAI[hal] to break out of the suspend_domain loop,
>   and process the event being passed in from root via the schedule_tail?  
>   Should it be suspended at a different place?
>  

adeos_suspend_domain() looks for events to process (traps & IRQs) before 
returning to the caller. So the proper callbacks for the current work 
cycle have already been fired when adeos_suspend_domain() returns back 
to the calling statement in the RTHAL entry point. This is why an Adeos 
work cycle usually looks like an endless loop calling 
adeos_suspend_domain().

> I'm not sure if this is an Adeos or an RTAI problem at this point.
>  

Everything looks ok so far.

>  
> TIA!
>  
> Terry.
>  
>  
>  
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 

Philippe.

