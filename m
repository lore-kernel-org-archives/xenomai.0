Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 1 Aug 2006 16:02:27 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A46D6A5@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-help] Convert Linux PosixThreads to Xenomai PosixThreads
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I try to port some software, which runs on native Linux, to Xenomai.
As the original SW uses Posix calls, I thought, I just have to compile =
with Xenomai-header files, link Xenomai-libraries, use the Xenomai flags =
as deliverd from xeno-config and the application will run on Xenomai.

So far so good. Compiling and linking works miraculous (see output =
below).=20
But when I start my application I still get just Linux threads and no =
Xenomai shadow tasks are created. Can anybody give me a hint how I can =
controll what kind of thread is created ?

By the way : the posix example satch.c works fine (Xenomai tasks are =
created) and compiler and linker output are nearly the same as for my =
application (see below). So, I can=B4t see, what I made wrong.

Thank you in advance for your help and best regards=20
Roderik

P.s.: I use Xenomai 2.2rc2

ppc-linux-gcc -I. -I/home/someuser/mc45/xenomai/_install/include=20
   -I/home/someuser/mc45/xenomai/_install/include/posix=20
   -g -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -pipe =20
   -c -o sw0.o sw0.c
ppc-linux-g++ -g -oapplication sw1.o lib1.a sw0.o =
-Wl,--wrap,pthread_create=20
   -Wl,--wrap,pthread_detach -Wl,--wrap,pthread_setschedparam=20
   -Wl,--wrap,pthread_yield -Wl,--wrap,sched_yield -Wl,--wrap,sem_init=20
   -Wl,--wrap,sem_destroy -Wl,--wrap,sem_post -Wl,--wrap,sem_timedwait=20
   -Wl,--wrap,sem_wait -Wl,--wrap,sem_trywait -Wl,--wrap,sem_getvalue=20
   -Wl,--wrap,sem_open -Wl,--wrap,sem_close -Wl,--wrap,sem_unlink=20
   -Wl,--wrap,clock_getres -Wl,--wrap,clock_gettime =
-Wl,--wrap,clock_settime=20
   -Wl,--wrap,clock_nanosleep -Wl,--wrap,nanosleep =
-Wl,--wrap,pthread_mutex_init=20
   -Wl,--wrap,pthread_mutex_destroy -Wl,--wrap,pthread_mutex_lock=20
   -Wl,--wrap,pthread_mutex_trylock -Wl,--wrap,pthread_mutex_timedlock=20
   -Wl,--wrap,pthread_mutex_unlock -Wl,--wrap,pthread_cond_init=20
   -Wl,--wrap,pthread_cond_destroy -Wl,--wrap,pthread_cond_wait=20
   -Wl,--wrap,pthread_cond_timedwait -Wl,--wrap,pthread_cond_signal=20
   -Wl,--wrap,pthread_cond_broadcast -Wl,--wrap,mq_open =
-Wl,--wrap,mq_close=20
   -Wl,--wrap,mq_unlink -Wl,--wrap,mq_getattr -Wl,--wrap,mq_setattr=20
   -Wl,--wrap,mq_send -Wl,--wrap,mq_timedsend -Wl,--wrap,mq_receive=20
   -Wl,--wrap,mq_timedreceive -Wl,--wrap,mq_notify -Wl,--wrap,open=20
   -Wl,--wrap,socket -Wl,--wrap,close -Wl,--wrap,ioctl -Wl,--wrap,read=20
   -Wl,--wrap,write -Wl,--wrap,recvmsg -Wl,--wrap,sendmsg =
-Wl,--wrap,recvfrom=20
   -Wl,--wrap,sendto -Wl,--wrap,recv -Wl,--wrap,send =
-Wl,--wrap,getsockopt=20
   -Wl,--wrap,setsockopt -Wl,--wrap,bind -Wl,--wrap,connect =
-Wl,--wrap,listen=20
   -Wl,--wrap,accept -Wl,--wrap,getsockname -Wl,--wrap,getpeername =
-Wl,--wrap,shutdown=20
   -Wl,--wrap,timer_create -Wl,--wrap,timer_delete =
-Wl,--wrap,timer_settime=20
   -Wl,--wrap,timer_getoverrun -Wl,--wrap,timer_gettime =
-Wl,--wrap,ftruncate -Wl,--wrap,close=20
   -Wl,--wrap,shm_open -Wl,--wrap,shm_unlink -Wl,--wrap,mmap =
-Wl,--wrap,munmap =20
   -L/home/someuser/mc45/xenomai/_install/lib -lpthread_rt -lpthread =
-lrt  -lnative -lm -lrtdm=20

