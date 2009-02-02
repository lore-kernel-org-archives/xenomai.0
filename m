Date: Mon, 2 Feb 2009 08:14:53 +0000 (GMT)
From: seb p <sebas_p2002@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1431454353-1233562493=:65105"
Message-ID: <271563.65105.qm@domain.hid>
Subject: [Xenomai-help] Problem with 	rtdm_irq_request
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

--0-1431454353-1233562493=:65105
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,=0A=0AI use a atmel card AT91SAM9260 and I install Linux 2.6.25 with =
xenomai 2.4.4. I am doing a RTDM serial driver. I use the function rtdm_irq=
_request with the routine rt_rs485_interrupt. The interrupt number is 7. Th=
e interrupt is enable when a carracter is in the buffer Rx and the programm=
 execute the routine rt_rs485_interrupt. But in my programm, when a caracte=
r is in the buffer Rx, the programm doesn't execute the routine and I must =
reboot the linux. The console don't answer.=0A=0AHave you got an idea of th=
e problem? Thanks.=0A=0AS=C3=A9b.=0A=0A=0A=0A      
--0-1431454353-1233562493=:65105
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:12pt"><div>Hello,<br><br>I use a atmel card AT91SAM9260 and I instal=
l Linux 2.6.25 with xenomai 2.4.4. I am doing a RTDM serial driver. I use t=
he function <a class=3D"el" href=3D"http://www.xenomai.org/documentation/tr=
unk/html/api/group__rtdmirq.html#g9bb3d95218ac5261e4033fb0bf695073">rtdm_ir=
q_request</a> with the routine rt_rs485_interrupt. The interrupt number is =
7. The interrupt is enable when a carracter is in the buffer Rx and the pro=
gramm execute the routine rt_rs485_interrupt. But in my programm, when a ca=
racter is in the buffer Rx, the programm doesn't execute the routine and I =
must reboot the linux. The console don't answer.<br><br>Have you got an ide=
a of the problem? Thanks.<br><br>S=C3=A9b.<br></div></div><br>=0A=0A=0A=0A =
     </body></html>
--0-1431454353-1233562493=:65105--

