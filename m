Message-ID: <2ff1a98a0805130149q4b092e30n6055d81cd40ef45a@domain.hid>
Date: Tue, 13 May 2008 10:49:50 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <6132061f0805122051j6854ee1bm20577b53397a6783@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6132061f0805122051j6854ee1bm20577b53397a6783@domain.hid>
Subject: Re: [Xenomai-help] POSIX API
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Breno Carneiro Pinheiro <brenodee@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, May 13, 2008 at 5:51 AM, Breno Carneiro Pinheiro
<brenodee@domain.hid> wrote:
> Hi all, I wanna some help with my application. I'm learning about Xenomai
> POSIX and Native API. I wonder know what is wrong with my code below because
> both don't worked out:
>
> POSIX:
>
> #include <sys/mman.h>
>
> #include <posix/pthread.h>
> #include <posix/time.h>

This should be:
#include <pthread.h>
#include <time.h>

If you want your application to be portable accross posix implementations.

>
> #include <stdio.h>
>
> static pthread_t task_desc;
> void task_body (void *cookie)
>  {
>      struct timespec time;
>      clock_gettime(CLOCK_MONOTONIC, &time);;
>       pthread_make_periodic_np(pthread_self(),&time, 1000000000);

Bad arguments type passed to pthread_make_periodic_np, read its
prototype in Xenomai online documentation. You should get a compiler
warning here, and if you do not get a compiler warning, then you are
not compiling with sufficient warnings, try -Wall or even -Wall -W. My
favorite is -Wall -W -Werror-implicit-function-declaration.

>      while(1) {
>      printf("%s\n","a");

missing pthread_wait_period_np. And in fact, you should not be using
pthread_make_periodic_np/pthread_wait_period_np at all since they are
rtlinux extensions to the posix interface and are implemented in
Xenomai posix skin only for compatibility with rtlinux, you should be
using clock_nanosleep.

Also, using printf in a real-time loop is not a good idea.

>      }
>  }
>
> int main (int argc, char *argv[])
>
>  {
>      int ret;
>       pthread_attr_t thattr;
>

Missing mlockall (unless you configured xenomai with --enable-posix-mlockall).

>      pthread_attr_init(&thattr);
>      pthread_attr_setdetachstate(&thattr, 0);
>      pthread_attr_setstacksize(&thattr, 1024);

Much too small, especially since you use printf which requires some
space on the stack. Use 65536 instead of 1024 for instance.
Also, since the thread you create is a real-time thread you should
give it a real-time priority, i.e. use the SCHED_FIFO policy with a
priority between 1 and 99.

>      ret = pthread_create(&task_desc, NULL, &task_body, NULL);

You initialized a thread attribute structure and do not use it.

>
>      if(!ret)
>       pthread_join(task_desc, NULL);
>
>  }
>


-- 
 Gilles

