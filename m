Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8AAF7.8A31ED84"
Date: Wed, 30 Apr 2008 15:22:33 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F5F@afsexc01.aurora.aero>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>		<51B669A8A7D2914E9AB2B3F40AC6553E646F52@domain.hid>		<18454.9396.476627.446653@domain.hid>		<51B669A8A7D2914E9AB2B3F40AC6553E646F54@domain.hid>		<48162C69.6040101@domain.hid>		<18454.12323.344999.258031@domain.hid>		<51B669A8A7D2914E9AB2B3F40AC6553E646F55@domain.hid>		<48163EE7.5000604@domain.hid>		<18454.17297.451664.334250@domain.hid>		<48164652.5090102@domain.hid>	<2ff1a98a0804290252j1c9dc444kffb345ebaeb123d@domain.hid>	<48187366.2060006@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F5C@afsexc01.aurora.aero>
	<4818BB0B.6020008@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F5E@afsexc01.aurora.aero>
	<4818BEE0.7060509@domain.hid>
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

------_=_NextPart_001_01C8AAF7.8A31ED84
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Phillipe,

I added a bunch of printf statements in the program and added the =
rt_queue_create section:
err =3D rt_queue_create(&q_desc, "q_desc", 100, Q_UNLIMITED, Q_FIFO);
I also changed rt_task_delete to rt_task_join  to wait for the task.

Running the following program gives the following:

in consumer task
rt task started
allocated queue of size 6
message sent
allocated queue of size 6
message sent
Xenomai: native: cleaning up queue "q_desc" (ret=3D0)

It appears that the task never got past the following line of code:


    err =3D rt_queue_bind(&q_desc,"SomeQueueName",TM_INFINITE);
    printf("rt_queue_bind returns %d",err);

But then I realized that the Queue Name "SomeQueueName" was different =
then the rt_queue_create "q_desc", fixed that, and now it seems to work. =
 So, I'm posting this as a simple working example of a message queue.

Thank you for your help,   my next task is to take this same example and =
make it work within the framework of a running loop.=20

Take care,

Joshua Karch

#include <sys/mman.h>
#include <stdio.h>
#include <string.h>
#include <native/task.h>
#include <native/queue.h>

#define TASK_PRIO  99 /* Highest RT priority */
#define TASK_MODE  0  /* No flags */
#define TASK_STKSZ 0  /* Stack size (use default one) */

RT_QUEUE q_desc;

RT_TASK task_desc;



void consumer (void *cookie)

