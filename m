MIME-Version: 1.0
In-Reply-To: <AANLkTimeLKjkOf-y-Jb89EQrbWYjxAbmNf-QqUWXd+tP@mail.gmail.com>
References: <AANLkTimeLKjkOf-y-Jb89EQrbWYjxAbmNf-QqUWXd+tP@mail.gmail.com>
Date: Tue, 26 Oct 2010 11:58:56 +0200
Message-ID: <AANLkTi=y8ix9REzUeCU+adyKTE=C-M=P_gFTtjVDO+rw@domain.hid>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=0016364ec7ae304da2049382289b
Subject: Re: [Xenomai-help] Possible memory leak in psos skin message queue
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

--0016364ec7ae304da2049382289b
Content-Type: text/plain; charset=ISO-8859-1

Hello

I did some further debugging on the problem described below and I made some
progress.
At creation time of the message queue using:
q_create("TEST",0,Q_NOLIMIT|Q_PRIOR,&qid);
a chunk of message buffers (64) is allocated and added to the free message
list of the queue (queue->freeq).
Once the message queue is deleted, the messages are added into the global
psosmbufq.
During the q_create/q_delete loop, the memory pool get depleted since the
number of messages in the psosmbufq keeps on increasing all the time.

In my opinion if the Q_PRIBUF is not set during queue creation, the
"psosmbufq" has to be used to allocate/release from/to.
This also implies that the local freeq in the queue object is not used in
this mode anymore.
Each time a message needs to be send, in function get_mbuf it is simply
taken from the psosmbufq. In case this would be empty, a feed_pool operation
is called on it.

static psosmbuf_t *get_mbuf(psosqueue_t *queue, u_long msglen)
{
    psosmbuf_t *mbuf = NULL;

    if (testbits(queue->synchbase.status, Q_NOCACHE)) {
        mbuf =
            (psosmbuf_t *) xnmalloc(sizeof(*mbuf) + msglen -
                        sizeof(mbuf->data));

        if (mbuf)
            inith(&mbuf->link);
    } else {
        xnholder_t *holder = NULL;
        if (testbits(queue->synchbase.status, Q_SHAREDINIT)) {
            holder = getq(&psosmbufq);
            if (!holder) {
                feed_pool(&psoschunkq,
&psosmbufq,PSOS_QUEUE_MIN_ALLOC,queue->maxlen);
                holder = getq(&psosmbufq);
            }
        } else {
            holder = getq(&queue->freeq);
            if (!holder && testbits(queue->synchbase.status, Q_INFINITE)) {
                feed_pool(&queue->chunkq,&queue->freeq,
PSOS_QUEUE_MIN_ALLOC,queue->maxlen);
                holder = getq(&queue->freeq);
            }
        }
        if (holder)
            mbuf = link2psosmbuf(holder);
    }
    return mbuf;
}

I have adapted the code accordingly and rerun my tests. Now it runs forever.
(Of course I also did changes in the code to create and delete a queue.)

Now the question is: Is my understanding correct? If it is, the flag
Q_SHAREDINIT would be better renamed to Q_SHAREDMSGS.

Please share your thoughts.

Best regards,
Ronny


On Tue, Oct 19, 2010 at 11:28 AM, ronny meeus <ronny.meeus@domain.hid> wrote:

