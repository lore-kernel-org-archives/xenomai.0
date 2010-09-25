Message-Id: <8sld2b$hq8lvg@domain.hid>
From: "Gao" <gwysu@domain.hid>
Date: Sat, 25 Sep 2010 08:36:27 +0800
MIME-Version: 1.0
Content-Type: multipart/related;
	boundary="----=_NextPart_000_0049_01CB5C8C.C06FCB80"
In-Reply-To: 
Subject: [Xenomai-help] Unloading xeno_psos cannot cleanup some sources
	completely.
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

------=_NextPart_000_0049_01CB5C8C.C06FCB80
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_004A_01CB5C8C.C0721570"


------=_NextPart_001_004A_01CB5C8C.C0721570
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi  All ,
 
After I load xeno_psos.ko by "/sbin/insmod xeno_psos.ko", and run my test
program, whic create a queue by "q_vcreate", but not delete it in the test
program.  After I finish running my test program. Then I unload the
xeno_psos and then reload it again, it will crash as follow:     
 
 
 /sbin/rmmod xeno_psos
Xenomai: stopping pSOS+ services.

# /sbin/insmod xeno_psos.ko
Xenomai: starting pSOS+ services.
proc_dir_entry 'registry/psos' already registered
------------[ cut here ]------------
Badness at fs/proc/generic.c:590
NIP: c00f7988 LR: c00f7988 CTR: c0027f20
REGS: c182bda0 TRAP: 0700   Not tainted  (2.6.33.4)
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22000442  XER: 00000000
TASK = c181cc60[4] 'events/0' THREAD: c182a000
GPR00: c00f7988 c182be50 c181cc60 00000038 c03bd180 c0394ae0 00000000
3eced82e
GPR08: 00000100 00000000 00000003 c182a000 42000424 100af23c 01ffe800
01ff50a0
GPR16: 01fd05d8 01ff507c c0348e18 c0320aa8 c182bea8 c03bd77c c0394fd8
c313e7c4
GPR24: c313e950 c0394fd8 00000000 c1881700 c1a35a80 c1a35600 c1a35ae0
c1a35600
NIP [c00f7988] proc_register+0xe4/0x1d0
LR [c00f7988] proc_register+0xe4/0x1d0
Call Trace:
[c182be50] [c00f7988] proc_register+0xe4/0x1d0 (unreliable)
[c182be80] [c00f7b90] create_proc_entry+0x60/0xac
[c182bea0] [c0056d10] registry_proc_callback+0x318/0x394
[c182bf60] [c002fe6c] worker_thread+0x12c/0x1c4
[c182bfc0] [c0033dcc] kthread+0x78/0x7c
[c182bff0] [c000f6c0] kernel_thread+0x4c/0x68
Instruction dump:
2f9f0000 419e0034 807f0008 7fc4f378 4bf1ab6d 2f830000 409effe4 809b0008
3c60c032 7fc5f378 38636ce4 4bf264a5 <0fe00000> 83bb0038 939b0038 93bc0030

 
 
 
The problem is caused by the reason that unloading xeno_psos.ko  cannot
clean up the the queues show as follow: 
 
# pwd
/proc/xenomai/registry/psos/queues
# ls
cmq  q2r

 
So can the problem be fixed? Thanks.
 
 
Best regards,
Wenyi Gao

 


