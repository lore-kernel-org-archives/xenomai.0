In-Reply-To: <4378B391.5030306@domain.hid>
Subject: Re: [Xenomai-core] rt_pipe_* usage
Message-ID: <OFDC60A907.2FB7647D-ONC12570B9.0058D97B-C12570B9.005A128D@datacon.at>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Mon, 14 Nov 2005 17:23:49 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA2ADFCB5FEB8f9e8a93df938690918c4EBBFA2ADFCB5FEB"
Content-Disposition: inline
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Ignacio =?ISO-8859-1?Q?Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

--0__=4EBBFA2ADFCB5FEB8f9e8a93df938690918c4EBBFA2ADFCB5FEB
Content-type: text/plain; charset=US-ASCII


xenomai-core-bounces@domain.hid wrote on 14.11.2005 16:56:01:

> Hi,
>
> I'm having now my first contact with the pipe framework, an have some
> comments about it that might be of interest to the core developers:
>
> While the documentation is overall *great*, I fould it a bit lacking
> regarding the pipes. Would be good to have some examples of general
usage.

You may take a look at testsuite/klatency example that uses a pipe for rt
kernel-mode task ---> normal linux task communication.


>
> As far as I can tell, there is no mention of the usage of P_MSGPTR and
> P_MSGSIZE. I had to learn about them in the headers.
>
> At first sight, the rt_pipe_send call is confusing: why should I pass
> the data size since it is supposed to be embedded in the RT_PIPE_MSG
> structure?.
>
> This is what I first did:
>
> RT_PIPE_MSG *m = rt_pipe_alloc(sizeof(mystruct));
> P_MSGPTR(m) = &mystruct;
> P_MSGSIZE(m) = sizeof(mystruct)
> rt_pipe_send(&mypipe, m, sizeof(mystruct), P_NORMAL);


