References: <55BA4C76.7010907@xenomai.org>
 <694496883.6540925.1438365243369.JavaMail.yahoo@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55BC7C7D.3010408@xenomai.org>
Date: Sat, 1 Aug 2015 09:59:57 +0200
MIME-Version: 1.0
In-Reply-To: <694496883.6540925.1438365243369.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-3.0-rc5 : binding named semaphores from
 external process
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/31/2015 07:54 PM, Frederik Bayart wrote:
>> On Thursday, 30 July 2015, 18:10, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 07/30/2015 05:08 PM, Frederik Bayart wrote:
>>>> On Thursday, 30 July 2015, 16:28, Frederik Bayart <frederik_bayart@yahoo.co.uk> wrote:
>>>>> On 07/29/2015 08:27 PM, Philippe Gerum wrote:
>>>>>>
>>>>>> Please merge the commit on top of -rc6 I mentioned this morning, which
>>>>>> fixes the spurious wake up:
>>>>>>
>>>>>> http://git.xenomai.org/xenomai-3.git/commit/?h=next&id=081cbb8b150f30a019245dfb0e2f0b92cc7f2dfd
>>>>>>
>>>>>
>>>>> Actually, I did not mention it, that's why we don't seem to be on the
>>>>> same page, sorry for this. We should resume the discussion from the
>>>>> situation obtained with this commit on top of -rc6.
>>>>
>>>> I have build a new rc6 kernel & libraries with the new kernel/cobalt/posix/sem.c
>>>> The rt_sem_p problem is now solved, the first process is not interrupted anymore.
>>>>
>>>> I still doesn't see the fuse file system like you do.  I'm looking to other problems (select/connect/send/recv on UNIX domain sockets) so I hope that this is not the cause.
>>>>
>>>> I found already that 'select' on  socket(PF_UNIX, SOCK_STREAM, 0)  causes Interrupted system call (errno 4).
>>>> If I replace 'select' with '__real_select' the problem seems to be solved, and the select timeout works.
>>>> But the select doesn't seem to react on connect. I'm looking at the problem.
>>>
>>>
>>> I just notice that the flood of Interrupted system calls is only cause when build with trank. When build with alchemy, Interrupted system call just happens once.
>>
>> libtrank is just an overlay on top of libalchemy, only consisting of
>> fairly simple wrappers. I would suspect a difference in the flags passed
>> to xeno-config instead.
> 
> I succeeded to start my server using alchemy directly.
> 
> Via trank the program generates a flood of error:
> 
> $ sudo ./ptest
> 
> ptest.c:68 ERROR: select(4): Interrupted system call
> ptest.c:68 ERROR: select(4): Interrupted system call
> ptest.c:68 ERROR: select(4): Interrupted system call
> ...
> 
> In attachment a test file ptest.c and makefile to reproduce the problem.
> 

Ok, I'll have a look.

> My original server uses both native and posix calls, for that I used both native and posix flags.
> 
> XENO_CFLAGS = $(shell $(XENOCONFIG) --posix  --compat --native --cflags )
> XENO_LDFLAGS = $(shell $(XENOCONFIG) --posix --compat --native --ldflags )
> 

--compat --native is redundant, --native enables --compat implicitly.
--alchemy does not.

> With alchemy directly there is no problem :
> 
> XENO_CFLAGS = $(shell $(XENOCONFIG) --alchemy --cflags)
> XENO_LDFLAGS = $(shell $(XENOCONFIG) --alchemy --ldflags)
> 
> 
> I noticed also that for the documentation of the transition kit at the bottom http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Using_the_Transition_Kit :
> 
> If I link with xeno-config  --posix --ldflags --compat, I get :
> 
> cc -Wl,@/usr/lib/cobalt.wrappers -ltrank   /usr/lib/xenomai/bootstrap.o -Wl,--wrap=main -Wl,--dynamic-list=/usr/lib/dynlist.ld -L/usr/lib -lcobalt -lpthread -lrt    -lfuse -pthread  -o ptest ptest.o
> /usr/lib/libtrank.so: undefined reference to `threadobj_set_schedparam'
> /usr/lib/libtrank.so: undefined reference to `__current_rt_alarm_create'
> /usr/lib/libtrank.so: undefined reference to `rt_task_self'
> /usr/lib/libtrank.so: undefined reference to `rt_task_wait_period'
> /usr/lib/libtrank.so: undefined reference to `xnfree'
> /usr/lib/libtrank.so: undefined reference to `__current_rt_event_create'
> /usr/lib/libtrank.so: undefined reference to `rt_task_start'
> /usr/lib/libtrank.so: undefined reference to `rt_task_delete'
> /usr/lib/libtrank.so: undefined reference to `rt_task_set_affinity'
> /usr/lib/libtrank.so: undefined reference to `rt_task_suspend'
> /usr/lib/libtrank.so: undefined reference to `__current_rt_event_clear'
> /usr/lib/libtrank.so: undefined reference to `threadobj_irq_prio'
> /usr/lib/libtrank.so: undefined reference to `__current_rt_event_signal'
> /usr/lib/libtrank.so: undefined reference to `__current_rt_task_create'
> /usr/lib/libtrank.so: undefined reference to `__current_rt_task_set_periodic'
> /usr/lib/libtrank.so: undefined reference to `__current_rt_pipe_create'
> /usr/lib/libtrank.so: undefined reference to `__threadobj_current'
> /usr/lib/libtrank.so: undefined reference to `__current_rt_alarm_delete'
> /usr/lib/libtrank.so: undefined reference to `xnmalloc'
> collect2: error: ld returned 1 exit status
> makefile:27: recipe for target 'ptest' failed
> make: *** [ptest] Error 1
> 
> With the --native flag added, this is solved because  -lalchemy -lcopperplate is then added.
> 

This is expected, compat mode is aimed at the legacy native API only.

-- 
Philippe.

