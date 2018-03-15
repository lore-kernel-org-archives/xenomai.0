MIME-Version: 1.0
In-Reply-To: <b43d4638-51a6-e583-e138-c1c8317f669b@xenomai.org>
References: <CAOuPNLjjqZgqzwRe5ACxdPiCUpedbEW4Xh3FU=gSZc9tMmdgjw@mail.gmail.com>
 <5f063f66-df76-f7d4-c01e-aa7baadf3420@xenomai.org>
 <CAOuPNLhDXu3+igc7dKCWUxp1uy=1KzCXorr1gWmtjY=3ZrL4ig@mail.gmail.com>
 <78df92df-7f8b-c439-ce1c-732068e91ff3@xenomai.org>
 <CAOuPNLitA++hLqwGqU6+SN3mhhAfgOzfpyEd0XR4CvU_ykT7fg@mail.gmail.com>
 <b43d4638-51a6-e583-e138-c1c8317f669b@xenomai.org>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Thu, 15 Mar 2018 22:17:15 +0530
Message-ID: <CAOuPNLgVyd45-vG9CF7vYnCxQ4ksf-O52etQe1iHUhSjG-HuxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] segmentation fault during rt_task_unblock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Please find the complete program below:

---------------------------------------------------------
$ cat bind_test.c
#include <sys/mman.h>
#include <alchemy/task.h>
#include <alchemy/cond.h>
#include <trank/rtdk.h>


#define ONE_SECOND      1000000000ULL
#define COND_NAME       "MyTestCond"


static void bind_task(void *none)
{
        int err;
        RT_COND cond;

        printf("PINTU: %s: Inside bind_server -1\n", __func__);
        /* If I use this sleep it does not crash, but it says resource
unavailable */
        //rt_task_sleep(75*1000);

        err = rt_cond_bind(&cond, COND_NAME, TM_INFINITE);
        if (err == -EINTR) {
                rt_printf("PINTU: %s: error: %s\n", __func__, strerror(errno));
                return;
        }
        printf("PINTU: %s: Finished\n", __func__);
}

