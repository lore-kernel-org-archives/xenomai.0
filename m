Subject: Re: Mode Switch
References: <CAFZ-hKiLthiDWtv8cuwRGMa0TAKv5ddWGt5XSsSJo1+UfBqgSg@mail.gmail.com>
 <b31e1506-ef9d-e3de-3c54-b7286bc7a400@freyder.net>
 <CAFZ-hKhSL90zbO9rGZRZGYkYz4ULHWAGOPowWe90r+fXvS9vmw@mail.gmail.com>
 <5c401257-2712-2120-21b1-bcc51650d681@freyder.net>
 <CAFZ-hKgCKiqoUAM3ooXgL=h1zsdn1j7UhnaPT9Sd+=t1iT_b3A@mail.gmail.com>
From: steve freyder <steve@freyder.net>
Message-ID: <f0983013-5e0e-4cc1-fe07-91d1db6e732e@freyder.net>
Date: Sun, 3 Jan 2021 16:57:33 -0600
MIME-Version: 1.0
In-Reply-To: <CAFZ-hKgCKiqoUAM3ooXgL=h1zsdn1j7UhnaPT9Sd+=t1iT_b3A@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leandro Bucci <guestleandro11@gmail.com>, xenomai@xenomai.org

OK, so then my theory about it having to do with launching a printf 
helper must be wrong (maybe that only happens on the original thread).  
I don't recall whether you had a flush call after your printf though...

On 1/3/2021 4:22 PM, Leandro Bucci wrote:
> I understand, but it's strange because if I do a printf inside the 
> task I always have MSW = 2.  Yes maybe Philippe can help.  Thank you too
>
> Il dom 3 gen 2021, 23:16 steve freyder <steve@freyder.net 
> <mailto:steve@freyder.net>> ha scritto:
>
>     Might need some help from Philippe on this one but my thinking
>     says that thread creation happens in secondary mode, so there's
>     gotta be at least *one* mode switch on the way to becoming a
>     cobalt thread running in primary mode, perhaps the second one has
>     to do with launching the background printf() helper thread?
>
>
>
>     On 1/3/2021 4:08 PM, Leandro Bucci wrote:
>>     But in the task I don't do any printf, how is it possible that
>>     MSW = 2?
>>
>>     Il dom 3 gen 2021, 23:00 steve freyder <steve@freyder.net
>>     <mailto:steve@freyder.net>> ha scritto:
>>
>>         Each time I would do something like this:
>>
>>
>>         printf(...) ;
>>
>>         fflush(stdout) ;
>>
>>         rt_task_sleep(1e9/5) ;
>>
>>         rt_task_inquire(...) ;
>>
>>
>>         msw incremented by 1, csw would increment by 2.
>>
>>
>>         On 1/3/2021 2:29 PM, Leandro Bucci via Xenomai wrote:
>>>         Hi, I have a strange behavior regarding the "mode switch".
>>>         In the attached code, the task should never switch to the Linux domain, but
>>>         instead I have a value of MSW = 2.
>>>         How is it possible?
>>>         Even if I do a printf in the task I always get MSW = 2.
>>>         I can't understand where the problem is.
>>>
>>>         #include <stdio.h>
>>>         #include <stdlib.h>
>>>         #include <unistd.h>
>>>         #include <alchemy/task.h>
>>>         #include <alchemy/timer.h>
>>>
>>>         RT_TASK task;
>>>         RT_TASK_INFO info;
>>>
>>>         void task_body(void *arg)
>>>         {
>>>         rt_task_inquire(NULL, &info);
>>>         }
>>>
>>>         int main()
>>>         {
>>>         int err;
>>>
>>>         err = rt_task_create(&task, "mytask", 0, 1, 0);
>>>         if (err != 0){
>>>         fprintf(stderr, "failed to create task\n");
>>>         exit(EXIT_FAILURE);
>>>         }
>>>
>>>         err = rt_task_start(&task, &task_body, NULL);
>>>         if (err != 0){
>>>         fprintf(stderr, "failed to start task\n");
>>>         exit(EXIT_FAILURE);
>>>         }
>>>
>>>         sleep(5); //sleep for 5 seconds
>>>
>>>         printf("mode switch = %d\n", (int)(info.stat.msw));
>>>
>>>         exit(EXIT_SUCCESS);
>>>         }
>>
