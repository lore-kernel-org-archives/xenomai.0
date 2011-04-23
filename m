MIME-Version: 1.0
Date: Sat, 23 Apr 2011 17:17:06 -0400
Message-ID: <BANLkTim3Z6v5Jr+O8197WZZAOpHsPwjwPA@mail.gmail.com>
From: Eric Eric <ericrebates@domain.hid>
Content-Type: multipart/alternative; boundary=001517447c82194d6104a19c7f3c
Subject: [Xenomai-help] FAQ, context switch latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--001517447c82194d6104a19c7f3c
Content-Type: text/plain; charset=ISO-8859-1

Hello, I've asked a lot of questions here and gotten very prompt and helpful
responses, so I summarized them in a FAQ since I figure others may have
similar questions.  See http://ericrebates.zzl.org/xen_faq.txt .  If this
seems useful maybe someone can append them to the end of the wiki FAQ.

On another note, I have been comparing Xenomai's context switch latency to
GHS Integrity.  I found that on average Xenomai seems to take three times as
long to context switch versus Integrity (12uS vs. 4uS) running almost
identical test code.  Does anyone know why this may be or how to reduce this
latency in Xenomai?  Since it appears Gilles helped implement the fast
context switching extension for the Linux kernel, I'm assuming Xenomai is
also taking advantage of this extension.

Below is the code I used in Xenomai to do the kernel context switch test.
This function is the entry point for two threads, one serving as the
producer and the other the consumer.  I am using FIFO scheduling and the
consumer thread has higher priority than the sender.  The Integrity code is
almost identical.

static void *ksemQTaskFcn(void *arg)
{
    int ct;
   kthreadctx_t *myCtx = (kthreadctx_t *)arg;

   init_times(&myCtx->times);

   /* Wait for real-time ioctl to broadcast start */
   TM_CHECK_CALL(rt_sem_p(&mySem, TM_INFINITE));

   for(ct = 0; ct < myCtx->loops; ct++) {
     if (myCtx->mode) { // Sender...
        globalStartTime = rtdm_clock_read_monotonic();
       TM_CHECK_CALL(rt_sem_v(&mySem));
      } else { // Receiver...
       RTIME end_time;
        TM_CHECK_CALL(rt_sem_p(&mySem, TM_INFINITE));
       end_time = rtdm_clock_read_monotonic();
        update_times(&myCtx->times, end_time - globalStartTime);
     }
    }

    if (!myCtx->mode) {
     myCtx->times.ave_time = slldiv(myCtx->times.ave_time, myCtx->loops);
      pthread_exit(&myCtx->times); // Safe, myCtx is global
   }

   pthread_exit(NULL);
   return(NULL); // Not reached.
}

As usual, thanks for any assistance.

- Eric

--001517447c82194d6104a19c7f3c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello, I&#39;ve asked a lot of questions here and gotten very prompt and he=
lpful responses, so I summarized them in a FAQ since I figure others may ha=
ve similar questions.=A0 See <a href=3D"http://ericrebates.zzl.org/xen_faq.=
txt">http://ericrebates.zzl.org/xen_faq.txt</a> .=A0 If this seems useful m=
aybe someone can append them to the end of the wiki FAQ.<br>
<br>On another note, I have been comparing Xenomai&#39;s context switch lat=
ency to GHS Integrity.=A0 I found that on average Xenomai seems to take thr=
ee times as long to context switch versus Integrity (12uS vs. 4uS) running =
almost identical test code.=A0 Does anyone know why this may be or how to r=
educe this latency in Xenomai?=A0 Since it appears Gilles helped implement =
the fast context switching extension for the Linux kernel, I&#39;m assuming=
 Xenomai is also taking advantage of this extension.<br>