int main(int argc, char **argv)
{
        int err;
        RT_TASK taskid;

        mlockall(MCL_CURRENT | MCL_FUTURE);

        err = rt_task_create(&taskid, NULL, 0, 99, T_JOINABLE);
        if (err) {
                printf("Error: rt_task_create failed, err = %d\n", err);
                return -1;
        }

        err = rt_task_start(&taskid, &bind_task, NULL);
        if (err) {
                printf("Error: rt_task_start failed, err = %d\n", err);
                goto failed;
        }

        printf("PINTU: Before rt_task_unblock\n");

        err = rt_task_unblock(&taskid);
        if (err) {
                printf("Error: rt_task_unblock failed, err = %d
[%s]\n", err, strerror(errno));
                goto failed;
        }
        //rt_task_sleep(ONE_SECOND);
        //rt_task_join(&taskid);
        printf("PINTU: After rt_task_unblock\n");

failed:
        rt_task_delete(&taskid);

        return err;
}

---------------------------------------------------------

$ sudo ./bind_test
PINTU: bind_task: Inside bind_server -1
PINTU: Before rt_task_unblock
Segmentation fault (core dumped)



On Thu, Mar 15, 2018 at 6:38 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 03/15/2018 12:07 PM, Pintu Kumar wrote:
>> On Thu, Mar 15, 2018 at 3:29 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>>> On 03/15/2018 10:51 AM, Pintu Kumar wrote:
>>>> On Thu, Mar 15, 2018 at 2:08 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>>>>> On 03/15/2018 09:24 AM, Pintu Kumar wrote:
>>>>>> Hi All,
>>>>>>
>>>>>> I am trying to test rt_cond_bind() and rt_task_unblock() API with a
>>>>>> simple thread program using the Xenomai native skin, and with xenomai
>>>>>> 3.0.6.
>>>>>>
>>>>>> But, during call to rt_task_unblock(&task1) from the main function, I
>>>>>> get the segmentation fault.
>>>>>>
>>>>>
>>>>> Use gdb to get more information about the crash.
>>>>>
>>>>
>>>> Here is the gdb output:
>>>>
>>>> Thread 1 "cond_bin_test" received signal SIGSEGV, Segmentation fault.
>>>> cobalt_monitor_exit (mon=0x3c) at internal.c:232
>>>> warning: Source file is more recent than executable.
>>>> 232             state = get_monitor_state(mon);
>>>> (gdb) backtrace
>>>> #0  cobalt_monitor_exit (mon=0x3c) at internal.c:232
>>>> #1  0x0000ffffb7f80058 in monitor_exit (sobj=<optimized out>) at syncobj.c:72
>>>> #2  syncobj_unlock (sobj=<optimized out>, syns=0xfffffffff960) at syncobj.c:279
>>>> #3  0x0000ffffb7f81be8 in threadobj_unblock (thobj=thobj@entry=0xffffb739df88)
>>>>     at threadobj.c:1570
>>>> #4  0x0000ffffb7fa13b0 in rt_task_unblock (task=<optimized out>) at task.c:1353
>>>> #5  0x00000000004011d8 in main (argc=1, argv=0x413710) at cond_bin_test:92
>>>> (gdb)
>>>>
>>>> Its crashing inside, rt_task_unblock().
>>>>
>>>> I also get these back trace on console:
>>>>
>>>> Kernel backtrace :
>>>>
>>>> root@:~/mine/xenomai-3/testsuite/cond# [ 7923.372700]
>>>> cond_bind_test[26257]: unhandled level 2 translation fault (11) at
>>>> 0x00000040, esr 0x92000006
>>>>
>>>> [ 7923.381677] mm_pgd = ffff800031fde000, hw_pgd = ffff800031fdc000
>>>>
>>>> [ 7923.387684] [00000040] *pgd=00000000340fe003,
>>>> *pud=00000000316b4003, *pmd=0000000000000000
>>>>
>>>> [ 7923.395962]
>>>> ....
>>>>
>>>> It looks like there is some clean up problem that needs to be handled.
>>>>
>>>>
>>>> I could not find any sample reference about how to use rt_cond_bind()
>>>> along with rt_task_unblock().
>>>> If you can share a sample logic, it would be great.
>>>>
>>>>
>>>>>> # ./cond_bin_test
>>>>>> PINTU: Inside bind_test task....
>>>>>> PINTU: Before rt_task_unblock
>>>>>> Segmentation fault (core dumped)
>>>>>>
>>>>>> This is the code snippet for the program:
>>>>>>
>>>>>> void bind_test(...)
>>>>>> {
>>>>>>         ....
>>>>>>         err = rt_cond_bind(&cond, "COND1", TM_INFINITE);
>>>>>>         if (err == -EINTR)
>>>>>>                printf("error....");
>>>>>> }
>>>>>>
>>>>>> int main(...)
>>>>>> {
>>>>>>          ....
>>>>>>          rt_task_create(&bind_test, .....);
>>>>>>          rt_task_start(&bind_test, .......);
>>>>>>
>>>>>>          err = rt_task_unblock(&bind_test);
>>>>>>
>>>>>>          rt_task_delete(&bind_test);
>>>>>>
>>>>>>
>>>>>>          return 0;
>>>>>> }
>>>>>>
>>>>>> What is wrong with the above sample ?
>>>>>> I suppose this code was working on Xenomai 2.6.x
>>>>>>
>>>>>> If there is any thing missing please let me know.
>>>>>
>>>>> Your full test code. Task descriptor definition and flags are missing.
>>>>>
>>>>
>>>> Makefile is like this:
>>>>
>>>> target = cond_bind_test
>>>> skin = alchemy
>>>> CC := $(shell $(INSTALL_PATH)/xeno-config --cc)
>>>> CFLAGS := $(shell $(INSTALL_PATH)/xeno-config --skin=$(skin) --cflags)
>>>> LDFLAGS := $(shell $(INSTALL_PATH)/xeno-config --skin=$(skin) --ldflags)
>>>> $(target): cond_bind_test
>>>>         $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
>>>>
>>>> ------------
>>>> The majority of sample program as a given above. I just removed some
>>>> error condition checks and declarations.
>>>> Task details are as follows:
>>>>
>>>> err = rt_task_create(&task1, NULL, 0, 99, T_JOINABLE);
>>>> err = rt_task_start(&task1, &bind_test, NULL);
>>>> err = rt_task_unblock(&bind_test);
>>>>
>>>> Apart from these there is nothing more...
>>>>
>>>> If you need more information please let me know.
>>>>
>>>
>>> __Full test code__, no ellipsis, verbatim, please. Or a self-contained
>>> test case reproducing the issue if you can't easily extract the faulting
>>> code from the original app. Where you define the task descriptor, and
>>> the exact sequence of your code could be involved in the issue.
>>>
>>>> I think we can easily reproduce it on Xenomai 3.0.6 if we just call
>>>> these functions.
>>>
>>> Did you try running testsuite/alchemy/*? task-9 is testing
>>> rt_task_unblock().
>>>
>>
>> Yes, this work because here we are not using rt_cond_bind.
>> The issue is when we combine: rt_cond_bind, with rt_task_unblock
>> What we are trying to do here is:
>> In the RT task, we are calling rt_cond_bind, so the task will block
>> for the condition, and wait for the err == -EINTR
>> Then, in the main function we are calling : rt_task_block.
>> Thus rt_task_unblock should unblock the task from rt_cond_bind and set
>> the err as -EINTR.
>>
>> But instead of this, rt_task_unblock is crashing.
>> And the error reason is: error: Resource temporarily unavailable
>>
>> One observation:
>> If I use rt_task_sleep(ONE_SECOND) just before rt_cond_bind in task
>> function, then the test is working fine.
>> So, I assume, we need to wait for some time before calling
>> rt_cond_bind, for the resource to be created.
>> Please correct me if I am wrong.
>>
>
> Sprinkling the code with "magical" delays is a documented way of
> papering over bugs which will most certainly bite at some point later
> on, so I would clearly not do that, and go to the bottom of the issue
> instead.
>
> Since you still did not provide me with any self-contained code
> demonstrating the bug, in order to help me in checking the Xenomai code
> for any issue, I guess there is no urgency on getting this problem
> solved on your end. I'm queuing this report to my todo list. I may get
> back to you when I have some cycles left for digging this deeper.
>
> Thanks,
>
> --
> Philippe.