{
    ssize_t len;
    void *msg;
    int err;
    printf("in consumer task\n");

    /* Bind to a queue which has been created elsewhere, either in
       kernel or user-space. The call will block us until such queue
       is created with the expected name. The queue should have been
       created with the Q_SHARED mode set, which is implicit when
       creation takes place in user-space. */

    err =3D rt_queue_bind(&q_desc,"SomeQueueName",TM_INFINITE);
    printf("rt_queue_bind returns %d",err);

    if (err)
	{
		printf("error: rt_queue_bind. Error code %d, %s =
\n",err,strerror(err));
	=09
		exit(99);
	}



    /* Collect each message sent to the queue by the queuer() routine,
       until the queue is eventually removed from the system by a call
       to rt_queue_delete(). */

    while ((len =3D rt_queue_receive(&q_desc,&msg,TM_INFINITE)) > 0)
        {
        printf("received message> len=3D%d bytes, ptr=3D%p, s=3D%s\n",
               len,msg,(const char *)msg);
        rt_queue_free(&q_desc,msg);
        }

    /* We need to unbind explicitly from the queue in order to
       properly release the underlying memory mapping. Exiting the
       process unbinds all mappings automatically. */

    rt_queue_unbind(&q_desc);

    if (len !=3D -EIDRM)
	{
		printf("error: rt_queue_bind. len=3D %d\n",len);
		exit(99);
	}
     =20
    /* ... */
}


int main (int argc, char *argv[])

{
    static char *messages[] =3D { "hello", "world", NULL };
    int n, len;
    void *msg;
    int err;
    err =3D rt_queue_create(&q_desc, "SomeQueueName", 100, Q_UNLIMITED, =
Q_FIFO);
	if(err<0)
		printf("error code of %s\n",strerror(err));

    mlockall(MCL_CURRENT|MCL_FUTURE);

    err =3D rt_task_create(&task_desc,
                         "MyTaskName",
                         TASK_STKSZ,
                         TASK_PRIO,
                         TASK_MODE);
    if (!err)
        rt_task_start(&task_desc,&consumer,NULL);

    /* ... */
	printf("rt task started\n");

    for (n =3D 0; messages[n] !=3D NULL; n++)
        {
        len =3D strlen(messages[n]) + 1;
        /* Get a message block of the right size. */
        msg =3D rt_queue_alloc(&q_desc,len);

        if (msg=3D=3DNULL)
            /* No memory available. */
            printf("rt_queue_alloc failed to allocate, NULL pointer =
received\n");
	else printf("allocated queue of size %d\n",len);

        strcpy((char *)msg,messages[n]);
        rt_queue_send(&q_desc,msg,len,Q_NORMAL);
	printf("message sent\n");
        }
    rt_task_join(&task_desc);

    //rt_task_delete(&task_desc);
}




-----Original Message-----
From: Philippe Gerum on behalf of Philippe Gerum
Sent: Wed 4/30/2008 2:48 PM
To: Karch, Joshua
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Segfault Problems with Message Queues
=20
Karch, Joshua wrote:
> Phillipe,
>=20
> I'm running 2.4.3 and compiling it on the same machine (a geode based =
machine).  Appending exit(99); to the next line after printf() allows =
the program to exit with just the "error" from printf().  No seg faults =
there, but it seems the rt_queue_alloc is the problem right now.
>

You may want to pass the error code to fail() and print it out. The =
problem is
that you ask rt_queue_alloc() to get a block from a non-existent queue, =
because
the queue descriptor is invalid for the main() task. You have to call
rt_queue_create() first.

> Thank you,
>=20
> Joshua Karch
>=20
> -----Original Message-----
> From: Philippe Gerum on behalf of Philippe Gerum
> Sent: Wed 4/30/2008 2:31 PM
> To: Karch, Joshua
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Segfault Problems with Message Queues
> =20
> Karch, Joshua wrote:
>> Hi All,
>>
>> I tried implementing inter-task message queues and following the
>> msg_queue.c example
>> =
(http://www.xenomai.org/documentation/trunk/html/api/msg__queue_8c-exampl=
e.html)
>> and when I try to run the implementation after fixing some of the =
code
>> (declaring fail() to printf an error, declaring int err, and changing
>> &task_body to &consumer), I get the following error
>> msg_queue[3897]: segfault at 00000000 eip b7cf8933 esp bf8dce04 error
>> 6.  This comes out of the rt_queue_alloc function.
>>
>> Has the implementation of message passing between userspace tasks
>> changed?  Is there a more recent example?  My end goal is to send non
>> blocking messages from one producer task at 50Hz to two reading tasks
>> tasks with similar (though not exactly same) loop rates-- i.e. None =
of
>> the tasks are synchronized, though they all run at about 50Hz.  =
Should I
>> use message queues to do this?
>>
>> Thank you,
>>
>> Joshua Karch
>>
>> Attached is the code I used..
>>
>> #include <sys/mman.h>
>> #include <stdio.h>
>> #include <string.h>
>> #include <native/task.h>
>> #include <native/queue.h>
>>
>> #define TASK_PRIO  99 /* Highest RT priority */
>> #define TASK_MODE  0  /* No flags */
>> #define TASK_STKSZ 0  /* Stack size (use default one) */
>>
>> RT_QUEUE q_desc;
>>
>> RT_TASK task_desc;
>>
>=20
> We need to know whether an error actually occurred. Nothing guarantees =
us that
> all stdio buffers would be flushed upon SEGV. Does the executable =
still behave
> the same way with that patch?
>=20
>> void fail()
>> {
>>         printf("error\n");
>=20
> +	exit(99);
>> }
>>
>>
>> void consumer (void *cookie)
>>
>> {
>>     ssize_t len;
>>     void *msg;
>>     int err;
>>
>>     /* Bind to a queue which has been created elsewhere, either in
>>        kernel or user-space. The call will block us until such queue
>>        is created with the expected name. The queue should have been
>>        created with the Q_SHARED mode set, which is implicit when
>>        creation takes place in user-space. */
>>
>>     err =3D rt_queue_bind(&q_desc,"SomeQueueName",TM_INFINITE);
>>
>>     if (err)
>>         fail();
>>
>>     /* Collect each message sent to the queue by the queuer() =
routine,
>>        until the queue is eventually removed from the system by a =
call
>>        to rt_queue_delete(). */
>>
>>     while ((len =3D rt_queue_receive(&q_desc,&msg,TM_INFINITE)) > 0)
>>         {
>>         printf("received message> len=3D%d bytes, ptr=3D%p, =
s=3D%s\n",
>>                len,msg,(const char *)msg);
>>         rt_queue_free(&q_desc,msg);
>>         }
>>
>>     /* We need to unbind explicitly from the queue in order to
>>        properly release the underlying memory mapping. Exiting the
>>        process unbinds all mappings automatically. */
>>
>>     rt_queue_unbind(&q_desc);
>>
>>     if (len !=3D -EIDRM)
>>         /* We received some unexpected error notification. */
>>         fail();
>>
>>     /* ... */
>> }
>>
>>
>> int main (int argc, char *argv[])
>>
>> {
>>     static char *messages[] =3D { "hello", "world", NULL };
>>     int n, len;
>>     void *msg;
>>     int err;
>>
>>     mlockall(MCL_CURRENT|MCL_FUTURE);
>>
>>     err =3D rt_task_create(&task_desc,
>>                          "MyTaskName",
>>                          TASK_STKSZ,
>>                          TASK_PRIO,
>>                          TASK_MODE);
>>     if (!err)
>>         rt_task_start(&task_desc,&consumer,NULL);
>>
>>     /* ... */
>>
>>     for (n =3D 0; messages[n] !=3D NULL; n++)
>>         {
>>         len =3D strlen(messages[n]) + 1;
>>         /* Get a message block of the right size. */
>>         msg =3D rt_queue_alloc(&q_desc,len);
>>
>>         if (!msg)
>>             /* No memory available. */
>>             fail();
>>
>>         strcpy((char *)msg,messages[n]);
>>         rt_queue_send(&q_desc,msg,len,Q_NORMAL);
>>         }
>>
>>     rt_task_delete(&task_desc);
>> }
>>
>>
>> =
------------------------------------------------------------------------
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>=20
>=20


--=20
Philippe.


------_=_NextPart_001_01C8AAF7.8A31ED84
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

<P><FONT SIZE=3D2>Phillipe,<BR>
<BR>
I added a bunch of printf statements in the program and added the =
rt_queue_create section:<BR>
err =3D rt_queue_create(&amp;q_desc, &quot;q_desc&quot;, 100, =
Q_UNLIMITED, Q_FIFO);<BR>
I also changed rt_task_delete to rt_task_join&nbsp; to wait for the =
task.<BR>
<BR>
Running the following program gives the following:<BR>
<BR>
in consumer task<BR>
rt task started<BR>
allocated queue of size 6<BR>
message sent<BR>
allocated queue of size 6<BR>
message sent<BR>
Xenomai: native: cleaning up queue &quot;q_desc&quot; (ret=3D0)<BR>
<BR>
It appears that the task never got past the following line of code:<BR>
<BR>
<BR>
&nbsp;&nbsp;&nbsp; err =3D =
rt_queue_bind(&amp;q_desc,&quot;SomeQueueName&quot;,TM_INFINITE);<BR>
&nbsp;&nbsp;&nbsp; printf(&quot;rt_queue_bind returns %d&quot;,err);<BR>
<BR>
But then I realized that the Queue Name &quot;SomeQueueName&quot; was =
different then the rt_queue_create &quot;q_desc&quot;, fixed that, and =
now it seems to work.&nbsp; So, I'm posting this as a simple working =
example of a message queue.<BR>
<BR>
Thank you for your help,&nbsp;&nbsp; my next task is to take this same =
example and make it work within the framework of a running loop.<BR>
<BR>
Take care,<BR>
<BR>
Joshua Karch<BR>
<BR>
#include &lt;sys/mman.h&gt;<BR>
#include &lt;stdio.h&gt;<BR>
#include &lt;string.h&gt;<BR>
#include &lt;native/task.h&gt;<BR>
#include &lt;native/queue.h&gt;<BR>
<BR>
#define TASK_PRIO&nbsp; 99 /* Highest RT priority */<BR>
#define TASK_MODE&nbsp; 0&nbsp; /* No flags */<BR>
#define TASK_STKSZ 0&nbsp; /* Stack size (use default one) */<BR>
<BR>
RT_QUEUE q_desc;<BR>
<BR>
RT_TASK task_desc;<BR>
<BR>
<BR>
<BR>
void consumer (void *cookie)<BR>
<BR>
{<BR>
&nbsp;&nbsp;&nbsp; ssize_t len;<BR>
&nbsp;&nbsp;&nbsp; void *msg;<BR>
&nbsp;&nbsp;&nbsp; int err;<BR>
&nbsp;&nbsp;&nbsp; printf(&quot;in consumer task\n&quot;);<BR>
<BR>
&nbsp;&nbsp;&nbsp; /* Bind to a queue which has been created elsewhere, =
either in<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel or user-space. The call will =
block us until such queue<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is created with the expected name. =
The queue should have been<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; created with the Q_SHARED mode set, =
which is implicit when<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; creation takes place in user-space. =
*/<BR>
<BR>
&nbsp;&nbsp;&nbsp; err =3D =
rt_queue_bind(&amp;q_desc,&quot;SomeQueueName&quot;,TM_INFINITE);<BR>
&nbsp;&nbsp;&nbsp; printf(&quot;rt_queue_bind returns %d&quot;,err);<BR>
<BR>
&nbsp;&nbsp;&nbsp; if (err)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;error: =
rt_queue_bind. Error code %d, %s \n&quot;,err,strerror(err));<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(99);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
<BR>
<BR>
&nbsp;&nbsp;&nbsp; /* Collect each message sent to the queue by the =
queuer() routine,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; until the queue is eventually =
removed from the system by a call<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to rt_queue_delete(). */<BR>
<BR>
&nbsp;&nbsp;&nbsp; while ((len =3D =
rt_queue_receive(&amp;q_desc,&amp;msg,TM_INFINITE)) &gt; 0)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;received =
message&gt; len=3D%d bytes, ptr=3D%p, s=3D%s\n&quot;,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; len,msg,(const char *)msg);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_queue_free(&amp;q_desc,msg);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp; /* We need to unbind explicitly from the queue in =
order to<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; properly release the underlying =
memory mapping. Exiting the<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process unbinds all mappings =
automatically. */<BR>
<BR>
&nbsp;&nbsp;&nbsp; rt_queue_unbind(&amp;q_desc);<BR>
<BR>
&nbsp;&nbsp;&nbsp; if (len !=3D -EIDRM)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;error: =
rt_queue_bind. len=3D %d\n&quot;,len);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(99);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp; /* ... */<BR>
}<BR>
<BR>
<BR>
int main (int argc, char *argv[])<BR>
<BR>
{<BR>
&nbsp;&nbsp;&nbsp; static char *messages[] =3D { &quot;hello&quot;, =
&quot;world&quot;, NULL };<BR>
&nbsp;&nbsp;&nbsp; int n, len;<BR>
&nbsp;&nbsp;&nbsp; void *msg;<BR>
&nbsp;&nbsp;&nbsp; int err;<BR>
&nbsp;&nbsp;&nbsp; err =3D rt_queue_create(&amp;q_desc, =
&quot;SomeQueueName&quot;, 100, Q_UNLIMITED, Q_FIFO);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(err&lt;0)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;error code of =
%s\n&quot;,strerror(err));<BR>
<BR>
&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT|MCL_FUTURE);<BR>
<BR>
&nbsp;&nbsp;&nbsp; err =3D rt_task_create(&amp;task_desc,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&quot;MyTaskName&quot;,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TASK_STKSZ,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TASK_PRIO,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TASK_MODE);<BR>
&nbsp;&nbsp;&nbsp; if (!err)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_start(&amp;task_desc,&amp;consumer,NULL);<BR>
<BR>
&nbsp;&nbsp;&nbsp; /* ... */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;rt task =
started\n&quot;);<BR>
<BR>
&nbsp;&nbsp;&nbsp; for (n =3D 0; messages[n] !=3D NULL; n++)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len =3D strlen(messages[n]) + =
1;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get a message block of the =
right size. */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D =
rt_queue_alloc(&amp;q_desc,len);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msg=3D=3DNULL)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No =
memory available. */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf(&quot;rt_queue_alloc failed to allocate, NULL pointer =
received\n&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else printf(&quot;allocated =
queue of size %d\n&quot;,len);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy((char =
*)msg,messages[n]);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_queue_send(&amp;q_desc,msg,len,Q_NORMAL);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;message =
sent\n&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp; rt_task_join(&amp;task_desc);<BR>
<BR>
&nbsp;&nbsp;&nbsp; //rt_task_delete(&amp;task_desc);<BR>
}<BR>
<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Philippe Gerum on behalf of Philippe Gerum<BR>
Sent: Wed 4/30/2008 2:48 PM<BR>
To: Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] Segfault Problems with Message Queues<BR>
<BR>
Karch, Joshua wrote:<BR>
&gt; Phillipe,<BR>
&gt;<BR>
&gt; I'm running 2.4.3 and compiling it on the same machine (a geode =
based machine).&nbsp; Appending exit(99); to the next line after =
printf() allows the program to exit with just the &quot;error&quot; from =
printf().&nbsp; No seg faults there, but it seems the rt_queue_alloc is =
the problem right now.<BR>
&gt;<BR>
<BR>
You may want to pass the error code to fail() and print it out. The =
problem is<BR>
that you ask rt_queue_alloc() to get a block from a non-existent queue, =
because<BR>
the queue descriptor is invalid for the main() task. You have to =
call<BR>
rt_queue_create() first.<BR>
<BR>
&gt; Thank you,<BR>
&gt;<BR>
&gt; Joshua Karch<BR>
&gt;<BR>
&gt; -----Original Message-----<BR>
&gt; From: Philippe Gerum on behalf of Philippe Gerum<BR>
&gt; Sent: Wed 4/30/2008 2:31 PM<BR>
&gt; To: Karch, Joshua<BR>
&gt; Cc: xenomai@xenomai.org<BR>
&gt; Subject: Re: [Xenomai-help] Segfault Problems with Message =
Queues<BR>
&gt;&nbsp;<BR>
&gt; Karch, Joshua wrote:<BR>
&gt;&gt; Hi All,<BR>
&gt;&gt;<BR>
&gt;&gt; I tried implementing inter-task message queues and following =
the<BR>
&gt;&gt; msg_queue.c example<BR>
&gt;&gt; (<A =
HREF=3D"http://www.xenomai.org/documentation/trunk/html/api/msg__queue_8c=
-example.html">http://www.xenomai.org/documentation/trunk/html/api/msg__q=
ueue_8c-example.html</A>)<BR>
&gt;&gt; and when I try to run the implementation after fixing some of =
the code<BR>
&gt;&gt; (declaring fail() to printf an error, declaring int err, and =
changing<BR>
&gt;&gt; &amp;task_body to &amp;consumer), I get the following error<BR>
&gt;&gt; msg_queue[3897]: segfault at 00000000 eip b7cf8933 esp bf8dce04 =
error<BR>
&gt;&gt; 6.&nbsp; This comes out of the rt_queue_alloc function.<BR>
&gt;&gt;<BR>
&gt;&gt; Has the implementation of message passing between userspace =
tasks<BR>
&gt;&gt; changed?&nbsp; Is there a more recent example?&nbsp; My end =
goal is to send non<BR>
&gt;&gt; blocking messages from one producer task at 50Hz to two reading =
tasks<BR>
&gt;&gt; tasks with similar (though not exactly same) loop rates-- i.e. =
None of<BR>
&gt;&gt; the tasks are synchronized, though they all run at about =
50Hz.&nbsp; Should I<BR>
&gt;&gt; use message queues to do this?<BR>
&gt;&gt;<BR>
&gt;&gt; Thank you,<BR>
&gt;&gt;<BR>
&gt;&gt; Joshua Karch<BR>
&gt;&gt;<BR>
&gt;&gt; Attached is the code I used..<BR>
&gt;&gt;<BR>
&gt;&gt; #include &lt;sys/mman.h&gt;<BR>
&gt;&gt; #include &lt;stdio.h&gt;<BR>
&gt;&gt; #include &lt;string.h&gt;<BR>
&gt;&gt; #include &lt;native/task.h&gt;<BR>
&gt;&gt; #include &lt;native/queue.h&gt;<BR>
&gt;&gt;<BR>
&gt;&gt; #define TASK_PRIO&nbsp; 99 /* Highest RT priority */<BR>
&gt;&gt; #define TASK_MODE&nbsp; 0&nbsp; /* No flags */<BR>
&gt;&gt; #define TASK_STKSZ 0&nbsp; /* Stack size (use default one) =
*/<BR>
&gt;&gt;<BR>
&gt;&gt; RT_QUEUE q_desc;<BR>
&gt;&gt;<BR>
&gt;&gt; RT_TASK task_desc;<BR>
&gt;&gt;<BR>
&gt;<BR>
&gt; We need to know whether an error actually occurred. Nothing =
guarantees us that<BR>
&gt; all stdio buffers would be flushed upon SEGV. Does the executable =
still behave<BR>
&gt; the same way with that patch?<BR>
&gt;<BR>
&gt;&gt; void fail()<BR>
&gt;&gt; {<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf(&quot;error\n&quot;);<BR>
&gt;<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; exit(99);<BR>
&gt;&gt; }<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
&gt;&gt; void consumer (void *cookie)<BR>
&gt;&gt;<BR>
&gt;&gt; {<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t len;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; void *msg;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; int err;<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* Bind to a queue which has been =
created elsewhere, either in<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel or user-space. =
The call will block us until such queue<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is created with the =
expected name. The queue should have been<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; created with the =
Q_SHARED mode set, which is implicit when<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; creation takes place =
in user-space. */<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_queue_bind(&amp;q_desc,&quot;SomeQueueName&quot;,TM_INFINITE);<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fail();<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* Collect each message sent to the =
queue by the queuer() routine,<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; until the queue is =
eventually removed from the system by a call<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to rt_queue_delete(). =
*/<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; while ((len =3D =
rt_queue_receive(&amp;q_desc,&amp;msg,TM_INFINITE)) &gt; 0)<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf(&quot;received message&gt; len=3D%d bytes, ptr=3D%p, =
s=3D%s\n&quot;,<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; len,msg,(const char *)msg);<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_queue_free(&amp;q_desc,msg);<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* We need to unbind explicitly from =
the queue in order to<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; properly release the =
underlying memory mapping. Exiting the<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process unbinds all =
mappings automatically. */<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; rt_queue_unbind(&amp;q_desc);<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (len !=3D -EIDRM)<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We received =
some unexpected error notification. */<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fail();<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* ... */<BR>
&gt;&gt; }<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
&gt;&gt; int main (int argc, char *argv[])<BR>
&gt;&gt;<BR>
&gt;&gt; {<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; static char *messages[] =3D { =
&quot;hello&quot;, &quot;world&quot;, NULL };<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; int n, len;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; void *msg;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; int err;<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT|MCL_FUTURE);<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_task_create(&amp;task_desc,<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;MyTaskName&quot;,<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; TASK_STKSZ,<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; TASK_PRIO,<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; TASK_MODE);<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (!err)<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_start(&amp;task_desc,&amp;consumer,NULL);<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* ... */<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; for (n =3D 0; messages[n] !=3D NULL; =
n++)<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len =3D =
strlen(messages[n]) + 1;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get a =
message block of the right size. */<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D =
rt_queue_alloc(&amp;q_desc,len);<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!msg)<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* No memory available. */<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; fail();<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy((char =
*)msg,messages[n]);<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_queue_send(&amp;q_desc,msg,len,Q_NORMAL);<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_delete(&amp;task_desc);<BR>
&gt;&gt; }<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
&gt;&gt; =
------------------------------------------------------------------------<=
BR>
&gt;&gt;<BR>
&gt;&gt; _______________________________________________<BR>
&gt;&gt; Xenomai-help mailing list<BR>
&gt;&gt; Xenomai-help@domain.hid<BR>
&gt;&gt; <A =
HREF=3D"https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/=
listinfo/xenomai-help</A><BR>
&gt;<BR>
&gt;<BR>
<BR>
<BR>
--<BR>
Philippe.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8AAF7.8A31ED84--

