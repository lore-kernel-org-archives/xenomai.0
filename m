In-Reply-To: <4378BE29.7070008@domain.hid>
Subject: Re: [Xenomai-help] xn_pipe_create [minor]
Message-ID: <OF904A8BBE.F91DE4A2-ONC12570B9.005BDDF6-C12570B9.005CB25A@datacon.at>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Mon, 14 Nov 2005 17:52:29 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA2ADFC85B668f9e8a93df938690918c4EBBFA2ADFC85B66"
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

--0__=4EBBFA2ADFC85B668f9e8a93df938690918c4EBBFA2ADFC85B66
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: quoted-printable



Ignacio Garc=EDa P=E9rez <iggarpe@domain.hid> wrote on 14.11.2005 17:41:1=
3:

>
> >> Using this scheme, user mode programs just need to open()
> >> /proc/xenomai/registry/pipes/whatever to access a named pipe, with=
out
> >> having to know the minor number.
> >>
> >> Under these circumstances, it would be *very* useful to have
> >> rt_pipe_create choose an unused minor automagically (for example
passing
> >> -1 as the minor).

ah.. yep, that's what I have meant with a PIPE_MINOR_AUTO thing :)

> >>
> >
> > Sounds reasonable.
>
> On the heels of our abs/rel discussion, I suggest to use a #define
> istead of -1
>
> Will you implement it, or should I give a try?
>

If you want to have some fun (and you have some time and desire for tha=
t)
then go ahead :) Otherwise, no problem, I'll do that.


> Nacho.
>

---
Best regards,
Dmitry=

--0__=4EBBFA2ADFC85B668f9e8a93df938690918c4EBBFA2ADFC85B66
Content-type: text/html; charset=ISO-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>Ignacio Garc=EDa P=E9rez &lt;iggarpe@domain.hid&gt; wrote on 14.11=
.2005 17:41:13:<br>
<br>
&gt; <br>
&gt; &gt;&gt; Using this scheme, user mode programs just need to open()=
<br>
&gt; &gt;&gt; /proc/xenomai/registry/pipes/whatever to access a named p=
ipe, without<br>
&gt; &gt;&gt; having to know the minor number.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Under these circumstances, it would be *very* useful to h=
ave<br>
&gt; &gt;&gt; rt_pipe_create choose an unused minor automagically (for =
example passing<br>
&gt; &gt;&gt; -1 as the minor).<br>
</tt><br>
<tt>ah.. yep, that's what I have meant with a PIPE_MINOR_AUTO thing :)<=
/tt><br>
<br>
<tt>&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; Sounds reasonable.<br>
&gt; <br>
&gt; On the heels of our abs/rel discussion, I suggest to use a #define=
<br>
&gt; istead of -1<br>
&gt; <br>
&gt; Will you implement it, or should I give a try?<br>
&gt; <br>
</tt><br>
<tt>If you want to have some fun (and you have some time and desire for=
 that) then go ahead :) Otherwise, no problem, I'll do that.</tt><br>
<br>
<br>
<tt>&gt; Nacho.<br>
&gt; <br>
</tt><br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
</body></html>=

--0__=4EBBFA2ADFC85B668f9e8a93df938690918c4EBBFA2ADFC85B66--


