Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8AAF1.C2BBBFE3"
Date: Wed, 30 Apr 2008 14:41:11 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F5E@afsexc01.aurora.aero>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>		<51B669A8A7D2914E9AB2B3F40AC6553E646F52@domain.hid>		<18454.9396.476627.446653@domain.hid>		<51B669A8A7D2914E9AB2B3F40AC6553E646F54@domain.hid>		<48162C69.6040101@domain.hid>		<18454.12323.344999.258031@domain.hid>		<51B669A8A7D2914E9AB2B3F40AC6553E646F55@domain.hid>		<48163EE7.5000604@domain.hid>		<18454.17297.451664.334250@domain.hid>		<48164652.5090102@domain.hid>	<2ff1a98a0804290252j1c9dc444kffb345ebaeb123d@domain.hid>	<48187366.2060006@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F5C@afsexc01.aurora.aero>
	<4818BB0B.6020008@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: Re: [Xenomai-help] Segfault Problems with Message Queues
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8AAF1.C2BBBFE3
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Phillipe,

I'm running 2.4.3 and compiling it on the same machine (a geode based =
machine).  Appending exit(99); to the next line after printf() allows =
the program to exit with just the "error" from printf().  No seg faults =
there, but it seems the rt_queue_alloc is the problem right now.

Thank you,

Joshua Karch

-----Original Message-----
From: Philippe Gerum on behalf of Philippe Gerum
Sent: Wed 4/30/2008 2:31 PM
To: Karch, Joshua
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Segfault Problems with Message Queues
=20
Karch, Joshua wrote:
> Hi All,
>=20
> I tried implementing inter-task message queues and following the
> msg_queue.c example
> =
(http://www.xenomai.org/documentation/trunk/html/api/msg__queue_8c-exampl=
e.html)
> and when I try to run the implementation after fixing some of the code
> (declaring fail() to printf an error, declaring int err, and changing
> &task_body to &consumer), I get the following error
> msg_queue[3897]: segfault at 00000000 eip b7cf8933 esp bf8dce04 error
> 6.  This comes out of the rt_queue_alloc function.
>=20
> Has the implementation of message passing between userspace tasks
> changed?  Is there a more recent example?  My end goal is to send non
> blocking messages from one producer task at 50Hz to two reading tasks
> tasks with similar (though not exactly same) loop rates-- i.e. None of
> the tasks are synchronized, though they all run at about 50Hz.  Should =
I
> use message queues to do this?
>=20
> Thank you,
>=20
> Joshua Karch
>=20
> Attached is the code I used..
>=20
> #include <sys/mman.h>
> #include <stdio.h>
> #include <string.h>
> #include <native/task.h>
> #include <native/queue.h>
>=20
> #define TASK_PRIO  99 /* Highest RT priority */
> #define TASK_MODE  0  /* No flags */
> #define TASK_STKSZ 0  /* Stack size (use default one) */
>=20
> RT_QUEUE q_desc;
>=20
> RT_TASK task_desc;
>=20

We need to know whether an error actually occurred. Nothing guarantees =
us that
all stdio buffers would be flushed upon SEGV. Does the executable still =
behave
the same way with that patch?