rt_pipe_write()
{
...
      msg = rt_pipe_alloc(size);

      if (!msg)
        return -ENOMEM;

      memcpy(P_MSGPTR(msg),buf,size);           <---- copying, not storing
a pointer like you did

      nbytes = rt_pipe_send(pipe,msg,size,mode);
...

Actually, if you have already a buffer filled with data, you may directly
use a rt_pipe_write() call.

>
> Which is obviously wrong. Please correct me if I'm wrong:
>
> P_MSGPTR and P_MSGSIZE are intended not to be used as an lvalue (is
> there a way to define these macros to generate a compile error if they
> are?).
>
> So, the correct way would be something like this (again, correct me if
> I'm wrong)::
>
> RT_PIPE_MSG *m = rt_pipe_alloc(sizeof(mystruct_t));
> mystruct_t *p = (mystruct_t *)P_MSGPTR(m);
> p->whatever1 = X;
> p->whatever2 = X;
> rt_pipe_send(&mypipe, m, sizeof(mystruct_t), P_NORMAL);
>
> If this is correct, why do I have to specify the size of mystruct_t
> *twice*. Can't it be initialized by rt_pipe_alloc ?.

It's initialized actually (*).

RT_PIPE_MSG *rt_pipe_alloc (size_t size)

{
    RT_PIPE_MSG *msg = (RT_PIPE_MSG *)xnheap_alloc(__pipe_heap,size +
sizeof(RT_PIPE_MSG));

    if (msg)
        {
        inith(&msg->link);
        msg->size = size;     <--- (*)
        }

    return msg;
}

Please take a look at testsuite/klatency/latency_module.c : latency() for a
correct use of the rt_pipe_alloc/send() calls.


>
> Nacho.
>

---
Best regards,
Dmitry
--0__=4EBBFA2ADFCB5FEB8f9e8a93df938690918c4EBBFA2ADFCB5FEB
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>xenomai-core-bounces@domain.hid wrote on 14.11.2005 16:56:01:<br>
<br>
&gt; Hi,<br>
&gt; <br>
&gt; I'm having now my first contact with the pipe framework, an have some<br>
&gt; comments about it that might be of interest to the core developers:<br>
&gt; <br>
&gt; While the documentation is overall *great*, I fould it a bit lacking<br>
&gt; regarding the pipes. Would be good to have some examples of general usage.</tt><br>
<br>
<tt>You may take a look at testsuite/klatency example that uses a pipe for rt kernel-mode task ---&gt; normal linux task communication.</tt><br>
<br>
<tt><br>
&gt; <br>
&gt; As far as I can tell, there is no mention of the usage of P_MSGPTR and<br>
&gt; P_MSGSIZE. I had to learn about them in the headers.<br>
&gt; <br>
&gt; At first sight, the rt_pipe_send call is confusing: why should I pass<br>
&gt; the data size since it is supposed to be embedded in the RT_PIPE_MSG<br>
&gt; structure?.<br>
&gt; <br>
&gt; This is what I first did:<br>
&gt; <br>
&gt; RT_PIPE_MSG *m = rt_pipe_alloc(sizeof(mystruct));<br>
&gt; P_MSGPTR(m) = &amp;mystruct;<br>
&gt; P_MSGSIZE(m) = sizeof(mystruct)<br>
&gt; rt_pipe_send(&amp;mypipe, m, sizeof(mystruct), P_NORMAL);</tt><br>
<br>
<br>
<tt>rt_pipe_write()</tt><br>
<tt>{</tt><br>
<tt>...</tt><br>
<tt>	msg = rt_pipe_alloc(size);</tt><br>
<br>
<tt> &nbsp; &nbsp;	if (!msg)</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp;return -ENOMEM;</tt><br>
<br>
<tt> &nbsp; &nbsp;	memcpy(P_MSGPTR(msg),buf,size);		&lt;---- copying, not storing a pointer like you did</tt><br>
<br>
<tt> &nbsp; &nbsp;	nbytes = rt_pipe_send(pipe,msg,size,mode);</tt><br>
<tt>...</tt><br>
<br>
<tt>Actually, if you have already a buffer filled with data, you may directly use a rt_pipe_write() call.</tt><br>
<br>
<tt>&gt; <br>
&gt; Which is obviously wrong. Please correct me if I'm wrong:</tt><br>
<tt>&gt; <br>
&gt; P_MSGPTR and P_MSGSIZE are intended not to be used as an lvalue (is<br>
&gt; there a way to define these macros to generate a compile error if they<br>
&gt; are?).<br>
&gt; <br>
&gt; So, the correct way would be something like this (again, correct me if<br>
&gt; I'm wrong)::<br>
&gt; <br>
&gt; RT_PIPE_MSG *m = rt_pipe_alloc(sizeof(mystruct_t));<br>
&gt; mystruct_t *p = (mystruct_t *)P_MSGPTR(m);<br>
&gt; p-&gt;whatever1 = X;<br>
&gt; p-&gt;whatever2 = X;<br>
&gt; rt_pipe_send(&amp;mypipe, m, sizeof(mystruct_t), P_NORMAL);<br>
&gt; <br>
&gt; If this is correct, why do I have to specify the size of mystruct_t<br>
&gt; *twice*. Can't it be initialized by rt_pipe_alloc ?.</tt><br>
<br>
<tt>It's initialized actually (*).</tt><br>
<br>
<tt>RT_PIPE_MSG *rt_pipe_alloc (size_t size)</tt><br>
<br>
<tt>{</tt><br>
<tt> &nbsp; &nbsp;RT_PIPE_MSG *msg = (RT_PIPE_MSG *)xnheap_alloc(__pipe_heap,size + sizeof(RT_PIPE_MSG));</tt><br>
<br>
<tt> &nbsp; &nbsp;if (msg)</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp;{</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp;inith(&amp;msg-&gt;link);</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp;msg-&gt;size = size;	&lt;--- (*)</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp;}</tt><br>
<br>
<tt> &nbsp; &nbsp;return msg;</tt><br>
<tt>}</tt><br>
<br>
<tt>Please take a look at testsuite/klatency/latency_module.c : latency() for a correct use of the rt_pipe_alloc/send() calls.</tt><br>
<br>
<tt><br>
&gt; <br>
&gt; Nacho.<br>
&gt; <br>
</tt><br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
</body></html>
--0__=4EBBFA2ADFCB5FEB8f9e8a93df938690918c4EBBFA2ADFCB5FEB--