> Hello
>
> We have a configuration based on QEMU, Xenomai 2.5.4 and we use the PSOS
> skin.
> [    0.623238] Xenomai: hal/i386 started.
> [    0.633758] Xenomai: scheduling class idle registered.
> [    0.636172] Xenomai: scheduling class rt registered.
> [    0.693178] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
> [    0.723234] Xenomai: starting native API services.
> [    0.728107] Xenomai: starting pSOS+ services.
>
> I'm currently writing a test application in pSOS to check whether the
> run-time behavior is equal to the real PSOS implementation.
> The check function I use is based in the one found in
> "/src/testsuite/unit/rtdm.c" of the xenomai distribution.
>
> This is a piece of the test code I use:
>
> static void test_queue(void)
> {
>     unsigned long qid;
>     unsigned long mesg[4] = {0,1,2,3};
>     unsigned long recv_msg[4];
>     char testCaseName[32];
>
>     printf("test_queue\n");
>     check("q_create",q_create("TEST",0,Q_NOLIMIT|Q_PRIOR,&qid),0);
>
>     check("q_send",q_send(qid,mesg),0);
>     check("q_receive",q_receive(qid,Q_NOWAIT,0,recv_msg),0);
>     check("q_receive TO",q_receive(qid,Q_WAIT,50,recv_msg),ERR_TIMEOUT);
>
>     for (i=0;i<10000;i++)
>     {
>         sprintf(testCaseName,"q_send LOOP %d",i);
>         mesg[3] = (unsigned long)i;
>         check(testCaseName,q_send(qid,mesg),0);
>     }
>
>     while (q_receive(qid,Q_NOWAIT,0,recv_msg) == 0);
>
>     check("q_delete",q_delete(qid),0);
> }
>
> This function is called in a loop:
>   i = 0;
>   while (1)
>   {
>     test_queue();
>     printf("LoopCount = %d\n",i++);
>   }
>
> If I run the testcode  I get:
>
> test_queue
> FAILED test_queue:216: q_send LOOP 7808 returned 52 instead of 0 - Unknown
> error -52
>
> If I change the number of messages I send to the queue to for example 100,
> I observe more or less the same behavior.
> After a number of invocations of the "test_queue" functions, the same error
> is reported.
>
> test_queue
> LoopCount = 117
> test_queue
> LoopCount = 118
> test_queue
> LoopCount = 119
> test_queue
> LoopCount = 120
> test_queue
> FAILED test_queue:216: q_send LOOP 64 returned 52 instead of 0 - Unknown
> error -52
>
> Once the test is failed and I restart the application, I get immediately a
> failure:
>
> test_queue
> FAILED test_queue:216: q_send LOOP 64 returned 52 instead of 0 - Unknown
> error -52
>
> So it looks to me that there is a memory leak in the message handling
> mechanism inside the kernel module.
> It looks like op to 64 messages can be sent to the queue but I get a
> failure as soon as I want to send more.
>
> As a last test I changed the number of loop iterations to 64.
> After doing this the test keeps on running forever.
>
> Another question I have: is there any testcode available for the pSOS skin?
> If not I'm willing the share my code once it is finalized.
>
> Thanks
> Ronny
>
>

--0016364ec7ae304da2049382289b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello<br><br>I did some further debugging on the problem described below an=
d I made some progress.<br>At creation time of the message queue using:<br>=
q_create(&quot;TEST&quot;,0,Q_NOLIMIT|Q_PRIOR,&amp;qid);<br>a chunk of mess=
age buffers (64) is allocated and added to the free message list of the que=
ue (queue-&gt;freeq).<br>
Once the message queue is deleted, the messages are added into the global p=
sosmbufq.<br>During the q_create/q_delete loop, the memory pool get deplete=
d since the number of messages in the psosmbufq keeps on increasing all the=
 time.<br>
<br>In my opinion if the Q_PRIBUF is not set during queue creation, the &qu=
ot;psosmbufq&quot; has to be used to allocate/release from/to.<br>This also=
 implies that the local freeq in the queue object is not used in this mode =
anymore.<br>
Each time a message needs to be send, in function get_mbuf it is simply tak=
en from the psosmbufq. In case this would be empty, a feed_pool operation i=
s called on it.<br><br><font size=3D"1"><span style=3D"font-family: courier=
 new,monospace;">static psosmbuf_t *get_mbuf(psosqueue_t *queue, u_long msg=
