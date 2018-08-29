Date: Wed, 29 Aug 2018 10:15:47 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <368012593.481146.1535555747324.JavaMail.zimbra@wolfram.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Importance of missing modechk/cobolt.wrappers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hello all


I'm working with a Yocto build of xenomai. I have compiled a sdk for buildi=
ng on a build-host but I am doing something wrong because I get the wrong p=
ath to modechk.wrappers and cobalt.wrappers. I could probably fix this but =
I just want to know whether this is a real problem or not.=20

When I run xeno-config i get :
Xenomai: wrappers cannot be read from /usr/lib/modechk.wrappers
Xenomai: wrappers cannot be read from /usr/lib/cobalt.wrappers

The contents of the wrapper files are listed below for completeness. It see=
ms like a lot of stuff that is not getting wrapped when these files are mis=
sing, and that would mean that I am missing a lot of wrapping and that I de=
finitely need to fix it. Or is is just a warning?=20

How do I know if the final software is wrapping stuff the way I want?


----------------------------------------------------------------=20
modechk.wrappers :=20
----------------------------------------------------------------=20
--wrap malloc
--wrap free

and=20
----------------------------------------------------------------=20
cobalt.wrappers :
----------------------------------------------------------------=20
--wrap pthread_attr_init
--wrap pthread_create
--wrap pthread_setschedparam
--wrap pthread_getschedparam
--wrap pthread_yield
--wrap sched_yield
--wrap sched_get_priority_min
--wrap sched_get_priority_max
--wrap sched_setscheduler
--wrap sched_getscheduler
--wrap pthread_kill
--wrap pthread_join
--wrap pthread_setname_np
--wrap sem_init
--wrap sem_destroy
--wrap sem_post
--wrap sem_timedwait
--wrap sem_wait
--wrap sem_trywait
--wrap sem_getvalue
--wrap sem_open
--wrap sem_close
--wrap sem_unlink
--wrap clock_getres
--wrap clock_gettime
--wrap clock_settime
--wrap clock_nanosleep
--wrap nanosleep
--wrap pthread_mutex_init
--wrap pthread_mutex_destroy
--wrap pthread_mutex_lock
--wrap pthread_mutex_trylock
--wrap pthread_mutex_timedlock
--wrap pthread_mutex_unlock
--wrap pthread_cond_init
--wrap pthread_cond_destroy
--wrap pthread_cond_wait
--wrap pthread_cond_timedwait
--wrap pthread_cond_signal
--wrap pthread_cond_broadcast
--wrap mq_open
--wrap mq_close
--wrap mq_unlink
--wrap mq_getattr
--wrap mq_setattr
--wrap mq_send
--wrap mq_timedsend
--wrap mq_receive
--wrap mq_timedreceive
--wrap mq_notify
--wrap open
--wrap open64
--wrap socket
--wrap close
--wrap ioctl
--wrap read
--wrap write
--wrap recvmsg
--wrap sendmsg
--wrap recvfrom
--wrap sendto
--wrap recv
--wrap send
--wrap getsockopt
--wrap setsockopt
--wrap bind
--wrap connect
--wrap listen
--wrap accept
--wrap getsockname
--wrap getpeername
--wrap shutdown
--wrap timer_create
--wrap timer_delete
--wrap timer_settime
--wrap timer_getoverrun
--wrap timer_gettime
--wrap timerfd_create
--wrap timerfd_gettime
--wrap timerfd_settime
--wrap select
--wrap vfprintf
--wrap vprintf
--wrap fprintf
--wrap printf
--wrap puts
--wrap fputs
--wrap fputc
--wrap putchar
--wrap fwrite
--wrap fclose
--wrap syslog
--wrap vsyslog
--wrap gettimeofday
--wrap __vfprintf_chk
--wrap __vprintf_chk
--wrap __fprintf_chk
--wrap __printf_chk
--wrap __vsyslog_chk
--wrap __syslog_chk
--wrap sigwait
--wrap sigwaitinfo
--wrap sigtimedwait
--wrap sigpending
--wrap sigqueue
--wrap kill
--wrap sleep
--wrap mmap
--wrap mmap64
--wrap time
--wrap fcntl

Regards
Per =C3=96berg=20

