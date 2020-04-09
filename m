MIME-Version: 1.0
References: <20200407154117.5D7D71C2@centrum.cz>
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>
 <20200407171816.E0B3979D@centrum.cz>
 <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>
 <20200408114406.6119E0D9@centrum.cz>
 <CAFLxGvx9-awne2He+ULqOzwf0cGae1s_k+-b8tdiM+uT67+cYg@mail.gmail.com>
 <20200409170009.5B0DAA77@centrum.cz>
In-Reply-To: <20200409170009.5B0DAA77@centrum.cz>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 9 Apr 2020 18:13:37 +0200
Message-ID: <CAFLxGvy8SP+4mr3PYYRHuxww=22w28RjaDPUgDSVFVHx-_cQ_g@mail.gmail.com>
Subject: Re: rt_task_unblock() POSIX alternative
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Petr_=C4=8Cervenka?= <grugh@centrum.cz>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Thu, Apr 9, 2020 at 5:00 PM Petr =C4=8Cervenka <grugh@centrum.cz> wrote:
>
> > BTW:
> > Why do you think nothing can interrupt a read() from a timerfd?
> > If read() blocks on a timerfd the calling thread will be put into
> > interruptable sleep.
>
> "I" was not able to send a signal to the task and interrupt it.
> Here is an example. Please let me know, how to improve it to interrupt th=
e read() before its timeout:
>
> #include <math.h>
> #include <pthread.h>
> #include <stdint.h>
> #include <signal.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/mman.h>
> #include <sys/timerfd.h>
> #include <unistd.h>
>
> #define AUTO_KILL
>
> #define SECOND  1000000000l     // ns
> #define PERIOD  (5 * SECOND)    // ns
> #define SLEEP   (1 * SECOND)    // ns
>
> using namespace std;
>
> static pid_t mainTask_pid;
> static pthread_t task;
> static int timer_fd;
> static bool end =3D false;
>
> void signalHandler(int signal) {
>     int err;
>     printf("Signal handler: %d\n", signal);
>     end =3D true;
>     err =3D pthread_kill(task, SIGINT);
>     if (err !=3D 0) {
>         printf("pthread_kill failed: %d (%s)\n", err, strerror(-err));
>     }
>     printf("Signal handler end\n");
> }
>
> void timediff (struct timespec *result, const struct timespec *t1, const =
struct timespec *t2) {
>     result->tv_sec =3D t2->tv_sec - t1->tv_sec;
>     result->tv_nsec =3D t2->tv_nsec - t1->tv_nsec;
>     if (result->tv_nsec >=3D SECOND) {
>         result->tv_nsec -=3D SECOND;
>         result->tv_sec++;
>     }
>     if (result->tv_nsec < 0) {
>         result->tv_nsec +=3D SECOND;
>         result->tv_sec--;
>     }
> }
>
> static void *taskHandler(void *cookie) {
>     int err;
>
>     printf("Task started\n");
>
>     signal(SIGINT, signalHandler);
>     signal(SIGTERM, signalHandler);

Don't use signal().
Use sigaction() and *don't* set SA_RESTART. Maybe read() is always restarte=
d...

--=20
Thanks,
//richard

