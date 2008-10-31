References: <857546.30206.qm@domain.hid>
	<490B32EF.8050503@domain.hid>
	<327543.30247.qm@domain.hid>
	<490B37D6.8050809@domain.hid>
Date: Fri, 31 Oct 2008 17:15:37 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-98243544-1225473337=:28773"
Message-ID: <352894.28773.qm@domain.hid>
Subject: Re: [Xenomai-help] floating point (int 16) exception
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

--0-98243544-1225473337=:28773
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A>No, you do not read the sources correctly. Xenomai does handle FPU=0A>e=
xception in primary mode. You know, I implemented part of this, so, you=0A>=
should not assume that I do not know what I am talking about.=0A=0AI *REALL=
Y* don't say you don't know what you say=0A(I ask you 'cause I think you kn=
ow... :)=0A=0Aring 3 xenomai task:=0Avoid xeno_task(void *cookie)=0A{=0A st=
atic long loop_count=3D0;=0A  unsigned int cw=3D0x360;=0A=0A  /* Unmask all=
 but not precision, the int 7 will be raised */=0A  __asm__ __volatile__("f=
ldcw %0;"::"m"(cw)); =0A  for (;;loop_count++) {=0A    rt_task_wait_period(=
NULL);=0A        rt_printf("Loop number: %ld\n", loop_count);=0A    /* Let'=
s raise an exception #16*/=0A    __asm__ __volatile__(=0A      "fldz;"=0A  =
    "fld1;"=0A      "fdivrp %st(0),%st(1);"=0A      "fwait;"=0A    ); =0A  =
}=0A}=0A=0Axnarch_fault_fpu_p is related to int 7 that It manage the TS bit=
 (fpu handling=0Aof save restore only if the task use fpu) and it works, it=
 doesn't switch to secondary=0Amode as you say.=0AIf I pass to Xenomai the =
exception 16 of fdivrp the task end 'cause (i thought) the=0Aswitch to seco=
ndary mode. Sorry if i bug you but i really need a suggestion.=0A=0A=0A    =
  Unisciti alla community di Io fotografo e video, il nuovo corso di fotogr=
afia di Gazzetta dello sport:=0Ahttp://www.flickr.com/groups/iofotografoevi=
deo
--0-98243544-1225473337=:28773
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"=
><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"><=
br>&gt;No, you do not read the sources correctly. Xenomai does handle FPU<b=
r>&gt;exception in primary mode. You know, I implemented part of this, so, =
you<br>&gt;should not assume that I do not know what I am talking about.<br=
><br>I *REALLY* don't say you don't know what you say<br>(I ask you 'cause =
I think you know... :)<br><br>ring 3 xenomai task:<br>void xeno_task(void *=
cookie)<br>{<br>&nbsp;static long loop_count=3D0;<br>&nbsp; unsigned int cw=
=3D0x360;<br><br>&nbsp; /* Unmask all but not precision, the int 7 will be =
raised */<br>&nbsp; __asm__ __volatile__("fldcw %0;"::"m"(cw));=0A<br>&nbsp=
; for (;;loop_count++) {<br>&nbsp;&nbsp;&nbsp; rt_task_wait_period(NULL);<b=
r>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rt_printf("Loop number: %ld\n", loo=
p_count);<br>&nbsp;&nbsp;&nbsp; /* Let's raise an exception #16*/<br>&nbsp;=
&nbsp;&nbsp; __asm__ __volatile__(<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "fldz;=
"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "fld1;"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; "fdivrp %st(0),%st(1);"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "fwait;"<br>&n=
bsp;&nbsp;&nbsp; );=0A<br>&nbsp; }<br>}<br><br>xnarch_fault_fpu_p is relate=
d to int 7 that It manage the TS bit (fpu handling<br>of save restore only =
if the task use fpu) and it works, it doesn't switch to secondary<br>=0Amod=
e as you say.<br>If I pass to Xenomai the exception 16 of fdivrp the task e=
nd 'cause (i thought) the<br>switch to secondary mode. Sorry if i bug you b=
ut i really need a suggestion.<br><br></div></div></div><br>=0A=0A=0A=0A   =
   <hr size=3D1><font face=3D"Arial" size=3D"2">Scopri la community di Io f=
otografo e video<br>=0A<a href=3Dhttp://us.rd.yahoo.com/SIG=3D11ud6kror/**h=
ttp%3A%2F%2Fwww.flickr.com%2Fgroups%2Fiofotografoevideo%2F>Il nuovo corso</=
a> di Gazzetta dello sport per diventare veri fotografi!</font></body></htm=
l>
--0-98243544-1225473337=:28773--