------=_NextPart_001_004A_01CB5C8C.C0721570
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE id=3DridTitle>Blank</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<STYLE><!-- body  { font-family: Arial, Helvetica; font-size: 10pt; =
color: #000000; margin-top: 25px; margin-left: 25px; } P.msoNormal, =
LI.msoNormal  { font-family: Helvetica, "Times New Roman"; font-size: =
10pt; margin-top: 0px; margin-left: 0px; color: "#ffffcc"; } --></STYLE>

<META content=3D"MSHTML 6.00.2900.3698" name=3DGENERATOR></HEAD>
<BODY id=3DridBody background=3Dcid:353523400@domain.hid>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D486354802-05122007><FONT =
size=3D3>Hi<SPAN=20
class=3D366431409-21092010>&nbsp;<SPAN class=3D353523400-25092010><FONT=20
size=3D4>&nbsp;All&nbsp;</FONT></SPAN>,</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D366431409-21092010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D366431409-21092010>After I load </SPAN></FONT></SPAN><SPAN=20
class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D366431409-21092010>xeno_psos.ko&nbsp;by "/sbin/insmod =
xeno_psos.ko", and=20
run&nbsp;my test program, whic create a queue by "q_vcreate", =
but&nbsp;not=20
delete it in the test program.&nbsp;&nbsp;After I finish running my test =

program.&nbsp;Then I unload the xeno_psos and then reload it again, it =
will=20
crash as follow:</SPAN>&nbsp;&nbsp;&nbsp;&nbsp; </FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D4>&nbsp;/sbin/rmmod=20
xeno_psos<BR>Xenomai: stopping pSOS+ services.</FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D4><BR># /sbin/insmod=20
xeno_psos.ko<BR>Xenomai: starting pSOS+ services.<BR>proc_dir_entry=20
'registry/psos' already registered<BR>------------[ cut here=20
]------------<BR>Badness at fs/proc/generic.c:590<BR>NIP: c00f7988 LR: =
c00f7988=20
CTR: c0027f20<BR>REGS: c182bda0 TRAP: 0700&nbsp;&nbsp; Not tainted&nbsp; =

(2.6.33.4)<BR>MSR: 00029032 &lt;EE,ME,CE,IR,DR&gt;&nbsp; CR: =
22000442&nbsp; XER:=20
00000000<BR>TASK =3D c181cc60[4] 'events/0' THREAD: c182a000<BR>GPR00: =
c00f7988=20
c182be50 c181cc60 00000038 c03bd180 c0394ae0 00000000 3eced82e<BR>GPR08: =

00000100 00000000 00000003 c182a000 42000424 100af23c 01ffe800=20
01ff50a0<BR>GPR16: 01fd05d8 01ff507c c0348e18 c0320aa8 c182bea8 c03bd77c =

c0394fd8 c313e7c4<BR>GPR24: c313e950 c0394fd8 00000000 c1881700 c1a35a80 =

c1a35600 c1a35ae0 c1a35600<BR>NIP [c00f7988] =
proc_register+0xe4/0x1d0<BR>LR=20
[c00f7988] proc_register+0xe4/0x1d0<BR>Call Trace:<BR>[c182be50] =
[c00f7988]=20
proc_register+0xe4/0x1d0 (unreliable)<BR>[c182be80] [c00f7b90]=20
create_proc_entry+0x60/0xac<BR>[c182bea0] [c0056d10]=20
registry_proc_callback+0x318/0x394<BR>[c182bf60] [c002fe6c]=20
worker_thread+0x12c/0x1c4<BR>[c182bfc0] [c0033dcc]=20
kthread+0x78/0x7c<BR>[c182bff0] [c000f6c0]=20
kernel_thread+0x4c/0x68<BR>Instruction dump:<BR>2f9f0000 419e0034 =
807f0008=20
7fc4f378 4bf1ab6d 2f830000 409effe4 809b0008<BR>3c60c032 7fc5f378 =
38636ce4=20
4bf264a5 &lt;0fe00000&gt; 83bb0038 939b0038 =
93bc0030<BR></DIV></FONT></SPAN>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D366431409-21092010><FONT=20
size=3D3></FONT></SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D366431409-21092010><FONT=20
size=3D3>The problem is caused by the reason that unloading <SPAN=20
class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D366431409-21092010>xeno_psos.ko&nbsp; cannot clean up =
the&nbsp;the queues=20
show as follow:&nbsp;</SPAN></FONT></SPAN></FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D366431409-21092010><FONT=20
size=3D3><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D366431409-21092010></SPAN></FONT></SPAN></FONT></SPAN></SPAN>&nbs=
p;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D366431409-21092010><FONT=20
size=3D3><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D366431409-21092010># =
pwd<BR>/proc/xenomai/registry/psos/queues<BR>#=20
ls<BR>cmq&nbsp; q2r<BR></SPAN></FONT></SPAN></FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D366431409-21092010><FONT=20
size=3D3><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D366431409-21092010></SPAN></FONT></SPAN></FONT></SPAN></SPAN>&nbs=
p;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D366431409-21092010><FONT=20
size=3D3><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D366431409-21092010>So<SPAN class=3D353523400-25092010><FONT=20
size=3D4>&nbsp;can&nbsp;</FONT></SPAN>the problem<FONT size=3D4><SPAN=20
class=3D353523400-25092010>&nbsp;</SPAN><SPAN =
class=3D353523400-25092010>be=20
fixed</SPAN></FONT>? =
Thanks.</SPAN></FONT></SPAN></FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D366431409-21092010><FONT=20
size=3D3><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D366431409-21092010><FONT=20
size=3D4></FONT>&nbsp;</DIV></SPAN></FONT></SPAN></FONT></SPAN></SPAN>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Best=20
regards,</FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Wenyi=20
Gao</FONT></SPAN></DIV><IFRAME width=3D100 height=3D0></IFRAME>
<P><FONT size=3D4></FONT>&nbsp;</P></BODY></HTML>

------=_NextPart_001_004A_01CB5C8C.C0721570--

------=_NextPart_000_0049_01CB5C8C.C06FCB80
Content-Type: image/gif;
	name="Blank Bkgrd.gif"
Content-Transfer-Encoding: base64
Content-ID: <353523400@domain.hid>

R0lGODlhLQAtAID/AP////f39ywAAAAALQAtAEACcAxup8vtvxKQsFon6d02898pGkgiYoCm6sq2
7iqWcmzOsmeXeA7uPJd5CYdD2g9oPF58ygqz+XhCG9JpJGmlYrPXGlfr/Yo/VW45e7amp2tou/lW
xo/zX513z+Vt+1n/tiX2pxP4NUhy2FM4xtjIUQAAOw==

------=_NextPart_000_0049_01CB5C8C.C06FCB80--


