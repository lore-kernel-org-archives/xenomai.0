MIME-Version: 1.0
In-Reply-To: <52DFA12F.3000304@xenomai.org>
References: <CAKKWdtc7uTkGTX30oso0ciV4JisdTXSNL6YbWbmsnoD6C_r_Uw@mail.gmail.com>
 <52DFA12F.3000304@xenomai.org>
Date: Sat, 25 Jan 2014 11:23:00 +0330
Message-ID: <CAKKWdtehVfx_ahU-GKRgX3nnt1PLQqUjD8sWPsFFBydkAcKSPg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Computer froze by a loop
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

Regarding to examp9.c: The computer freezes, it means that no key
works. I can not use <ctrl-C> either. The task2 is in Primary mode, I
am sure. I have checked  /proc/sys/kernel/. sched_rt_period_us=1000000
and sched_rt_runtime_us=950000.
If task2 immigrates to Linux domain, the computer becomes responsive
and the key-presses are seen. Besides while(1) is present after
rt_task_inquire() which i guess makes task2 go to the primary domain.


On 1/22/14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 01/22/2014 10:04 AM, ali hagigat wrote:
>> Watchdog is enabled and if i put "while(1);" command at the begining
>> of task2, or any where in task1, after 4 seconds all the tasks are
>> killed. But in the example I have attached ( please look at the place
>> of "while(1);") computer froze! Not <ctrl-C> nor Linux scheduling
>> works!
>>
>> I have two questions:
>>
>> 1) Why computer freezes in the cae? It seems a bug
>
> The Xenomai watchdog only handles task which are looping in primary
> mode, handling task running in secondary mode is left to the Linux
> scheduler. Normally, you should see a message about RT throttling, and
> you should be able to interrupt the task with Ctrl-C, unless you
> disabled rt throttling by writing to /proc/sys/kernel/sched_rt_*
>
>> 2) When I put "while(1);" instruction in task1, then task1 is killed
>> by SIGXCPU and the CPU time exceeded, why task2 and the parent task
>> are all killed? I mean only one task should be killed not all of them!
>
> That is the default way of handling SIGXCPU. If you want a different
> behaviour, simply register a signal handler for SIGXCPU. Note that doing
> nothing in SIGXCPU signal handler will defeat the watchdog, as the
> killed task will continue to run, in secondary mode however.
>
> --
>                                                                 Gilles.
>