> void fail()
> {
>         printf("error\n");

+	exit(99);
> }
>=20
>=20
> void consumer (void *cookie)
>=20
> {
>     ssize_t len;
>     void *msg;
>     int err;
>=20
>     /* Bind to a queue which has been created elsewhere, either in
>        kernel or user-space. The call will block us until such queue
>        is created with the expected name. The queue should have been
>        created with the Q_SHARED mode set, which is implicit when
>        creation takes place in user-space. */
>=20
>     err =3D rt_queue_bind(&q_desc,"SomeQueueName",TM_INFINITE);
>=20
>     if (err)
>         fail();
>=20
>     /* Collect each message sent to the queue by the queuer() routine,
>        until the queue is eventually removed from the system by a call
>        to rt_queue_delete(). */
>=20
>     while ((len =3D rt_queue_receive(&q_desc,&msg,TM_INFINITE)) > 0)
>         {
>         printf("received message> len=3D%d bytes, ptr=3D%p, s=3D%s\n",
>                len,msg,(const char *)msg);
>         rt_queue_free(&q_desc,msg);
>         }
>=20
>     /* We need to unbind explicitly from the queue in order to
>        properly release the underlying memory mapping. Exiting the
>        process unbinds all mappings automatically. */
>=20
>     rt_queue_unbind(&q_desc);
>=20
>     if (len !=3D -EIDRM)
>         /* We received some unexpected error notification. */
>         fail();
>=20
>     /* ... */
> }
>=20
>=20
> int main (int argc, char *argv[])
>=20
> {
>     static char *messages[] =3D { "hello", "world", NULL };
>     int n, len;
>     void *msg;
>     int err;
>=20
>     mlockall(MCL_CURRENT|MCL_FUTURE);
>=20
>     err =3D rt_task_create(&task_desc,
>                          "MyTaskName",
>                          TASK_STKSZ,
>                          TASK_PRIO,
>                          TASK_MODE);
>     if (!err)
>         rt_task_start(&task_desc,&consumer,NULL);
>=20
>     /* ... */
>=20
>     for (n =3D 0; messages[n] !=3D NULL; n++)
>         {
>         len =3D strlen(messages[n]) + 1;
>         /* Get a message block of the right size. */
>         msg =3D rt_queue_alloc(&q_desc,len);
>=20
>         if (!msg)
>             /* No memory available. */
>             fail();
>=20
>         strcpy((char *)msg,messages[n]);
>         rt_queue_send(&q_desc,msg,len,Q_NORMAL);
>         }
>=20
>     rt_task_delete(&task_desc);
> }
>=20
>=20
> =
------------------------------------------------------------------------
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.


