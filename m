Date: Mon, 17 Dec 2007 14:20:50 +0000 (GMT)
From: Michael Trimarchi <trimarchimichael@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1244056849-1197901250=:86920"
Message-ID: <168027.86920.qm@domain.hid>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

--0-1244056849-1197901250=:86920
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0AHi,=0A>> >Wait a minute. You mean that you want more than 5000 interrupt=
s by=0A>> >second ? Are you sure you do not get overruns with plain, unpatc=
hed=0A>> >Linux, if you load it sufficiently ?=0A>> If you do a simple coun=
t ( 115200 bps ) considering buffer length =3D 1=0A the=0A>> answer is yes.=
=0A>>=0A>> :)=0A>>=0A>> regards Michael=0A>>=0A>> PS work with linux=0A=0A>=
Do you observe this behaviour with I-pipe only or with Xenomai running=0A>?=
 If we xenomai, could you try only booting Linux with I-pipe enabled=0A>?=
=0A>=0A>-- =0A>                                               Gilles Chante=
perdrix=0A=0AI report this only using ipipe. I have some trouble with xenom=
ai, that I will try to solve ( see below )=0A=0A=0A=3D=3D Sampling period: =
100 us=0A=3D=3D Test mode: periodic user-mode task=0A=3D=3D All results in =
microseconds=0Awarming up...=0AI-pipe: Detected illicit call from domain 'X=
enomai'=0A        into a service reserved for domain 'Linux' and below.=0A[=
<c0021988>] (show_stack+0x0/0x48) from [<c005cca0>] (ipipe_check_context+0x=
88/0xa4)=0A[<c005cc18>] (ipipe_check_context+0x0/0xa4) from [<c0057e40>] (s=
earch_module_extables+0x3c/0xe8)=0A r5:00000000 r4:c0063cf0=0A[<c0057e04>] =
(search_module_extables+0x0/0xe8) from [<c004887c>] (search_exception_table=
s+0x30/0x3c)=0A r8:00000154 r7:00000017 r6:00000000 r5:c0271e00 r4:c0063cf0=
=0A[<c004884c>] (search_exception_tables+0x0/0x3c) from [<c00231c0>] (fixup=
_exception+0x18/0x30)=0A r4:c0271e00=0A[<c00231a8>] (fixup_exception+0x0/0x=
30) from [<c002339c>] (__do_kernel_fault+0x24/0x7c)=0A r4:00000154=0A[<c002=
3378>] (__do_kernel_fault+0x0/0x7c) from [<c0023670>] (do_page_fault+0x27c/=
0x29c)=0A r7:00000000 r6:c0266520 r5:c01a1e6c r4:ffffffff=0A[<c00233f4>] (d=
o_page_fault+0x0/0x29c) from [<c001c2c8>] (do_DataAbort+0x3c/0x11c)=0A[<c00=
1c28c>] (do_DataAbort+0x0/0x11c) from [<c001cb40>] (__dabt_svc+0x40/0x60)=
=0AException stack(0xc0271e00 to 0xc0271e48)=0A1e00: 204c0000 c0457860 4000=
0093 40000093 c0457860 00000000 c01bf860 00000000 =0A1e20: c0280b30 c027000=
0 c01bf890 c0271e80 00000000 c0271e48 c0063ce4 c0063cf0 =0A1e40: 40000093 f=
fffffff                                                       =0A r8:c0280b=
30 r7:00000000 r6:c01bf860 r5:c0271e34 r4:ffffffff=0A[<c00636ec>] (xnpod_sc=
hedule+0x0/0x7ac) from [<c00608f8>] (xnintr_clock_handler+0xa8/0x124)=0A[<c=
0060850>] (xnintr_clock_handler+0x0/0x124) from [<c005deb0>] (__ipipe_dispa=
tch_wired+0xdc/0x104)=0A r8:c0266520 r7:c01bf480 r6:c01a8120 r5:c01aa4e0 r4=
:c01bd140=0A[<c005ddd4>] (__ipipe_dispatch_wired+0x0/0x104) from [<c0021efc=
>] (__ipipe_handle_irq+0x94/0x1c8)=0A r6:c0271f20 r5:00000011 r4:c01bd140=
=0A[<c0021e68>] (__ipipe_handle_irq+0x0/0x1c8) from [<c00220f4>] (__ipipe_g=
rab_irq+0xc4/0x120)=0A[<c0022030>] (__ipipe_grab_irq+0x0/0x120) from [<c001=
cb90>] (__irq_svc+0x30/0x78)=0A r8:c0266520 r7:c0457860 r6:00000011 r5:feff=
f000 r4:ffffffff=0A[<c014e0d4>] (schedule+0x0/0x814) from [<c006af54>] (gat=
ekeeper_thread+0xfc/0x194)=0A[<c006ae58>] (gatekeeper_thread+0x0/0x194) fro=
m [<c004b1a4>] (kthread+0x58/0x90)=0A[<c004b14c>] (kthread+0x0/0x90) from [=
<c003780c>] (do_exit+0x0/0x94c)=0A r6:00000000 r5:00000000 r4:00000000=0A=
=0A=0AThere is a patch to using the serial device with DMA too and I use it=
 with other board=0A=0A equipped with the at91rm9200. But my question is th=
