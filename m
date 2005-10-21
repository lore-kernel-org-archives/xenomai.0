Message-ID: <435967A7.6060903@domain.hid>
Date: Sat, 22 Oct 2005 00:11:51 +0200
From: Luotao Fu <devtty0@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strangeness in named Semaphores(xenomai posix skin)
References: <43590FD1.5030503@domain.hid>
	<17241.24548.920222.440189@domain.hid>
In-Reply-To: <17241.24548.920222.440189@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Luotao Fu wrote:
>  > Hi folks,
>  > 
>  > I got the feeling, that named semaphores in xenomai posix skin don't
>  > work properly. I hacked some simple code to test this and attached the
>  > code to this mail, so that you might have a look of my problem yourself.
> 
> There was one issue on POSIX skin side: the sem_timedwait function
> was not implemented in Xenomai user-space POSIX library, your code was
> hence calling libc sem_timedwait, which accounted for the segfault. The
> remaining misbehaviours you observed are due to problems in the example
> code.

Thanx Gilles, I've just sent out another mail to this thread before I
noticed your mail. Well sorry for the delay than. I found the
sem_timedwait in posix_overrides.h
 #define sem_timedwait pse51_sem_timedwait
so I thought it'll be handled by the posix skin.

> 
>  > (...)
>  > 
>  > char *semName = "/testSem";
>  > struct timespec t;
>  > 
>  > void *funcA(void *parm){
>  > 	sem_t *binSem;
>  >  	if ((binSem = sem_open(semName, O_CREAT)) == SEM_FAILED){
> 
> When calling sem_open with the O_CREAT flag, you have to pass a "mode"
> and most importantly a "value" argument which is the initial value of
> the semaphore. Your also make the assumption that 0 is a valid numeric
> value for the enum O_RDONLY/O_WRONLY/O_RDWR.
>

oh, hell yeah, forgot it.

> 
.......
>  > 	sem_post(binSem);
>  >  	sem_wait(binSem); 	
> 
> Pending on a semaphore is forbidden for non-Xenomai threads, so sem_wait
> returns -1 with errno set to EPERM here and the semaphore remains
> available, assuming, of course that the call to sem_open was changed to
> initialize the semaphore value to 0.
>

Well this is interesting. I did have had to test the Return value here.

I'd change the testcode as your advice and give it some more tests.

Thanx
cheers
Luotao Fu

