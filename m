MIME-Version: 1.0
In-Reply-To: <4CC6BCBB.8020902@domain.hid>
References: <AANLkTimeLKjkOf-y-Jb89EQrbWYjxAbmNf-QqUWXd+tP@mail.gmail.com>
	<AANLkTi=y8ix9REzUeCU+adyKTE=C-M=P_gFTtjVDO+rw@domain.hid>
	<4CC6BCBB.8020902@domain.hid>
Date: Tue, 26 Oct 2010 15:13:02 +0200
Message-ID: <AANLkTik1+vF_AzF7iYwzsJi9nh-giBOU7vNjaeK0TiCH@mail.gmail.com>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/mixed; boundary=20cf300fa99560b4e4049384de6f
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

--20cf300fa99560b4e4049384de6f
Content-Type: multipart/alternative; boundary=20cf300fa99560b4df049384de6d

--20cf300fa99560b4df049384de6d
Content-Type: text/plain; charset=ISO-8859-1

Gilles,

patch is in attachment, no problem.
I wanted to check first whether my reasoning is correct.

Best regards,
Ronny

On Tue, Oct 26, 2010 at 1:34 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> ronny meeus wrote:
> > Hello
> >
> > I did some further debugging on the problem described below and I made
> > some progress.
> > At creation time of the message queue using:
> > q_create("TEST",0,Q_NOLIMIT|Q_PRIOR,&qid);
> > a chunk of message buffers (64) is allocated and added to the free
> > message list of the queue (queue->freeq).
> > Once the message queue is deleted, the messages are added into the
> > global psosmbufq.
> > During the q_create/q_delete loop, the memory pool get depleted since
> > the number of messages in the psosmbufq keeps on increasing all the time.
> >
> > In my opinion if the Q_PRIBUF is not set during queue creation, the
> > "psosmbufq" has to be used to allocate/release from/to.
> > This also implies that the local freeq in the queue object is not used
> > in this mode anymore.
> > Each time a message needs to be send, in function get_mbuf it is simply
> > taken from the psosmbufq. In case this would be empty, a feed_pool
> > operation is called on it.
> >
> > static psosmbuf_t *get_mbuf(psosqueue_t *queue, u_long msglen)
> > {
> >     psosmbuf_t *mbuf = NULL;
> >
> >     if (testbits(queue->synchbase.status, Q_NOCACHE)) {
> >         mbuf =
> >             (psosmbuf_t *) xnmalloc(sizeof(*mbuf) + msglen -
> >                         sizeof(mbuf->data));
> >
> >         if (mbuf)
> >             inith(&mbuf->link);
> >     } else {
> >         xnholder_t *holder = NULL;
> >         if (testbits(queue->synchbase.status, Q_SHAREDINIT)) {
> >             holder = getq(&psosmbufq);
> >             if (!holder) {
> >                 feed_pool(&psoschunkq,
> > &psosmbufq,PSOS_QUEUE_MIN_ALLOC,queue->maxlen);
> >                 holder = getq(&psosmbufq);
> >             }
> >         } else {
> >             holder = getq(&queue->freeq);
> >             if (!holder && testbits(queue->synchbase.status, Q_INFINITE))
> {
> >                 feed_pool(&queue->chunkq,&queue->freeq,
> > PSOS_QUEUE_MIN_ALLOC,queue->maxlen);
> >                 holder = getq(&queue->freeq);
> >             }
> >         }
> >         if (holder)
> >             mbuf = link2psosmbuf(holder);
> >     }
> >     return mbuf;
> > }
> >
> > I have adapted the code accordingly and rerun my tests. Now it runs
> forever.
> > (Of course I also did changes in the code to create and delete a queue.)
> >
> > Now the question is: Is my understanding correct? If it is, the flag
> > Q_SHAREDINIT would be better renamed to Q_SHAREDMSGS.
> >
> > Please share your thoughts.
>
> A patch would be better than some fancy HTML colouring, if you intend
> your fix to be reviewed/integrated.
>
> --
>                                                                 Gilles.
>

