From: Roberto Finazzi <rfinaz@tin.it>
In-Reply-To: <96045a73-a4c5-a441-ec74-31d03322b0d3@xenomai.org>
References: <1508232053.2272.23.camel@scrappix.utpvision.local>
 <96045a73-a4c5-a441-ec74-31d03322b0d3@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Oct 2017 08:03:11 +0200
Message-ID: <1508306591.2177.19.camel@scrappix.utpvision.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Heap binding error (EWOULDBLOCK)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi,
thank you for your answer, but there was already both --enable-registry
and --enable-pshared as I can see using /usr/xenomai/sbin/version -a.

Just to be sure for the code, this is the first program I used.

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/mman.h>
#include <alchemy/task.h>
#include <alchemy/sem.h>

RT_TASK task;
RT_SEM semA;

void end(int sig) {
  rt_sem_delete(&semA);
  exit(0);
}

int main() {
int err;

signal (SIGINT, end);

mlockall(MCL_CURRENT|MCL_FUTURE);
err=rt_task_shadow(&task, "writetest", 10, 0);

err= rt_sem_create(&semA, "semA", 0, S_FIFO);
printf("After create= %d\n", err);

while(1) ;

}

And this is the second one.
 
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/mman.h>
#include <alchemy/task.h>
#include <alchemy/sem.h>

RT_TASK task;
RT_SEM semA;

void end(int sig) {

  rt_sem_unbind(&semA);
  exit(0);
}

int main() {
int err;

signal (SIGINT, end);

mlockall(MCL_CURRENT|MCL_FUTURE);
err=rt_task_shadow(&task, "readtest", 10, 0);

err= rt_sem_bind(&semA, "semA", TM_INFINITE);
printf("After bind= %d\n", err);

while(1) ;

}

I started the first one and the semaphore was created without problems.
When I started the second, it remained blocked on the rt_sem_bind.

Regards
Roberto

Il giorno mar, 17/10/2017 alle 12.04 +0200, Philippe Gerum ha scritto:
> On 10/17/2017 11:20 AM, Roberto Finazzi wrote:
> > Hi,
> > I'm porting an old Xenomai 2.5.6 application to the Cobalt 3.0.5.
> > In the original application there were several heaps shared between many
> > processes.
> > Now I maintained the same structure but, when I tryed to bind an already
> > created heap from another process, I had always the EWOULDBLOCK error.
> > The names used in create and bind were the same. In the previous
> > application the heap was created using H_SHARED but now is obsolete.
> > 
> > Just to test I created two simple programs with a shared semaphore and
> > the behaviour is the same: the second program is blocked always on the
> > rt_sem_bind even if the semaphore is already created.
> > It seems like if the name of the shared resource is not registered
> > properly.
> > 
> > Have you got some suggestions for me?
> > 
> 
> --enable-pshared is required for sharing common resources between processes.
> 
> 



