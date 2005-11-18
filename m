Message-ID: <OFC82948A5.5D809872-ONC12570BD.0030CA81-C12570BD.003576C6@domain.hid>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Fri, 18 Nov 2005 10:43:58 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA2EDFA34C118f9e8a93df938690918c4EBBFA2EDFA34C11"
Content-Disposition: inline
Subject: [Xenomai-core] [pipe.c] hairy synchronization -> "flush the output
	queue upon closure"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

--0__=4EBBFA2EDFA34C118f9e8a93df938690918c4EBBFA2EDFA34C11
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable




Hi,

I failed to find the original message from Sebastian that led to the
following change:

-----
2005-11-09  Philippe Gerum  <rpm@xenomai.org>

        * nucleus/pipe.c (xnpipe_disconnect): Flush the output queue
        upon closure. Issue spotted by Sebastian Smolorz.
        (xnpipe_release): Flush the input queue upon closure.
-----

There is one more issue as follows. The reason is that
xnpipe_open/release() are not atomic.

Briefly, a newly connected standard linux thread may get a message that=

have been posted by the real-time side long time before a connection ha=
s
been opened by that thread. That message has been placed to the queue a=
t
the time when there was another linux thread connected to the pipe.

err... I'm not sure now that we should fight against that :confused a b=
it:

--- details ---

THREAD #1 on CPU #1 (normal linux thread):

xnpipe_release()
{

// ok, we are locked here and noone may access the inq queue, let's fre=
e
all the messages if any
...
        if (state->output_handler !=3D NULL)
            {
            while ((holder =3D getq(&state->outq)) !=3D NULL)

state->output_handler(minor,link2mh(holder),-EPIPE,state->cookie);
            }
        while ((holder =3D getq(&state->inq)) !=3D NULL)
            {
            if (state->input_handler !=3D NULL)

state->input_handler(minor,link2mh(holder),-EPIPE,state->cookie);
            else if (state->alloc_handler =3D=3D NULL)
                xnfree(link2mh(holder));
            }

...
    if (waitqueue_active(&state->readq))
        wake_up_interruptible_all(&state->readq);

    if (state->asyncq) /* Clear the async queue */
        {
        xnlock_get_irqsave(&nklock,s);
        removeq(&xnpipe_asyncq,&state->alink);
        clrbits(state->status,XNPIPE_USER_SIGIO);
        xnlock_put_irqrestore(&nklock,s);
        fasync_helper(-1,file,0,&state->asyncq);
        }

// here the lock is not held.

(*** EIP ***) -------> THREAD #1 is about to drop the XNPIPE_USER_CONN
flag.

    /* Free the state object. Since that time it can be open by someone=

else */
    clrbits(state->status,XNPIPE_USER_CONN);
}


THREAD #2 on CPU #2 (real-time thread)

xnpipe_send()
{
...
// locked section

   xnlock_get_irqsave(&nklock,s);

// actually, the following 2 checks should be re-ordered :)

(*** EIP ***)     <----- THREAD #1 doesn't dropped the XNPIPE_USER_CONN=

flag yet but the pipe is almost non-valid!

    if (!testbits(state->status,XNPIPE_USER_CONN))
        {
        xnlock_put_irqrestore(&nklock,s);
        return -EPIPE;
        }

    if (!testbits(state->status,XNPIPE_KERN_CONN))
        {
        xnlock_put_irqrestore(&nklock,s);
        return -EBADF;
        }

    inith(xnpipe_m_link(mh));
    xnpipe_m_size(mh) =3D size - sizeof(*mh);
    state->ionrd +=3D xnpipe_m_size(mh);

// here the message is successfully added to the outq

    if (flags & XNPIPE_URGENT)
        prependq(&state->outq,xnpipe_m_link(mh));
    else
        appendq(&state->outq,xnpipe_m_link(mh));

}

...

In the mean time, THREAD #1 drops the XNPIPE_USER_FLAG so another stand=
ard
linux thread may open a pipe. When that happens, that thread will find =
a
message that have been posted when the old connection existed.

