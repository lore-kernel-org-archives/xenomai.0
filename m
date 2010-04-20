MIME-Version: 1.0
In-Reply-To: <1271697374.16659.156.camel@domain.hid>
References: <20100419190151.56913gdansdxkhvk@domain.hid>
	<1271697374.16659.156.camel@domain.hid>
Date: Tue, 20 Apr 2010 00:46:46 -0400
Message-ID: <g2tdd8925a51004192146m3dc41c1la59720974282b961@domain.hid>
From: Josh Bowman <jbowman@domain.hid>
Content-Type: multipart/alternative; boundary=0016e68eeeddcb2a5d0484a3c3e8
Subject: Re: [Xenomai-help] RT_QUEUE problem in Sender/Receiver order
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Michel He <michel.he@domain.hid>

--0016e68eeeddcb2a5d0484a3c3e8
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I'm reluctant to jump in here with my own notably limited psychic powers,
but I did notice that the code given spawns the receiving tasks before it
creates the queues that they receive from.  This would create a race
condition (if a STD_PRIO task can preempt the task that's doing the
initialization.)

-Josh

On Mon, Apr 19, 2010 at 1:16 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Mon, 2010-04-19 at 19:01 +0200, Michel He wrote:
> >
> >       err = rt_task_spawn(&test_task2_ptr, "Recep2", STACK_SIZE,
> STD_PRIO,
> > 0, &testtask2, NULL);
> >       if (err) {
> >               rt_printf("error rt_task_spawn 2\n");
> >               return 0;
> >       }
> >       recvTask[nrecvhost]=&test_task2_ptr;
> >
> >       err =
> > rt_queue_create(&(recvCanal[nrecvhost]),"Recep2CANAL",MAX_MESSAGE_LENGTH,
> > QUEUE_LIM, Q_FIFO);
> >
> >       if (err) {
> >               rt_printf("error RT_canal_create 2 \n");
> >               return 0;
> >       }
> >       nrecvhost++;
> >
> >
> >       err = rt_task_spawn(&test_task3_ptr, "Recep3", STACK_SIZE,
> STD_PRIO,
> > 0, &testtask3, NULL);
> >       if (err) {
> >               rt_printf("error rt_task_spawn 3\n");
> >               return 0;
> >       }
> >       recvTask[nrecvhost]=&test_task3_ptr;
> >
> >       err =
> > rt_queue_create(&(recvCanal[nrecvhost]),"Recep3CANAL",MAX_MESSAGE_LENGTH,
> > QUEUE_LIM, Q_FIFO);
> >
> >       if (err) {
> >               rt_printf("error RT_canal_create 2 \n");
> >               return 0;
> >
> >       }
> >       nrecvhost++;
> >
> >
> >       err = rt_task_spawn(&test_task_ptr, "Sender", STACK_SIZE, STD_PRIO,
> > 0, &testtask, NULL);
> >       if (err) {
> >               rt_printf("error rt_task_spawn\n");
> >               return 0;
> >       }
> >       recvTask[nrecvhost]=&test_task_ptr;
> >       nrecvhost++;
> >
> >
> >
> > testtask2()
> > {
> > ...
> >
> rcbytes=RT_queue_read(&(recvCanal[0]),&rcvmsg,sizeof(rcvmsg),TM_INFINITE);
> > }
> >
> >
> > testtask3()
> > {
> > ...
> >
> rcbytes=RT_queue_read(&(recvCanal[1]),&rcvmsg,sizeof(rcvmsg),TM_INFINITE);
> > }
> >
>

--0016e68eeeddcb2a5d0484a3c3e8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I&#39;m reluctant to jump in here with my own notably limited ps=
ychic powers, but I did notice that the code given spawns the receiving tas=
ks before it creates the queues that they receive from.=A0 This would creat=
e a race condition (if  a STD_PRIO task can preempt  the task that&#39;s do=
ing the initialization.)<br>
<br>-Josh<br><br><div class=3D"gmail_quote">On Mon, Apr 19, 2010 at 1:16 PM=
, Philippe Gerum <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">r=
pm@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
<div class=3D"im">On Mon, 2010-04-19 at 19:01 +0200, Michel He wrote:<br></=
div><div><div class=3D"h5">&gt;<br>
&gt; =A0 =A0 =A0 err =3D rt_task_spawn(&amp;test_task2_ptr, &quot;Recep2&qu=
ot;, STACK_SIZE, STD_PRIO,<br>
&gt; 0, &amp;testtask2, NULL);<br>
&gt; =A0 =A0 =A0 if (err) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt_printf(&quot;error rt_task_spawn 2\n&qu=
ot;);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 recvTask[nrecvhost]=3D&amp;test_task2_ptr;<br>
&gt;<br>
&gt; =A0 =A0 =A0 err =3D<br>
&gt; rt_queue_create(&amp;(recvCanal[nrecvhost]),&quot;Recep2CANAL&quot;,MA=
X_MESSAGE_LENGTH,<br>
&gt; QUEUE_LIM, Q_FIFO);<br>
&gt;<br>
&gt; =A0 =A0 =A0 if (err) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt_printf(&quot;error RT_canal_create 2 \n=
&quot;);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 nrecvhost++;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 err =3D rt_task_spawn(&amp;test_task3_ptr, &quot;Recep3&qu=
ot;, STACK_SIZE, STD_PRIO,<br>
&gt; 0, &amp;testtask3, NULL);<br>
&gt; =A0 =A0 =A0 if (err) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt_printf(&quot;error rt_task_spawn 3\n&qu=
ot;);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 recvTask[nrecvhost]=3D&amp;test_task3_ptr;<br>
&gt;<br>
&gt; =A0 =A0 =A0 err =3D<br>
&gt; rt_queue_create(&amp;(recvCanal[nrecvhost]),&quot;Recep3CANAL&quot;,MA=
X_MESSAGE_LENGTH,<br>
&gt; QUEUE_LIM, Q_FIFO);<br>
&gt;<br>
&gt; =A0 =A0 =A0 if (err) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt_printf(&quot;error RT_canal_create 2 \n=
&quot;);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
&gt;<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 nrecvhost++;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 err =3D rt_task_spawn(&amp;test_task_ptr, &quot;Sender&quo=
t;, STACK_SIZE, STD_PRIO,<br>
&gt; 0, &amp;testtask, NULL);<br>
&gt; =A0 =A0 =A0 if (err) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt_printf(&quot;error rt_task_spawn\n&quot=
;);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 recvTask[nrecvhost]=3D&amp;test_task_ptr;<br>
&gt; =A0 =A0 =A0 nrecvhost++;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; testtask2()<br>
&gt; {<br>
&gt; ...<br>
&gt; rcbytes=3DRT_queue_read(&amp;(recvCanal[0]),&amp;rcvmsg,sizeof(rcvmsg)=
,TM_INFINITE);<br>
&gt; }<br>
&gt;<br>
&gt;<br>
&gt; testtask3()<br>
&gt; {<br>
&gt; ...<br>
&gt; rcbytes=3DRT_queue_read(&amp;(recvCanal[1]),&amp;rcvmsg,sizeof(rcvmsg)=
,TM_INFINITE);<br>
&gt; }<br>
&gt;<br></div></div></blockquote></div><br>

--0016e68eeeddcb2a5d0484a3c3e8--

