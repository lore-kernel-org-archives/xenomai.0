MIME-Version: 1.0
Date: Fri, 30 Apr 2010 16:39:05 +0200
Message-ID: <x2qa2d86cab1004300739z5dffe340o7df607e1dc2ec189@domain.hid>
From: Leyrit Vincent <sec.leyrit@domain.hid>
Content-Type: multipart/alternative; boundary=00151747b46e7dfef00485753464
Subject: [Xenomai-help] help with porting simple posix application
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

--00151747b46e7dfef00485753464
Content-Type: text/plain; charset=ISO-8859-1

Hello,

i would like to port a POSIX application on XENOMAI ..
i have try a very simple test to verify the xenomai functionnalities ...
a thread call a recursive funtion which call clock_gettime() ...
this thread is set with a SCHED_FIFO and has a priority of 10 ...

the binary is well linked with the xenomail pthread_rt library (in makefile
i have used xeno-config with posix sking and cflags / ldflags)

when i execute the binary , i take a look on the /proc/xenomai/sched and i
see that my thread is set as X 'related shadow'
i think it is a problem? For my opinion the flag show that my thread swich
many time from the Xenomai domain to the Linux domain ...

Does someone can help me if my simple code is false?
Thanks for help...

Alexandre... (xenomai )

xeno-info : xenomai 2.5.2 (kernel 2.6.32.11 | ipipe 2.6-03)

CODE -----------------------------------------------------------------------

int recursive_method(int cp)
{
  struct timeval ta;
  struct timespec ts_start, ts_end;

  if(cp < n_recurs)
    {
      for(int i=0; i < 10;i++)
        {
          clock_gettime(CLOCK_REALTIME,&ts_start);
          xnprintf("%d\n", ts_start.tv_nsec);
        }
      recursive_method(cp++);
    }
}


void *producer(void *)
{
  recursive_method(1);
  return 0;
}

int xeno_user_init()
{
  struct sched_param parm;
  pthread_attr_t attr;
  int rc = 0, fd = -1;
  struct sigevent evt;

  pthread_attr_init(&attr);
  pthread_attr_setinheritsched(&attr, 1);
  pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
  parm.sched_priority = 10;
  pthread_attr_setschedparam(&attr, &parm);

  rc = pthread_create(&producer_task, &attr, &producer, NULL);

  if (rc)
    {
      xnprintf("pthread_create(producer_task): %d\n", rc);
    }
  return rc;
}

int main (int ac, char *av[])
{
  int rc, sig;
  mlockall(MCL_CURRENT|MCL_FUTURE);

  rc = xeno_user_init();
  return 0;
}

CODE -----------------------------------------------------------------------

--00151747b46e7dfef00485753464
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>i would like to port a POSIX application on XENOMAI ..<br>i h=
ave try a very simple test to verify the xenomai functionnalities ...<br>a =
thread call a recursive funtion which call clock_gettime() ...<br>this thre=
ad is set with a SCHED_FIFO and has a priority of 10 ...<br>
<br>the binary is well linked with the xenomail pthread_rt library (in make=
file i have used xeno-config with posix sking and cflags / ldflags)<br><br>=
when i execute the binary , i take a look on the /proc/xenomai/sched and i =
see that my thread is set as X &#39;related shadow&#39;<br>
i think it is a problem? For my opinion the flag show that my thread swich =
many time from the Xenomai domain to the Linux domain ...<br><br>Does someo=
ne can help me if my simple code is false?<br>Thanks for help...<br><br>
Alexandre... (xenomai )<br><br>xeno-info : xenomai 2.5.2 (kernel 2.6.32.11 =
| ipipe 2.6-03)<br><br>CODE -----------------------------------------------=
------------------------<br><br>int recursive_method(int cp)<br>{<br>=A0 st=
ruct timeval ta;<br>
=A0 struct timespec ts_start, ts_end;<br><br>=A0 if(cp &lt; n_recurs)<br>=
=A0=A0=A0 {<br>=A0=A0=A0=A0=A0 for(int i=3D0; i &lt; 10;i++)<br>=A0=A0=A0=
=A0=A0=A0=A0 {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0 clock_gettime(CLOCK_REALTIME,=
&amp;ts_start);<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0 xnprintf(&quot;%d\n&quot;, t=
s_start.tv_nsec);<br>
=A0=A0=A0=A0=A0=A0=A0 }<br>=A0=A0=A0=A0=A0 recursive_method(cp++);<br>=A0=
=A0=A0 }<br>}<br><br><br>void *producer(void *)<br>{<br>=A0 recursive_metho=
d(1);<br>=A0 return 0;<br>}<br><br>int xeno_user_init()<br>{<br>=A0 struct =
sched_param parm;<br>=A0 pthread_attr_t attr;<br>
=A0 int rc =3D 0, fd =3D -1;<br>=A0 struct sigevent evt;<br><br>=A0 pthread=
_attr_init(&amp;attr);<br>=A0 pthread_attr_setinheritsched(&amp;attr, 1);<b=
r>=A0 pthread_attr_setschedpolicy(&amp;attr, SCHED_FIFO);<br>=A0 parm.sched=
_priority =3D 10;<br>
=A0 pthread_attr_setschedparam(&amp;attr, &amp;parm);<br><br>=A0 rc =3D pth=
read_create(&amp;producer_task, &amp;attr, &amp;producer, NULL);<br><br>=A0=
 if (rc)<br>=A0=A0=A0 {<br>=A0=A0=A0=A0=A0 xnprintf(&quot;pthread_create(pr=
oducer_task): %d\n&quot;, rc);<br>
=A0=A0=A0 }<br>=A0 return rc;<br>}<br><br>int main (int ac, char *av[])<br>=
{<br>=A0 int rc, sig;<br>=A0 mlockall(MCL_CURRENT|MCL_FUTURE);<br><br>=A0 r=
c =3D xeno_user_init();<br>=A0 return 0;<br>}<br><br>CODE -----------------=
------------------------------------------------------<br>
<br>

--00151747b46e7dfef00485753464--

