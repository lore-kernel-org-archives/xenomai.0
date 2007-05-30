Message-ID: <7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>
Date: Wed, 30 May 2007 09:51:17 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_678_8710932.1180511477321"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
	<465ADB44.2070705@domain.hid> <1180360288.4727.50.camel@domain.hid>
	<7289437c0705290130k627df2f9j2940c509311c75c5@domain.hid>
	<465BE777.7010204@domain.hid>
	<7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>
	<465C6268.1090704@domain.hid>
	<18012.28254.882249.144005@domain.hid>
	<7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid>
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
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

------=_Part_678_8710932.1180511477321
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I compiled cyclictest with this command line and it works with no problem :


arm-linux-gcc -I/usr/xenomai_arm-2.3.1uClibc/include -I/usr/xenomai_arm-
2.3.1uClibc/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__
-D__IN_XENO__ -Wstrict-prototypes -DIPIPE_TRACE=1 -g cyclictest.c -c -o
cyclictest.o

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
-L/usr/xenomai_arm-2.3.1uClibc/lib cyclictest.o -lpthread_rt -lpthread -lrt
-o cyclictest



I don't see the difference with my own test.
I try again with my code with this command line exactly and I have the same
error :


/usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to
`__wrap_mmap'

/usr/src/ELDK_arm/usr/../arm/lib/librt.so: undefined reference
to`__wrap_close'

/usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to
`__wrap_munmap'

collect2: ld returned 1 exit status


On 5/30/07, Perrine Martignoni <perrmart@domain.hid> wrote:
>
> >Could you show us the compilation command used to compile cyclictest or
> switchtest ?
>
> I didn't try to compile myself these tests. I thought they were compiled
> when I installed Xenomai and put in /xenomai/bin
>
> I'll try to do it myself.
>
>
> On 5/29/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org >
> wrote:
> >
> > Jan Kiszka wrote:
> > > Perrine Martignoni wrote:
> > > ...
> > > > -Wl,--wrap,close -Wl,--wrap,shm_open -Wl,--wrap,shm_unlink
> > -Wl,--wrap,mmap
> > > > -Wl,--wrap,munmap -L/usr/xenomai_arm-2.3.1uClibc/lib
> > essai_mutex_rt.o
> > > > -lpthread_rt -lpthread -lrt -o essai_mutex_rt
> > >
> > > I think to remember the ordering makes a difference here: Try to put
> > > essai_mutex_rt.o after the libs. That's also what happens when using
> > the
> > > Xenomai provided flags.
> >
> > Yes, the order matters, but essai_mutex_rt.o should be before the
> > libraries. Xenomai makefiles pass libraries in the LDADD variable, which
> >
> > is put at the very end of the compilation command line.
> >
> > >
> > > Apropos: Use `<xenomai-installation-path>/xeno-config --posix-ldflags`
> > > (also for --posix-cflags) to make your life easier. There is generally
> >
> > > no need to maintain all the flags on your own - and it's error-prone.
> >
> > I thought that what Perrine showed us was the result of running make and
> > that her makefiles really used xeno-config.
> >
> > --
> >
> >
> >                                             Gilles Chanteperdrix.
> >
>
>

------=_Part_678_8710932.1180511477321
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>I compiled cyclictest with this command line and it works with no prob=
lem : </div>
<div>&nbsp;</div>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><span style=3D"mso-bid=
i-font-family: &#39;Luxi Sans&#39;; mso-bidi-language: #00FF"><font face=3D=
"Times New Roman"><font size=3D"2">arm-linux-gcc -I/usr/xenomai_arm-2.3.1uC=
libc/include -I/usr/xenomai_arm-
2.3.1uClibc/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -D__IN_XENO=
__ -Wstrict-prototypes -DIPIPE_TRACE=3D1 -g cyclictest.c -c -o cyclictest.o=
</font></font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><span style=3D"mso-bid=
i-font-family: &#39;Luxi Sans&#39;; mso-bidi-language: #00FF"><font face=3D=
"Times New Roman"><font size=3D"2">arm-linux-gcc -Wl,--wrap,pthread_create =
-Wl,--wrap,pthread_setschedparam -Wl,--wrap,pthread_getschedparam -Wl,--wra=
p,pthread_yield -Wl,--wrap,sched_yield -Wl,--wrap,sem_init -Wl,--wrap,sem_d=
estroy -Wl,--wrap,sem_post -Wl,--wrap,sem_timedwait -Wl,--wrap,sem_wait -Wl=
,--wrap,sem_trywait -Wl,--wrap,sem_getvalue -Wl,--wrap,sem_open -Wl,--wrap,=
sem_close -Wl,--wrap,sem_unlink -Wl,--wrap,clock_getres -Wl,--wrap,clock_ge=
ttime -Wl,--wrap,clock_settime -Wl,--wrap,clock_nanosleep -Wl,--wrap,nanosl=
eep -Wl,--wrap,pthread_mutexattr_init -Wl,--wrap,pthread_mutexattr_destroy =
-Wl,--wrap,pthread_mutexattr_gettype -Wl,--wrap,pthread_mutexattr_settype -=
Wl,--wrap,pthread_mutexattr_getprotocol -Wl,--wrap,pthread_mutexattr_setpro=
tocol -Wl,--wrap,pthread_mutexattr_getpshared -Wl,--wrap,pthread_mutexattr_=
setpshared -Wl,--wrap,pthread_mutex_init -Wl,--wrap,pthread_mutex_destroy -=
Wl,--wrap,pthread_mutex_lock -Wl,--wrap,pthread_mutex_trylock -Wl,--wrap,pt=
hread_mutex_timedlock -Wl,--wrap,pthread_mutex_unlock -Wl,--wrap,pthread_co=
ndattr_init -Wl,--wrap,pthread_condattr_destroy -Wl,--wrap,pthread_condattr=
_getclock -Wl,--wrap,pthread_condattr_setclock -Wl,--wrap,pthread_condattr_=
getpshared -Wl,--wrap,pthread_condattr_setpshared -Wl,--wrap,pthread_cond_i=
nit -Wl,--wrap,pthread_cond_destroy -Wl,--wrap,pthread_cond_wait -Wl,--wrap=
,pthread_cond_timedwait -Wl,--wrap,pthread_cond_signal -Wl,--wrap,pthread_c=
ond_broadcast -Wl,--wrap,mq_open -Wl,--wrap,mq_close -Wl,--wrap,mq_unlink -=
Wl,--wrap,mq_getattr -Wl,--wrap,mq_setattr -Wl,--wrap,mq_send -Wl,--wrap,mq=
_timedsend -Wl,--wrap,mq_receive -Wl,--wrap,mq_timedreceive -Wl,--wrap,mq_n=
otify -Wl,--wrap,open -Wl,--wrap,socket -Wl,--wrap,close -Wl,--wrap,ioctl -=
Wl,--wrap,read -Wl,--wrap,write -Wl,--wrap,recvmsg -Wl,--wrap,sendmsg -Wl,-=
-wrap,recvfrom -Wl,--wrap,sendto -Wl,--wrap,recv -Wl,--wrap,send -Wl,--wrap=
,getsockopt -Wl,--wrap,setsockopt -Wl,--wrap,bind -Wl,--wrap,connect -Wl,--=
wrap,listen -Wl,--wrap,accept -Wl,--wrap,getsockname -Wl,--wrap,getpeername=
 -Wl,--wrap,shutdown -Wl,--wrap,timer_create -Wl,--wrap,timer_delete -Wl,--=
wrap,timer_settime -Wl,--wrap,timer_getoverrun -Wl,--wrap,timer_gettime -Wl=
,--wrap,ftruncate -Wl,--wrap,close -Wl,--wrap,shm_open -Wl,--wrap,shm_unlin=
k -Wl,--wrap,mmap -Wl,--wrap,munmap -L/usr/xenomai_arm-
2.3.1uClibc/lib cyclictest.o -lpthread_rt -lpthread -lrt -o cyclictest</fon=
t></font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><span style=3D"mso-bid=
i-font-family: &#39;Luxi Sans&#39;; mso-bidi-language: #00FF"><font face=3D=
"Times New Roman"><font size=3D"2"></font></font></span>&nbsp;</p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><span style=3D"mso-bid=
i-font-family: &#39;Luxi Sans&#39;; mso-bidi-language: #00FF"><font><font f=
ace=3D"" size=3D"2">I don&#39;t see the difference with my own test.</font>=
</font>
</span></p>
<div>I try again with my code with this command line exactly and I have the=
 same error : </div>
<div>&nbsp;</div>
<div>
<p style=3D"MARGIN: 0cm 0cm 0pt"><span><font face=3D"Times New Roman" color=
=3D"#000000">/usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined refe=
rence to `__wrap_mmap&#39; </font></span></p>
<p style=3D"MARGIN: 0cm 0cm 0pt"><span><font face=3D"Times New Roman" color=
=3D"#000000">/usr/src/ELDK_arm/usr/../arm/lib/librt.so: undefined reference=
 to`__wrap_close&#39; </font></span></p>
<p style=3D"MARGIN: 0cm 0cm 0pt"><span><font face=3D"Times New Roman" color=
=3D"#000000">/usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined refe=
rence to `__wrap_munmap&#39; </font></span></p><span class=3D"q">
<p style=3D"MARGIN: 0cm 0cm 0pt"><span><font face=3D"Times New Roman" color=
=3D"#000000">collect2: ld returned 1 exit status</font></span></p></span><b=
r>&nbsp;</div>
<div><span class=3D"gmail_quote">On 5/30/07, <b class=3D"gmail_sendername">=
Perrine Martignoni</b> &lt;<a href=3D"mailto:perrmart@domain.hid">perrmart@domain.hid=
mail.com</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><span class=3D"q">&gt;Could you =
show us the compilation command used to compile cyclictest or<br>switchtest=
 ?