len)</span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">{</span><br style=3D"fo=
nt-family: courier new,monospace;"><span style=3D"font-family: courier new,=
monospace;">=A0=A0=A0 psosmbuf_t *mbuf =3D NULL;</span><br style=3D"font-fa=
mily: courier new,monospace;">
<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;">=A0=A0=A0 if (testbits(queue-&gt;synchbase.statu=
s, Q_NOCACHE)) {</span><br style=3D"font-family: courier new,monospace;"><s=
pan style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0 mbu=
f =3D</span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 (psosmbuf_t *) xnmalloc(sizeof(*mbuf) + msglen -</span><br sty=
le=3D"font-family: courier new,monospace;"><span style=3D"font-family: cour=
ier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 sizeof(mbuf-&gt;data));</span><br style=3D"font-family: cou=
rier new,monospace;">
<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0 if (mbuf)</span><br style=
=3D"font-family: courier new,monospace;"><span style=3D"font-family: courie=
r new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inith(&amp;mbuf-&gt;lin=
k);</span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0 } else {</spa=
n><br style=3D"font-family: courier new,monospace;"><span style=3D"font-fam=
ily: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0 xnholder_t *holder =3D N=
ULL;</span><br style=3D"font-family: courier new,monospace;">
</font><div style=3D"text-align: left;"><font style=3D"background-color: rg=
b(255, 255, 153);" size=3D"1"><span style=3D"font-family: courier new,monos=
pace;">=A0=A0=A0=A0=A0=A0=A0 if (testbits(queue-&gt;synchbase.status, Q_SHA=
REDINIT)) {</span></font><br style=3D"font-family: courier new,monospace; b=
ackground-color: rgb(255, 255, 153);">
<font style=3D"background-color: rgb(255, 255, 153);" size=3D"1"><span styl=
e=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 holder =3D getq(&amp;psosmbufq);</span></font><br style=3D"font-family: co=
urier new,monospace; background-color: rgb(255, 255, 153);">
<font style=3D"background-color: rgb(255, 255, 153);" size=3D"1"><span styl=
e=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 if (!holder) {</span><span style=3D"font-family: courier new,monospace;"><=
/span></font><br style=3D"font-family: courier new,monospace; background-co=
lor: rgb(255, 255, 153);">
<font style=3D"background-color: rgb(255, 255, 153);" size=3D"1"><span styl=
e=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 feed_pool(&amp;psoschunkq, &amp;psosmbufq,PSOS_QUEUE_MIN_ALLOC=
,queue-&gt;maxlen);</span></font><br style=3D"font-family: courier new,mono=
space; background-color: rgb(255, 255, 153);">
<font style=3D"background-color: rgb(255, 255, 153);" size=3D"1"><span styl=
e=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 holder =3D getq(&amp;psosmbufq);</span></font><br style=3D"fon=
t-family: courier new,monospace; background-color: rgb(255, 255, 153);">
<font style=3D"background-color: rgb(255, 255, 153);" size=3D"1"><span styl=
e=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 }</span></font><br style=3D"font-family: courier new,monospace;"></div><fo=
nt size=3D"1"><span style=3D"font-family: courier new,monospace;">=A0=A0=A0=
=A0=A0=A0=A0 } else {</span><br style=3D"font-family: courier new,monospace=
;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 holder =3D getq(&amp;queue-&gt;freeq);</span><br style=3D"font=
-family: courier new,monospace;"><span style=3D"font-family: courier new,mo=
nospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!holder &amp;&amp; testbits=
(queue-&gt;synchbase.status, Q_INFINITE)) {</span><br style=3D"font-family:=
 courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 feed_pool(&amp;queue-&gt;chunkq,&amp;queue-&gt;fre=
eq, PSOS_QUEUE_MIN_ALLOC,queue-&gt;maxlen);</span><br style=3D"font-family:=
 courier new,monospace;"><span style=3D"font-family: courier new,monospace;=
">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 holder =3D getq(&amp;queue-=
&gt;freeq);</span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 }=A0=A0=A0 </span><br style=3D"font-family: courier new,monosp=
ace;"><span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=
=A0=A0 }</span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0 i=
f (holder)</span><br style=3D"font-family: courier new,monospace;"><span st=
yle=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 mbuf =3D link2psosmbuf(holder);</span><br style=3D"font-family: courier=
 new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0 }</span><br s=
tyle=3D"font-family: courier new,monospace;"><span style=3D"font-family: co=
urier new,monospace;">=A0=A0=A0 return mbuf;</span><br style=3D"font-family=
: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">}</span></font><br styl=
e=3D"font-family: courier new,monospace;"><br>I have adapted the code accor=
dingly and rerun my tests. Now it runs forever.<br>(Of course I also did ch=
anges in the code to create and delete a queue.)<br>
<br>Now the question is: Is my understanding correct? If it is, the flag Q_=
SHAREDINIT would be better renamed to Q_SHAREDMSGS.<br><br>Please share you=
r thoughts.<br><br>Best regards,<br>Ronny<br><br><br><div class=3D"gmail_qu=
ote">
On Tue, Oct 19, 2010 at 11:28 AM, ronny meeus <span dir=3D"ltr">&lt;<a href=
=3D"mailto:ronny.meeus@domain.hid">ronny.meeus@domain.hid</a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex;=
 border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
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

<br>Thanks<br><font color=3D"#888888">Ronny<br><br>
</font></blockquote></div><br>

--0016364ec7ae304da2049382289b--

