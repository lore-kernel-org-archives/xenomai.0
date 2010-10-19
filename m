MIME-Version: 1.0
Date: Tue, 19 Oct 2010 11:28:52 +0200
Message-ID: <AANLkTimeLKjkOf-y-Jb89EQrbWYjxAbmNf-QqUWXd+tP@mail.gmail.com>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3005e08ccdf82b0492f4ebb7
Subject: [Xenomai-help] Possible memory leak in psos skin message queue
	handling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

--20cf3005e08ccdf82b0492f4ebb7
Content-Type: text/plain; charset=ISO-8859-1

Hello

We have a configuration based on QEMU, Xenomai 2.5.4 and we use the PSOS
skin.
[    0.623238] Xenomai: hal/i386 started.
[    0.633758] Xenomai: scheduling class idle registered.
[    0.636172] Xenomai: scheduling class rt registered.
[    0.693178] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
[    0.723234] Xenomai: starting native API services.
[    0.728107] Xenomai: starting pSOS+ services.

I'm currently writing a test application in pSOS to check whether the
run-time behavior is equal to the real PSOS implementation.
The check function I use is based in the one found in
"/src/testsuite/unit/rtdm.c" of the xenomai distribution.

This is a piece of the test code I use:

static void test_queue(void)
{
    unsigned long qid;
    unsigned long mesg[4] = {0,1,2,3};
    unsigned long recv_msg[4];
    char testCaseName[32];

    printf("test_queue\n");
    check("q_create",q_create("TEST",0,Q_NOLIMIT|Q_PRIOR,&qid),0);

    check("q_send",q_send(qid,mesg),0);
    check("q_receive",q_receive(qid,Q_NOWAIT,0,recv_msg),0);
    check("q_receive TO",q_receive(qid,Q_WAIT,50,recv_msg),ERR_TIMEOUT);

    for (i=0;i<10000;i++)
    {
        sprintf(testCaseName,"q_send LOOP %d",i);
        mesg[3] = (unsigned long)i;
        check(testCaseName,q_send(qid,mesg),0);
    }

    while (q_receive(qid,Q_NOWAIT,0,recv_msg) == 0);

    check("q_delete",q_delete(qid),0);
}

This function is called in a loop:
  i = 0;
  while (1)
  {
    test_queue();
    printf("LoopCount = %d\n",i++);
  }

If I run the testcode  I get:

test_queue
FAILED test_queue:216: q_send LOOP 7808 returned 52 instead of 0 - Unknown
error -52

If I change the number of messages I send to the queue to for example 100, I
observe more or less the same behavior.
After a number of invocations of the "test_queue" functions, the same error
is reported.

test_queue
LoopCount = 117
test_queue
LoopCount = 118
test_queue
LoopCount = 119
test_queue
LoopCount = 120
test_queue
FAILED test_queue:216: q_send LOOP 64 returned 52 instead of 0 - Unknown
error -52

Once the test is failed and I restart the application, I get immediately a
failure:

test_queue
FAILED test_queue:216: q_send LOOP 64 returned 52 instead of 0 - Unknown
error -52

So it looks to me that there is a memory leak in the message handling
mechanism inside the kernel module.
It looks like op to 64 messages can be sent to the queue but I get a failure
as soon as I want to send more.

As a last test I changed the number of loop iterations to 64.
After doing this the test keeps on running forever.

Another question I have: is there any testcode available for the pSOS skin?
If not I'm willing the share my code once it is finalized.

Thanks
Ronny

