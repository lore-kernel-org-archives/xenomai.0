MIME-Version: 1.0
In-Reply-To: <AANLkTik1+vF_AzF7iYwzsJi9nh-giBOU7vNjaeK0TiCH@mail.gmail.com>
References: <AANLkTimeLKjkOf-y-Jb89EQrbWYjxAbmNf-QqUWXd+tP@mail.gmail.com>
	<AANLkTi=y8ix9REzUeCU+adyKTE=C-M=P_gFTtjVDO+rw@domain.hid>
	<4CC6BCBB.8020902@domain.hid>
	<AANLkTik1+vF_AzF7iYwzsJi9nh-giBOU7vNjaeK0TiCH@mail.gmail.com>
Date: Tue, 2 Nov 2010 21:05:53 +0100
Message-ID: <AANLkTimZ3L9Sy3OPB4p_x2xYMJnKZwz3m1uF==PRx0ER@mail.gmail.com>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=e0cb4e385666bd0ae9049417739b
Subject: Re: [Xenomai-help] Possible memory leak in psos skin message queue
	handling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

--e0cb4e385666bd0ae9049417739b
Content-Type: text/plain; charset=ISO-8859-1

Hello

any feedback on the patch I have posted last week?

Thanks,
Ronny

On Tue, Oct 26, 2010 at 3:13 PM, ronny meeus <ronny.meeus@domain.hid> wrote:

> Gilles,
>
> patch is in attachment, no problem.
> I wanted to check first whether my reasoning is correct.
>
> Best regards,
> Ronny
>
>
> On Tue, Oct 26, 2010 at 1:34 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>>  ronny meeus wrote:
>> > Hello
>> >
>> > I did some further debugging on the problem described below and I made
>> > some progress.
>> > At creation time of the message queue using:
>> > q_create("TEST",0,Q_NOLIMIT|Q_PRIOR,&qid);
>> > a chunk of message buffers (64) is allocated and added to the free
>> > message list of the queue (queue->freeq).
>> > Once the message queue is deleted, the messages are added into the
>> > global psosmbufq.
>> > During the q_create/q_delete loop, the memory pool get depleted since
>> > the number of messages in the psosmbufq keeps on increasing all the
>> time.
>> >
>> > In my opinion if the Q_PRIBUF is not set during queue creation, the
>> > "psosmbufq" has to be used to allocate/release from/to.
>> > This also implies that the local freeq in the queue object is not used
>> > in this mode anymore.
>> > Each time a message needs to be send, in function get_mbuf it is simply
>> > taken from the psosmbufq. In case this would be empty, a feed_pool
>> > operation is called on it.
>> >
>> > static psosmbuf_t *get_mbuf(psosqueue_t *queue, u_long msglen)
>> > {
>> >     psosmbuf_t *mbuf = NULL;
>> >
>> >     if (testbits(queue->synchbase.status, Q_NOCACHE)) {
>> >         mbuf =
>> >             (psosmbuf_t *) xnmalloc(sizeof(*mbuf) + msglen -
>> >                         sizeof(mbuf->data));
>> >
>> >         if (mbuf)
>> >             inith(&mbuf->link);
>> >     } else {
>> >         xnholder_t *holder = NULL;
>> >         if (testbits(queue->synchbase.status, Q_SHAREDINIT)) {
>> >             holder = getq(&psosmbufq);
>> >             if (!holder) {
>> >                 feed_pool(&psoschunkq,
>> > &psosmbufq,PSOS_QUEUE_MIN_ALLOC,queue->maxlen);
>> >                 holder = getq(&psosmbufq);
>> >             }
>> >         } else {
>> >             holder = getq(&queue->freeq);
>> >             if (!holder && testbits(queue->synchbase.status,
>> Q_INFINITE)) {
>> >                 feed_pool(&queue->chunkq,&queue->freeq,
>> > PSOS_QUEUE_MIN_ALLOC,queue->maxlen);
>> >                 holder = getq(&queue->freeq);
>> >             }
>> >         }
>> >         if (holder)
>> >             mbuf = link2psosmbuf(holder);
>> >     }
>> >     return mbuf;
>> > }
>> >
>> > I have adapted the code accordingly and rerun my tests. Now it runs
>> forever.
>> > (Of course I also did changes in the code to create and delete a queue.)
>> >
>> > Now the question is: Is my understanding correct? If it is, the flag
>> > Q_SHAREDINIT would be better renamed to Q_SHAREDMSGS.
>> >
>> > Please share your thoughts.
>>
>> A patch would be better than some fancy HTML colouring, if you intend
>> your fix to be reviewed/integrated.
>>
>> --
>>                                                                Gilles.
>>
>
>

