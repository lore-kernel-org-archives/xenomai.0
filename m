Message-ID: <4486D2BD.7040101@domain.hid>
Date: Wed, 07 Jun 2006 15:21:01 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Ipipe hook at system call exit
References: <88AEA5AC18A141439A0D954EB037B0D30439F327@domain.hid>
In-Reply-To: <88AEA5AC18A141439A0D954EB037B0D30439F327@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Krause, Karl-Heinz" <karl-heinz.krause@domain.hid>
Cc: xenomai@xenomai.org


Hello,

Krause, Karl-Heinz wrote:
> Hallo Philippe
> 
>  
> 
> Jan Kiszka referred me to you discussing our problem with a missing 
> Ipipe hook at system call exit.
> 
> We at Siemens A&D do have a Linux realtime approach which is based on a 
> previous ADEOS version. When trying to port an improved version to the 
> Ipipe version for kernel 2.6.15.4 we ran into the problem of not having 
> an event hook at system call exit. Let me explain the need for it by 
> briefly outlining our approach.
> 
> It is a two kernel approach based on the model of a multihreaded process 
> (means 2.6 kernel) where the threads above  a certain static priority 
> level e.g. 68 are scheduled by the  scheduler of the realtime kernel. 
> The realtime kernel maintains exactly the same systemcall interface as 
> the Linux kernel. The entire process works uniformely with the glibc. 
> The glibc isn't aware under which scheduler the current thread is 
> executing. To make this happen and having both schedulers  to work with 
> the same struct task struct  we had to put some restrictions on the 
> signalling for the realtime domain (restrictions which make sense for 
> the realtime arena anyway). Because of that transparency this approach 
> combines somehow the advantages of a separated realtime kernel with the 
> user convenience of  PREEMPT_RT. (the user convenience was the driving 
> requirement for our approach)
> 

There seems to be quite a lot of commonality with the way Xenomai deals 
with shadow threads to enable realtime processing in user-space, while 
providing a seamless integration with Linux. One difference might be the 
way your system deals with Linux syscalls fired on behalf of a thread 
controlled by the real-time scheduler; Xenomai migrates the thread to 
the Linux scheduler transparently, but I did not figure out yet if this 
was a relevant issue in your system. Anyway, I think that I now roughly 
understand the general dynamics of it, thanks for the explanations.

>  
> 
> Now to the question why we need a hook at systemcall exit.
> 
> The hook at systemcall entry branches to the system call handling of the 
> realtime kernel, which is also entered via a systemcall table. The 
> handling can be grouped in three classes
> 
> -         complete handling in the realtime domain e.g. timer_settime(), 
> sigwait()
> 
> -         only migration of the thread to the Linux scheduler. Basically 
> all calls needed for setup e.g. open(), mmap(), pthread_create().  The 
> migration is transparent for the ipipe code, the thread continues 
> execution in the Linux domain with the call of the Linux system call 
> table (the priority hasn't changed).
> 
> -         handling in the realtime domain and migration to the Linux 
> domain if the thread priority has dropped unter the boundary (e.g 
> releasing a mutex with priority ceiling)
> 
>  
> 
> In particular for the second case a check needs to be done at sytem call 
> exit as to whether the thread has to migrate (back) to the realtime 
> scheduler. But this is also needed when a call issued in the Linux 
> raises the priority above the threshold. A third reason for the hook is 
> to touch the corresponding pages after a brk() or mmap() call for 
> getting residency.
> 
>  Note:
> 
> The migration only takes place for threads of a process marked as realtime.
> 
> Currently we allow only for one realtime process. First it is sufficient 
> for us and second it allows us to maintain the futex queue (each domain 
> maintains a local queue) of the realtime domain with virtual addresses 
> (no mm_lock).  
>

Does this mean that you specifically intercept futex ops to process them 
in real-time mode when fired over the real-time context? Which would in 
turn allow you to traverse most of the glibc code and get it 
synchronized with the plain Linux threads?

>  
> 
> So this hook at system call exit is a necessity for us. Of course we 
> could do a private patch, but do you see a possibility to have it in the 
> standard Ipipe-patch?
>

Basically, I removed the sysexit hook from the I-pipe patch because it 
added a non-negligible overhead to each syscall. Even the sysenter hook 
needs some work to reduce its CPU footprint and I've planned to tackle 
the issue soon. For this reason, the current Xeno implementation only 
relies on the sysenter (IPIPE_EVENT_SYSCALL) hook to deal with 
migrations between the Linux and Xenomai schedulers, usually enforcing a 
lazy migration scheme, i.e. the syscall prologue added by the RT 
extension switches the caller to the proper domain before running the 
system call handler, but does not eagerly switch back to the originating 
domain (well, there are exceptions to this, but that's the usual way 
things are handled).

Reading your description, a few questions came to my mind:

- why do you force a switch back to the originating domain? IOW, are 
eager transitions absolutely required in your design, since your RT 
thread is underlaid by a regular Linux task anyway, so it could continue 
its processing and switch back to the RT side only when needed?

- would not it be possible to intercept the IPIPE_EVENT_SETSCHED 
notifications, which are fired by the I-pipe when a Linux task is about 
to have its priority changed? It's a direct hook from the kernel's 
sched_setscheduler(), which is given the task_struct pointer of the 
altered task, right after its priority field has been updated, but still 
before the Linux runqueue is reordered.

- would mlocking the data segment of your application be enough/possible 
to ensure that brk() and mmapped() segments get committed to physical 
memory automatically, and as such spare you the need for touching those 
areas explicitely? AFAIK, mlocked pages are going to be fixed up this 
way by the mm layer during the mlocking call.

- generally speaking, since you control the prologue and epilogue of all 
system calls (Linux or real-time) which go through your own syscall 
demux by mean of the IPIPE_EVENT_SYSCALL hook, it should be possible to 
handle the whole migration issue (be it eager or lazy in this case) from 
your code, instead of relying on a hook inserted in Linux's syscall 
return path. Or am I missing something?

>  
> 
>  
> 
> Karl-Heinz Krause
> 
> Siemens A&D
> 
> Nbg.-Moorenbrunn
> 
>  
> 
>  
> 
>  
> 
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.