--20cf300fa99560b4df049384de6d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles,<br><br>patch is in attachment, no problem.<br>I wanted to check fir=
st whether my reasoning is correct.<br><br>Best regards,<br>Ronny<br><br><d=
iv class=3D"gmail_quote">On Tue, Oct 26, 2010 at 1:34 PM, Gilles Chanteperd=
rix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
g">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div><div></div><=
div class=3D"h5">ronny meeus wrote:<br>
&gt; Hello<br>
&gt;<br>
&gt; I did some further debugging on the problem described below and I made=
<br>
&gt; some progress.<br>
&gt; At creation time of the message queue using:<br>
&gt; q_create(&quot;TEST&quot;,0,Q_NOLIMIT|Q_PRIOR,&amp;qid);<br>
&gt; a chunk of message buffers (64) is allocated and added to the free<br>
&gt; message list of the queue (queue-&gt;freeq).<br>
&gt; Once the message queue is deleted, the messages are added into the<br>
&gt; global psosmbufq.<br>
&gt; During the q_create/q_delete loop, the memory pool get depleted since<=
br>
&gt; the number of messages in the psosmbufq keeps on increasing all the ti=
me.<br>
&gt;<br>
&gt; In my opinion if the Q_PRIBUF is not set during queue creation, the<br=
>
&gt; &quot;psosmbufq&quot; has to be used to allocate/release from/to.<br>
&gt; This also implies that the local freeq in the queue object is not used=
<br>
&gt; in this mode anymore.<br>
&gt; Each time a message needs to be send, in function get_mbuf it is simpl=
y<br>
&gt; taken from the psosmbufq. In case this would be empty, a feed_pool<br>
&gt; operation is called on it.<br>
&gt;<br>
&gt; static psosmbuf_t *get_mbuf(psosqueue_t *queue, u_long msglen)<br>
&gt; {<br>
&gt; =A0 =A0 psosmbuf_t *mbuf =3D NULL;<br>
&gt;<br>
&gt; =A0 =A0 if (testbits(queue-&gt;synchbase.status, Q_NOCACHE)) {<br>
&gt; =A0 =A0 =A0 =A0 mbuf =3D<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 (psosmbuf_t *) xnmalloc(sizeof(*mbuf) + msglen=
 -<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(mbuf-&gt;data))=
;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 if (mbuf)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 inith(&amp;mbuf-&gt;link);<br>
&gt; =A0 =A0 } else {<br>
&gt; =A0 =A0 =A0 =A0 xnholder_t *holder =3D NULL;<br>
&gt; =A0 =A0 =A0 =A0 if (testbits(queue-&gt;synchbase.status, Q_SHAREDINIT)=
) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 holder =3D getq(&amp;psosmbufq);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 if (!holder) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 feed_pool(&amp;psoschunkq,<br>
&gt; &amp;psosmbufq,PSOS_QUEUE_MIN_ALLOC,queue-&gt;maxlen);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 holder =3D getq(&amp;psosmbufq);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 =A0 } else {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 holder =3D getq(&amp;queue-&gt;freeq);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 if (!holder &amp;&amp; testbits(queue-&gt;sync=
hbase.status, Q_INFINITE)) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 feed_pool(&amp;queue-&gt;chunkq,&amp;q=
ueue-&gt;freeq,<br>
&gt; PSOS_QUEUE_MIN_ALLOC,queue-&gt;maxlen);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 holder =3D getq(&amp;queue-&gt;freeq);=
<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 =A0 if (holder)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 mbuf =3D link2psosmbuf(holder);<br>
&gt; =A0 =A0 }<br>
&gt; =A0 =A0 return mbuf;<br>
&gt; }<br>
&gt;<br>
&gt; I have adapted the code accordingly and rerun my tests. Now it runs fo=
rever.<br>
&gt; (Of course I also did changes in the code to create and delete a queue=
.)<br>
&gt;<br>
&gt; Now the question is: Is my understanding correct? If it is, the flag<b=
r>
&gt; Q_SHAREDINIT would be better renamed to Q_SHAREDMSGS.<br>
&gt;<br>
&gt; Please share your thoughts.<br>
<br>
</div></div>A patch would be better than some fancy HTML colouring, if you =
intend<br>
your fix to be reviewed/integrated.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>

--20cf300fa99560b4df049384de6d--

--20cf300fa99560b4e4049384de6f
Content-Type: text/x-patch; charset=US-ASCII; name="psos-queue.patch"
Content-Disposition: attachment; filename="psos-queue.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gfqsqobl0

