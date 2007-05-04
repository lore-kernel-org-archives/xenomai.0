Message-ID: <7289437c0705040615n2272cf83oeec8db0a7dda910c@domain.hid>
Date: Fri, 4 May 2007 15:15:01 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_22494_14142434.1178284501441"
Subject: [Xenomai-help] Problem to compile for ARM
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

------=_Part_22494_14142434.1178284501441
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I have some problems to compile my code Posix for ARM. I have installed
xenomai in /usr/xenomai_arm-2.3.1 for ARM.

Here is my compilation :


[root@domain.hid Essai_mutex_arm]# make XENO_CONFIG=/usr/xenomai_arm-2.3.1
/bin/xeno-config

arm-linux-gcc -I/usr/xenomai_arm-2.3.1/include
-I/usr/xenomai_arm-2.3.1/include/posix
-D_GNU_SOURCE -D_REENTRANT -D__XENO__ -g essai_mutex.c -c -o
essai_mutex_rt.o

arm-linux-gcc -Wl,--wrap,pthread_create -Wl,--wrap,pthread_setschedparam
-Wl,--wrap,pthread_getschedparam -Wl,--wrap,pthread_yield
-Wl,--wrap,sched_yield -Wl,--wrap,sem_init -Wl,--wrap,sem_destroy
-Wl,--wrap,sem_post -Wl,--wrap,sem_timedwait -Wl,--wrap,sem_wait
-Wl,--wrap,sem_trywait -Wl,--wrap,sem_getvalue -Wl,--wrap,sem_open
-Wl,--wrap,sem_close -Wl,--wrap,sem_unlink -Wl,--wrap,clock_getres
-Wl,--wrap,clock_gettime -Wl,--wrap,clock_settime -Wl,--wrap,clock_nanosleep
-Wl,--wrap,nanosleep -Wl,--wrap,pthread_mutexattr_init
-Wl,--wrap,pthread_mutexattr_destroy -Wl,--wrap,pthread_mutexattr_gettype
-Wl,--wrap,pthread_mutexattr_settype
-Wl,--wrap,pthread_mutexattr_getprotocol
-Wl,--wrap,pthread_mutexattr_setprotocol
-Wl,--wrap,pthread_mutexattr_getpshared
-Wl,--wrap,pthread_mutexattr_setpshared -Wl,--wrap,pthread_mutex_init
-Wl,--wrap,pthread_mutex_destroy -Wl,--wrap,pthread_mutex_lock
-Wl,--wrap,pthread_mutex_trylock -Wl,--wrap,pthread_mutex_timedlock
-Wl,--wrap,pthread_mutex_unlock -Wl,--wrap,pthread_condattr_init
-Wl,--wrap,pthread_condattr_destroy -Wl,--wrap,pthread_condattr_getclock
-Wl,--wrap,pthread_condattr_setclock -Wl,--wrap,pthread_condattr_getpshared
-Wl,--wrap,pthread_condattr_setpshared -Wl,--wrap,pthread_cond_init
-Wl,--wrap,pthread_cond_destroy -Wl,--wrap,pthread_cond_wait
-Wl,--wrap,pthread_cond_timedwait -Wl,--wrap,pthread_cond_signal
-Wl,--wrap,pthread_cond_broadcast -Wl,--wrap,mq_open -Wl,--wrap,mq_close
-Wl,--wrap,mq_unlink -Wl,--wrap,mq_getattr -Wl,--wrap,mq_setattr
-Wl,--wrap,mq_send -Wl,--wrap,mq_timedsend -Wl,--wrap,mq_receive
-Wl,--wrap,mq_timedreceive -Wl,--wrap,mq_notify -Wl,--wrap,open
-Wl,--wrap,socket -Wl,--wrap,close -Wl,--wrap,ioctl -Wl,--wrap,read
-Wl,--wrap,write -Wl,--wrap,recvmsg -Wl,--wrap,sendmsg -Wl,--wrap,recvfrom
-Wl,--wrap,sendto -Wl,--wrap,recv -Wl,--wrap,send -Wl,--wrap,getsockopt
-Wl,--wrap,setsockopt -Wl,--wrap,bind -Wl,--wrap,connect -Wl,--wrap,listen
-Wl,--wrap,accept -Wl,--wrap,getsockname -Wl,--wrap,getpeername
-Wl,--wrap,shutdown -Wl,--wrap,timer_create -Wl,--wrap,timer_delete
-Wl,--wrap,timer_settime -Wl,--wrap,timer_getoverrun
-Wl,--wrap,timer_gettime -Wl,--wrap,ftruncate -Wl,--wrap,close
-Wl,--wrap,shm_open -Wl,--wrap,shm_unlink -Wl,--wrap,mmap -Wl,--wrap,munmap
-L/usr/xenomai_arm-2.3.1/lib -lpthread_rt -lpthread -lrt   essai_mutex_rt.o
-o essai_mutex_rt

