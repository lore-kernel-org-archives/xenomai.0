Message-ID: <737283.11182.qm@domain.hid>
References: 
Date: Tue, 7 Jun 2011 19:22:55 -0700 (PDT)
From: sanjay anvekar <sanjayanvekar@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-780321907-1307499775=:11182"
Subject: [Xenomai-help] Xenomai-Driver
Reply-To: sanjay anvekar <sanjayanvekar@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--0-780321907-1307499775=:11182
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=0A=A0=A0=A0=A0 I am facing little problem with Xenomai tasks. Please he=
lp me.=0AI am using Xenomai 2.5.6 patched to Kernel 2.6.37 on Intel Atom bo=
ard with display and touch=0Ainterface. I have created an application which=
 uses various Linux Drivers such as=0ASerial Driver - Configured and used u=
sing tty layer.=0ADisplay driver - Intel Frame buffer interface (mmap and i=
octl).=0ASocket Programming and file system handling.=0AWhen I run this app=
lication without having any Xenomai tasks then application works fine,=0Abu=
t when I create different tasks then application does not work correctly. E=
specially Serial=0Ainterface and display. Serial data seems to be loosing d=
ata and display update is not happening instantly.=0AI am sure I am missing=
 something. Please help me to=0A resolve this issue.=0AI am using following=
 functions to create and maintain Xenomai tasks and tasks are successfully =
created.=0A=A0=A0=A0=A0 =0A=A0=A0=A0=A0 mlockall(MCL_CURRENT | MCL_FUTURE);=
=0A=A0=A0=A0=A0 rt_task_set_mode(0, T_WARNSW , NULL);=0A=A0=A0=A0=A0 rt_tas=
k_create();=0A=A0=A0=A0=A0 rt_task_start()=0A=A0=A0=A0=A0 rt_task_yield() -=
 To allow execution of other tasks.=0A=0AThanks & Best Regards,=0ASanjay
--0-780321907-1307499775=:11182
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt">Hi,<div style=3D"font=
-family: times new roman,new york,times,serif; font-size: 12pt;"><div style=
=3D"font-family: times new roman,new york,times,serif; font-size: 12pt;"><d=
iv id=3D"yiv601713824"><div style=3D"color: rgb(0, 0, 0); background-color:=
 rgb(255, 255, 255); font-family: times new roman,new york,times,serif; fon=
t-size: 12pt;"><div><span>&nbsp;&nbsp;&nbsp;&nbsp; I am facing little probl=
em with Xenomai tasks. Please help me.</span></div><div><span>I am using Xe=
nomai 2.5.6 patched to Kernel 2.6.37 on Intel Atom board with display and t=
ouch<br>interface. I have created an application which uses various Linux D=
rivers such as<br>Serial Driver - Configured and used using tty layer.<br>D=
isplay driver - Intel Frame buffer interface (mmap and ioctl).<br>Socket Pr=
ogramming and file system handling.<br>When I run this application without
 having any Xenomai tasks then application works fine,<br>but when I create=
 different tasks then application does not work correctly. Especially Seria=
l<br> interface and display. Serial data seems to be loosing data and displ=
ay update is not happening instantly.<br>I am sure I am missing something. =
Please help me to=0A resolve this issue.<br>I am using following functions =
to create and maintain Xenomai tasks and tasks are successfully created.<br=
></span><span>&nbsp;&nbsp;&nbsp;&nbsp; <br></span><span>&nbsp;&nbsp;&nbsp;&=
nbsp; </span><span>mlockall(MCL_CURRENT | MCL_FUTURE);<br></span><span>&nbs=
p;&nbsp;&nbsp;&nbsp; </span><span>rt_task_set_mode(0, T_WARNSW , NULL);<br>=
</span><span>&nbsp;&nbsp;&nbsp;&nbsp; rt_task_create();</span><br><span>&nb=
sp;&nbsp;&nbsp;&nbsp; </span>rt_task_start()<br><span>&nbsp;&nbsp;&nbsp;&nb=
sp; </span>rt_task_yield() - To allow execution of other tasks.<br><br><spa=
n>Thanks &amp; Best Regards,<br>Sanjay<br><br></span></div><br></div></div>=
<br><br></div></div></div></body></html>
--0-780321907-1307499775=:11182--