<br>Below is the code I used in Xenomai to do the kernel context switch tes=
t.=A0 This function is the entry point for two threads, one serving as the =
producer and the other the consumer.=A0 I am using FIFO scheduling and the =
consumer thread has higher priority than the sender.=A0 The Integrity code =
is almost identical.<br>
<span style=3D"font-family: courier new,monospace;"><br>static void *ksemQT=
askFcn(void *arg)</span><br style=3D"font-family: courier new,monospace;"><=
span style=3D"font-family: courier new,monospace;">{</span><br style=3D"fon=
t-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;"> =A0 =A0int ct;</span><=
br style=3D"font-family: courier new,monospace;"><span style=3D"font-family=
: courier new,monospace;"> =A0 =A0kthreadctx_t *myCtx =3D (kthreadctx_t *)a=
rg;</span><br style=3D"font-family: courier new,monospace;">

<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;"> =A0 =A0init_times(&amp;myCtx-&gt;times);</span>=
<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;"></span><br style=3D"font-family: courier new,mon=
ospace;">
<span style=3D"font-family: courier new,monospace;"> =A0 =A0/* Wait for rea=
l-time ioctl to broadcast start */</span><br style=3D"font-family: courier =
new,monospace;"><span style=3D"font-family: courier new,monospace;"> =A0 =
=A0TM_CHECK_CALL(rt_sem_p(&amp;mySem, TM_INFINITE));</span><br style=3D"fon=
t-family: courier new,monospace;">

<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;"> =A0 =A0for(ct =3D 0; ct &lt; myCtx-&gt;loops; c=
t++) {</span><br style=3D"font-family: courier new,monospace;"><span style=
=3D"font-family: courier new,monospace;"> =A0 =A0 =A0if (myCtx-&gt;mode) { =
// Sender...</span><br style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;"> =A0 =A0 =A0 =A0globalS=
tartTime =3D rtdm_clock_read_monotonic();</span><br style=3D"font-family: c=
ourier new,monospace;"><span style=3D"font-family: courier new,monospace;">=
 =A0 =A0 =A0 =A0TM_CHECK_CALL(rt_sem_v(&amp;mySem));</span><br style=3D"fon=
t-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;"> =A0 =A0 =A0} else { //=
 Receiver...</span><br style=3D"font-family: courier new,monospace;"><span =
style=3D"font-family: courier new,monospace;"> =A0 =A0 =A0 =A0RTIME end_tim=
e;</span><br style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;"> =A0 =A0 =A0 =A0TM_CHEC=
K_CALL(rt_sem_p(&amp;mySem, TM_INFINITE));</span><br style=3D"font-family: =
courier new,monospace;"><span style=3D"font-family: courier new,monospace;"=
> =A0 =A0 =A0 =A0end_time =3D rtdm_clock_read_monotonic();</span><br style=
=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;"> =A0 =A0 =A0 =A0update_=
times(&amp;myCtx-&gt;times, end_time - globalStartTime);</span><br style=3D=
"font-family: courier new,monospace;"><span style=3D"font-family: courier n=
ew,monospace;"> =A0 =A0 =A0}</span><br style=3D"font-family: courier new,mo=
nospace;">

<span style=3D"font-family: courier new,monospace;"> =A0 =A0}</span><br sty=
le=3D"font-family: courier new,monospace;"><br style=3D"font-family: courie=
r new,monospace;">
<span style=3D"font-family: courier new,monospace;"> =A0 =A0if (!myCtx-&gt;=
mode) {</span><br style=3D"font-family: courier new,monospace;"><span style=
=3D"font-family: courier new,monospace;"> =A0 =A0 =A0myCtx-&gt;times.ave_ti=
me =3D slldiv(myCtx-&gt;times.ave_time, myCtx-&gt;loops);</span><br style=
=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;"> =A0 =A0 =A0pthread_exi=
t(&amp;myCtx-&gt;times); // Safe, myCtx is global</span><br style=3D"font-f=
amily: courier new,monospace;"><span style=3D"font-family: courier new,mono=
space;"> =A0 =A0}</span><br style=3D"font-family: courier new,monospace;">

<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;"> =A0 =A0pthread_exit(NULL);</span><br style=3D"f=
ont-family: courier new,monospace;"><span style=3D"font-family: courier new=
,monospace;"> =A0 =A0return(NULL); // Not reached.</span><br style=3D"font-=
family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">}<br></span><br>As usua=
l, thanks for any assistance.<br><br>- Eric<br>

--001517447c82194d6104a19c7f3c--

