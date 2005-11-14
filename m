In-Reply-To: <4378BB28.8080804@domain.hid>
Subject: Re: [Xenomai-help] xn_pipe_create [minor]
Message-ID: <OF29DE1488.58718704-ONC12570B9.005A8D87-C12570B9.005B9BD6@domain.hid>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Mon, 14 Nov 2005 17:40:36 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA2ADFC90B178f9e8a93df938690918c4EBBFA2ADFC90B17"
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

--0__=4EBBFA2ADFC90B178f9e8a93df938690918c4EBBFA2ADFC90B17
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: quoted-printable



Ignacio Garc=EDa P=E9rez <iggarpe@domain.hid> wrote on 14.11.2005 17:28:2=
4:

> Dmitry Adamushko wrote:
>
> > xenomai-help-bounces@domain.hid wrote on 14.11.2005 13:15:07:
> >
> > > Hi,
> > >
> > > The registry system is great, allows to forget about agreeing abo=
ut
an
> > > arbitrary minor number for pipes. But as far as I ca see, you sti=
ll
have
> > > to pass an unique "minor" number to rt_pipe_create.
> > >
> > > What if you have several rt modules?... you must make sure you as=
sign
> > > different minor numbers to each pipe!.
> > >
> > > Wouldn't be useful to have a way to let the rt_pipe_create decide=

which
> > > minor to use? (a free one, of course)
> >
> > It can be done and that would work if both sides of the communicati=
on
> > channel are real-time threads so a rt_pipe_create/bind() pair may b=
e
> > used to establish a connection.
> >
> > But what should be done if another side is a linux task and uses a
> > mere open() call?
> >
> > Currently, a naming convention is a "/dev/rtpN", N - is a minor bei=
ng
> > used by rt_pipe_create() and both sides of the channel must be awar=
e
> > of it.
> >
> > Moreover, a client side of the connection may be open even in case
> > there is no server side yet (the one that calls rt_pipe_create) at =
the
> > mement. In that case, the client is blocked in open().
> >
> > So the only convention between both sides can be a minor number +
> > pre-created /dev/rtp[0, OPT_PIPE_NRDEV] character devices.
> >
> Um... I think you are wrong. When the rt task creates a pipe, a symbo=
lik
> link appears at /proc/xenomai/registry/pipes. Its name is the fifo na=
me,
> and points to the /dev/rtpN device. That's what I was talking about w=
hen
> I said "clever procfs usage of xenomai".
>
> Using this scheme, user mode programs just need to open()
> /proc/xenomai/registry/pipes/whatever to access a named pipe, without=

> having to know the minor number.
>
> Under these circumstances, it would be *very* useful to have
> rt_pipe_create choose an unused minor automagically (for example pass=
ing
> -1 as the minor).
>
> Currently, I'm emulating this by calling rt_pipe_create for minor =3D=

> 0,1,2... until it succeeds or returns any error different than -EBUSY=
.
>

Ok, I have missed that point. But one more thing I have pointed out bef=
ore
remains.

Currently it's possible to have a client blocked in open(/dev/rtpN, fla=
gs)
waiting for a pipe to be created (if flags does contain O_NONBLOCK). An=
d it
can be done only through /dev/rtpN since there is still nothing at
/proc/xenomai/registry/pipe/ (there is no pipe object yet created by th=
e
"server" side).

Does anybody need that? me, no at the moment.

Ok, we can keep actually this functionality as well but just extend the=

rt_pipe_create() interface to

rt_pipe_create (&pipe, whatever_name, PIPE_MINOR_AUTO)

so in that case a minor value will be "auto-generated" without a need t=
o
bother a user. And the old interface is still can be used.

Technically, nothing difficult to implement that.


> Nacho.

---
Best regards,
Dmitry
=

