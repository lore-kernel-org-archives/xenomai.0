Message-ID: <BLU166-W4963DB0BDCBFDED1A1EF5CC4AD0@domain.hid>
Content-Type: multipart/alternative;
	boundary="_fe66b6e9-d001-48aa-9eff-3f8fdc7afec1_"
From: Jan-Erik Lange <jan0385@domain.hid>
Date: Thu, 29 Dec 2011 13:04:25 +0100
MIME-Version: 1.0
Subject: [Xenomai-core] general questions
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--_fe66b6e9-d001-48aa-9eff-3f8fdc7afec1_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello=2C
I'm new in the topic about the Xenomai co-kernel approach and I have some q=
uestions to the primary mode and secondary mode.=20
=20
I have trouble with the imagination of the fact in general=2C that one task=
 (process oder thread) can be processed by two kernels (Xenomai nucleus and=
 standard kernel)=2C and treated by the one in real time and by the other i=
n non real-time.
=20
1. So far I understood this approach=2C the primary and secondary mode is a=
n abstract description of the fact=2C that threads or processes can be sche=
duled by the Xenomai nucleus or by the standard Linux kernel scheduler. Is =
this correct?
=20
2. Now supose=2C that I have chosen the VxWork-skin and I started a task in=
 the primary mode. Is it correct that when this task is calling a non VxWor=
k-API-funtion=2C there will a change of the context from primary to the sec=
ondary mode? Or what is the exact condition of the switching of the context=
?
=20
It would be very nice=2C if you could tell me a little bit about these ques=
tions?
=20
Best regards=20
Jan 		 	   		  =

--_fe66b6e9-d001-48aa-9eff-3f8fdc7afec1_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
Hello=2C<BR>I'm new in the topic about the Xenomai co-kernel approach and&n=
bsp=3BI have some questions to the primary mode and secondary mode. <BR>
&nbsp=3B<BR>
I have trouble with the imagination of the fact in general=2C that one task=
 (process oder thread) can be processed by two kernels (Xenomai nucleus and=
 standard kernel)=2C and treated by the one in real time and by the other i=
n non real-time.<BR>
&nbsp=3B<BR>
1. So far I understood this approach=2C the primary and secondary mode is a=
n abstract description of the fact=2C that threads or processes can be sche=
duled by the Xenomai nucleus or by the standard Linux kernel scheduler. Is =
this correct?<BR>
&nbsp=3B<BR>
2. Now supose=2C that I have chosen the VxWork-skin and I started a task in=
 the primary mode. Is it correct that when this task is calling a non VxWor=
k-API-funtion=2C there will a change of the context from primary to the sec=
ondary mode? Or what is the exact condition of the switching of the context=
?<BR>
&nbsp=3B<BR>
It would be very nice=2C if you could tell me a little bit about these ques=
tions?<BR>
&nbsp=3B<BR>
Best regards <BR>Jan<BR> 		 	   		  </div></body>
</html>=

--_fe66b6e9-d001-48aa-9eff-3f8fdc7afec1_--

