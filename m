References: <CAOuPNLjjqZgqzwRe5ACxdPiCUpedbEW4Xh3FU=gSZc9tMmdgjw@mail.gmail.com>
 <5f063f66-df76-f7d4-c01e-aa7baadf3420@xenomai.org>
 <CAOuPNLhDXu3+igc7dKCWUxp1uy=1KzCXorr1gWmtjY=3ZrL4ig@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <78df92df-7f8b-c439-ce1c-732068e91ff3@xenomai.org>
Date: Thu, 15 Mar 2018 10:59:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAOuPNLhDXu3+igc7dKCWUxp1uy=1KzCXorr1gWmtjY=3ZrL4ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] segmentation fault during rt_task_unblock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/15/2018 10:51 AM, Pintu Kumar wrote:
> On Thu, Mar 15, 2018 at 2:08 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 03/15/2018 09:24 AM, Pintu Kumar wrote:
>>> Hi All,
>>>
>>> I am trying to test rt_cond_bind() and rt_task_unblock() API with a
>>> simple thread program using the Xenomai native skin, and with xenomai
>>> 3.0.6.
>>>
>>> But, during call to rt_task_unblock(&task1) from the main function, I
>>> get the segmentation fault.
>>>
>>
>> Use gdb to get more information about the crash.
>>
> 
> Here is the gdb output:
> 
> Thread 1 "cond_bin_test" received signal SIGSEGV, Segmentation fault.
> cobalt_monitor_exit (mon=0x3c) at internal.c:232
> warning: Source file is more recent than executable.
> 232             state = get_monitor_state(mon);
> (gdb) backtrace
> #0  cobalt_monitor_exit (mon=0x3c) at internal.c:232
> #1  0x0000ffffb7f80058 in monitor_exit (sobj=<optimized out>) at syncobj.c:72
> #2  syncobj_unlock (sobj=<optimized out>, syns=0xfffffffff960) at syncobj.c:279
> #3  0x0000ffffb7f81be8 in threadobj_unblock (thobj=thobj@entry=0xffffb739df88)
>     at threadobj.c:1570
> #4  0x0000ffffb7fa13b0 in rt_task_unblock (task=<optimized out>) at task.c:1353
> #5  0x00000000004011d8 in main (argc=1, argv=0x413710) at cond_bin_test:92
> (gdb)
> 
> Its crashing inside, rt_task_unblock().
> 
> I also get these back trace on console:
> 
> Kernel backtrace :
> 
> root@:~/mine/xenomai-3/testsuite/cond# [ 7923.372700]
> cond_bind_test[26257]: unhandled level 2 translation fault (11) at
> 0x00000040, esr 0x92000006
> 
> [ 7923.381677] mm_pgd = ffff800031fde000, hw_pgd = ffff800031fdc000
> 
> [ 7923.387684] [00000040] *pgd=00000000340fe003,
> *pud=00000000316b4003, *pmd=0000000000000000
> 
> [ 7923.395962]
> ....
> 
> It looks like there is some clean up problem that needs to be handled.
> 
> 
> I could not find any sample reference about how to use rt_cond_bind()
> along with rt_task_unblock().
> If you can share a sample logic, it would be great.
> 
> 
>>> # ./cond_bin_test
>>> PINTU: Inside bind_test task....
>>> PINTU: Before rt_task_unblock
>>> Segmentation fault (core dumped)
>>>
>>> This is the code snippet for the program:
>>>
>>> void bind_test(...)
>>> {
>>>         ....
>>>         err = rt_cond_bind(&cond, "COND1", TM_INFINITE);
>>>         if (err == -EINTR)
>>>                printf("error....");
>>> }
>>>
>>> int main(...)
>>> {
>>>          ....
>>>          rt_task_create(&bind_test, .....);
>>>          rt_task_start(&bind_test, .......);
>>>
>>>          err = rt_task_unblock(&bind_test);
>>>
>>>          rt_task_delete(&bind_test);
>>>
>>>
>>>          return 0;
>>> }
>>>
>>> What is wrong with the above sample ?
>>> I suppose this code was working on Xenomai 2.6.x
>>>
>>> If there is any thing missing please let me know.
>>
>> Your full test code. Task descriptor definition and flags are missing.
>>
> 
> Makefile is like this:
> 
> target = cond_bind_test
> skin = alchemy
> CC := $(shell $(INSTALL_PATH)/xeno-config --cc)
> CFLAGS := $(shell $(INSTALL_PATH)/xeno-config --skin=$(skin) --cflags)
> LDFLAGS := $(shell $(INSTALL_PATH)/xeno-config --skin=$(skin) --ldflags)
> $(target): cond_bind_test
>         $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
> 
> ------------
> The majority of sample program as a given above. I just removed some
> error condition checks and declarations.
> Task details are as follows:
> 
> err = rt_task_create(&task1, NULL, 0, 99, T_JOINABLE);
> err = rt_task_start(&task1, &bind_test, NULL);
> err = rt_task_unblock(&bind_test);
> 
> Apart from these there is nothing more...
> 
> If you need more information please let me know.
>

__Full test code__, no ellipsis, verbatim, please. Or a self-contained
test case reproducing the issue if you can't easily extract the faulting
code from the original app. Where you define the task descriptor, and
the exact sequence of your code could be involved in the issue.

> I think we can easily reproduce it on Xenomai 3.0.6 if we just call
> these functions.

Did you try running testsuite/alchemy/*? task-9 is testing
rt_task_unblock().

-- 
Philippe.