is:=0A=0A=0A=0Aspi prioriy < serial priority=0A=0A=0A=0AIn linux the interr=
upt nesting is controlled by the hardware logic. Is it true?=0A=0A=0A=0AThe=
 priority is mainted using ipipe in at91sam9260? =0A=0A=0A=0A=0A=0ARegards =
Michael=0A=0A=0A=0A=0A=0A=0A      ___________________________________ =0AL'=
email della prossima generazione? Puoi averla con la nuova Yahoo! Mail: =0A=
http://it.docs.yahoo.com/nowyoucan.html
--0-1244056849-1197901250=:86920
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:10pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 10pt;"><br><div style=3D"font-family: times new roman,new =
york,times,serif; font-size: 12pt;">Hi,<br>&gt;&gt; &gt;Wait a minute. You =
mean that you want more than 5000 interrupts by<br>&gt;&gt; &gt;second ? Ar=
e you sure you do not get overruns with plain, unpatched<br>&gt;&gt; &gt;Li=
nux, if you load it sufficiently ?<br>&gt;&gt; If you do a simple count ( 1=
15200 bps ) considering buffer length =3D 1=0A the<br>&gt;&gt; answer is ye=
s.<br>&gt;&gt;<br>&gt;&gt; :)<br>&gt;&gt;<br>&gt;&gt; regards Michael<br>&g=
t;&gt;<br>&gt;&gt; PS work with linux<br><br>&gt;Do you observe this behavi=
our with I-pipe only or with Xenomai running<br>&gt;? If we xenomai, could =
you try only booting Linux with I-pipe enabled<br>&gt;?<br>&gt;<br>&gt;-- <=
br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp;  Gilles Chanteperdrix<br><br>I report this only using ipi=
pe. I have some trouble with xenomai, that I will try to solve ( see below =
)<br><br><br>=3D=3D Sampling period: 100 us<br>=3D=3D Test mode: periodic u=
ser-mode task<br>=3D=3D All results in microseconds<br>warming up...<br>I-p=
ipe: Detected illicit call from domain 'Xenomai'<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; into a service reserved for domain 'Linux' and below.<b=
r>[&lt;c0021988&gt;] (show_stack+0x0/0x48) from
 [&lt;c005cca0&gt;] (ipipe_check_context+0x88/0xa4)<br>[&lt;c005cc18&gt;] (=
ipipe_check_context+0x0/0xa4) from [&lt;c0057e40&gt;] (search_module_extabl=
es+0x3c/0xe8)<br>&nbsp;r5:00000000 r4:c0063cf0<br>[&lt;c0057e04&gt;] (searc=
h_module_extables+0x0/0xe8) from [&lt;c004887c&gt;] (search_exception_table=
s+0x30/0x3c)<br>&nbsp;r8:00000154 r7:00000017 r6:00000000 r5:c0271e00 r4:c0=
063cf0<br>[&lt;c004884c&gt;] (search_exception_tables+0x0/0x3c) from [&lt;c=
00231c0&gt;] (fixup_exception+0x18/0x30)<br>&nbsp;r4:c0271e00<br>[&lt;c0023=
1a8&gt;] (fixup_exception+0x0/0x30) from [&lt;c002339c&gt;] (__do_kernel_fa=
ult+0x24/0x7c)<br>&nbsp;r4:00000154<br>[&lt;c0023378&gt;] (__do_kernel_faul=
t+0x0/0x7c) from [&lt;c0023670&gt;] (do_page_fault+0x27c/0x29c)<br>&nbsp;r7=
:00000000 r6:c0266520 r5:c01a1e6c r4:ffffffff<br>[&lt;c00233f4&gt;] (do_pag=
e_fault+0x0/0x29c) from [&lt;c001c2c8&gt;] (do_DataAbort+0x3c/0x11c)<br>[&l=
t;c001c28c&gt;] (do_DataAbort+0x0/0x11c) from [&lt;c001cb40&gt;]
 (__dabt_svc+0x40/0x60)<br>Exception stack(0xc0271e00 to 0xc0271e48)<br>1e0=
