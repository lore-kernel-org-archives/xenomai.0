Message-ID: <45AE25D2.5070706@domain.hid>
Date: Wed, 17 Jan 2007 14:34:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] special glibc support for Xenomai?
References: <45AE059C.9050605@domain.hid>		<1169033628.17493.35.camel@domain.hid>
	<45AE0C86.9080101@domain.hid>	<1169036056.17493.43.camel@domain.hid>
	<45AE1E91.8050900@domain.hid>
In-Reply-To: <45AE1E91.8050900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Steven Scholz <steven.scholz@domain.hid>
Cc: xenomai@xenomai.org

Steven Scholz wrote:
> Philippe,
> 
> 
>>>>You just need to make sure to compile/link with the hardened
>>>>Xenomai POSIX library, try running:
>>>>$ xeno-config --posix-cflags|--posix-ldflags.
>>>
>>>What does it do?
>>
>>It returns the proper CFLAGS and LDFLAGS to use in order to compile a
>>POSIX application using the Xenomai hardened POSIX library. In short,
>>libpthread.so is partially shadowed by our libpthread_rt.so library.
> 
> 
> xeno-config --verbose
>     --version="2.3.50"
>     --cc="arm-softfloat-linux-gnu-gcc"
>     --arch="arm"
>     --prefix="/usr/xenomai"
>     --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT"
>     --xeno-ldflags="-L/usr/xenomai/lib -lpthread "
>     --posix-cflags="-I/usr/xenomai/include -I/usr/xenomai/include/posix
> -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
>     --posix-ldflags="-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
>     --library-dir="/usr/xenomai/lib"
> 
> Sorry. I have to ask again. What am I supposed to do with these lines?
> Shell I use all of it whenn calling arm-softfloat-linux-gnu-gcc to compile
> my application?

Yes, you should pass the result of xeno-config --posix-cflags and
xeno-config --posix-ldflags to arm-softfloat-linux-gnu-gcc. When running
xeno-config --posix-ldflags here, I get:

-Wl,--wrap,pthread_create -Wl,--wrap,pthread_setschedparam
-Wl,--wrap,pthread_getschedparam -Wl,--wrap,pthread_yield
-Wl,--wrap,sched_yield -Wl,--wrap,sem_init -Wl,--wrap,sem_destroy
-Wl,--wrap,sem_post -Wl,--wrap,sem_timedwait -Wl,--wrap,sem_wait
-Wl,--wrap,sem_trywait -Wl,--wrap,sem_getvalue -Wl,--wrap,sem_open
-Wl,--wrap,sem_close -Wl,--wrap,sem_unlink -Wl,--wrap,clock_getres
-Wl,--wrap,clock_gettime -Wl,--wrap,clock_settime
-Wl,--wrap,clock_nanosleep -Wl,--wrap,nanosleep
-Wl,--wrap,pthread_mutexattr_init -Wl,--wrap,pthread_mutexattr_destroy
-Wl,--wrap,pthread_mutexattr_gettype
-Wl,--wrap,pthread_mutexattr_settype
-Wl,--wrap,pthread_mutexattr_getprotocol
-Wl,--wrap,pthread_mutexattr_setprotocol
-Wl,--wrap,pthread_mutexattr_getpshared
-Wl,--wrap,pthread_mutexattr_setpshared -Wl,--wrap,pthread_mutex_init
-Wl,--wrap,pthread_mutex_destroy -Wl,--wrap,pthread_mutex_lock
-Wl,--wrap,pthread_mutex_trylock -Wl,--wrap,pthread_mutex_timedlock
-Wl,--wrap,pthread_mutex_unlock -Wl,--wrap,pthread_condattr_init
-Wl,--wrap,pthread_condattr_destroy -Wl,--wrap,pthread_condattr_getclock
-Wl,--wrap,pthread_condattr_setclock
-Wl,--wrap,pthread_condattr_getpshared
-Wl,--wrap,pthread_condattr_setpshared -Wl,--wrap,pthread_cond_init
-Wl,--wrap,pthread_cond_destroy -Wl,--wrap,pthread_cond_wait
-Wl,--wrap,pthread_cond_timedwait -Wl,--wrap,pthread_cond_signal
-Wl,--wrap,pthread_cond_broadcast -Wl,--wrap,mq_open -Wl,--wrap,mq_close
-Wl,--wrap,mq_unlink -Wl,--wrap,mq_getattr -Wl,--wrap,mq_setattr
-Wl,--wrap,mq_send -Wl,--wrap,mq_timedsend -Wl,--wrap,mq_receive
-Wl,--wrap,mq_timedreceive -Wl,--wrap,mq_notify -Wl,--wrap,open
-Wl,--wrap,socket -Wl,--wrap,close -Wl,--wrap,ioctl -Wl,--wrap,read
-Wl,--wrap,write -Wl,--wrap,recvmsg -Wl,--wrap,sendmsg
-Wl,--wrap,recvfrom -Wl,--wrap,sendto -Wl,--wrap,recv -Wl,--wrap,send
-Wl,--wrap,getsockopt -Wl,--wrap,setsockopt -Wl,--wrap,bind
-Wl,--wrap,connect -Wl,--wrap,listen -Wl,--wrap,accept
-Wl,--wrap,getsockname -Wl,--wrap,getpeername -Wl,--wrap,shutdown
-Wl,--wrap,timer_create -Wl,--wrap,timer_delete -Wl,--wrap,timer_settime
-Wl,--wrap,timer_getoverrun -Wl,--wrap,timer_gettime
-Wl,--wrap,ftruncate -Wl,--wrap,close -Wl,--wrap,shm_open
-Wl,--wrap,shm_unlink -Wl,--wrap,mmap -Wl,--wrap,munmap
-L/home/gcx/repository/HardV3/linux2.6/trunk/lib/xenomai/inst//lib
-lpthread_rt -lpthread -lrt

The wrapped calls are handled by xenomai libpthread_rt.so library.

-- 
                                                 Gilles Chanteperdrix

