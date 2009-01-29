In-Reply-To: <49805FCC.4020403@domain.hid>
From: stefano.franzoni@domain.hid
Date: Thu, 29 Jan 2009 16:22:04 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Message-Id: <20090129152206.A82B71C066@domain.hid>
Subject: Re: [Xenomai-help] interrupt service routine issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks Gilles,

with your suggestion, setting the special mode bit T_WARNSW for the
incriminated task, we found two critical functions that caused switches to
secondary mode.

I report them for documentation:

1. We used mmap function used to map a file into memory. The access to the
memory caused sometimes the switch to secondary mode.
2. A pthread_cond_signal call used to unlock a waiting task always
generates the switch to secondary mode.

We have implemented the two functions in a lower priority thread and the
issue was solved.
Thanks to your magic silver bullet!!

To stress my application I have found a DoHell script by Ingo Molnar
(http://marc.info/?l=linux-kernel&m=111947618802722&w=2) but it is
uncompleted. Can you send your DoHell script?

Thanks in advance

Stefano




                                                                           
             Gilles                                                        
             Chanteperdrix                                                 
             <gilles.chanteper                                          To 
             drix@domain.hid>         stefano.franzoni@domain.hid        
                                                                        cc 
             28/01/2009 14:38          "xenomai@xenomai.org"              
                                       <xenomai@xenomai.org>              
                                                                   Subject 
                                       Re: [Xenomai-help] interrupt        
                                       service routine issue               
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




stefano.franzoni@domain.hid wrote:
> Dear experts
>
> we are working on a systems with Ubuntu Linux 2.6.25.11 and Xenomai
2.4.4.
> The system has an Intel(R) Pentium(R) M processor 1.73GHz.
> The Xenomai installation seems to be ok and also native application tests
> give right results.

Are you sure about this ? To benchmark your system, you should let the
latency test run for some time (say 24 hours), with a sustained load. I
tend to like the "dohell" script to generate this load. What we could
suspect here is SMI issues.

>
> We developed a RT application based on an ISA IRQ.
>
> The application has two RT tasks created with rt_task_create.
> One task has maximum (99) priority waits and manages the IRQ waiting for
it
> with an rt_intr_wait.
> The other task has a lower priority and manages the communication with an
> external system using TCP/IP sockets.
>
> The IRQ arrive every 1.6 msec and the interrupt service routine takes
about
> 250 usec.
> The issue is that sporadically happens that the interrupt service routine
> takes about 1.7 msec.

>From what I understand, your "interrupt service routine", is in fact a
Xenomai task which you expect to run in primary mode. Did you check
whether it is always running in primary mode? You can ask Xenomai to
send a signal to your thread if ever it switches to secondary mode,
setting a special mode bit with rt_task_set_mode/pthread_set_mode_np,
see online documentation.

Note that you should let your application run with this mode set, to see
if it is indeed what causes the overrun. There are services (malloc
comes to my mind) which will only cause a mode switch from time to time.

There are also unfortunately ways to have a primary mode thread wait for
Linux without causing a mode switch. The typical example is a mutex
shared between the two RT tasks, that the low priority task would take
before calling a plain Linux services. The high priority task locking
this mutex would in fact wait for Linux.

So, this mode bit is no silver bullet, your best option is careful code
inspection.

--
                                                 Gilles.



