Date: Fri, 10 Oct 2008 16:02:09 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1111212992-1223654529=:87674"
Message-ID: <129381.87674.qm@domain.hid>
Subject: Re: [Xenomai-help] trap exceptions in user
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
Cc: Xenomai help <xenomai@xenomai.org>

--0-1111212992-1223654529=:87674
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A=0A=0A=0A>> It's a long story... I know anonymous mapping is better but =
I have need physical contiguos memory=0A>> (not for the test of course). Th=
e binary blob has fixed addresses between 1 to 16 MB so I have mapped the =
=0A>To do this with RTDM, you should use rtdm_mmap_to_user, not=0A>rtdm_iom=
ap_to_user. And to do this with an anonymous mapping, you simply=0A>need to=
 pass the address where you want the mmap to occur to mmap, and=0A>pass MAP=
_FIXED to mmap flags, this is all documented in mmap manual.=0A=0AI did't s=
pecify I have passed mem=3Dxxx to kernel to take the upper 16MB so I have t=
o use rtdm_iomap_to_user.=0AI think the RTDM mapping works.=0A=0A>> I start=
 UD from the terminal and the terminal always report the right error.=0A>=
=0A>Ok. Probably the I-pipe patch only calls your callback for real-time=0A=
>tasks. Is the thread which runs the binary blob created with xenomai=0A>se=
rvices ?=0A=0Amy_rt_task_func()=0A{=0A    int 3 // This is trapped by the c=
ustom exception routine (forwarded to xenomai handler). The terminal write=
=0A            // trace/breakpoint trap=0A}=0A=0Amy_rt_task_func()=0A{=0A  =
  call *asm_part=0A}=0A=0Aasm_part --- (it has been copied in the first 16 =
MB of user task mapped to the 16 MB kernel memory)=0A=0Aint 3 // This is no=
t trapped by the custom exception routine however the a trace/breakpoint tr=
ap is raised and=0A       //  it is written in terminal=0A---=0A=0A    Gabr=
iele=0A=0A=0A      Scopri il blog di Yahoo! Mail:=0ATrucchi, novit=C3=A0 e =
scrivi la tua opinione.=0Ahttp://www.ymailblogit.com/blog
--0-1111212992-1223654529=:87674
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div><br></div><div style=3D"font-family: arial,helvetica,sans-serif; fo=
nt-size: 10pt;"><br><div style=3D"font-family: arial,helvetica,sans-serif; =
font-size: 10pt;">&gt;&gt; It's a long story... I know anonymous mapping is=
 better but I have need physical contiguos memory<br>&gt;&gt; (not for the =
test of course). The binary blob has fixed addresses between 1 to 16 MB so =
I have mapped the <br>&gt;To do this with RTDM, you should use rtdm_mmap_to=
_user, not<br>&gt;rtdm_iomap_to_user. And to do this with an anonymous mapp=
ing, you simply<br>&gt;need to pass the address where you want the mmap to =
occur to mmap, and<br>&gt;pass MAP_FIXED to mmap flags, this is all documen=
ted in mmap manual.<br><br>I did't specify I have passed mem=3Dxxx to kerne=
l to take the upper 16MB so I have to use rtdm_iomap_to_user.<br>I think th=
e
 RTDM mapping works.<br><br>&gt;&gt; I start UD from the terminal and the t=
erminal always report the right error.<br>&gt;<br>&gt;Ok. Probably the I-pi=
pe patch only calls your callback for real-time<br>&gt;tasks. Is the thread=
 which runs the binary blob created with xenomai<br>&gt;services ?<br><br>m=
y_rt_task_func()<br>{<br>&nbsp;&nbsp;&nbsp; int 3 // This is trapped by the=
 custom exception routine (forwarded to xenomai handler). The terminal writ=
e<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // trace/brea=
kpoint trap<br>}<br><br>my_rt_task_func()<br>=0A{<br>=0A&nbsp;&nbsp;&nbsp; =
call *asm_part<br>=0A}<br>=0A<br>asm_part --- (it has been copied in the fi=
rst 16 MB of user task mapped to the 16 MB kernel memory)<br><br>int 3 // T=
his is not trapped by the custom exception routine however the a trace/brea=
kpoint trap is raised and<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; =
it is written in terminal<br>---<br><br>&nbsp;&nbsp;&nbsp; Gabriele<br><br>=
</div></div></div><br>=0A=0A=0A=0A      <hr size=3D1><font face=3D"Arial" s=
ize=3D"2">Scopri il <a href=3D"http://us.rd.yahoo.com/mail/it/taglines/yaho=
o/ymail/SIG=3D11djrg460/**http%3A%2F%2Fwww.ymailblogit.com%2Fblog%2F"> Blog=
 di Yahoo! Mail</a>: trucchi, novit=C3=A0, consigli... e scrivi la tua opin=
ione!</font></body></html>
--0-1111212992-1223654529=:87674--