ZGlmZiAtciBmOGJiYjNlNzhjNDAgeGVub21haS0yLjUuNC9rc3JjL3NraW5zL3Bzb3MrL3F1ZXVl
LmMKLS0tIGEveGVub21haS0yLjUuNC9rc3JjL3NraW5zL3Bzb3MrL3F1ZXVlLmMJTW9uIFNlcCAy
NyAyMDoyNjozMiAyMDEwICswMjAwCisrKyBiL3hlbm9tYWktMi41LjQva3NyYy9za2lucy9wc29z
Ky9xdWV1ZS5jCVR1ZSBPY3QgMjYgMTU6MTI6MDYgMjAxMCArMDIwMApAQCAtNDAsNiArNDAsNyBA
QAogCWludCBsZW47CiAJc3BsX3QgczsKIAorCXAgKz0gc3ByaW50ZihwLCAicHNvc21idWZxICNi
dWZzPSVkXG4iLGNvdW50cSgmcHNvc21idWZxKSk7CiAJcCArPSBzcHJpbnRmKHAsICJtYXhudW09
JWx1Om1heGxlbj0lbHU6bWNvdW50PSVkXG4iLAogCQkgICAgIHF1ZXVlLT5tYXhudW0sIHF1ZXVl
LT5tYXhsZW4sIGNvdW50cSgmcXVldWUtPmlucSkpOwogCkBAIC00Nyw3ICs0OCw3IEBACiAKIAlp
ZiAoeG5zeW5jaF9uc2xlZXBlcnMoJnF1ZXVlLT5zeW5jaGJhc2UpID4gMCkgewogCQl4bnBob2xk
ZXJfdCAqaG9sZGVyOwotCisJICAgIAogCQkvKiBQZW5kZWQgcXVldWUgLS0gZHVtcCB3YWl0ZXJz
LiAqLwogCiAJCWhvbGRlciA9IGdldGhlYWRwcSh4bnN5bmNoX3dhaXRfcXVldWUoJnF1ZXVlLT5z
eW5jaGJhc2UpKTsKQEAgLTE2NCwxNSArMTY1LDIwIEBACiAJCWlmIChtYnVmKQogCQkJaW5pdGgo
Jm1idWYtPmxpbmspOwogCX0gZWxzZSB7Ci0JCXhuaG9sZGVyX3QgKmhvbGRlciA9IGdldHEoJnF1
ZXVlLT5mcmVlcSk7Ci0KLQkJaWYgKCFob2xkZXIgJiYKLQkJICAgIHRlc3RiaXRzKHF1ZXVlLT5z
eW5jaGJhc2Uuc3RhdHVzLCBRX0lORklOSVRFKSAmJgotCQkgICAgZmVlZF9wb29sKCZxdWV1ZS0+
Y2h1bmtxLAotCQkJICAgICAgJnF1ZXVlLT5mcmVlcSwgUFNPU19RVUVVRV9NSU5fQUxMT0MsCi0J
CQkgICAgICBxdWV1ZS0+bWF4bGVuKSAhPSAwKQotCQkJaG9sZGVyID0gZ2V0cSgmcXVldWUtPmZy
ZWVxKTsKLQorCSAgICB4bmhvbGRlcl90ICpob2xkZXIgPSBOVUxMOworCSAgICBpZiAodGVzdGJp
dHMocXVldWUtPnN5bmNoYmFzZS5zdGF0dXMsIFFfU0hBUkVESU5JVCkpIHsKKwkgICAgICAgIGhv
bGRlciA9IGdldHEoJnBzb3NtYnVmcSk7CisJICAgICAgICBpZiAoIWhvbGRlcikgeworCSAgICAg
ICAgICAgIGZlZWRfcG9vbCgmcHNvc2NodW5rcSwgJnBzb3NtYnVmcSxQU09TX1FVRVVFX01JTl9B
TExPQyxxdWV1ZS0+bWF4bGVuKTsKKwkgICAgICAgICAgICBob2xkZXIgPSBnZXRxKCZwc29zbWJ1
ZnEpOworICAgICAgICAgICAgfQorICAgICAgICB9IGVsc2UgeyAgICAgICAgCisJCSAgICBob2xk
ZXIgPSBnZXRxKCZxdWV1ZS0+ZnJlZXEpOworCQkgICAgaWYgKCFob2xkZXIgJiYgdGVzdGJpdHMo
cXVldWUtPnN5bmNoYmFzZS5zdGF0dXMsIFFfSU5GSU5JVEUpKSB7IAorICAgICAgICAgICAgICAg
IGZlZWRfcG9vbCgmcXVldWUtPmNodW5rcSwmcXVldWUtPmZyZWVxLCBQU09TX1FVRVVFX01JTl9B
TExPQyxxdWV1ZS0+bWF4bGVuKTsKKyAgICAgICAgICAgICAgICBob2xkZXIgPSBnZXRxKCZxdWV1
ZS0+ZnJlZXEpOworICAgICAgICAgICAgfSAgICAKKyAgICAgICAgfQogCQlpZiAoaG9sZGVyKQog
CQkJbWJ1ZiA9IGxpbmsycHNvc21idWYoaG9sZGVyKTsKIAl9CkBAIC0xODcsNyArMTkzLDYgQEAK
IAlzdGF0aWMgdW5zaWduZWQgbG9uZyBtc2dxX2lkczsKIAlwc29zcXVldWVfdCAqcXVldWU7CiAJ
aW50IGJmbGFncywgcmV0OwotCXVfbG9uZyByYzsKIAlzcGxfdCBzOwogCiAJYmZsYWdzID0gKGZs
YWdzICYgUV9WQVJJQUJMRSk7CkBAIC0yMzYsMjcgKzI0MSwxMyBAQAogCWluaXRxKCZxdWV1ZS0+
Y2h1bmtxKTsKIAogCWlmIChiZmxhZ3MgJiBRX1BSSVZDQUNIRSkgewotCQlpZiAoYmZsYWdzICYg
UV9TSEFSRURJTklUKSB7Ci0JCQl4bmxvY2tfZ2V0X2lycXNhdmUoJm5rbG9jaywgcyk7Ci0JCQly
YyA9IGZlZWRfcG9vbCgmcHNvc2NodW5rcSwgJnBzb3NtYnVmcSwgbWF4bnVtLCBtYXhsZW4pOwot
CQkJeG5sb2NrX3B1dF9pcnFyZXN0b3JlKCZua2xvY2ssIHMpOwotCQl9IGVsc2UKLQkJCXJjID0g
ZmVlZF9wb29sKCZxdWV1ZS0+Y2h1bmtxLCAmcXVldWUtPmZyZWVxLCBtYXhudW0sCi0JCQkJICAg
ICAgIG1heGxlbik7Ci0KLQkJaWYgKCFyYykgewotCQkJLyogQ2FuJ3QgcHJlYWxsb2NhdGUgbXNn
IGJ1ZmZlcnMuICovCi0JCQl4bmZyZWUocXVldWUpOwotCQkJcmV0dXJuIEVSUl9OT01HQjsKLQkJ
fQotCi0JCWlmIChiZmxhZ3MgJiBRX1NIQVJFRElOSVQpIHsKLQkJCXhubG9ja19nZXRfaXJxc2F2
ZSgmbmtsb2NrLCBzKTsKLQotCQkJd2hpbGUgKGNvdW50cSgmcXVldWUtPmZyZWVxKSA8IG1heG51
bSkKLQkJCQlhcHBlbmRxKCZxdWV1ZS0+ZnJlZXEsIGdldHEoJnBzb3NtYnVmcSkpOwotCi0JCQl4
bmxvY2tfcHV0X2lycXJlc3RvcmUoJm5rbG9jaywgcyk7CisJCWlmICgoYmZsYWdzICYgUV9TSEFS
RURJTklUKSA9PSAwKSB7CisJCQl1X2xvbmcgcmMgPSBmZWVkX3Bvb2woJnF1ZXVlLT5jaHVua3Es
ICZxdWV1ZS0+ZnJlZXEsIG1heG51bSwgbWF4bGVuKTsKKwkJCWlmICghcmMpIHsKKwkJCQkvKiBD
YW4ndCBwcmVhbGxvY2F0ZSBtc2cgYnVmZmVycy4gKi8KKwkJCQl4bmZyZWUocXVldWUpOyAgIAor
CQkJCXJldHVybiBFUlJfTk9NR0I7CisJCQl9CiAJCX0KIAl9CiAKQEAgLTQ3Nyw3ICs0NjgsMTAg
QEAKIAogCWlmICh0ZXN0Yml0cyhxdWV1ZS0+c3luY2hiYXNlLnN0YXR1cywgUV9OT0NBQ0hFKSkK
IAkJeG5mcmVlKG1idWYpOwotCWVsc2UKKwllbHNlIGlmICh0ZXN0Yml0cyhxdWV1ZS0+c3luY2hi
YXNlLnN0YXR1cywgUV9TSEFSRURJTklUKSkgeworCQkvKiBNZXNzYWdlIGJ1ZmZlciBzaG91bGQg
Z28gdG8gdGhlIHBzb3NtYnVmcSAqLworCQlhcHBlbmRxKCZwc29zbWJ1ZnEsICZtYnVmLT5saW5r
KTsKKwl9IGVsc2UgICAgCiAJCWFwcGVuZHEoJnF1ZXVlLT5mcmVlcSwgJm1idWYtPmxpbmspOwog
CiAgICAgICB1bmxvY2tfYW5kX2V4aXQ6Cg==
--20cf300fa99560b4e4049384de6f--

