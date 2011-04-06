Message-ID: <COL122-W4082C3BC356937E8C1DDADBDA50@domain.hid>
Content-Type: multipart/alternative;
	boundary="_07ee6abc-2e7f-4ff6-ae7e-b5577b48792a_"
From: krishna m <krishnamurthyjs@domain.hid>
Date: Wed, 6 Apr 2011 21:48:55 +0530
MIME-Version: 1.0
Subject: [Xenomai-core] Backfire: User <-> Kernel latancy mesurement tool on
	Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--_07ee6abc-2e7f-4ff6-ae7e-b5577b48792a_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I ported the backfire tool in the OSADL site [https://www.osadl.org/backfir=
e-4.backfire.0.html] to measure the user to/from kernel latency.I wanted to=
 measure the difference between the RT_PREEMPT kernel and Xenomai Kernel. S=
urprisingly i see RT_PREEMPT performance better than Xenomai.=20
=20
Here are few points to note:
1. The thread priority of the "sendme" tool of backfire in RT_PREEMPT is 99=
 [highest]
2. I have made the thread priority 99 for the rt_task that i spawn [par of =
ported sendme]
ret =3D rt_task_shadow(&rt_task_desc=2C NULL=2C 99=2C 0)=3B
=20
My Questions:
* I wanted to know if any one has done such measurements using backfire and=
 how dose Xenomai fair agnist RT_PREEMPT?
* is there any similar tool like backfire in the Xenomai tool set that dose=
 the similar measurements?
* Do I need to do more Xenomai specific optimization in the "sendme" and "b=
ackfire" code to get better performance?
=20
Thanks - Krishna=20
  		 	   		  =

--_07ee6abc-2e7f-4ff6-ae7e-b5577b48792a_
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
--></style>
</head>
<body class=3D'hmmessage'>
<SPAN style=3D"FONT-FAMILY: 'Tahoma'=2C'sans-serif'=3B FONT-SIZE: 10pt">I p=
orted the backfire tool in the OSADL site [https://www.osadl.org/backfire-4=
.backfire.0.html] to measure the user to/from kernel latency.</SPAN><SPAN s=
tyle=3D"FONT-FAMILY: 'Tahoma'=2C'sans-serif'=3B FONT-SIZE: 10pt">I wanted t=
o measure the difference between the RT_PREEMPT kernel and Xenomai Kernel. =
Surprisingly i see RT_PREEMPT performance better than Xenomai. </SPAN><BR>
<SPAN style=3D"FONT-FAMILY: 'Tahoma'=2C'sans-serif'=3B FONT-SIZE: 10pt"></S=
PAN>&nbsp=3B<BR>
<SPAN style=3D"FONT-FAMILY: 'Tahoma'=2C'sans-serif'=3B FONT-SIZE: 10pt">Her=
e are few points to note:<?xml:namespace prefix =3D o ns =3D "urn:schemas-m=
icrosoft-com:office:office" /><o:p></o:p></SPAN><BR>
<SPAN style=3D"FONT-FAMILY: 'Tahoma'=2C'sans-serif'=3B FONT-SIZE: 10pt">1. =
The thread priority of the "sendme" tool of backfire in RT_PREEMPT is 99 [h=
ighest]<o:p></o:p></SPAN><BR>
<SPAN style=3D"FONT-FAMILY: 'Tahoma'=2C'sans-serif'=3B FONT-SIZE: 10pt">2. =
I have made the thread priority 99 for the rt_task that i spawn [par of por=
ted sendme]<o:p></o:p></SPAN><BR>
<SPAN style=3D"FONT-FAMILY: 'Tahoma'=2C'sans-serif'=3B FONT-SIZE: 10pt">ret=
 =3D rt_task_shadow(&amp=3Brt_task_desc=2C NULL=2C 99=2C 0)=3B</SPAN><BR>
<SPAN style=3D"FONT-FAMILY: 'Tahoma'=2C'sans-serif'=3B FONT-SIZE: 10pt"><o:=
p></o:p></SPAN>&nbsp=3B<BR>
<SPAN style=3D"FONT-FAMILY: 'Tahoma'=2C'sans-serif'=3B FONT-SIZE: 10pt">My =
Questions:<o:p></o:p></SPAN><BR>
<SPAN style=3D"FONT-FAMILY: 'Tahoma'=2C'sans-serif'=3B FONT-SIZE: 10pt">* I=
 wanted to know if any one has done such measurements using backfire and ho=
w dose Xenomai fair agnist RT_PREEMPT?<o:p></o:p></SPAN><BR>
<SPAN style=3D"FONT-FAMILY: 'Tahoma'=2C'sans-serif'=3B FONT-SIZE: 10pt">* i=
s there any similar tool like backfire in the Xenomai tool set that dose th=
e similar measurements?<o:p></o:p></SPAN><BR>
<SPAN style=3D"FONT-FAMILY: 'Tahoma'=2C'sans-serif'=3B FONT-SIZE: 10pt">* D=
o I need to do more Xenomai specific optimization in the "sendme" and "back=
fire" code to get better performance?</SPAN><BR>
<SPAN style=3D"FONT-FAMILY: 'Tahoma'=2C'sans-serif'=3B FONT-SIZE: 10pt"><o:=
p></o:p></SPAN>&nbsp=3B<BR>
<SPAN style=3D"FONT-FAMILY: 'Tahoma'=2C'sans-serif'=3B FONT-SIZE: 10pt">Tha=
nks - Krishna <o:p></o:p></SPAN><BR>
&nbsp=3B<BR> 		 	   		  </body>
</html>=

--_07ee6abc-2e7f-4ff6-ae7e-b5577b48792a_--