--20cf3005e08ccdf82b0492f4ebb7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello<br><br>We have a configuration based on QEMU, Xenomai 2.5.4 and we us=
e the PSOS skin.<br>[=A0=A0=A0 0.623238] Xenomai: hal/i386 started.<br>[=A0=
=A0=A0 0.633758] Xenomai: scheduling class idle registered.<br>[=A0=A0=A0 0=
.636172] Xenomai: scheduling class rt registered.<br>
[=A0=A0=A0 0.693178] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.=
<br>[=A0=A0=A0 0.723234] Xenomai: starting native API services.<br>[=A0=A0=
=A0 0.728107] Xenomai: starting pSOS+ services.<br><br>I&#39;m currently wr=
iting a test application in pSOS to check whether the run-time behavior is =
equal to the real PSOS implementation.<br>
The check function I use is based in the one found in &quot;/src/testsuite/=
unit/rtdm.c&quot; of the xenomai distribution.<br><br>This is a piece of th=
e test code I use:<br><br>static void test_queue(void)<br>{<br>=A0=A0=A0 un=
signed long qid;<br>
=A0=A0=A0 unsigned long mesg[4] =3D {0,1,2,3};<br>=A0=A0=A0 unsigned long r=
ecv_msg[4];<br>=A0=A0=A0 char testCaseName[32];<br>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0 printf=
(&quot;test_queue\n&quot;);<br>=A0=A0=A0 check(&quot;q_create&quot;,q_creat=
e(&quot;TEST&quot;,0,Q_NOLIMIT|Q_PRIOR,&amp;qid),0);<br>
<br>=A0=A0=A0 check(&quot;q_send&quot;,q_send(qid,mesg),0);<br>=A0=A0=A0 ch=
eck(&quot;q_receive&quot;,q_receive(qid,Q_NOWAIT,0,recv_msg),0);<br>=A0=A0=
=A0 check(&quot;q_receive TO&quot;,q_receive(qid,Q_WAIT,50,recv_msg),ERR_TI=
MEOUT);<br><br>
=A0=A0=A0 for (i=3D0;i&lt;10000;i++)<br>=A0=A0=A0 {<br>=A0=A0=A0=A0=A0=A0=
=A0 sprintf(testCaseName,&quot;q_send LOOP %d&quot;,i);<br>=A0=A0=A0=A0=A0=
=A0=A0 mesg[3] =3D (unsigned long)i;<br>=A0=A0=A0=A0=A0=A0=A0 check(testCas=
eName,q_send(qid,mesg),0);<br>=A0=A0=A0 }<br><br>=A0=A0=A0 while (q_receive=
(qid,Q_NOWAIT,0,recv_msg) =3D=3D 0);<br>
<br>=A0=A0=A0 check(&quot;q_delete&quot;,q_delete(qid),0);<br>}=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 <br><br>This function is called in a loop:<br>=A0 i =3D =
0;<br>=A0 while (1)<br>=A0 {<br>=A0=A0=A0 test_queue();<br>=A0=A0=A0 printf=
(&quot;LoopCount =3D %d\n&quot;,i++);<br>
=A0 }<br><br>If I run the testcode=A0 I get:<br><br>test_queue<br>FAILED te=
st_queue:216: q_send LOOP 7808 returned 52 instead of 0 - Unknown error -52=
<br><br>If I change the number of messages I send to the queue to for examp=
le 100, I observe more or less the same behavior. <br>
After a number of invocations of the &quot;test_queue&quot; functions, the =
same error is reported.<br><br>test_queue<br>LoopCount =3D 117<br>test_queu=
e<br>LoopCount =3D 118<br>test_queue<br>LoopCount =3D 119<br>test_queue<br>=
LoopCount =3D 120<br>
test_queue<br>FAILED test_queue:216: q_send LOOP 64 returned 52 instead of =
0 - Unknown error -52<br><br>Once the test is failed and I restart the appl=
ication, I get immediately a failure:<br><br>test_queue<br>FAILED test_queu=
e:216: q_send LOOP 64 returned 52 instead of 0 - Unknown error -52<br>
<br>So it looks to me that there is a memory leak in the message handling m=
echanism inside the kernel module.<br>It looks like op to 64 messages can b=
e sent to the queue but I get a failure as soon as I want to send more.<br>
<br>As a last test I changed the number of loop iterations to 64.<br>After =
doing this the test keeps on running forever.<br><br>Another question I hav=
e: is there any testcode available for the pSOS skin? If not I&#39;m willin=
g the share my code once it is finalized.<br>
<br>Thanks<br>Ronny<br><br>

--20cf3005e08ccdf82b0492f4ebb7--

