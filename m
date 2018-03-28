References: <CAOuPNLjGFNwaCNa1zGQY4gZpLC7J=5M4EzGNS-YiK1UOx=+t0w@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2fc6c577-a71c-7af8-1889-42f358884ae1@xenomai.org>
Date: Wed, 28 Mar 2018 10:12:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAOuPNLjGFNwaCNa1zGQY4gZpLC7J=5M4EzGNS-YiK1UOx=+t0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem with rt_cond_wait and rt_cond_signal
 combination
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/28/2018 09:54 AM, Pintu Kumar wrote:
> Hi,
> 
> We are facing one issue on Xenomai-3 on x86_64 system.
> Kernel: 4.9.51
> ipipe version: 4
> # /usr/xenomai/sbin/version
> Xenomai/cobalt v3.0.6 -- #5956064 (2018-03-20 12:13:33 +0100)
> 
> Its a very simple API level test.
> We create a condition variable and wait for the condition inside a task.
> Then, we immediately signal the condition from the main thread, and simply
> wait for the test to finish.
> 
> But we observed that condition task is never getting released, and the
> program hangs.
> 
> This is the output:
> --------------------------
> # ./condsignal
> cond_task --> started
> main --> cond signal success: 0
> Waiting for task to finish....
> ^C
> 
> 
> This is the code snippet that was used.
> -----------------------------------------------------
> # cat condsignal.c
> 
> /*
>  * 1. Create an condition variable and wait inside a task.
>  * 2. Delete the condition variable from main task.
>  * 3. Observe that the condition wait is released and task ends normally.
>  * 4. Finally main task should exit normally.
>  *
>  * */
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> #include <alchemy/task.h>
> #include <alchemy/mutex.h>
> #include <alchemy/cond.h>
> #include <alchemy/task.h>
> 
> static RT_COND cond;
> static RT_MUTEX mutex;
> 
> static void cond_task(void *cookie)
> {
>         int err;
> 
>         printf("%s --> started \n", __func__);
>         rt_mutex_acquire(&mutex, TM_INFINITE);
>         err = rt_cond_wait(&cond, &mutex, TM_INFINITE);
>         rt_mutex_release(&mutex);
>         if (err) {
>                 printf("rt_cond_wait failed, err = %d", err);
>                 return;
>         }
>         printf("%s --> cond wait done\n", __func__);
> }
> 
> int main(int argc, char **argv)
> {
>         int err;
>         RT_TASK task1;
> 
>         mlockall(MCL_CURRENT | MCL_FUTURE);
> 
>         err = rt_mutex_create(&mutex, NULL);
>         err = rt_cond_create(&cond, "cond_test");
>         err = rt_task_create(&task1, NULL, 0, 99, T_JOINABLE);
>         err = rt_task_start(&task1, &cond_task, NULL);
>         rt_mutex_acquire(&mutex, TM_INFINITE);
>         err = rt_cond_signal(&cond);
>         rt_mutex_release(&mutex);
>         if (err) {
>                 printf("Error: rt_cond_signal failed, err = %d", err);
>                 exit(-1);
>         }
>         printf("%s --> cond signal success: %d\n", __func__, err);
>         printf("Waiting for task to finish....\n");
>         rt_task_join(&task1);
> 
>         return 0;
> }
> -----------------------------------------------------
> 
> Is there any fix available in Xenomai-3 for this?
> Please let me know if there is something wrong here.
> 
> 

You are not using condition variables the right way, those have no
semaphore semantics. Please read a POSIX documentation about them like
[1], the alchemy API does not differ in behavior.

[1] http://pubs.opengroup.org/onlinepubs/7908799/xsh/pthread_cond_wait.html

-- 
Philippe.