------_=_NextPart_001_01C8AAF1.C2BBBFE3
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>RE: [Xenomai-help] Segfault Problems with Message Queues</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Phillipe,<BR>
<BR>
I'm running 2.4.3 and compiling it on the same machine (a geode based =
machine).&nbsp; Appending exit(99); to the next line after printf() =
allows the program to exit with just the &quot;error&quot; from =
printf().&nbsp; No seg faults there, but it seems the rt_queue_alloc is =
the problem right now.<BR>
<BR>
Thank you,<BR>
<BR>
Joshua Karch<BR>
<BR>
-----Original Message-----<BR>
From: Philippe Gerum on behalf of Philippe Gerum<BR>
Sent: Wed 4/30/2008 2:31 PM<BR>
To: Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] Segfault Problems with Message Queues<BR>
<BR>
Karch, Joshua wrote:<BR>
&gt; Hi All,<BR>
&gt;<BR>
&gt; I tried implementing inter-task message queues and following =
the<BR>
&gt; msg_queue.c example<BR>
&gt; (<A =
HREF=3D"http://www.xenomai.org/documentation/trunk/html/api/msg__queue_8c=
-example.html">http://www.xenomai.org/documentation/trunk/html/api/msg__q=
ueue_8c-example.html</A>)<BR>
&gt; and when I try to run the implementation after fixing some of the =
code<BR>
&gt; (declaring fail() to printf an error, declaring int err, and =
changing<BR>
&gt; &amp;task_body to &amp;consumer), I get the following error<BR>
&gt; msg_queue[3897]: segfault at 00000000 eip b7cf8933 esp bf8dce04 =
error<BR>
&gt; 6.&nbsp; This comes out of the rt_queue_alloc function.<BR>
&gt;<BR>
&gt; Has the implementation of message passing between userspace =
tasks<BR>
&gt; changed?&nbsp; Is there a more recent example?&nbsp; My end goal is =
to send non<BR>
&gt; blocking messages from one producer task at 50Hz to two reading =
tasks<BR>
&gt; tasks with similar (though not exactly same) loop rates-- i.e. None =
of<BR>
&gt; the tasks are synchronized, though they all run at about =
50Hz.&nbsp; Should I<BR>
&gt; use message queues to do this?<BR>
&gt;<BR>
&gt; Thank you,<BR>
&gt;<BR>
&gt; Joshua Karch<BR>
&gt;<BR>
&gt; Attached is the code I used..<BR>
&gt;<BR>
&gt; #include &lt;sys/mman.h&gt;<BR>
&gt; #include &lt;stdio.h&gt;<BR>
&gt; #include &lt;string.h&gt;<BR>
&gt; #include &lt;native/task.h&gt;<BR>
&gt; #include &lt;native/queue.h&gt;<BR>
&gt;<BR>
&gt; #define TASK_PRIO&nbsp; 99 /* Highest RT priority */<BR>
&gt; #define TASK_MODE&nbsp; 0&nbsp; /* No flags */<BR>
&gt; #define TASK_STKSZ 0&nbsp; /* Stack size (use default one) */<BR>
&gt;<BR>
&gt; RT_QUEUE q_desc;<BR>
&gt;<BR>
&gt; RT_TASK task_desc;<BR>
&gt;<BR>
<BR>
We need to know whether an error actually occurred. Nothing guarantees =
us that<BR>
all stdio buffers would be flushed upon SEGV. Does the executable still =
behave<BR>
the same way with that patch?<BR>
<BR>
&gt; void fail()<BR>
&gt; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf(&quot;error\n&quot;);<BR>
<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(99);<BR>
&gt; }<BR>
&gt;<BR>
&gt;<BR>
&gt; void consumer (void *cookie)<BR>
&gt;<BR>
&gt; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t len;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; void *msg;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; int err;<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* Bind to a queue which has been created =
elsewhere, either in<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel or user-space. The =
call will block us until such queue<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is created with the =
expected name. The queue should have been<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; created with the Q_SHARED =
mode set, which is implicit when<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; creation takes place in =
user-space. */<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_queue_bind(&amp;q_desc,&quot;SomeQueueName&quot;,TM_INFINITE);<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fail();<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* Collect each message sent to the queue =
by the queuer() routine,<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; until the queue is =
eventually removed from the system by a call<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to rt_queue_delete(). =
*/<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; while ((len =3D =
rt_queue_receive(&amp;q_desc,&amp;msg,TM_INFINITE)) &gt; 0)<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf(&quot;received message&gt; len=3D%d bytes, ptr=3D%p, =
s=3D%s\n&quot;,<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; len,msg,(const char *)msg);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_queue_free(&amp;q_desc,msg);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* We need to unbind explicitly from the =
queue in order to<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; properly release the =
underlying memory mapping. Exiting the<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process unbinds all =
mappings automatically. */<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; rt_queue_unbind(&amp;q_desc);<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (len !=3D -EIDRM)<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We received some =
unexpected error notification. */<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fail();<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* ... */<BR>
&gt; }<BR>
&gt;<BR>
&gt;<BR>
&gt; int main (int argc, char *argv[])<BR>
&gt;<BR>
&gt; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; static char *messages[] =3D { =
&quot;hello&quot;, &quot;world&quot;, NULL };<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; int n, len;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; void *msg;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; int err;<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT|MCL_FUTURE);<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; err =3D rt_task_create(&amp;task_desc,<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &quot;MyTaskName&quot;,<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; TASK_STKSZ,<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; TASK_PRIO,<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; TASK_MODE);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (!err)<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_start(&amp;task_desc,&amp;consumer,NULL);<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* ... */<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; for (n =3D 0; messages[n] !=3D NULL; =
n++)<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len =3D =
strlen(messages[n]) + 1;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get a message =
block of the right size. */<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D =
rt_queue_alloc(&amp;q_desc,len);<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!msg)<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* No memory available. */<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; fail();<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy((char =
*)msg,messages[n]);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_queue_send(&amp;q_desc,msg,len,Q_NORMAL);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_delete(&amp;task_desc);<BR>
&gt; }<BR>
&gt;<BR>
&gt;<BR>
&gt; =
------------------------------------------------------------------------<=
BR>
&gt;<BR>
&gt; _______________________________________________<BR>
&gt; Xenomai-help mailing list<BR>
&gt; Xenomai-help@domain.hid<BR>
&gt; <A =
HREF=3D"https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/=
listinfo/xenomai-help</A><BR>
<BR>
<BR>
--<BR>
Philippe.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8AAF1.C2BBBFE3--

