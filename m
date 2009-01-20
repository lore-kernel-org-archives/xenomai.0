Message-ID: <4975CF9E.905@domain.hid>
Date: Tue, 20 Jan 2009 13:20:30 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A01776718@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01776718@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to use Xenomai libraries with "normal" (non
 Xenomai) linux processes ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
> I have build a library which makes use of some Xenomai-Posix functions (mainly shared memory but also some semaphore functions). This library provides functions (logging) which should be used by Xenomai tasks and Linux processes.
> When I link this new library with a standard linux process, this process obviously becomes automatically a Xenomai task (task is listed in /proc/xenomai/sched) just by linking with my library (not even calling a xeno-function is necessary). 
> Unfortunatelly this seems also to have an influence on the scheduling policy and the priority of the linux process:
> 
> When I set the policy (to SCHED_FIFO) and the priority of this linux process (by an external startup process) with :
> 	p.sched_priority = somepriority;
> 	sched_setscheduler(pidoflinuxprocess, SCHED_FIFO, &p);

sched_setscheduler is not what you want, it changes the scheduling
parameters of the whole process whereas you want to change scheduling
parameters of only one thread.
So, use pthread_setschedparam instead.

-- 
                                                 Gilles.

