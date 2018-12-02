Subject: Re: rt_task_delete is resuming a task in a C++ environment
References: <CAMDdWuyGGTx5VthAWDkyM127aWE8X97cag7nZPrrVx0vyvEt+Q@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c36065ed-60c1-49f6-96ca-facce3de36d4@xenomai.org>
Date: Sun, 2 Dec 2018 10:59:20 +0100
MIME-Version: 1.0
In-Reply-To: <CAMDdWuyGGTx5VthAWDkyM127aWE8X97cag7nZPrrVx0vyvEt+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matheus Pinto <lpinto.matheus@gmail.com>, xenomai@xenomai.org

On 12/1/18 9:52 PM, Matheus Pinto via Xenomai wrote:
> Hi,
> 
> I want use the Xenomai library as underlayer for objects classes in C++.
> For that, I am using the follow system:
> 
> -Ubuntu Mate 16.04.2 (Xenial)
> -Xenomai/cobalt v3.0.6
> -Raspberry Pi 3 with Broadcom BCM2837
> 
> This prototype code is in a .cpp main file:
> 
> #include "test_led.hpp"
> #include <stdio.h>
> #include <stdlib.h>
> #include <iostream>
> #include <signal.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <alchemy/task.h>
> #include <alchemy/timer.h>
> #include <alchemy/heap.h>
> 
> using namespace std;
> 
> /*******************TASKS PROTOTYPES*********************/
> 
> void PubFunc(void * arg);
> 
> void ManFunc(void* arg);
> 
> void TopicTaskFunc(void * args);
> 
> /*******************************************************/
> 
> 
> class Topic
> {
> private:
>     RT_TASK task;
> public:
> 
>     Topic(void)
>     {
>         rt_task_create(&task, "", 100000, 20, 0);
>     }
> 
>     ~Topic(void)
>     {
>         rt_task_delete(&task);
>     }
> 
>     RT_TASK* GetTask(void)
>     {
>         return &task;
>     }
> 
> private:
>     friend void TopicTaskFunc(void* args);
> };
> 
> 
> class Communic{
> private:
>     Topic *top;
>     RT_HEAP heap;
> public:
> 
>     Communic():
>         top(NULL)
>     {
>         /*******************Create heap to allocate dynamically the
> objects*********************/
>         if(rt_heap_create(&(this->heap), "commHeap", 83886080, H_PRIO) != 0)
>         {
>             rt_printf("Impossible create heap.\n");
>             exit(1);
>         }
>     }
> 
>     void InitComm()
>     {
>         void *temp;
> 
> 
>         /*******************Allocate memory for Topic object and call
> constructor****************/
>         if(rt_heap_alloc(&(this->heap),
>                          sizeof(Topic),
>                          TM_INFINITE,
>                          (void**)&(temp))
>             != 0)
>         {
>             rt_printf("Problem to create topic: impossible allocate heap
> for topic.\n");
>             exit(1);
>         }
> 
>         this->top = new(temp) Topic();
> 
>         /*****************Initiate the topic task, that will start after
> management task sleep***/
>         rt_task_start(this->top->GetTask(),
>                       TopicTaskFunc,
>                       (void*)this->top);
>     }
> 
>     void DeinitComm(void)
>     {
>         this->top->~Topic();
>         led_TurnOn(9); // This led never is ON.
>         rt_heap_free(&(this->heap), this->top);
>     }
> 
> };
> 
> /*******************TASKS IMPLEMENTATIONS*********************/
> 
> void PubFunc(void * arg)
> {
>     uint16_t id = *((uint16_t*)arg);
>     size_t execNum = 0;
> 
>     RT_TASK_INFO info;
> 
>     rt_task_inquire(rt_task_self(), &info);
> 
>     rt_printf("Start Task with PID: %d.\n", info.pid);
> 
>     /*Sleep for 1 second and show the current execution number*/
>     for(;;)
>     {
>         execNum++;
>         rt_printf("Task %d -> Execution %d.\n", id, execNum);
>         rt_task_sleep(1000000000);
>     }
> }
> 
> void ManFunc(void* arg)
> {
>     RT_TASK taskHand;
>     Communic comm;
>     size_t id = 1;
> 
>     /* Create the task for "PubFunc above" and init the comm object.
>      * After 5 seconds, sleep for "Pub Func execute and delete it and
>      * deinitialize comm object (with its own task )"*/
>     for(;;)
>     {
>         rt_task_create(&taskHand, "", 500, 5, 0);
>         rt_task_start(&taskHand,
>                       PubFunc,
>                       (void*)&id);
> 
>         comm.InitComm();
>         rt_task_sleep((uint64_t)(((uint64_t)1000000000)*5));
>         comm.DeinitComm();
> 
>         rt_task_delete(&taskHand);
>         rt_task_sleep(1000000000);
>     }
> }
> 
> void TopicTaskFunc(void * args)
> {
>     RT_TASK_INFO info;
> 
>     rt_task_inquire(rt_task_self(), &info);
> 
>     rt_printf("topic task PID = %d.\n",info.pid);
> 
>     /* Just stay suspend and wait be deleted.
>      * HINT: the task is awaken when management task call delete
>      * through "comm.Deinit()", The led being ON confirmed that,
>      * besides that the program is freeze when led is ON.*/
>     for(;;)
>     {
>         rt_task_suspend(rt_task_self());
>         led_TurnOn(8);
>     }
> }
> 
> /*************************************************************************/
> 
> int main(int argc, char* argv[])
> {
>     RT_TASK taskHand;
> 
>     // Lock memory : avoid memory swapping for this program
>     mlockall(MCL_CURRENT|MCL_FUTURE);
> 
>     led_Init(8);
>     led_Init(9);
>     led_TurnOff(8);
>     led_TurnOff(9);
> 
>     rt_task_create(&taskHand, "", 500, 40, 0);
>     rt_task_start(&taskHand,
>                   ManFunc,
>                   NULL);
> 
>     for(;;)
>     {
> 
>         getchar();
>     }
> }
> 
> The first thing I do was create a management task (ManFunc) in main with
> the higher priority (40). Inside this task another task (PubFunc) is create
> directly with priority 5, and other is create indirectly (TopicTaskFunc)
> with the call oh method "comm.InitComm" with priority 20.
> 
> After creation, ManFunc  sleep for 5 seconds, to PubFunc execute is
> workload (Just print). The TopicTaskFunc do nothing, because is stuck in a
> "rt_task_suspend" inside a loop.
> 
> Passed the 5 seconds, the PubFunc stop its execution because its lower
> priority. However, in call of "comm.DeinitComm" the program freeze. It was
> confirmed that the reason is because in the call of "rt_task_delete"
> for  TopicTaskFunc,
> it is awaken from its blocked state and get stuck in its own loop.
> 
> This is a weird behavior, because:
>   - rt_task_delete resumes the TopicTaskFunc, instead just removing it from
> schedule and:

Technically speaking, Linux threads cannot be "removed from schedule" by
other threads: they do block or exit, possibly as a result of a remote
action or event, typically signals. So the question would rather be: why
doesn't your thread receive the cancellation request sent on behalf of
rt_task_delete()?

>   - TopicTaskFunc have a lower priority than ManFunc, but execute instead
> that.
> 
> Any tip for this problem?
> 

Try --enable-async-cancel when configuring.

-- 
Philippe.