essai_mutex_rt.o: In function `affich':

/home/martignoni/Programme/Test/Essai_mutex_arm/essai_mutex.c:30: undefined
reference to `__wrap_pthread_mutex_lock'

/home/martignoni/Programme/Test/Essai_mutex_arm/essai_mutex.c:37: undefined
reference to `__wrap_pthread_mutex_unlock'

essai_mutex_rt.o: In function `cleanup_upon_sig':

/home/martignoni/Programme/Test/Essai_mutex_arm/essai_mutex.c:70: undefined
reference to `__wrap_pthread_mutex_destroy'

essai_mutex_rt.o: In function `main':

/home/martignoni/Programme/Test/Essai_mutex_arm/essai_mutex.c:88: undefined
reference to `__wrap_pthread_mutex_init'

/home/martignoni/Programme/Test/Essai_mutex_arm/essai_mutex.c:121: undefined
reference to `__wrap_pthread_create'

/home/martignoni/Programme/Test/Essai_mutex_arm/essai_mutex.c:124: undefined
reference to `__wrap_pthread_create'

collect2: ld returned 1 exit status

make: *** [essai_mutex_rt] Erreur 1

rm essai_mutex_rt.o





It would seem the problem is only with Posix.

In the directory /usr/xenomai_arm-2.3.1/lib, I have only static librairies
(.a, .la). Maybe it's the problem.

------=_Part_22494_14142434.1178284501441
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hello, </div>
<div>&nbsp;</div>
<div>I have some problems to compile my code Posix for ARM. I have installe=
d xenomai in /usr/xenomai_arm-2.3.1 for ARM.</div>
<div>&nbsp;</div>
<div>Here is my compilation : </div>
<div>&nbsp;</div>
<div>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">[root@domain.hid Essai_mutex_arm]# make XENO_CONFIG=3D/usr/xenomai_=
arm-2.3.1/bin/xeno-config</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">arm-linux-gcc -I/usr/xenomai_arm-2.3.1/include -I/usr/xenomai_arm-=
2.3.1/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -g essai_mutex.c =
-c -o essai_mutex_rt.o
</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">arm-linux-gcc -Wl,--wrap,pthread_create -Wl,--wrap,pthread_setsche=
dparam -Wl,--wrap,pthread_getschedparam -Wl,--wrap,pthread_yield -Wl,--wrap=
,sched_yield -Wl,--wrap,sem_init -Wl,--wrap,sem_destroy -Wl,--wrap,sem_post=
 -Wl,--wrap,sem_timedwait -Wl,--wrap,sem_wait -Wl,--wrap,sem_trywait -Wl,--=
wrap,sem_getvalue -Wl,--wrap,sem_open -Wl,--wrap,sem_close -Wl,--wrap,sem_u=
nlink -Wl,--wrap,clock_getres -Wl,--wrap,clock_gettime -Wl,--wrap,clock_set=
time -Wl,--wrap,clock_nanosleep -Wl,--wrap,nanosleep -Wl,--wrap,pthread_mut=
exattr_init -Wl,--wrap,pthread_mutexattr_destroy -Wl,--wrap,pthread_mutexat=
tr_gettype -Wl,--wrap,pthread_mutexattr_settype -Wl,--wrap,pthread_mutexatt=
r_getprotocol -Wl,--wrap,pthread_mutexattr_setprotocol -Wl,--wrap,pthread_m=
utexattr_getpshared -Wl,--wrap,pthread_mutexattr_setpshared -Wl,--wrap,pthr=
ead_mutex_init -Wl,--wrap,pthread_mutex_destroy -Wl,--wrap,pthread_mutex_lo=
ck -Wl,--wrap,pthread_mutex_trylock -Wl,--wrap,pthread_mutex_timedlock -Wl,=
--wrap,pthread_mutex_unlock -Wl,--wrap,pthread_condattr_init -Wl,--wrap,pth=
read_condattr_destroy -Wl,--wrap,pthread_condattr_getclock -Wl,--wrap,pthre=
ad_condattr_setclock -Wl,--wrap,pthread_condattr_getpshared -Wl,--wrap,pthr=
ead_condattr_setpshared -Wl,--wrap,pthread_cond_init -Wl,--wrap,pthread_con=
d_destroy -Wl,--wrap,pthread_cond_wait -Wl,--wrap,pthread_cond_timedwait -W=
l,--wrap,pthread_cond_signal -Wl,--wrap,pthread_cond_broadcast -Wl,--wrap,m=
q_open -Wl,--wrap,mq_close -Wl,--wrap,mq_unlink -Wl,--wrap,mq_getattr -Wl,-=
-wrap,mq_setattr -Wl,--wrap,mq_send -Wl,--wrap,mq_timedsend -Wl,--wrap,mq_r=
eceive -Wl,--wrap,mq_timedreceive -Wl,--wrap,mq_notify -Wl,--wrap,open -Wl,=
--wrap,socket -Wl,--wrap,close -Wl,--wrap,ioctl -Wl,--wrap,read -Wl,--wrap,=
write -Wl,--wrap,recvmsg -Wl,--wrap,sendmsg -Wl,--wrap,recvfrom -Wl,--wrap,=
sendto -Wl,--wrap,recv -Wl,--wrap,send -Wl,--wrap,getsockopt -Wl,--wrap,set=
sockopt -Wl,--wrap,bind -Wl,--wrap,connect -Wl,--wrap,listen -Wl,--wrap,acc=
ept -Wl,--wrap,getsockname -Wl,--wrap,getpeername -Wl,--wrap,shutdown -Wl,-=
-wrap,timer_create -Wl,--wrap,timer_delete -Wl,--wrap,timer_settime -Wl,--w=
rap,timer_getoverrun -Wl,--wrap,timer_gettime -Wl,--wrap,ftruncate -Wl,--wr=
ap,close -Wl,--wrap,shm_open -Wl,--wrap,shm_unlink -Wl,--wrap,mmap -Wl,--wr=
ap,munmap
<span style=3D"mso-spacerun: yes">&nbsp; </span>-L/usr/xenomai_arm-2.3.1/li=
b -lpthread_rt -lpthread -lrt<span style=3D"mso-spacerun: yes">&nbsp;&nbsp;=
 </span>essai_mutex_rt.o<span style=3D"mso-spacerun: yes">&nbsp;&nbsp; </sp=
an>-o essai_mutex_rt</font>
</p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">essai_mutex_rt.o: In function `affich&#39;:</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">/home/martignoni/Programme/Test/Essai_mutex_arm/essai_mutex.c:30: =
undefined reference to `__wrap_pthread_mutex_lock&#39;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">/home/martignoni/Programme/Test/Essai_mutex_arm/essai_mutex.c:37: =
undefined reference to `__wrap_pthread_mutex_unlock&#39;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">essai_mutex_rt.o: In function `cleanup_upon_sig&#39;:</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">/home/martignoni/Programme/Test/Essai_mutex_arm/essai_mutex.c:70: =
undefined reference to `__wrap_pthread_mutex_destroy&#39;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">essai_mutex_rt.o: In function `main&#39;:</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">/home/martignoni/Programme/Test/Essai_mutex_arm/essai_mutex.c:88: =
undefined reference to `__wrap_pthread_mutex_init&#39;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">/home/martignoni/Programme/Test/Essai_mutex_arm/essai_mutex.c:121:=
 undefined reference to `__wrap_pthread_create&#39;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">/home/martignoni/Programme/Test/Essai_mutex_arm/essai_mutex.c:124:=
 undefined reference to `__wrap_pthread_create&#39;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">collect2: ld returned 1 exit status</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">make: *** [essai_mutex_rt] Erreur 1</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">rm essai_mutex_rt.o</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"></font>&nbsp;</p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"></font>&nbsp;</p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">It would seem the problem is only with Posix.</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">In the directory /usr/xenomai_arm-2.3.1/lib, I have only static li=
brairies (.a, .la). Maybe it&#39;s the problem.</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"></font>&nbsp;</p></div>

------=_Part_22494_14142434.1178284501441--

