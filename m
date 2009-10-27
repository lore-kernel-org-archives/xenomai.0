MIME-Version: 1.0
Date: Tue, 27 Oct 2009 15:13:46 +0600
Message-ID: <64f64b850910270213t71bf2ef0me92ce285df82e6e0@domain.hid>
From: Dmitry Romannikov <rom2006@domain.hid>
Content-Type: multipart/alternative; boundary=0016364166d17228200476e718dd
Subject: [Xenomai-help] help
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

--0016364166d17228200476e718dd
Content-Type: text/plain; charset=ISO-8859-1

Hello!

I have problem with binding xenomai's queue. I created queue at the kernal
space with Q_SHARED flag and binded queue at user space.

static int __init sample_module_init(void)
{
 int err;
  printk(KERN_DEBUG "init sample module device\n");
 err=rt_queue_create(&QUEUE,"Queue_msg1",1024*20,Q_UNLIMITED,Q_SHARED|Q_DMA);
 printk(KERN_DEBUG "err=%i\n",err);
 return 0;
}
and it was created correctly: err=0 and at
/proc/xenomai/registry/native/queues derictory was queue's name.

but I cannot bind queue from user space.

int main() {
 cl_err err;
 //CIniFile ini;
 int ret1,ret2,itmp=1;
 msgbuff q;
 char asd[50];

 //mlockall(MCL_CURRENT|MCL_FUTURE);

 //tasks
 rt_task_create(&Cycle1, "cycle1", 0, 90, 0);
 rt_task_create(&Cycle2, "cycle2", 0, 91, 0);

ret1=rt_queue_bind(&MsgQue1_2,"Queue_msg1",TM_INFINITE);
printf("ret=%d:%s",ret1,strerror(-ret1));

....

rt_queue_bind returns -12:cannot alocate memory.

I tried change flags and execute code from rt_task or from main.

Does anyone have similarly problem or know problem-solving?
xenomai version: 2.4.7
platform: blackfin bf537
os: uclinux
--
Dmitry Romannikov

--0016364166d17228200476e718dd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello!<br><br>I have problem with binding xenomai&#39;s queue. I created qu=
eue at the kernal space with Q_SHARED flag and binded queue at user space.<=
br><br>static int __init sample_module_init(void)<br>{<br>=A0int err;<br>=
=A0 printk(KERN_DEBUG &quot;init sample module device\n&quot;);<br>
=A0err=3Drt_queue_create(&amp;QUEUE,&quot;Queue_msg1&quot;,1024*20,Q_UNLIMI=
TED,Q_SHARED|Q_DMA);<br>=A0printk(KERN_DEBUG &quot;err=3D%i\n&quot;,err);<b=
r>=A0return 0;<br>}<br>and it was created correctly: err=3D0 and at /proc/x=
enomai/registry/native/queues derictory was queue&#39;s name.<br>
<br>but I cannot bind queue from user space.<br><br>int main() {<br>=A0cl_e=
rr err;<br>=A0//CIniFile ini;<br>=A0int ret1,ret2,itmp=3D1;<br>=A0msgbuff q=
;<br>=A0char asd[50];<br>=A0<br>=A0//mlockall(MCL_CURRENT|MCL_FUTURE);<br>=
=A0<br>=A0//tasks<br>
=A0rt_task_create(&amp;Cycle1, &quot;cycle1&quot;, 0, 90, 0);<br>=A0rt_task=
_create(&amp;Cycle2, &quot;cycle2&quot;, 0, 91, 0);<br><br>ret1=3Drt_queue_=
bind(&amp;MsgQue1_2,&quot;Queue_msg1&quot;,TM_INFINITE);<br>printf(&quot;re=
t=3D%d:%s&quot;,ret1,strerror(-ret1));=A0<br>
<br>....<br><br>rt_queue_bind returns -12:cannot alocate memory.<br><br>I t=
ried change flags and execute code from rt_task or from main.<br><br><div>D=
oes anyone have similarly problem or know problem-solving?<br></div><div>
</div><div>xenomai version: 2.4.7</div><div>platform: blackfin bf537</div><=
div>os: uclinux</div><div></div><div>--</div><div>Dmitry Romannikov</div><b=
r>

--0016364166d17228200476e718dd--

