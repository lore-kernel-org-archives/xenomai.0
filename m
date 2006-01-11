Message-ID: <43C50F88.1040501@domain.hid>
Date: Wed, 11 Jan 2006 15:00:40 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Using Xenomai in C++ App.
References: <43B8ED00.9070908@domain.hid>
	<200601111409.41282.s.zimmermann@domain.hid>
In-Reply-To: <200601111409.41282.s.zimmermann@domain.hid>
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

Stephan Zimmermann wrote:
> Hello List, 
> actually I am playing around with Xenomai 2.0.1 functions in a C++ 
> Application. I Wrote some simple wrapper-classes to use mutexes, semaphores 
> and tasks. Now, after thinking a while about message queues, I am confused 
> somehow. Is it possible to use the standard 'new' Operator in a mutithreaded 
> realtime application,

It's possible but could make some of your application threads migrate to secondary 
(i.e. relaxed execution) mode while running, due to the presence of Linux syscalls 
in the malloc code that underlies the standard C++ allocator, unless you did 
overload the new & delete operators appropriately. IOW, you would lose determinism 
wrt execution latency. Typical issues would concern brk() for extending the data 
segment of the current process to get more core, or controlled access to a 
contended critical section by means of glibc mutexes, that malloc() may start 
behind your back.

  or do I need to allocate memory inside a Xenomai heap
> (and overload operator new to do so)?

That would be a correct solution for keeping the allocation/deallocation ops 
within the bounds of very strict timing constraints, I think.

Hint: check out the T_WARNSW of rt_task_set_mode() for debugging unexpected 
transitions to secondary mode.

> 
> I would be thankful for some hints,
> Greetings, Stephan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

