Message-ID: <7289437c0705300210n6c54b750sab11a005107e21b0@domain.hid>
Date: Wed, 30 May 2007 11:10:02 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <465D304D.6020606@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_441_14684544.1180516202119"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
	<1180360288.4727.50.camel@domain.hid>
	<7289437c0705290130k627df2f9j2940c509311c75c5@domain.hid>
	<465BE777.7010204@domain.hid>
	<7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>
	<465C6268.1090704@domain.hid>
	<18012.28254.882249.144005@domain.hid>
	<7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid>
	<7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>
	<465D304D.6020606@domain.hid>
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

------=_Part_441_14684544.1180516202119
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have reduced my code until this and it doesn't compile :


#include <pthread.h>

#include <stdlib.h>

#include <sys/mman.h>



void routine1 (void * cookie){

            int i=0;

            for(i=0;i<10;i++){

            }

}



int main(int argc, char **argv)

{

            int i = 0;

            int err;

            pthread_t task1;

            pthread_attr_t attr1;

            mlockall(MCL_CURRENT | MCL_FUTURE);

            err = pthread_create (&task1,&attr1,(void *)routine1,NULL);

exit;

}



I don't see what remove.

mlockall isn't the reason. I tried too.



On 5/30/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Perrine Martignoni wrote:
> > I compiled cyclictest with this command line and it works with no
> problem :
> >
> >
> > arm-linux-gcc -I/usr/xenomai_arm-2.3.1uClibc/include -I/usr/xenomai_arm-
> > 2.3.1uClibc/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__
> > -D__IN_XENO__ -Wstrict-prototypes -DIPIPE_TRACE=1 -g cyclictest.c -c -o
> > cyclictest.o
> >
> > arm-linux-gcc -Wl,--wrap,pthread_create -Wl,--wrap,pthread_setschedparam
> > -Wl,--wrap,pthread_getschedparam -Wl,--wrap,pthread_yield
> > -Wl,--wrap,sched_yield -Wl,--wrap,sem_init -Wl,--wrap,sem_destroy
> > -Wl,--wrap,sem_post -Wl,--wrap,sem_timedwait -Wl,--wrap,sem_wait
> > -Wl,--wrap,sem_trywait -Wl,--wrap,sem_getvalue -Wl,--wrap,sem_open
> > -Wl,--wrap,sem_close -Wl,--wrap,sem_unlink -Wl,--wrap,clock_getres
> > -Wl,--wrap,clock_gettime -Wl,--wrap,clock_settime
> > -Wl,--wrap,clock_nanosleep
> > -Wl,--wrap,nanosleep -Wl,--wrap,pthread_mutexattr_init
> > -Wl,--wrap,pthread_mutexattr_destroy
> -Wl,--wrap,pthread_mutexattr_gettype
> > -Wl,--wrap,pthread_mutexattr_settype
> > -Wl,--wrap,pthread_mutexattr_getprotocol
> > -Wl,--wrap,pthread_mutexattr_setprotocol
> > -Wl,--wrap,pthread_mutexattr_getpshared
> > -Wl,--wrap,pthread_mutexattr_setpshared -Wl,--wrap,pthread_mutex_init
> > -Wl,--wrap,pthread_mutex_destroy -Wl,--wrap,pthread_mutex_lock
> > -Wl,--wrap,pthread_mutex_trylock -Wl,--wrap,pthread_mutex_timedlock
> > -Wl,--wrap,pthread_mutex_unlock -Wl,--wrap,pthread_condattr_init
> > -Wl,--wrap,pthread_condattr_destroy -Wl,--wrap,pthread_condattr_getclock
> > -Wl,--wrap,pthread_condattr_setclock
> -Wl,--wrap,pthread_condattr_getpshared
> > -Wl,--wrap,pthread_condattr_setpshared -Wl,--wrap,pthread_cond_init
> > -Wl,--wrap,pthread_cond_destroy -Wl,--wrap,pthread_cond_wait
> > -Wl,--wrap,pthread_cond_timedwait -Wl,--wrap,pthread_cond_signal
> > -Wl,--wrap,pthread_cond_broadcast -Wl,--wrap,mq_open -Wl,--wrap,mq_close
> > -Wl,--wrap,mq_unlink -Wl,--wrap,mq_getattr -Wl,--wrap,mq_setattr
> > -Wl,--wrap,mq_send -Wl,--wrap,mq_timedsend -Wl,--wrap,mq_receive
> > -Wl,--wrap,mq_timedreceive -Wl,--wrap,mq_notify -Wl,--wrap,open
> > -Wl,--wrap,socket -Wl,--wrap,close -Wl,--wrap,ioctl -Wl,--wrap,read
> > -Wl,--wrap,write -Wl,--wrap,recvmsg -Wl,--wrap,sendmsg
> -Wl,--wrap,recvfrom
> > -Wl,--wrap,sendto -Wl,--wrap,recv -Wl,--wrap,send -Wl,--wrap,getsockopt
> > -Wl,--wrap,setsockopt -Wl,--wrap,bind -Wl,--wrap,connect
> -Wl,--wrap,listen
> > -Wl,--wrap,accept -Wl,--wrap,getsockname -Wl,--wrap,getpeername
> > -Wl,--wrap,shutdown -Wl,--wrap,timer_create -Wl,--wrap,timer_delete
> > -Wl,--wrap,timer_settime -Wl,--wrap,timer_getoverrun
> > -Wl,--wrap,timer_gettime -Wl,--wrap,ftruncate -Wl,--wrap,close
> > -Wl,--wrap,shm_open -Wl,--wrap,shm_unlink -Wl,--wrap,mmap
> -Wl,--wrap,munmap
> > -L/usr/xenomai_arm-2.3.1uClibc/lib cyclictest.o -lpthread_rt -lpthread
> -lrt
> > -o cyclictest
> >
> >
> >
> > I don't see the difference with my own test.
> > I try again with my code with this command line exactly and I have the
> same
> > error :
> >
> >
> > /usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to
> > `__wrap_mmap'
> >
> > /usr/src/ELDK_arm/usr/../arm/lib/librt.so: undefined reference
> > to`__wrap_close'
> >
> > /usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to
> > `__wrap_munmap'
> >
> > collect2: ld returned 1 exit status
> >
>
> I don't see the reason either. But as the compiled code seems to have an
> effect here, could you try to reduce your program until is builds fine?
> Maybe this will give us some more hints where to dig.
>
> Jan
>
>
>

------=_Part_441_14684544.1180516202119
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I have reduced my code until this and it doesn&#39;t compile : </div>
<div>&nbsp;</div>
<div>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;pthread.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;stdlib.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;sys/mman.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">&nbsp;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">void routine1 (void * cookie){</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>int i=0;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>for(i=0;i&lt;10;i++){<span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">}</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">&nbsp;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">int main(int argc, char **argv)</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">{</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>int i = 0; </font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>int err;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_t task1;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_t attr1;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>mlockall(MCL_CURRENT | MCL_FUTURE);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>err = pthread_create (&amp;task1,&amp;attr1,(void *)routine1,NULL);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">exit;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">}</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt">&nbsp;</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><font face="arial,sans-serif" size="2">I don&#39;t see <font face="arial,sans-serif">what</font></font></font><font face="arial,sans-serif"> remove. 
</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="arial,sans-serif">mlockall isn&#39;t the reason. I tried too.</font></p><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 5/30/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Perrine Martignoni wrote:<br>&gt; I compiled cyclictest with this command line and it works with no problem :
<br>&gt;<br>&gt;<br>&gt; arm-linux-gcc -I/usr/xenomai_arm-2.3.1uClibc/include -I/usr/xenomai_arm-<br>&gt; 2.3.1uClibc/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__<br>&gt; -D__IN_XENO__ -Wstrict-prototypes -DIPIPE_TRACE=1 -g 
cyclictest.c -c -o<br>&gt; cyclictest.o<br>&gt;<br>&gt; arm-linux-gcc -Wl,--wrap,pthread_create -Wl,--wrap,pthread_setschedparam<br>&gt; -Wl,--wrap,pthread_getschedparam -Wl,--wrap,pthread_yield<br>&gt; -Wl,--wrap,sched_yield -Wl,--wrap,sem_init -Wl,--wrap,sem_destroy
<br>&gt; -Wl,--wrap,sem_post -Wl,--wrap,sem_timedwait -Wl,--wrap,sem_wait<br>&gt; -Wl,--wrap,sem_trywait -Wl,--wrap,sem_getvalue -Wl,--wrap,sem_open<br>&gt; -Wl,--wrap,sem_close -Wl,--wrap,sem_unlink -Wl,--wrap,clock_getres
<br>&gt; -Wl,--wrap,clock_gettime -Wl,--wrap,clock_settime<br>&gt; -Wl,--wrap,clock_nanosleep<br>&gt; -Wl,--wrap,nanosleep -Wl,--wrap,pthread_mutexattr_init<br>&gt; -Wl,--wrap,pthread_mutexattr_destroy -Wl,--wrap,pthread_mutexattr_gettype
<br>&gt; -Wl,--wrap,pthread_mutexattr_settype<br>&gt; -Wl,--wrap,pthread_mutexattr_getprotocol<br>&gt; -Wl,--wrap,pthread_mutexattr_setprotocol<br>&gt; -Wl,--wrap,pthread_mutexattr_getpshared<br>&gt; -Wl,--wrap,pthread_mutexattr_setpshared -Wl,--wrap,pthread_mutex_init
<br>&gt; -Wl,--wrap,pthread_mutex_destroy -Wl,--wrap,pthread_mutex_lock<br>&gt; -Wl,--wrap,pthread_mutex_trylock -Wl,--wrap,pthread_mutex_timedlock<br>&gt; -Wl,--wrap,pthread_mutex_unlock -Wl,--wrap,pthread_condattr_init<br>
&gt; -Wl,--wrap,pthread_condattr_destroy -Wl,--wrap,pthread_condattr_getclock<br>&gt; -Wl,--wrap,pthread_condattr_setclock -Wl,--wrap,pthread_condattr_getpshared<br>&gt; -Wl,--wrap,pthread_condattr_setpshared -Wl,--wrap,pthread_cond_init
<br>&gt; -Wl,--wrap,pthread_cond_destroy -Wl,--wrap,pthread_cond_wait<br>&gt; -Wl,--wrap,pthread_cond_timedwait -Wl,--wrap,pthread_cond_signal<br>&gt; -Wl,--wrap,pthread_cond_broadcast -Wl,--wrap,mq_open -Wl,--wrap,mq_close
<br>&gt; -Wl,--wrap,mq_unlink -Wl,--wrap,mq_getattr -Wl,--wrap,mq_setattr<br>&gt; -Wl,--wrap,mq_send -Wl,--wrap,mq_timedsend -Wl,--wrap,mq_receive<br>&gt; -Wl,--wrap,mq_timedreceive -Wl,--wrap,mq_notify -Wl,--wrap,open<br>
&gt; -Wl,--wrap,socket -Wl,--wrap,close -Wl,--wrap,ioctl -Wl,--wrap,read<br>&gt; -Wl,--wrap,write -Wl,--wrap,recvmsg -Wl,--wrap,sendmsg -Wl,--wrap,recvfrom<br>&gt; -Wl,--wrap,sendto -Wl,--wrap,recv -Wl,--wrap,send -Wl,--wrap,getsockopt
<br>&gt; -Wl,--wrap,setsockopt -Wl,--wrap,bind -Wl,--wrap,connect -Wl,--wrap,listen<br>&gt; -Wl,--wrap,accept -Wl,--wrap,getsockname -Wl,--wrap,getpeername<br>&gt; -Wl,--wrap,shutdown -Wl,--wrap,timer_create -Wl,--wrap,timer_delete
<br>&gt; -Wl,--wrap,timer_settime -Wl,--wrap,timer_getoverrun<br>&gt; -Wl,--wrap,timer_gettime -Wl,--wrap,ftruncate -Wl,--wrap,close<br>&gt; -Wl,--wrap,shm_open -Wl,--wrap,shm_unlink -Wl,--wrap,mmap -Wl,--wrap,munmap<br>&gt; -L/usr/xenomai_arm-
2.3.1uClibc/lib cyclictest.o -lpthread_rt -lpthread -lrt<br>&gt; -o cyclictest<br>&gt;<br>&gt;<br>&gt;<br>&gt; I don&#39;t see the difference with my own test.<br>&gt; I try again with my code with this command line exactly and I have the same
<br>&gt; error :<br>&gt;<br>&gt;<br>&gt; /usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to<br>&gt; `__wrap_mmap&#39;<br>&gt;<br>&gt; /usr/src/ELDK_arm/usr/../arm/lib/librt.so: undefined reference<br>&gt; to`__wrap_close&#39;
<br>&gt;<br>&gt; /usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to<br>&gt; `__wrap_munmap&#39;<br>&gt;<br>&gt; collect2: ld returned 1 exit status<br>&gt;<br><br>I don&#39;t see the reason either. But as the compiled code seems to have an
<br>effect here, could you try to reduce your program until is builds fine?<br>Maybe this will give us some more hints where to dig.<br><br>Jan<br><br><br></blockquote></div><br>

------=_Part_441_14684544.1180516202119--

