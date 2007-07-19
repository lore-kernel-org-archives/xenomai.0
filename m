Message-ID: <2862c2c80707190105j79e9357ehbba9285c2f8a250c@domain.hid>
Date: Thu, 19 Jul 2007 16:05:11 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_73869_1692135.1184832311290"
Subject: [Xenomai-help] Cross Compile the Xenomai-2.3.2 for AT91 - ld
	terminated with signal 11
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_73869_1692135.1184832311290
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,

I have tried to cross compile the xenomai-2.3.2 for AT91RM9200 but run in to
the following problems:

arm-linux-gcc -Wl,--wrap -Wl,pthread_create -Wl,--wrap
-Wl,pthread_setschedparam -Wl,--wrap -Wl,pthread_getschedparam -Wl,--wrap
-Wl,pthread_yield -Wl,--wrap -Wl,sched_yield -Wl,--wrap -Wl,sem_init
-Wl,--wrap -Wl,sem_destroy -Wl,--wrap -Wl,sem_post -Wl,--wrap
-Wl,sem_timedwait -Wl,--wrap -Wl,sem_wait -Wl,--wrap -Wl,sem_trywait
-Wl,--wrap -Wl,sem_getvalue -Wl,--wrap -Wl,sem_open -Wl,--wrap -Wl,sem_close
-Wl,--wrap -Wl,sem_unlink -Wl,--wrap -Wl,clock_getres -Wl,--wrap
-Wl,clock_gettime -Wl,--wrap -Wl,clock_settime -Wl,--wrap
-Wl,clock_nanosleep -Wl,--wrap -Wl,nanosleep -Wl,--wrap
-Wl,pthread_mutexattr_init -Wl,--wrap -Wl,pthread_mutexattr_destroy
-Wl,--wrap -Wl,pthread_mutexattr_gettype -Wl,--wrap
-Wl,pthread_mutexattr_settype -Wl,--wrap -Wl,pthread_mutexattr_getprotocol
-Wl,--wrap -Wl,pthread_mutexattr_setprotocol -Wl,--wrap
-Wl,pthread_mutexattr_getpshared -Wl,--wrap -Wl,pthread_mutexattr_setpshared
-Wl,--wrap -Wl,pthread_mutex_init -Wl,--wrap -Wl,pthread_mutex_destroy
-Wl,--wrap -Wl,pthread_mutex_lock -Wl,--wrap -Wl,pthread_mutex_trylock
-Wl,--wrap -Wl,pthread_mutex_timedlock -Wl,--wrap -Wl,pthread_mutex_unlock
-Wl,--wrap -Wl,pthread_condattr_init -Wl,--wrap -Wl,pthread_condattr_destroy
-Wl,--wrap -Wl,pthread_condattr_getclock -Wl,--wrap
-Wl,pthread_condattr_setclock -Wl,--wrap -Wl,pthread_condattr_getpshared
-Wl,--wrap -Wl,pthread_condattr_setpshared -Wl,--wrap -Wl,pthread_cond_init
-Wl,--wrap -Wl,pthread_cond_destroy -Wl,--wrap -Wl,pthread_cond_wait
-Wl,--wrap -Wl,pthread_cond_timedwait -Wl,--wrap -Wl,pthread_cond_signal
-Wl,--wrap -Wl,pthread_cond_broadcast -Wl,--wrap -Wl,mq_open -Wl,--wrap
-Wl,mq_close -Wl,--wrap -Wl,mq_unlink -Wl,--wrap -Wl,mq_getattr -Wl,--wrap
-Wl,mq_setattr -Wl,--wrap -Wl,mq_send -Wl,--wrap -Wl,mq_timedsend -Wl,--wrap
-Wl,mq_receive -Wl,--wrap -Wl,mq_timedreceive -Wl,--wrap -Wl,mq_notify
-Wl,--wrap -Wl,open -Wl,--wrap -Wl,socket -Wl,--wrap -Wl,close -Wl,--wrap
-Wl,ioctl -Wl,--wrap -Wl,read -Wl,--wrap -Wl,write -Wl,--wrap -Wl,recvmsg
-Wl,--wrap -Wl,sendmsg -Wl,--wrap -Wl,recvfrom -Wl,--wrap -Wl,sendto
-Wl,--wrap -Wl,recv -Wl,--wrap -Wl,send -Wl,--wrap -Wl,getsockopt -Wl,--wrap
-Wl,setsockopt -Wl,--wrap -Wl,bind -Wl,--wrap -Wl,connect -Wl,--wrap
-Wl,listen -Wl,--wrap -Wl,accept -Wl,--wrap -Wl,getsockname -Wl,--wrap
-Wl,getpeername -Wl,--wrap -Wl,shutdown -Wl,--wrap -Wl,timer_create
-Wl,--wrap -Wl,timer_delete -Wl,--wrap -Wl,timer_settime -Wl,--wrap
-Wl,timer_getoverrun -Wl,--wrap -Wl,timer_gettime -Wl,--wrap -Wl,ftruncate
-Wl,--wrap -Wl,close -Wl,--wrap -Wl,shm_open -Wl,--wrap -Wl,shm_unlink
-Wl,--wrap -Wl,mmap -Wl,--wrap -Wl,munmap -o .libs/cyclictest
cyclictest-cyclictest.o  ../../skins/posix/.libs/libpthread_rt.so -lpthread
-lrt -Wl,--rpath -Wl,/usr/xenomai/lib
collect2: ld terminated with signal 11 [Segmentation fault]
/buildroot/build_arm_nofpu/staging_dir/lib/gcc/arm-linux-uclibc/3.4.2/../../../../arm-linux-uclibc/bin/ld:
make[3]: *** [cyclictest] Error 1
make[3]: Leaving directory `/home/yeow/kwikbyte/sources/xenomai-2.3.2
/src/testsuite/cyclic'
make[2]: *** [install-recursive] Error 1
make[2]: Leaving directory
`/home/yeow/kwikbyte/sources/xenomai-2.3.2/src/testsuite'

