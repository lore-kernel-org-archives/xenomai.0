Message-ID: <4DA70CAE.4040901@domain.hid>
Date: Thu, 14 Apr 2011 17:03:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=fp61zxZyg=gGt4moNNw_hLa8_og@domain.hid>	<4DA6E5FB.1050204@domain.hid>
	<BANLkTikdg1X_Ua0WR2k-KpCJO6iePSxVCA@mail.gmail.com>
In-Reply-To: <BANLkTikdg1X_Ua0WR2k-KpCJO6iePSxVCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] avoiding page faults
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

Jeff Weber wrote:
> On Thu, Apr 14, 2011 at 7:18 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> Jeff Weber wrote:
>>> I wish to avoid unwanted transitions of POSIX pthreads to secondary mode
>> due
>>> to page faults.
>>>
>>> Does calling
>>> mlockall(MCL_CURRENT | MCL_FUTURE)
>>>
>>> lock pages when the memory is allocated, or referenced?
>>>
>>> From reviewing Xenomai, Linux RT_PREEMPT, and RTAI code, it appears the
>>> answer is that memory is locked when the page is "referenced" (not
>>> allocated), and that referencing by write is preferred over referencing
>> by
>>> read.  xeno_fault_stack() appears to pre-fault a subset of the stack when
>>> turning the calling thread into a Xenomai thread.
>>>
>>> If true, then I should allocate my own stack for each pthread created in
>> my
>>> program, and write every page ahead of time, then
>>> call pthread_attr_setstack() prior to thread creation.  I should also
>> write
>>> every page of every dynamically allocated memory object.
>>>
>>> Please help me verify if this understanding is correct.
>> mlockall(MCL_CURRENT) locks all the memory currently mapped.
>> mlockall(MCL_FUTURE) will lock all the memory when it is allocated/mapped.
>>
>> Here's an strace of my pthread library starting up a thread, which will
> become a Xenomai posix thread:
> ...
> 25210 mlockall(MCL_CURRENT|MCL_FUTURE)  = 0
> 25210 open("/dev/null", O_RDWR)         = 3
> 25210 open("/dev/null", O_RDWR)         = 4
> 25210 sched_get_priority_max(SCHED_FIFO) = 99
> 25210 sched_get_priority_min(SCHED_FIFO) = 1
> 25210 sched_get_priority_max(SCHED_FIFO) = 99
> 25210 mmap2(NULL, 8392704, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_S
> TACK, -1, 0) = 0xb6dd7000
> 25210 mprotect(0xb6dd7000, 4096, PROT_NONE) = 0
> 25210 clone(child_stack=0xb75d7474,
> flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SI
> GHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CL
> EARTID, parent_tidptr=0xb75d7bd8, {entry_number:6, base_addr:0xb75d7b70,
> limit:1
> 048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
> seg_not_pre
> sent:0, useable:1}, child_tidptr=0xb75d7bd8) = 25212
> ...
> 
> The child thread stack is allocated/mapped by the mmap2() call above, in the
> parent thread.  Since mlock(MCL_FUTURE) was called prior, the child stack
> should be completely locked into parent memory.  However, it is not clear if
> the stack memory locks are lost in the new child thread across the
> clone().  The mlock() man page says these are definitely lost across a
> fork().  The clone() CLONE_VM flag indicates the the parent and child thread
> share the same memory mappings. I'm not a Linux virtual memory wizard.  Does
> this also imply parent memory locks are inherited by a cloned child?

Yes, it does. As I said, from what I have seen in the systems where I
run Xenomai until now. The only stack which is an issue is the main
thread stack.

-- 
					    Gilles.

