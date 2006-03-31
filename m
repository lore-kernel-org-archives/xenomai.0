Message-ID: <442D02CD.6080508@domain.hid>
Date: Fri, 31 Mar 2006 12:22:05 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_task_delete() question
References: <442C19F2.206@domain.hid>
In-Reply-To: <442C19F2.206@domain.hid>
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
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai@xenomai.org

Sean McGranaghan wrote:
> Hello all,
> 
> I am posting this for a co-worker who is having problems with killing a 
> real-time task. (He is joining the email list shortly but for now I will 
> pass responses on to him.) Here is the scenario:
> 
> 1. A Linux process starts up and detaches from the tty (daemon)
> 2. The daemon creates a xeno message queue
> 2. The daemon spawns a xeno task
> 3. The xeno task on startup binds to the queue rt_queue_bind()
> 4. The xeno task waits on the queue recv with infinite timeout
> 5. The daemon process goes to sleep in a join, waiting for the task to exit
> 6. Some time later another program starts
> 7. The other non-realtime program looks up the xeno task name via 
> rt_task_bind()
> 8. The other non-realtime program attempts to delete the task via 
> rt_task_delete()
>         Failed Attempt #1 - Non-realtime program calls rt_task_delete() 
> and gets
>                             a segmentation fault
>         Failed Attempt #2 - Non-realtime program spawns a realtime task 
> which
>                             binds to original task and tries 
> rt_task_delete().
>                             Also gets segmentation fault.
> 

Eeek... 100% reproducible here. Blatant bug. More later. Thanks for 
reporting.

> The was attempted one a system running the latest Xenomai 2.1 release.
> 
> What is the preferred method to start/join threads from a non-realtime 
> context?
> 
> Any help is appreciated.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