make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory `/home/yeow/kwikbyte/sources/xenomai-2.3.2/src'
make: *** [install-recursive] Error 1

I have configure the makefile as follows:
./configure --build=i386-pc-linux-gnu --host=arm-linux CC=arm-linux-gcc
CXX=arm-linux-gcc AR=arm-linux-ar LD=arm-linux-ld --enable-arm-mach=at91

The gcc version as follow:
Reading specs from
/buildroot/build_arm_nofpu/staging_dir/lib/gcc/arm-linux-uclibc/3.4.2/specs
Configured with: /buildroot/toolchain_build_arm_nofpu/gcc-3.4.2/configure
--prefix=/buildroot/build_arm_nofpu/staging_dir --build=i386-pc-linux-gnu
--host=i386-pc-linux-gnu --target=arm-linux-uclibc --enable-languages=c,c++
--enable-shared --disable-__cxa_atexit --enable-target-optspace
--with-gnu-ld --disable-nls --enable-threads --enable-multilib
--with-float=soft
Thread model: posix
gcc version 3.4.2

Am I doing something wrong?

Please help. Thanks

regards,
chun yeow

------=_Part_73869_1692135.1184832311290
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear all,<br><br>I have tried to cross compile the xenomai-2.3.2 for AT91RM=
9200 but run in to the following problems:<br><br>arm-linux-gcc -Wl,--wrap =
-Wl,pthread_create -Wl,--wrap -Wl,pthread_setschedparam -Wl,--wrap -Wl,pthr=
ead_getschedparam -Wl,--wrap -Wl,pthread_yield -Wl,--wrap -Wl,sched_yield -=
Wl,--wrap -Wl,sem_init -Wl,--wrap -Wl,sem_destroy -Wl,--wrap -Wl,sem_post -=
Wl,--wrap -Wl,sem_timedwait -Wl,--wrap -Wl,sem_wait -Wl,--wrap -Wl,sem_tryw=
ait -Wl,--wrap -Wl,sem_getvalue -Wl,--wrap -Wl,sem_open -Wl,--wrap -Wl,sem_=
close -Wl,--wrap -Wl,sem_unlink -Wl,--wrap -Wl,clock_getres -Wl,--wrap -Wl,=
clock_gettime -Wl,--wrap -Wl,clock_settime -Wl,--wrap -Wl,clock_nanosleep -=
Wl,--wrap -Wl,nanosleep -Wl,--wrap -Wl,pthread_mutexattr_init -Wl,--wrap -W=
l,pthread_mutexattr_destroy -Wl,--wrap -Wl,pthread_mutexattr_gettype -Wl,--=
wrap -Wl,pthread_mutexattr_settype -Wl,--wrap -Wl,pthread_mutexattr_getprot=
ocol -Wl,--wrap -Wl,pthread_mutexattr_setprotocol -Wl,--wrap -Wl,pthread_mu=
texattr_getpshared -Wl,--wrap -Wl,pthread_mutexattr_setpshared -Wl,--wrap -=
Wl,pthread_mutex_init -Wl,--wrap -Wl,pthread_mutex_destroy -Wl,--wrap -Wl,p=
thread_mutex_lock -Wl,--wrap -Wl,pthread_mutex_trylock -Wl,--wrap -Wl,pthre=
ad_mutex_timedlock -Wl,--wrap -Wl,pthread_mutex_unlock -Wl,--wrap -Wl,pthre=
ad_condattr_init -Wl,--wrap -Wl,pthread_condattr_destroy -Wl,--wrap -Wl,pth=
read_condattr_getclock -Wl,--wrap -Wl,pthread_condattr_setclock -Wl,--wrap =
-Wl,pthread_condattr_getpshared -Wl,--wrap -Wl,pthread_condattr_setpshared =
-Wl,--wrap -Wl,pthread_cond_init -Wl,--wrap -Wl,pthread_cond_destroy -Wl,--=
wrap -Wl,pthread_cond_wait -Wl,--wrap -Wl,pthread_cond_timedwait -Wl,--wrap=
 -Wl,pthread_cond_signal -Wl,--wrap -Wl,pthread_cond_broadcast -Wl,--wrap -=
Wl,mq_open -Wl,--wrap -Wl,mq_close -Wl,--wrap -Wl,mq_unlink -Wl,--wrap -Wl,=
mq_getattr -Wl,--wrap -Wl,mq_setattr -Wl,--wrap -Wl,mq_send -Wl,--wrap -Wl,=
mq_timedsend -Wl,--wrap -Wl,mq_receive -Wl,--wrap -Wl,mq_timedreceive -Wl,-=
-wrap -Wl,mq_notify -Wl,--wrap -Wl,open -Wl,--wrap -Wl,socket -Wl,--wrap -W=
l,close -Wl,--wrap -Wl,ioctl -Wl,--wrap -Wl,read -Wl,--wrap -Wl,write -Wl,-=
-wrap -Wl,recvmsg -Wl,--wrap -Wl,sendmsg -Wl,--wrap -Wl,recvfrom -Wl,--wrap=
 -Wl,sendto -Wl,--wrap -Wl,recv -Wl,--wrap -Wl,send -Wl,--wrap -Wl,getsocko=
pt -Wl,--wrap -Wl,setsockopt -Wl,--wrap -Wl,bind -Wl,--wrap -Wl,connect -Wl=
,--wrap -Wl,listen -Wl,--wrap -Wl,accept -Wl,--wrap -Wl,getsockname -Wl,--w=
rap -Wl,getpeername -Wl,--wrap -Wl,shutdown -Wl,--wrap -Wl,timer_create -Wl=
,--wrap -Wl,timer_delete -Wl,--wrap -Wl,timer_settime -Wl,--wrap -Wl,timer_=
getoverrun -Wl,--wrap -Wl,timer_gettime -Wl,--wrap -Wl,ftruncate -Wl,--wrap=
 -Wl,close -Wl,--wrap -Wl,shm_open -Wl,--wrap -Wl,shm_unlink -Wl,--wrap -Wl=
,mmap -Wl,--wrap -Wl,munmap -o .libs/cyclictest=20
cyclictest-cyclictest.o&nbsp; ../../skins/posix/.libs/libpthread_rt.so -lpt=
hread -lrt -Wl,--rpath -Wl,/usr/xenomai/lib<br>collect2: ld terminated with=
 signal 11 [Segmentation fault]<br>/buildroot/build_arm_nofpu/staging_dir/l=
ib/gcc/arm-linux-uclibc/3.4.2/../../../../arm-linux-uclibc/bin/ld: make[3]:=
 *** [cyclictest] Error 1
<br>make[3]: Leaving directory `/home/yeow/kwikbyte/sources/xenomai-2.3.2/s=
rc/testsuite/cyclic&#39;<br>make[2]: *** [install-recursive] Error 1<br>mak=
e[2]: Leaving directory `/home/yeow/kwikbyte/sources/xenomai-2.3.2/src/test=
suite&#39;
<br>make[1]: *** [install-recursive] Error 1<br>make[1]: Leaving directory =
`/home/yeow/kwikbyte/sources/xenomai-2.3.2/src&#39;<br>make: *** [install-r=
ecursive] Error 1<br><br>I have configure the makefile as follows:<br>


./configure --build=3Di386-pc-linux-gnu --host=3Darm-linux CC=3Darm-linux-g=
cc CXX=3Darm-linux-gcc AR=3Darm-linux-ar LD=3Darm-linux-ld --enable-arm-mac=
h=3Dat91
<br><br>The gcc version as follow:<br>
Reading specs from /buildroot/build_arm_nofpu/staging_dir/lib/gcc/arm-linux=
-uclibc/3.4.2/specs<br>
Configured with:
/buildroot/toolchain_build_arm_nofpu/gcc-3.4.2/configure
--prefix=3D/buildroot/build_arm_nofpu/staging_dir
--build=3Di386-pc-linux-gnu --host=3Di386-pc-linux-gnu
--target=3Darm-linux-uclibc --enable-languages=3Dc,c++ --enable-shared
--disable-__cxa_atexit --enable-target-optspace --with-gnu-ld
--disable-nls --enable-threads --enable-multilib --with-float=3Dsoft<br>
Thread model: posix<br>
gcc version 3.4.2<br><br>Am I doing something wrong?<br><br>Please help. Th=
anks<br><br>regards,<br>chun yeow<br>

------=_Part_73869_1692135.1184832311290--

