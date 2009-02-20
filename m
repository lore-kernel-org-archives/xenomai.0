MIME-Version: 1.0
Date: Fri, 20 Feb 2009 15:06:28 -0300
Message-ID: <8b216e9e0902201006u4f7b7f1dk4a30958e2a5cc9f9@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Content-Type: multipart/alternative; boundary=0016362851fc074f6f04635d8379
Subject: [Xenomai-help] Real Time Serial Port
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

--0016362851fc074f6f04635d8379
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I am currently working with Xenomai on an embedded platform (Gumstix
Verdex), which uses a non-standard serial interface. I do need real-time
access to these serial devices (3 of them), including semaphores, etc, so I
am wondering what the best solution would be:
1st solution - access the registers directly from the user-space, from
within my program (this shoudn't be an issue as the only program running in
my device is my real-time program).
2nd solution - write a real time driver using RTDM.

I do have access to the source code of the driver that is currently running
on it, as well as the datasheets containing pretty much all the info I need=
.

So, any opinions on what would be the proper way of proceding here? I do
need to keep latencies at a minimum, as well as development time.....

Also, are there any documents regarding hardware and real time (i.e.,
drivers, etc....)?

Thanks for the help,
         -Felipe Brand=E3o Cavalcanti
         LARA - Laboratory of Robotics and Automation
         Department of Electrical Engineering
         UnB - University of Bras=EDlia, Brazil
         http://www.lara.unb.br/

--0016362851fc074f6f04635d8379
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am currently working with Xenomai on an embedded platform (Gum=
stix Verdex), which uses a non-standard serial interface. I do need real-ti=
me access to these serial devices (3 of them), including semaphores, etc, s=
o I am wondering what the best solution would be:<br>
1st solution - access the registers directly from the user-space, from with=
in my program (this shoudn&#39;t be an issue as the only program running in=
 my device is my real-time program).<br>2nd solution - write a real time dr=
iver using RTDM.<br>
<br>I do have access to the source code of the driver that is currently run=
ning on it, as well as the datasheets containing pretty much all the info I=
 need.<br><br>So, any opinions on what would be the proper way of proceding=
 here? I do need to keep latencies at a minimum, as well as development tim=
e.....<br>
<br>Also, are there any documents regarding hardware and real time (i.e., d=
rivers, etc....)?<br><br>Thanks for the help,<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; -Felipe Brand=E3o Cavalcanti<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; LARA - Laboratory of Robotics and Automation<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Department of Electrical=
 Engineering<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UnB - University of Bras=
=EDlia, Brazil<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=
=3D"http://www.lara.unb.br/">http://www.lara.unb.br/</a><br>

--0016362851fc074f6f04635d8379--