<br><br></span>I didn&#39;t try to compile myself these tests. I thought th=
ey were compiled when I installed Xenomai and put in /xenomai/bin <br><br>I=
&#39;ll try to do it myself.<br><br><br>
<div><span class=3D"q"><span class=3D"gmail_quote">On 5/29/07, <b class=3D"=
gmail_sendername">Gilles Chanteperdrix</b> &lt;<a onclick=3D"return top.js.=
OpenExtLink(window,event,this)" href=3D"mailto:gilles.chanteperdrix@xenomai.org=
.net" target=3D"_blank">
gilles.chanteperdrix@xenomai.org </a>&gt; wrote:</span></span>=20
<div><span class=3D"e" id=3D"q_112db8fd52324251_3">
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0=
pt 0pt 0.8ex; BORDER-LEFT: rgb(204,204,204) 1px solid">Jan Kiszka wrote:<br=
>&gt; Perrine Martignoni wrote:<br>&gt; ...<br>&gt; &gt; -Wl,--wrap,close -=
Wl,--wrap,shm_open -Wl,--wrap,shm_unlink -Wl,--wrap,mmap=20
<br>&gt; &gt; -Wl,--wrap,munmap -L/usr/xenomai_arm-2.3.1uClibc/lib essai_mu=
tex_rt.o<br>&gt; &gt; -lpthread_rt -lpthread -lrt -o essai_mutex_rt<br>&gt;=
<br>&gt; I think to remember the ordering makes a difference here: Try to p=
ut=20
<br>&gt; essai_mutex_rt.o after the libs. That&#39;s also what happens when=
 using the<br>&gt; Xenomai provided flags.<br><br>Yes, the order matters, b=
ut essai_mutex_rt.o should be before the<br>libraries. Xenomai makefiles pa=
ss libraries in the LDADD variable, which=20
<br>is put at the very end of the compilation command line.<br><br>&gt;<br>=
&gt; Apropos: Use `&lt;xenomai-installation-path&gt;/xeno-config --posix-ld=
flags`<br>&gt; (also for --posix-cflags) to make your life easier. There is=
 generally=20
<br>&gt; no need to maintain all the flags on your own - and it&#39;s error=
-prone.<br><br>I thought that what Perrine showed us was the result of runn=
ing make and<br>that her makefiles really used xeno-config.<br><br>--<br>
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.<br></b=
lockquote></span></div></div><br></blockquote></div><br>

------=_Part_678_8710932.1180511477321--