--e0cb4e385666bd0ae9049417739b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hello </div>
<div>=A0</div>
<div>any feedback on the patch I have posted last week?</div>
<div>=A0</div>
<div>Thanks,</div>
<div>Ronny<br><br></div>
<div class=3D"gmail_quote">On Tue, Oct 26, 2010 at 3:13 PM, ronny meeus <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:ronny.meeus@domain.hid">ronny.meeus@domain.hid=
il.com</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">Gilles,<br><br>patch is in attac=
hment, no problem.<br>I wanted to check first whether my reasoning is corre=
ct.<br>
<br>Best regards,<br><font color=3D"#888888">Ronny</font>=20
<div>
<div></div>
<div class=3D"h5"><br><br>
<div class=3D"gmail_quote">On Tue, Oct 26, 2010 at 1:34 PM, Gilles Chantepe=
rdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org.=
org" target=3D"_blank">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrot=
e:<br>

<blockquote style=3D"BORDER-LEFT: rgb(204,204,204) 1px solid; MARGIN: 0pt 0=
pt 0pt 0.8ex; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div>
<div></div>
<div>ronny meeus wrote:<br>&gt; Hello<br>&gt;<br>&gt; I did some further de=
bugging on the problem described below and I made<br>&gt; some progress.<br=
>&gt; At creation time of the message queue using:<br>&gt; q_create(&quot;T=
EST&quot;,0,Q_NOLIMIT|Q_PRIOR,&amp;qid);<br>
&gt; a chunk of message buffers (64) is allocated and added to the free<br>=
&gt; message list of the queue (queue-&gt;freeq).<br>&gt; Once the message =
queue is deleted, the messages are added into the<br>&gt; global psosmbufq.=
<br>
&gt; During the q_create/q_delete loop, the memory pool get depleted since<=
br>&gt; the number of messages in the psosmbufq keeps on increasing all the=
 time.<br>&gt;<br>&gt; In my opinion if the Q_PRIBUF is not set during queu=
e creation, the<br>
&gt; &quot;psosmbufq&quot; has to be used to allocate/release from/to.<br>&=
gt; This also implies that the local freeq in the queue object is not used<=
br>&gt; in this mode anymore.<br>&gt; Each time a message needs to be send,=
 in function get_mbuf it is simply<br>
&gt; taken from the psosmbufq. In case this would be empty, a feed_pool<br>=
&gt; operation is called on it.<br>&gt;<br>&gt; static psosmbuf_t *get_mbuf=
(psosqueue_t *queue, u_long msglen)<br>&gt; {<br>&gt; =A0 =A0 psosmbuf_t *m=
buf =3D NULL;<br>
&gt;<br>&gt; =A0 =A0 if (testbits(queue-&gt;synchbase.status, Q_NOCACHE)) {=
<br>&gt; =A0 =A0 =A0 =A0 mbuf =3D<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 (psosmbuf=
_t *) xnmalloc(sizeof(*mbuf) + msglen -<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 sizeof(mbuf-&gt;data));<br>
&gt;<br>&gt; =A0 =A0 =A0 =A0 if (mbuf)<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 init=
h(&amp;mbuf-&gt;link);<br>&gt; =A0 =A0 } else {<br>&gt; =A0 =A0 =A0 =A0 xnh=
older_t *holder =3D NULL;<br>&gt; =A0 =A0 =A0 =A0 if (testbits(queue-&gt;sy=
nchbase.status, Q_SHAREDINIT)) {<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 holder =3D=
 getq(&amp;psosmbufq);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 if (!holder) {<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 feed_pool(&amp;psoschunkq,<br>&gt; &amp;psosmbufq,PSOS_QUEUE_MIN_A=
LLOC,queue-&gt;maxlen);<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 holder =3D =
getq(&amp;psosmbufq);<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 =A0 } else {<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 holder =3D ge=
tq(&amp;queue-&gt;freeq);<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 if (!holder &amp;=
&amp; testbits(queue-&gt;synchbase.status, Q_INFINITE)) {<br>&gt; =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 feed_pool(&amp;queue-&gt;chunkq,&amp;queue-&gt;free=
q,<br>
&gt; PSOS_QUEUE_MIN_ALLOC,queue-&gt;maxlen);<br>&gt; =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 holder =3D getq(&amp;queue-&gt;freeq);<br>&gt; =A0 =A0 =A0 =A0 =
=A0 =A0 }<br>&gt; =A0 =A0 =A0 =A0 }<br>&gt; =A0 =A0 =A0 =A0 if (holder)<br>=
&gt; =A0 =A0 =A0 =A0 =A0 =A0 mbuf =3D link2psosmbuf(holder);<br>
&gt; =A0 =A0 }<br>&gt; =A0 =A0 return mbuf;<br>&gt; }<br>&gt;<br>&gt; I hav=
e adapted the code accordingly and rerun my tests. Now it runs forever.<br>=
&gt; (Of course I also did changes in the code to create and delete a queue=
.)<br>
&gt;<br>&gt; Now the question is: Is my understanding correct? If it is, th=
e flag<br>&gt; Q_SHAREDINIT would be better renamed to Q_SHAREDMSGS.<br>&gt=
;<br>&gt; Please share your thoughts.<br><br></div></div>A patch would be b=
etter than some fancy HTML colouring, if you intend<br>
your fix to be reviewed/integrated.<br><br>--<br><font color=3D"#888888">=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br></font></blo=
ckquote></div><br></div></div></blockquote></div><br>

--e0cb4e385666bd0ae9049417739b--