err... so is it a problem regarding desired behaviour of pipes?


---

Dmitry

=

--0__=4EBBFA2EDFA34C118f9e8a93df938690918c4EBBFA2EDFA34C11
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font face=3D"Arial"><br>
</font><font face=3D"Arial">Hi,</font><br>
<br>
<font face=3D"Arial">I failed to find the original message from Sebasti=
an that led to the following change:</font><br>
<br>
<font face=3D"Arial">-----</font><br>
<font face=3D"Arial">2005-11-09  Philippe Gerum  &lt;rpm@xenomai.org&gt=
;</font><br>
<br>
<font face=3D"Arial">        * nucleus/pipe.c (xnpipe_disconnect): Flus=
h the output queue</font><br>
<font face=3D"Arial">        upon closure. Issue spotted by Sebastian S=
molorz.</font><br>
<font face=3D"Arial">        (xnpipe_release): Flush the input queue up=
on closure.</font><br>
<font face=3D"Arial">-----</font><br>
<br>
<font face=3D"Arial">There is one more issue as follows. The reason is =
that xnpipe_open/release() are not atomic.</font><br>
<br>
<font face=3D"Arial">Briefly, a newly connected standard linux thread m=
ay get a message that have been posted by the real-time side long time =
before a connection has been opened by that thread. That message has be=
en placed to the queue at the time when there was another linux thread =
connected to the pipe.</font><br>
<br>
<font face=3D"Arial">err... I'm not sure now that we should fight again=
st that :confused a bit:</font><br>
<br>
<font face=3D"Arial">--- details ---</font><br>
<br>
<font face=3D"Arial">THREAD #1 on CPU #1 (normal linux thread):</font><=
br>
<br>
<font face=3D"Arial">xnpipe_release()</font><br>
<font face=3D"Arial">{</font><br>
<br>
<font face=3D"Arial">// ok, we are locked here and noone may access the=
 inq queue, let's free all the messages if any</font><br>
<font face=3D"Arial">...</font><br>
<font face=3D"Arial">        if (state-&gt;output_handler !=3D NULL)</f=
ont><br>
<font face=3D"Arial">            {</font><br>
<font face=3D"Arial">            while ((holder =3D getq(&amp;state-&gt=
;outq)) !=3D NULL)</font><br>
<font face=3D"Arial">                state-&gt;output_handler(minor,lin=
k2mh(holder),-EPIPE,state-&gt;cookie);</font><br>
<font face=3D"Arial">            }</font><br>
<font face=3D"Arial">        while ((holder =3D getq(&amp;state-&gt;inq=
)) !=3D NULL)</font><br>
<font face=3D"Arial">            {</font><br>
<font face=3D"Arial">            if (state-&gt;input_handler !=3D NULL)=
</font><br>
<font face=3D"Arial">                state-&gt;input_handler(minor,link=
2mh(holder),-EPIPE,state-&gt;cookie);</font><br>
<font face=3D"Arial">            else if (state-&gt;alloc_handler =3D=3D=
 NULL)</font><br>
<font face=3D"Arial">                xnfree(link2mh(holder));</font><br=
>
<font face=3D"Arial">            }</font><br>
<br>
<font face=3D"Arial">...</font><br>
<font face=3D"Arial">    if (waitqueue_active(&amp;state-&gt;readq))</f=
ont><br>
<font face=3D"Arial">        wake_up_interruptible_all(&amp;state-&gt;r=
eadq);</font><br>
<br>
<font face=3D"Arial">    if (state-&gt;asyncq) /* Clear the async queue=
 */</font><br>
<font face=3D"Arial">        {</font><br>
<font face=3D"Arial">        xnlock_get_irqsave(&amp;nklock,s);</font><=
br>
<font face=3D"Arial">        removeq(&amp;xnpipe_asyncq,&amp;state-&gt;=
alink);</font><br>
<font face=3D"Arial">        clrbits(state-&gt;status,XNPIPE_USER_SIGIO=
);</font><br>
<font face=3D"Arial">        xnlock_put_irqrestore(&amp;nklock,s);</fon=
t><br>
<font face=3D"Arial">        fasync_helper(-1,file,0,&amp;state-&gt;asy=
ncq);</font><br>
<font face=3D"Arial">        }</font><br>
<br>
<font face=3D"Arial">// here the lock is not held.</font><br>
<br>
<font face=3D"Arial">(*** EIP ***) -------&gt; THREAD #1 is about to dr=
op the XNPIPE_USER_CONN flag.</font><br>
<br>
<font face=3D"Arial">    /* Free the state object. Since that time it c=
an be open by someone else */</font><br>
<font face=3D"Arial">    clrbits(state-&gt;status,XNPIPE_USER_CONN);</f=
ont><br>
<font face=3D"Arial">}</font><br>
<br>
<br>
<font face=3D"Arial">THREAD #2 on CPU #2 (real-time thread)</font><br>
<br>
<font face=3D"Arial">xnpipe_send()</font><br>
<font face=3D"Arial">{</font><br>
<font face=3D"Arial">...</font><br>
<font face=3D"Arial">// locked section</font><br>
<br>
<font face=3D"Arial">   xnlock_get_irqsave(&amp;nklock,s);</font><br>
<br>
<font face=3D"Arial">// actually, the following 2 checks should be re-o=
rdered :)</font><br>
<br>
<font face=3D"Arial">(*** EIP ***)	&lt;----- THREAD #1 doesn't dropped =
the XNPIPE_USER_CONN flag yet but the pipe is almost non-valid! </font>=
<br>
<br>
<font face=3D"Arial">    if (!testbits(state-&gt;status,XNPIPE_USER_CON=
N))	</font><br>
<font face=3D"Arial">        {</font><br>
<font face=3D"Arial">        xnlock_put_irqrestore(&amp;nklock,s);</fon=
t><br>
<font face=3D"Arial">        return -EPIPE;</font><br>
<font face=3D"Arial">        }</font><br>
<br>
<font face=3D"Arial">    if (!testbits(state-&gt;status,XNPIPE_KERN_CON=
N))</font><br>
<font face=3D"Arial">        {</font><br>
<font face=3D"Arial">        xnlock_put_irqrestore(&amp;nklock,s);</fon=
t><br>
<font face=3D"Arial">        return -EBADF;</font><br>
<font face=3D"Arial">        }</font><br>
<br>
<font face=3D"Arial">    inith(xnpipe_m_link(mh));</font><br>
<font face=3D"Arial">    xnpipe_m_size(mh) =3D size - sizeof(*mh);</fon=
t><br>
<font face=3D"Arial">    state-&gt;ionrd +=3D xnpipe_m_size(mh);</font>=
<br>
<br>
<font face=3D"Arial">// here the message is successfully added to the o=
utq</font><br>
<br>
<font face=3D"Arial">    if (flags &amp; XNPIPE_URGENT)</font><br>
<font face=3D"Arial">        prependq(&amp;state-&gt;outq,xnpipe_m_link=
(mh));</font><br>
<font face=3D"Arial">    else</font><br>
<font face=3D"Arial">        appendq(&amp;state-&gt;outq,xnpipe_m_link(=
mh));</font><br>
<br>
<font face=3D"Arial">}</font><br>
<br>
<font face=3D"Arial">...</font><br>
<br>
<font face=3D"Arial">In the mean time, THREAD #1 drops the XNPIPE_USER_=
FLAG so another standard linux thread may open a pipe. When that happen=
s, that thread will find a message that have been posted when the old c=
onnection existed.</font><br>
<br>
<font face=3D"Arial">err... so is it a problem regarding desired behavi=
our of pipes?</font><br>
<br>
<br>
<font face=3D"Arial">---</font><br>
<br>
<font face=3D"Arial">Dmitry</font><br>
<br>
<br>
</body></html>=

--0__=4EBBFA2EDFA34C118f9e8a93df938690918c4EBBFA2EDFA34C11--


