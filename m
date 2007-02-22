Message-ID: <45DDFE59.1070407@domain.hid>
Date: Thu, 22 Feb 2007 21:34:33 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Hello world with questions
References: <bc4264770702220523r6af8f8at6d709a0e9079bd6c@domain.hid>
	<45DDB8A6.9090703@domain.hid>
In-Reply-To: <45DDB8A6.9090703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Thanks. Will go through this and hopefully slowly start making sense of it.

Roland



Jan Kiszka wrote:
> roland Tollenaar wrote:
>> Hi,
>>
>> I have copy-pasted the trivial app into the body of this mail. To
>> understand what is
>> going on I have sprinkled and garnished it with questions.
>>
>>
>> [These are standard headers I presume]
>> #include <stdio.h>
>> #include <signal.h>
>> #include <unistd.h>
>> #include <sys/mman.h>
> 
> Jep.
> 
>>
>> [These are xenomai headers. What libraries must be linked in with them?]
>> #include <native/task.h>
>> #include <native/timer.h>
> 
> -lnative, see examples.
> 
>> [I see this macro is called later as an argument. What is its function?]
>> RT_TASK demo_task;
> 
> It's a type in fact. Actually, this is bad style, derived from the
> original RTAI API mess. I think we should establish something like
> rt_task_t etc. on the long-term for the Xenomai native skin, keeping the
> current names only for legacy code (Philippe?).
> 
>> /* NOTE: error handling omitted. */
>>
>> void demo(void *arg)
>> {
>>
>>           RTIME now, previous;
>>
>>     /*
>>      * Arguments: &task (NULL=self),
>>      *            start time,
>>      *            period (here: 1 s)
>>      */
>>     rt_task_set_periodic(NULL, TM_NOW, 1000000000);
>>
>>     previous = rt_timer_read();
>>
>>     while (1) {
>>         rt_task_wait_period(NULL);
>>         now = rt_timer_read();
>>
>>         /*
>>          * NOTE: printf may have unexpected impact on the timing of
>>          *       your program. It is used here in the critical loop
>>          *       only for demonstration purposes.
>>          */
>>         printf("Time since last turn: %ld.%06ld ms\n",
>>                (long)(now - previous) / 1000000,
>>                (long)(now - previous) % 1000000);
>>                previous = now;
>>     }
>> }
>>
>>
>> [The purpose of this function eludes me ?]
>> void catch_signal(int sig)
>> {
>> }
> 
> POSIX signal handling (not Xenomai-related): makes pause() below return
> when some of the caught signals arrive.
> 
>> int main(int argc, char* argv[])
>> {
>>
>> [What is happening here?]
>>     signal(SIGTERM, catch_signal);
>>     signal(SIGINT, catch_signal);
> 
> # man signal
> 
>> [Does this mean I cannot access global variables if this program is
>> running in a thread? That would be a disastrous limitation!]
>>     /* Avoids memory swapping for this program */
>>     mlockall(MCL_CURRENT|MCL_FUTURE);
> 
> ??? There is no such limitation. It's the plain thread programming model
> like with normal pthreads.
> 
> # man mlockall
> 
>>     /*
>>      * Arguments: &task,
>>      *            name,
>>      *            stack size (0=default),
>>      *            priority,
>>      *            mode (FPU, start suspended, ...)
>>      */
>> [I presume this sets the function "demo" as a real-time task?]
>>     rt_task_create(&demo_task, "trivial", 0, 99, 0);
> 
> No, it just creates that task object, the function is set below.
> 
>>     /*
>>      * Arguments: &task,
>>      *            task function,
>>      *            function argument
>>      */
>>     rt_task_start(&demo_task, &demo, NULL);
>> [Is RTASK a task label? What happens if there are more than 1 task to
>> run in separate threads?]
> 
> RT_TASK is the type of a task /descriptor/ (like a file descriptor or
> pthread_t). You can have more tasks by playing with more descriptors.
> 
>> [How is the loop broken to get to this part of the program?]
>>     pause();
> 
> see above
> 
>>     rt_task_delete(&demo_task);
>> }
>>
>>
>> Kindly,
>>
>> Roland.
>>
> 
> HTH,
> Jan
> 

