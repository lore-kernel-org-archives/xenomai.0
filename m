MIME-Version: 1.0
References: <CAFZ-hKjeJZGD7s54hH_QURdY4z=ViUEz3_mrgQbwH4pX4weY+g@mail.gmail.com>
 <fa5f0b2a-4f92-343c-b00d-0d75ee79a97e@freyder.net>
 <87zh1qqpkp.fsf@xenomai.org>
 <CAFZ-hKiOMOk9JZU6cyjV7yaen05VKke=Har-3Xyy_Qh4iEPerw@mail.gmail.com>
 <87v9ceqnya.fsf@xenomai.org>
 <CAFZ-hKjdSmjrFRNF2ugvDqKtTVae0XbLH4KvXhAas+k88PY4hw@mail.gmail.com>
In-Reply-To: <CAFZ-hKjdSmjrFRNF2ugvDqKtTVae0XbLH4KvXhAas+k88PY4hw@mail.gmail.com>
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Sun, 3 Jan 2021 19:24:17 +0100
Message-ID: <CAFZ-hKgxxZ6LQ9uBhJH2Wba7wnh9gKgafAmTrdNL8KFfMtvLRg@mail.gmail.com>
Subject: Re: domain switch
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org, steve freyder <steve@freyder.net>

Sorry for the inconvenience,
I tried to write this code to report domain changes (or mode switch):

##############################################################
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <alchemy/task.h>
#include <alchemy/timer.h>


RT_TASK task;

void task_body(void *arg)
{

RT_TASK_INFO info;

printf("Hello\n");
rt_printf("ByeBye\n");
rt_task_inquire(NULL, &info);
rt_printf("mode switch = %d\n", info.stat.msw);
}

int main()
{
int err;

err = rt_task_create(&task, "mytask", 0, 1, 0);
if (err != 0){
fprintf(stderr, "failed to create task\n");
exit(EXIT_FAILURE);
}

err = rt_task_start(&task, &task_body, NULL);
if (err != 0){
fprintf(stderr, "failed to start task\n");
exit(EXIT_FAILURE);
}

pause();
exit(EXIT_SUCCESS);
}

######################################################################

but I get 0 as a result. How is this possible?

Il giorno dom 3 gen 2021 alle ore 12:20 Leandro Bucci <
guestleandro11@gmail.com> ha scritto:

> perfect thank you so much for the explanation
>
> Il dom 3 gen 2021, 12:06 Philippe Gerum <rpm@xenomai.org> ha scritto:
>
>>
>> Leandro Bucci <guestleandro11@gmail.com> writes:
>>
>> > is it possible to have the same thing for tasks instead of threads?
>> >
>>
>> task == thread
>>
>> > Il dom 3 gen 2021, 11:31 Philippe Gerum <rpm@xenomai.org> ha scritto:
>> >
>> >>
>> >> steve freyder via Xenomai <xenomai@xenomai.org> writes:
>> >>
>> >> > Right.
>> >> >
>> >> >
>> >> > AKA, "mode switch", a switch from "primary mode" to "secondary mode",
>> >> > or vice versa.
>> >> >
>> >> > One place you can find that information is in:
>> >> >
>> >> > /proc/xenomai/sched/acct
>> >> >
>> >> > there are two fields MSW, and CSW which count mode/context switches
>> >> > per-process. This requires an open, a read loop to locate the desired
>> >> > pid and extract the desired information, then either rewind or
>> >> > close/reopen to do it again - all of which will almost surely
>> generate
>> >> > more mode/context switching.
>> >> >
>> >>
>> >> If that helps, there is also the option of getting the thread stats by
>> >> program, using int cobalt_thread_stat(pid_t pid, struct
>> >> cobalt_threadstat *stat), declared in sys/cobalt.h. pid refers to a
>> >> thread identifier (as obtained from gettid(2) in the context of the
>> >> target thread). It must refer to a Cobalt thread, otherwise the call
>> >> would fail with -ESRCH.
>> >>
>> >> The mode switch count is present in the returned information block
>> >> (->msw). cobalt_thread_stat() would not cause any mode switch. It can
>> be
>> >> called by any thread regardless of its type (i.e. regular or Cobalt).
>> >>
>> >> --
>> >> Philippe.
>> >>
>>
>>
>> --
>> Philippe.
>>
>
