MIME-Version: 1.0
In-Reply-To: <4A3010BE.9020107@domain.hid>
References: <6a782b880906051338r401163b2m7e1d1a53f7f0800@domain.hid> 
	<4A299794.6010504@domain.hid>
	<6a782b880906101236l625792d5p6fcd3dad53e965a2@domain.hid> 
	<4A3010BE.9020107@domain.hid>
From: Thiago Lima <thiagolims@domain.hid>
Date: Fri, 17 Jul 2009 08:18:45 -0300
Message-ID: <6a782b880907170418q6bd4fbe7p6fde0f0c6bae551c@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd5149cc6f458046ee4f435
Subject: Re: [Xenomai-help] Get ready queue
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
Cc: xenomai@xenomai.org

--000e0cd5149cc6f458046ee4f435
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am doing an schedulability test of real time processes in Xenomai. So
that, when a new task is started in system, i need to get all threads from
system, including the new one and make a test to decide if this workset is
schedulable.

I have a linux kernel module with a hook that is called whenever a task is
started. Besides, i have to apply a patch to xenomai kernel in order to
allow the hooks calling when a user space task is started.

My question is: how can i get all ready xenomai tasks ? Because i need to
get the amount of threads to do this test.

Sorry for my last email. I have not so much time to write and it was vague.

att,

Thiago.

On Wed, Jun 10, 2009 at 4:59 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Thiago Lima wrote:
> > Sorry, i didnt understand you answer.
>
> The question was vague, so was the answer.
>
> > I get the global queue doing this:
> >
> > threads =3D &pod->threadq;    // GLOBAL QUEUE
> > holder =3D getheadq(&nkpod->threadq); //HEAD NODE
>
> These are internal data, you are not supposed to access them that way.
> Besides threadq is not the ready queue. And with the recent advent of
> the scheduler classes, you could not do the same modification for the
> latest version of Xenomai. In short, it is a bad idea, really.
>
> If you explained us what you are trying to do (and not how you are
> trying to do it), maybe we could help. Chances are that you can do what
> you do without changing Xenomai core, simply using hooks for instance.
>
> --
>                                             Gilles.
>



--=20
Thiago Lima Silva
Graduando - Ci=EAncia da Computa=E7=E3o UFBA
Registered Linux user #466887

--000e0cd5149cc6f458046ee4f435
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am doing an schedulability test of real time processes in Xenomai. So
that, when a new task is started in system, i need to get all threads
from system, including the new one and make a test to decide if this
workset is schedulable.<br>
<br>
I have a linux kernel module with a hook that is called whenever a task
is started. Besides, i have to apply a patch to xenomai kernel in order
to allow the hooks calling when a user space task is started.<br>
<br>
My question is: how can i get all ready xenomai tasks ? Because i need to g=
et the amount of threads to do this test.<br>
<br>
Sorry for my last email. I have not so much time to write and it was vague.=
<br>
<br>
att,<br>
<br>
Thiago.<br><br><div class=3D"gmail_quote">On Wed, Jun 10, 2009 at 4:59 PM, =
Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chantep=
erdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<=
br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>Thiago Lima wrote:<br>
&gt; Sorry, i didnt understand you answer.<br>
<br>
</div>The question was vague, so was the answer.<br>
<div class=3D"im"><br>
&gt; I get the global queue doing this:<br>
&gt;<br>
&gt; threads =3D &amp;pod-&gt;threadq; =A0 =A0// GLOBAL QUEUE<br>
&gt; holder =3D getheadq(&amp;nkpod-&gt;threadq); //HEAD NODE<br>
<br>
</div>These are internal data, you are not supposed to access them that way=
.<br>
Besides threadq is not the ready queue. And with the recent advent of<br>
the scheduler classes, you could not do the same modification for the<br>
latest version of Xenomai. In short, it is a bad idea, really.<br>
<br>
If you explained us what you are trying to do (and not how you are<br>
trying to do it), maybe we could help. Chances are that you can do what<br>
you do without changing Xenomai core, simply using hooks for instance.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Thiago Lima Silv=
a<br>Graduando - Ci=EAncia da Computa=E7=E3o UFBA<br>Registered Linux user =
#466887<br><br>

--000e0cd5149cc6f458046ee4f435--

