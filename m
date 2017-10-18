References: <1508232053.2272.23.camel@scrappix.utpvision.local>
 <96045a73-a4c5-a441-ec74-31d03322b0d3@xenomai.org>
 <1508306591.2177.19.camel@scrappix.utpvision.local>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fb8410b0-d082-5eeb-2237-f725ba9b25af@xenomai.org>
Date: Wed, 18 Oct 2017 11:02:04 +0200
MIME-Version: 1.0
In-Reply-To: <1508306591.2177.19.camel@scrappix.utpvision.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Heap binding error (EWOULDBLOCK)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Finazzi <rfinaz@tin.it>
Cc: xenomai@xenomai.org

On 10/18/2017 08:03 AM, Roberto Finazzi wrote:
> Hi,
> thank you for your answer, but there was already both --enable-registry
> and --enable-pshared as I can see using /usr/xenomai/sbin/version -a.
> 

Please paste the output of:
# <your-test-app> --dump-config.

> Just to be sure for the code, this is the first program I used.
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <signal.h>
> #include <sys/mman.h>
> #include <alchemy/task.h>
> #include <alchemy/sem.h>
> 
> RT_TASK task;
> RT_SEM semA;
> 
> void end(int sig) {
>   rt_sem_delete(&semA);

Calling rt_sem_delete() over a signal handler is unsafe.

>   exit(0);
> }
> 
> int main() {
> int err;
> 
> signal (SIGINT, end);
> 
> mlockall(MCL_CURRENT|MCL_FUTURE);

Explicit mlock is redundant with Xenomai 3.x (libcobalt does this for
you during early init).

> err=rt_task_shadow(&task, "writetest", 10, 0);
> 
> err= rt_sem_create(&semA, "semA", 0, S_FIFO);
> printf("After create= %d\n", err);
> 
> while(1) ;
>

That infinite CPU-bound loop should rapidly cause a hard lockup, even on
a multi-core system.

> }
> 
> And this is the second one.
>  
> #include <stdio.h>
> #include <stdlib.h>
> #include <signal.h>
> #include <sys/mman.h>
> #include <alchemy/task.h>
> #include <alchemy/sem.h>
> 
> RT_TASK task;
> RT_SEM semA;
> 
> void end(int sig) {
> 
>   rt_sem_unbind(&semA);
>   exit(0);
> }
> 
> int main() {
> int err;
> 
> signal (SIGINT, end);
> 
> mlockall(MCL_CURRENT|MCL_FUTURE);
> err=rt_task_shadow(&task, "readtest", 10, 0);
> 
> err= rt_sem_bind(&semA, "semA", TM_INFINITE);
> printf("After bind= %d\n", err);
> 
> while(1) ;
> 
> }
> 
> I started the first one and the semaphore was created without problems.
> When I started the second, it remained blocked on the rt_sem_bind.
> 

Are you starting both apps in sequence on a single shell command line,
like "./sem_create_app; ./sem_bind_app"?

-- 
Philippe.

