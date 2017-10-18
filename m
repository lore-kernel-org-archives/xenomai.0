From: Roberto Finazzi <rfinaz@tin.it>
In-Reply-To: <fb8410b0-d082-5eeb-2237-f725ba9b25af@xenomai.org>
References: <1508232053.2272.23.camel@scrappix.utpvision.local>
 <96045a73-a4c5-a441-ec74-31d03322b0d3@xenomai.org>
 <1508306591.2177.19.camel@scrappix.utpvision.local>
 <fb8410b0-d082-5eeb-2237-f725ba9b25af@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Oct 2017 11:55:51 +0200
Message-ID: <1508320551.3237.13.camel@scrappix.utpvision.local>
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

Il giorno mer, 18/10/2017 alle 11.02 +0200, Philippe Gerum ha scritto:
> On 10/18/2017 08:03 AM, Roberto Finazzi wrote:
> > Hi,
> > thank you for your answer, but there was already both --enable-registry
> > and --enable-pshared as I can see using /usr/xenomai/sbin/version -a.
> > 
> 
> Please paste the output of:
> # <your-test-app> --dump-config.
> 


based on Xenomai/cobalt v3.0.5
CONFIG_MMU=1
CONFIG_SMP=1
CONFIG_XENO_BUILD_ARGS=" '--with-core=cobalt' '--disable-debug'
'--enable-pshared' '--enable-smp' '--enable-registry'"
CONFIG_XENO_BUILD_STRING="x86_64-unknown-linux-gnu"
CONFIG_XENO_COBALT=1
CONFIG_XENO_COMPILER="gcc version 6.3.0 20170516 (Debian 6.3.0-18) "
CONFIG_XENO_DEFAULT_PERIOD=100000
CONFIG_XENO_FORTIFY=1
CONFIG_XENO_HOST_STRING="x86_64-unknown-linux-gnu"
CONFIG_XENO_LORES_CLOCK_DISABLED=1
CONFIG_XENO_PREFIX="/usr/xenomai"
CONFIG_XENO_PSHARED=1
CONFIG_XENO_RAW_CLOCK_ENABLED=1
CONFIG_XENO_REGISTRY=1
CONFIG_XENO_REGISTRY_ROOT="/var/run/xenomai"
CONFIG_XENO_REVISION_LEVEL=5
CONFIG_XENO_SANITY=1
CONFIG_XENO_TLSF=1
CONFIG_XENO_TLS_MODEL="initial-exec"
CONFIG_XENO_UAPI_LEVEL=14
CONFIG_XENO_VERSION_MAJOR=3
CONFIG_XENO_VERSION_MINOR=0
CONFIG_XENO_VERSION_NAME="Sisyphus's Boulder"
CONFIG_XENO_VERSION_STRING="3.0.5"
CONFIG_XENO_X86_VSYSCALL=1
---
CONFIG_XENO_ASYNC_CANCEL is OFF
CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
CONFIG_XENO_DEBUG is OFF
CONFIG_XENO_DEBUG_FULL is OFF
CONFIG_XENO_LIBS_DLOPEN is OFF
CONFIG_XENO_MERCURY is OFF
CONFIG_XENO_VALGRIND_API is OFF
CONFIG_XENO_WORKAROUND_CONDVAR_PI is OFF
---
PTHREAD_STACK_DEFAULT=65536
AUTOMATIC_BOOTSTRAP=1

> > Just to be sure for the code, this is the first program I used.
> > 
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <signal.h>
> > #include <sys/mman.h>
> > #include <alchemy/task.h>
> > #include <alchemy/sem.h>
> > 
> > RT_TASK task;
> > RT_SEM semA;
> > 
> > void end(int sig) {
> >   rt_sem_delete(&semA);
> 
> Calling rt_sem_delete() over a signal handler is unsafe.
> 
> >   exit(0);
> > }
> > 
> > int main() {
> > int err;
> > 
> > signal (SIGINT, end);
> > 
> > mlockall(MCL_CURRENT|MCL_FUTURE);
> 
> Explicit mlock is redundant with Xenomai 3.x (libcobalt does this for
> you during early init).
> 

Ok, thank you.

> > err=rt_task_shadow(&task, "writetest", 10, 0);
> > 
> > err= rt_sem_create(&semA, "semA", 0, S_FIFO);
> > printf("After create= %d\n", err);
> > 
> > while(1) ;
> >
> 
> That infinite CPU-bound loop should rapidly cause a hard lockup, even on
> a multi-core system.
> 

To simplify I removed part of source code not useful for understand the
problem...

> > }
> > 
> > And this is the second one.
> >  
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <signal.h>
> > #include <sys/mman.h>
> > #include <alchemy/task.h>
> > #include <alchemy/sem.h>
> > 
> > RT_TASK task;
> > RT_SEM semA;
> > 
> > void end(int sig) {
> > 
> >   rt_sem_unbind(&semA);
> >   exit(0);
> > }
> > 
> > int main() {
> > int err;
> > 
> > signal (SIGINT, end);
> > 
> > mlockall(MCL_CURRENT|MCL_FUTURE);
> > err=rt_task_shadow(&task, "readtest", 10, 0);
> > 
> > err= rt_sem_bind(&semA, "semA", TM_INFINITE);
> > printf("After bind= %d\n", err);
> > 
> > while(1) ;
> > 
> > }
> > 
> > I started the first one and the semaphore was created without problems.
> > When I started the second, it remained blocked on the rt_sem_bind.
> > 
> 
> Are you starting both apps in sequence on a single shell command line,
> like "./sem_create_app; ./sem_bind_app"?
> 

I started them in two different xterm. I tried also with one shell
command line with the same result.

Regards
Roberto


