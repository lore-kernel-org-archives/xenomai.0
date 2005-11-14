In-Reply-To: <43787FCB.2050909@domain.hid>
Subject: Re: [Xenomai-help] xn_pipe_create [minor]
Message-ID: <OFEDEE04A0.61E312DA-ONC12570B9.0044844D-C12570B9.004C5251@domain.hid>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Mon, 14 Nov 2005 14:53:38 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA2ADFD702DD8f9e8a93df938690918c4EBBFA2ADFD702DD"
Content-Disposition: inline
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ignacio =?ISO-8859-1?Q?Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

--0__=4EBBFA2ADFD702DD8f9e8a93df938690918c4EBBFA2ADFD702DD
Content-type: text/plain; charset=US-ASCII


xenomai-help-bounces@domain.hid wrote on 14.11.2005 13:15:07:

> Hi,
>
> The registry system is great, allows to forget about agreeing about an
> arbitrary minor number for pipes. But as far as I ca see, you still have
> to pass an unique "minor" number to rt_pipe_create.
>
> What if you have several rt modules?... you must make sure you assign
> different minor numbers to each pipe!.
>
> Wouldn't be useful to have a way to let the rt_pipe_create decide which
> minor to use? (a free one, of course)

It can be done and that would work if both sides of the communication
channel are real-time threads so a rt_pipe_create/bind() pair may be used
to establish a connection.

But what should be done if another side is a linux task and uses a mere
open() call?

Currently, a naming convention is a "/dev/rtpN", N - is a minor being used
by rt_pipe_create() and both sides of the channel must be aware of it.

Moreover, a client side of the connection may be open even in case there is
no server side yet (the one that calls rt_pipe_create) at the mement. In
that case, the client is blocked in open().

So the only convention between both sides can be a minor number +
pre-created /dev/rtp[0, OPT_PIPE_NRDEV] character devices.

>
> Nacho.
>

---
Best regards,
Dmitry
--0__=4EBBFA2ADFD702DD8f9e8a93df938690918c4EBBFA2ADFD702DD
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>xenomai-help-bounces@domain.hid wrote on 14.11.2005 13:15:07:<br>
<br>
&gt; Hi,<br>
&gt; <br>
&gt; The registry system is great, allows to forget about agreeing about an<br>
&gt; arbitrary minor number for pipes. But as far as I ca see, you still have<br>
&gt; to pass an unique &quot;minor&quot; number to rt_pipe_create.<br>
&gt; <br>
&gt; What if you have several rt modules?... you must make sure you assign<br>
&gt; different minor numbers to each pipe!.<br>
&gt; <br>
&gt; Wouldn't be useful to have a way to let the rt_pipe_create decide which<br>
&gt; minor to use? (a free one, of course)</tt><br>
<br>
<tt>It can be done and that would work if both sides of the communication channel are real-time threads so a rt_pipe_create/bind() pair may be used to establish a connection.</tt><br>
<br>
<tt>But what should be done if another side is a linux task and uses a mere open() call?</tt><br>
<br>
<tt>Currently, a naming convention is a &quot;/dev/rtpN&quot;, N - is a minor being used by rt_pipe_create() and both sides of the channel must be aware of it.</tt><br>
<br>
<tt>Moreover, a client side of the connection may be open even in case there is no server side yet (the one that calls rt_pipe_create) at the mement. In that case, the client is blocked in open().</tt><br>
<br>
<tt>So the only convention between both sides can be a minor number + pre-created /dev/rtp[0, OPT_PIPE_NRDEV] character devices.</tt><br>
<tt><br>
&gt; <br>
&gt; Nacho.<br>
&gt; <br>
</tt><br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
</body></html>
--0__=4EBBFA2ADFD702DD8f9e8a93df938690918c4EBBFA2ADFD702DD--


