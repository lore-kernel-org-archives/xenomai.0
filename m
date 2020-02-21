Subject: Re: rt_task_bind blocking: inter-process ?
References: <4392cb58-f99f-f1d6-b4c7-58c75040cf01@laas.fr>
 <89e083e9-ca3f-6f4a-b9f6-0ab8f988db1d@freyder.net>
 <52fb4d78-1a90-13af-6833-b5b8c98942c5@laas.fr>
From: steve freyder <steve@freyder.net>
Message-ID: <5c76c05c-65f6-8b0b-e486-b7835faf0afe@freyder.net>
Date: Fri, 21 Feb 2020 11:40:12 -0600
MIME-Version: 1.0
In-Reply-To: <52fb4d78-1a90-13af-6833-b5b8c98942c5@laas.fr>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 2/21/2020 10:10 AM, LOCHE Daniel via Xenomai wrote:
> On 20/02/2020 à 22:36, steve freyder via Xenomai wrote:
>> On 2/20/2020 7:29 AM, LOCHE Daniel via Xenomai wrote:
>>> Hello everyone,
>>>
>>> I a currently factoring my application to go from a multi-thread one 
>>> to a multi-process one (C++11).
>>> I am using Xenomai 3.0.5 on Linux Mint 18.04 (on a Intel 8250U 
>>> computer), 90% alchemy library (10% posix).
>>> (either processes or tasks, let's call all of those "tasks" here 
>>> after for easier understanding)
>>>
>>> *Context : *Basically, during the setup phase of the execution, 
>>> previously I was reading a list of "task" parameters from a file
>>> and launched consequently the correct amount of rt_task_create() / 
>>> launch() from my main process.
>>> All my RT_TASK links to the threads were stored in the main thread 
>>> to manage them.
>>>
>>> Now, I have to go through a fork() for every task, followed by a 
>>> rt_task_shadow(). OK.
>>> But to get in my main process the link to the RT_TASK of every 
>>> xenomai process created, I have to use rt_task_bind().
>>> Issue is here : whatever arguments I give to rt_task_bind(), it 
>>> blocks as long as the searched task name exists... don't know why.
>>>
>>> Here is a sample code bellow ... what is wrong exactly ? Is it 
>>> possible to use rt_task_bind with inter-process tasks..? Why the 
>>> "TM_NONBLOCK" does nothing..? Thanks for your help.
>>>
>>> Daniel
>>>
>>> #include <alchemy/task.h>
>>> #include <alchemy/timer.h>
>>> #include <sys/types.h>
>>> #include <unistd.h>
>>>
>>> int main ()
>>>
>>> {
>>>     const char* taskNames[3] = {"task0", "task1", "task2"};
>>>     for (int i = 0, i < 3, ++i)
>>>     {
>>>             pid_t pid = fork()
>>>             if (pid) //
>>>             {
>>>                 sleep(1); // wait a little before going through 
>>> another fork.
>>>
>>>         } else { // child process
>>>             RT_TASK _t;
>>>             rt_task_shadow(&_t, taskNames[i], 50, 0);
>>>             rt_printf("Success creating task %s", taskNames[i]);
>>>             sleep(15);        /* placeholder, should do real-time stuff
>>>    here, then end process. */
>>>             exit(EXIT_SUCCESS);
>>>         }
>>>
>>>    }
>>>
>>>     // Only "main" process goes here.
>>>
>>>     RT_TASK _t;
>>>     for (int i = 0, i < 3, ++i)
>>>     {
>>>         int ret = rt_task_bind(&t, taskNames[i], TM_NONBLOCK); // 
>>> <== HERE. TM_NONBLOCK, TM_INFINITE or a time value, changes    
>>> nothing.... never goes here.
>>>         if (ret) printf("Error : could not bind task. Error #%d", ret);
>>>         else printf("Bind to task %s done.", taskNames[i]);
>>>     }
>>>     /* Do stuff here on the binded tasks */
>>>     exit(EXIT_SUCCESS);
>>>
>>> }
>>
>> Daniel,
>>
>>
>> Are you using the --shared-registry and --session=foo switches when 
>> you run your program?  I don't believe there's any other way to get 
>> the registry (which is needed to register your task names so that 
>> rt_task_bind() can find them) shared across processes. The 
>> --shared-registry might be a default, but for sure the --session= 
>> switch is not a default - it defaults to an "anonymous session" which 
>> means that every process has its own registry - shared with nobody.
>>
>>
>> Also, calling fork() might be part of the problem, and if you're 
>> having rt_task_bind() problems then you definitely need to be 
>> checking the return code from your rt_task_shadow() calls.  Part of 
>> what happens there is putting the task name into the registry, so if 
>> that fails, your rt_task_bind() call will also have problems. Why it 
>> is hanging instead of returning -EAGAIN when you're using TM_NONBLOCK 
>> and the task doesn't exist, I don't know.
>>
>>
>> What you're attempting to do here does work if you:
>>
>>
>> 1) disable auto-init using xeno-config --no-auto-init in your build 
>> flags
>>
>> 2) call xenomai_init() explicitly in the child processes before you 
>> call rt_task_shadow()
>>
>> 3) don't call xenomai_init() in the parent task until *after* you 
>> have fork()'ed the child processes
>>
>>
>> I made a copy of your program and modified it to use the no-auto-init 
>> option on the xeno-config invocation, attached.
>>
>>
>> Steve
>>
>>
>>
>> -------------- next part --------------
>> #include <stdio.h>
>> #include <alchemy/task.h>
>> #include <alchemy/timer.h>
>> #include <stdlib.h>
>> #include <sys/types.h>
>> #include <unistd.h>
>> #include <xenomai/init.h>
>>
>> /*
>> * make sure everybody is in the same session and that
>> * we have registry sharing.
>> */
>> int do_xeno_init(void)  {
>>    char *args[] = {
>>        "program",
>>        "--shared-registry",
>>        "--session=test",
>>        NULL
>>    } ;
>>    char **argv = args ;
>>    int argc = (sizeof args/sizeof args[0])-1 ; /* exclude NULL */
>>
>>    xenomai_init(&argc,(char * const **)&argv) ;
>> }
>> #define XENO_INIT()     do_xeno_init()
>>
>> int main (int argc, char **argv)
>>
>> {
>>    static char* taskNames[3] = {"task0", "task1", "task2"};
>>
>>    setvbuf(stdout,NULL,_IOLBF,4096) ;
>>
>>    for (int i = 0 ; i < 3 ; ++i)
>>    {
>>            pid_t pid = fork() ;
>>
>>            if (pid < 0)  {
>>                perror("fork") ;
>>                continue ;
>>            }
>>            else if (pid)        // fork OK, we're parent
>>            {
>>                //sleep(1); // wait a little before going through 
>> another fork.
>>            } else { // child process
>>                RT_TASK _t;
>>                int ret = 0 ;
>>
>>                printf("calling xenomai_init()\n") ;
>>                XENO_INIT() ;
>>                rt_printf("process for %s running, pid %lu\n",
>>                    taskNames[i],getpid()) ;
>>                ret = rt_task_shadow(&_t, taskNames[i], 50, 0);
>>                rt_printf("shadow task %s returns %d\n", taskNames[i], 
>> ret) ;
>>                ret = rt_task_sleep(1e9*30) ;
>>                rt_printf("sleep returned status %d\n",ret) ;
>>                exit(EXIT_SUCCESS);
>>            }
>>
>>   }
>>
>>    // Only "main" process goes here.
>>
>>    printf("launching done, sleeping 5\n") ;
>>    sleep(5) ;
>>    printf("resuming, binding...\n") ;
>>
>>    printf("dumping the registry\n") ;
>>    system("find /run/xenomai") ;   // see what the registry is 
>> looking like
>>
>>    XENO_INIT() ;
>>
>>    for (int i = 0 ; i < 3 ; ++i)
>>    {
>>        RT_TASK _t;
>>        int ret ;
>>        printf("binding to %s\n",taskNames[i]) ;
>>        ret = rt_task_bind(&_t, taskNames[i], TM_NONBLOCK); // <== 
>> HERE. TM_NONBLOCK, TM_INFINITE or a time value, changes nothing.... 
>> never goes here.
>>        if (ret) printf("Error : could not bind task. Error #%d\n", ret);
>>        else printf("Bind to task %s done.\n", taskNames[i]);
>>    }
>>    /* Do stuff here on the binded tasks */
>>    exit(EXIT_SUCCESS);
>> }
>
> Hello,
>
> Thanks for the information. I did not know exactly what was behind the 
> notion of "xenomai domain".
> Things are getting more clear now.
> In my actual code I was already looking at rt_task_shadow return 
> value, but got nothing wrong here, that's why I did not put it on the 
> sample code above.
>
> Just launching your code, rt_task_bind() get a return value, that is 
> -11 (=>EWOULDBLOCK, better than infinite blocking I had before..!).
> However,   system("find /run/xenomai")   returns nothing : "No such 
> file or directory."..!
> I guess this means I don't have such folder on the computer and thus 
> the xenomai task list cannot be found for rt_task_bind...
>
> Any idea why ..?
>
> Daniel
>
My best guess would be "no pshared/registry support in your Xenomai build".

As far as I know, having shared registry support is something you need 
to specify during your configuration process prior to building Xenomai. 
You will probably want to look at this excellent document:


https://xenomai.org/documentation/xenomai-3/html/README.INSTALL/


specifically section 5.2.1 and --enable-pshared, and --enable-registry.

It's possible your system wasn't generated with the appropriate shared 
registry support, or that whomever configured the system used a 
non-standard registry path (meaning find /run/xenomai wouldn't see it), 
or possibly it *is* the default (/var/run/xenomai) but your system 
doesn't have /var/run symlinked to /run like my system does (that's a 
Linux choice more than a Xenomai choice). Also, you'd need to have your 
Linux kernel configured to support the FUSE filesystem, and if that were 
generated as a module, have that module loaded before you start any 
Xenomai programs that need registry access.


Steve





