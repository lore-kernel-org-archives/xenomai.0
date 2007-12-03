From: "Henk Geraads" <linux@domain.hid>
Date: Mon, 3 Dec 2007 13:58:35 +0100
Message-ID: <NGBBLNEOGLJIIJKLFLPFOEBFDFAA.linux@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_005E_01C835B4.99105930"
Subject: Re: [Xenomai-help] native pipe can not write
Reply-To: linux@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------=_NextPart_000_005E_01C835B4.99105930
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

we are currently using a PXA270 board with kernel 2.6.15 with xenomai =
2.2.2. We are having the same problem. We create a pipe like;
rt_pipe_create(&dti_pipe_wr, "DTI_FROM_UART", FIFO_WR, 1000);

i=3Drt_pipe_write(&dti_pipe_wr, data->dti_rcvbuf, 20, P_NORMAL)

we got error =3D -ENOMEM?

Is this the same error?

> -- Gilles Chanteperdrix wrote :=20
> wrote:
> > Hi,
> > I try to use the message pipe in native API, but I can not write t=
o the
> > pipe. Can anyone help me to find what is wrong?
> > And in Linux side it says:"write failed: Cannot allocate memory"
> > Thank you!
> > Following is the program and return message.
> > #./test_pipe
> > create return: 0, write return: -12, read return: -110
> >=20
> > #include <stdio.h>
> > #include <errno.h>
> > #include <native/task.h>
> > #include <sys/mman.h>
> >=20
> > RT_PIPE pipe_desc;
> > RT_TASK task;
> >=20
> > void op_pipe(void *arg)
> > {
> >         int  err, pipe_fd, wre, rre;
> >         char buf[16] =3D {'a', 'b', 'c'};
> >         char rd;
> >=20
> >         err =3D rt_pipe_create(&pipe_desc, "my_testpipe2", 3, 128);
> >         char tmp[] =3D {"test pipe"};
> >=20
> >         wre =3D rt_pipe_write(&pipe_desc, buf, 2, P_NORMAL);
> >         rre =3D rt_pipe_read(&pipe_desc, &rd, 2, 100);

> I do not know if this is related with your issue, but the receive bu=
ff
> is too small: you want write 2 bytes in a 1 byte buffer.
>
> --=20
>         Gilles Chanteperdrix.

If we create the pipe on the heap, that means at creation time with si=
ze '0' the pipe seems at first to works, but the memory of other proce=
sses (not related) is corrupted and those processes crashes!

Henk Geraads=20

------=_NextPart_000_005E_01C835B4.99105930
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=EF=BB=BF<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8">
<META content=3D"MSHTML 6.00.6000.16544" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>we are currently using a PXA270 board with =
kernel=20
2.6.15 with xenomai 2.2.2. We are having the same problem. We create a=
 pipe=20
like;<BR>rt_pipe_create(&amp;dti_pipe_wr, "DTI_FROM_UART", FIFO_WR,=20
1000);</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>i=3Drt_pipe_write(&amp;dti_pipe_wr,=20
data-&gt;dti_rcvbuf, 20, P_NORMAL)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>we got error =3D -ENOMEM?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Is this the same error?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN class=3D515555512-03122007>&gt; </=
SPAN>--=20
Gilles Chanteperdrix wrote :&nbsp;<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;wrote:<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt; Hi,<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt; I try to use the message=
 pipe in=20
native API, but I can not write to the<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt; pipe. Can anyone help me=
 to find=20
what is wrong?<BR><SPAN class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt; =
And in=20
Linux side it says:"write failed: Cannot allocate memory"<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt; Thank you!<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt; Following is the program=
 and=20
return message.<BR><SPAN class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt;=
=20
#./test_pipe<BR><SPAN class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt; cr=
eate=20
return: 0, write return: -12, read return: -110<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt;&nbsp;<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt; #include &lt;stdio.h&gt;=
<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt; #include &lt;errno.h&gt;=
<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt; #include=20
&lt;native/task.h&gt;<BR><SPAN class=3D515555512-03122007>&gt;</SPAN>&nbs=
p;&gt;=20
#include &lt;sys/mman.h&gt;<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt;&nbsp;<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt; RT_PIPE pipe_desc;<BR><S=
PAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt; RT_TASK task;<BR><SPAN=
=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt;&nbsp;<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt; void op_pipe(void *arg)<=
BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt; {<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
int&nbsp; err, pipe_fd, wre, rre;<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
char buf[16] =3D {'a', 'b', 'c'};<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
char rd;<BR><SPAN class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt;&nbsp;<=
BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
err =3D rt_pipe_create(&amp;pipe_desc, "my_testpipe2", 3, 128);<BR><SPAN=
=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
char tmp[] =3D {"test pipe"};<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt;&nbsp;<BR><SPAN=20
class=3D515555512-03122007>&gt;=20
</SPAN>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wre =3D=20
rt_pipe_write(&amp;pipe_desc, buf, 2, P_NORMAL);<BR><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
rre =3D rt_pipe_read(&amp;pipe_desc, &amp;rd, 2, 100);</FONT></FONT></DIV=
>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN class=3D515555512-03122007>&gt; </=
SPAN>I=20
do not know if this is related with your issue, but the receive buff<B=
R><SPAN=20
class=3D515555512-03122007>&gt; </SPAN>is too small: you want write 2 byt=
es in a 1=20
byte buffer.</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D515555512-03122007>&gt;</SPAN></FONT></DIV>
<DIV><SPAN class=3D515555512-03122007></SPAN><FONT face=3DArial size=3D2>&gt;<S=
PAN=20
class=3D515555512-03122007> </SPAN>-- </FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D515555512-03122007>&gt;</SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
Gilles Chanteperdrix.</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If we create the pipe on the heap, that mea=
ns at=20
creation time with size '0' the pipe seems at first to works, but the =
memory of=20
other processes (not related) is corrupted and those processes=20
crashes!</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Henk Geraads </FONT></DIV>
<DIV>&nbsp;</DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_005E_01C835B4.99105930--