--0__=4EBBFA2ADFC90B178f9e8a93df938690918c4EBBFA2ADFC90B17
Content-type: text/html; charset=ISO-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>Ignacio Garc=EDa P=E9rez &lt;iggarpe@domain.hid&gt; wrote on 14.11=
.2005 17:28:24:<br>
<br>
&gt; Dmitry Adamushko wrote:<br>
&gt; <br>
&gt; &gt; xenomai-help-bounces@domain.hid wrote on 14.11.2005 13:15:07:<br=
>
&gt; &gt;<br>
&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The registry system is great, allows to forget about agr=
eeing about an<br>
&gt; &gt; &gt; arbitrary minor number for pipes. But as far as I ca see=
, you still have<br>
&gt; &gt; &gt; to pass an unique &quot;minor&quot; number to rt_pipe_cr=
eate.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; What if you have several rt modules?... you must make su=
re you assign<br>
&gt; &gt; &gt; different minor numbers to each pipe!.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Wouldn't be useful to have a way to let the rt_pipe_crea=
te decide which<br>
&gt; &gt; &gt; minor to use? (a free one, of course)<br>
&gt; &gt;<br>
&gt; &gt; It can be done and that would work if both sides of the commu=
nication<br>
&gt; &gt; channel are real-time threads so a rt_pipe_create/bind() pair=
 may be<br>
&gt; &gt; used to establish a connection.<br>
&gt; &gt;<br>
&gt; &gt; But what should be done if another side is a linux task and u=
ses a<br>
&gt; &gt; mere open() call?<br>
&gt; &gt;<br>
&gt; &gt; Currently, a naming convention is a &quot;/dev/rtpN&quot;, N =
- is a minor being<br>
&gt; &gt; used by rt_pipe_create() and both sides of the channel must b=
e aware<br>
&gt; &gt; of it.<br>
&gt; &gt;<br>
&gt; &gt; Moreover, a client side of the connection may be open even in=
 case<br>
&gt; &gt; there is no server side yet (the one that calls rt_pipe_creat=
e) at the<br>
&gt; &gt; mement. In that case, the client is blocked in open().<br>
&gt; &gt;<br>
&gt; &gt; So the only convention between both sides can be a minor numb=
er +<br>
&gt; &gt; pre-created /dev/rtp[0, OPT_PIPE_NRDEV] character devices.<br=
>
&gt; &gt;<br>
&gt; Um... I think you are wrong. When the rt task creates a pipe, a sy=
mbolik<br>
&gt; link appears at /proc/xenomai/registry/pipes. Its name is the fifo=
 name,<br>
&gt; and points to the /dev/rtpN device. That's what I was talking abou=
t when<br>
&gt; I said &quot;clever procfs usage of xenomai&quot;.<br>
&gt; <br>
&gt; Using this scheme, user mode programs just need to open()<br>
&gt; /proc/xenomai/registry/pipes/whatever to access a named pipe, with=
out<br>
&gt; having to know the minor number.<br>
&gt; <br>
&gt; Under these circumstances, it would be *very* useful to have<br>
&gt; rt_pipe_create choose an unused minor automagically (for example p=
assing<br>
&gt; -1 as the minor).<br>
&gt; <br>
&gt; Currently, I'm emulating this by calling rt_pipe_create for minor =
=3D<br>
&gt; 0,1,2... until it succeeds or returns any error different than -EB=
USY.<br>
&gt; <br>
</tt><br>
<tt>Ok, I have missed that point. But one more thing I have pointed out=
 before remains.</tt><br>
<br>
<tt>Currently it's possible to have a client blocked in open(/dev/rtpN,=
 flags) waiting for a pipe to be created (if flags does </tt><tt>contai=
n O_NONBLOCK</tt><tt>). And it can be done only through /dev/rtpN since=
 there is still nothing at /proc/xenomai/registry/pipe/ (there is no pi=
pe object yet created by the &quot;server&quot; side).</tt><br>
<br>
<tt>Does anybody need that? me, no at the moment.</tt><br>
<br>
<tt>Ok, we can keep actually this functionality as well but just extend=
 the rt_pipe_create() interface to </tt><br>
<br>
<tt>rt_pipe_create (&amp;pipe, whatever_name, PIPE_MINOR_AUTO)</tt><br>=

<br>
<tt>so in that case a minor value will be &quot;auto-generated&quot; wi=
thout a need to bother a user. And the old interface is still can be us=
ed.</tt><br>
<br>
<tt>Technically, nothing difficult to implement that.</tt><br>
<br>
<br>
<tt>&gt; Nacho.</tt><br>
<br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
<tt><br>
</tt></body></html>=

--0__=4EBBFA2ADFC90B178f9e8a93df938690918c4EBBFA2ADFC90B17--