0: 204c0000 c0457860 40000093 40000093 c0457860 00000000 c01bf860 00000000 =
<br>1e20: c0280b30 c0270000 c01bf890 c0271e80 00000000 c0271e48 c0063ce4 c0=
063cf0 <br>1e40: 40000093 ffffffff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;r8:c02=
80b30 r7:00000000 r6:c01bf860 r5:c0271e34 r4:ffffffff<br>[&lt;c00636ec&gt;]=
 (xnpod_schedule+0x0/0x7ac) from [&lt;c00608f8&gt;] (xnintr_clock_handler+0=
xa8/0x124)<br>[&lt;c0060850&gt;] (xnintr_clock_handler+0x0/0x124) from [&lt=
;c005deb0&gt;] (__ipipe_dispatch_wired+0xdc/0x104)<br>&nbsp;r8:c0266520 r7:=
c01bf480 r6:c01a8120 r5:c01aa4e0 r4:c01bd140<br>[&lt;c005ddd4&gt;]
 (__ipipe_dispatch_wired+0x0/0x104) from [&lt;c0021efc&gt;] (__ipipe_handle=
_irq+0x94/0x1c8)<br>&nbsp;r6:c0271f20 r5:00000011 r4:c01bd140<br>[&lt;c0021=
e68&gt;] (__ipipe_handle_irq+0x0/0x1c8) from [&lt;c00220f4&gt;] (__ipipe_gr=
ab_irq+0xc4/0x120)<br>[&lt;c0022030&gt;] (__ipipe_grab_irq+0x0/0x120) from =
[&lt;c001cb90&gt;] (__irq_svc+0x30/0x78)<br>&nbsp;r8:c0266520 r7:c0457860 r=
6:00000011 r5:fefff000 r4:ffffffff<br>[&lt;c014e0d4&gt;] (schedule+0x0/0x81=
4) from [&lt;c006af54&gt;] (gatekeeper_thread+0xfc/0x194)<br>[&lt;c006ae58&=
gt;] (gatekeeper_thread+0x0/0x194) from [&lt;c004b1a4&gt;] (kthread+0x58/0x=
90)<br>[&lt;c004b14c&gt;] (kthread+0x0/0x90) from [&lt;c003780c&gt;] (do_ex=
it+0x0/0x94c)<br>&nbsp;r6:00000000 r5:00000000 r4:00000000<br><br><br>There=
 is a patch to using the serial device with DMA too and I use it with other=
 board<br>=0A&nbsp;equipped with the at91rm9200. But my question is this:<b=
r>=0A<br>=0Aspi prioriy &lt; serial priority<br>=0A<br>=0AIn linux the inte=
rrupt nesting is controlled by the hardware logic. Is it true?<br>=0A<br>=
=0AThe priority is mainted using ipipe in at91sam9260? <br>=0A<br>=0A<br>=
=0ARegards Michael<br><br></div></div></div><br>=0A=0A=0A      <hr size=3D1=
><font face=3D"Arial" size=3D"2">L'email della prossima generazione? Puoi a=
verla con la <a href=3D"http://us.rd.yahoo.com/mail/it/taglines/gmail/nowyo=
ucan/nextgen/*http://it.docs.yahoo.com/nowyoucan.html">Nuova Yahoo! Mail</a=
></font></body></html>
--0-1244056849-1197901250=:86920--

