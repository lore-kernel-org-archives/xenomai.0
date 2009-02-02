References: <271563.65105.qm@domain.hid>
	<4986B44B.3030307@domain.hid>
Date: Mon, 2 Feb 2009 11:17:20 +0000 (GMT)
From: seb p <sebas_p2002@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1103046172-1233573440=:27985"
Message-ID: <162418.27985.qm@domain.hid>
Subject: [Xenomai-help] Re :  Problem with  rtdm_irq_request
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

--0-1103046172-1233573440=:27985
Content-Type: multipart/alternative; boundary="0-786420333-1233573440=:27985"

--0-786420333-1233573440=:27985
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I try with the last version of xenomai but it's the same problem.=0A=0AI se=
nd you my code. =0A=0AThank you for your help.=0A=0ASeb.=0A=0A=0A=0A=0A____=
____________________________=0ADe : Philippe Gerum <rpm@xenomai.org>=0A=C3=
=80 : seb p <sebas_p2002@domain.hid>=0ACc : xenomai@xenomai.org=
=A9 le : Lundi, 2 F=C3=A9vrier 2009, 9h52mn 27s=0AObjet : Re: [Xenomai-help=
] Problem with  rtdm_irq_request=0A=0Aseb p wrote:=0A> Hello,=0A> =0A> I us=
e a atmel card AT91SAM9260 and I install Linux 2.6.25 with xenomai=0A> 2.4.=
4. I am doing a RTDM serial driver. I use the function=0A> rtdm_irq_request=
=0A> <http://www.xenomai.org/documentation/trunk/html/api/group__rtdmirq.ht=
ml#g9bb3d95218ac5261e4033fb0bf695073>=0A> with the routine rt_rs485_interru=
pt. The interrupt number is 7. The=0A> interrupt is enable when a carracter=
 is in the buffer Rx and the=0A> programm execute the routine rt_rs485_inte=
rrupt. But in my programm,=0A> when a caracter is in the buffer Rx, the pro=
gramm doesn't execute the=0A> routine and I must reboot the linux. The cons=
ole don't answer.=0A> =0A> Have you got an idea of the problem? Thanks.=0A>=
=0A=0ATime is a scarce resource for everyone. With that in mind, please:=0A=
=0A- do not report issues based on outdated Xenomai releases unless you mad=
e sure=0Athat such issue also happens on the latest release. Xenomai 2.4.6.=
1 will happily=0Awork over 2.6.25/arm.=0A=0A- send an excerpt of your code =
that helps understanding the issue.=0A=0A> S=C3=A9b.=0A> =0A> =0A> --------=
----------------------------------------------------------------=0A> =0A> _=
______________________________________________=0A> Xenomai-help mailing lis=
t=0A> Xenomai-help@domain.hid> https://mail.gna.org/listinfo/xenomai-help=
=0A=0A=0A-- =0APhilippe.=0A=0A=0A=0A      
--0-786420333-1233573440=:27985
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:12pt"><div>I try with the last version of xenomai but it's the same =
problem.<br><br>I send you my code. <br><br>Thank you for your help.<br><br=
>Seb.<br></div><div style=3D"font-family: times new roman,new york,times,se=
rif; font-size: 12pt;"><br><div style=3D"font-family: arial,helvetica,sans-=
serif; font-size: 13px;"><font size=3D"2" face=3D"Tahoma"><hr size=3D"1"><b=
><span style=3D"font-weight: bold;">De :</span></b> Philippe Gerum &lt;rpm@=
xenomai.org&gt;<br><b><span style=3D"font-weight: bold;">=C3=80 :</span></b=
> seb p &lt;sebas_p2002@domain.hid&gt;<br><b><span style=3D"font-weight: bold=
;">Cc :</span></b> xenomai@xenomai.org<br><b><span style=3D"font-weight: b=
old;">Envoy=C3=A9 le :</span></b> Lundi, 2 F=C3=A9vrier 2009, 9h52mn 27s<br=
><b><span style=3D"font-weight: bold;">Objet&nbsp;:</span></b> Re: [Xenomai=
-help] Problem with=20
 rtdm_irq_request<br></font><br>seb p wrote:<br>&gt; Hello,<br>&gt; <br>&gt=
; I use a atmel card AT91SAM9260 and I install Linux 2.6.25 with xenomai<br=
>&gt; 2.4.4. I am doing a RTDM serial driver. I use the function<br>&gt; rt=
dm_irq_request<br>&gt; &lt;<a href=3D"http://www.xenomai.org/documentation/=
trunk/html/api/group__rtdmirq.html#g9bb3d95218ac5261e4033fb0bf695073" targe=
t=3D"_blank">http://www.xenomai.org/documentation/trunk/html/api/group__rtd=
mirq.html#g9bb3d95218ac5261e4033fb0bf695073</a>&gt;<br>&gt; with the routin=
e rt_rs485_interrupt. The interrupt number is 7. The<br>&gt; interrupt is e=
nable when a carracter is in the buffer Rx and the<br>&gt; programm execute=
 the routine rt_rs485_interrupt. But in my programm,<br>&gt; when a caracte=
r is in the buffer Rx, the programm doesn't execute the<br>&gt; routine and=
 I must reboot the linux. The console don't answer.<br>&gt; <br>&gt; Have y=
ou got an idea of the problem? Thanks.<br>&gt;<br><br>Time is a scarce
 resource for everyone. With that in mind, please:<br><br>- do not report i=
ssues based on outdated Xenomai releases unless you made sure<br>that such =
issue also happens on the latest release. Xenomai 2.4.6.1 will happily<br>w=
ork over 2.6.25/arm.<br><br>- send an excerpt of your code that helps under=
standing the issue.<br><br>&gt; S=C3=A9b.<br>&gt; <br>&gt; <br>&gt; -------=
-----------------------------------------------------------------<br>&gt; <=
br>&gt; _______________________________________________<br>&gt; Xenomai-hel=
p mailing list<br>&gt; <a ymailto=3D"mailto:Xenomai-help@domain.hid" href=3D"m=
ailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>&gt; <a href=3D"htt=
ps://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">https://mail.gna=
.org/listinfo/xenomai-help</a><br><br><br>-- <br>Philippe.<br></div></div><=
/div><br>=0A=0A=0A=0A      </body></html>
--0-786420333-1233573440=:27985--

--0-1103046172-1233573440=:27985
Content-Type: application/x-gzip; name="driver_serial_rt.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="driver_serial_rt.tar.gz"

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
9XlPjNyiL4rRpRIjN6tG1AkmRdR2u51QFi+1VdmWTFP0Iz/HmEs89RHQmMVJ
IJBNNJHsrKDpP/2YaVO+uMDBybSNb/sK8J7//6PutdX4/V97b+fgSVtVd3/c
2bz/+ztK+jgu+BCUvdYLQmv1LR5UOfb5mqd1K2/5XDi7XfNWaAZX+Q5xA4SO
fmnL0l7yFWYo4mJhuuLd3sNFxwIH52l38gbREIUB6AxmHREPLkzbpWc+pn8x
U2TmrAk/rpOIEDBdmVPyQoQXrF7T0HMkTP/m/kaX9OLeki88/8N2cGMul4jb
4moN/5IJeExB4NULxFH1YW9g9M50XRtN4UyJv07Opme6hvgsk9SwGeJWMZeB
DcwKthaF1TRdP9XZYTKj4NK0vJtD9jTAXEGVjsFA6fn1beRCiE+oTeB/VwFp
55bY23EfoaxTNlXejmWYWz+zNmvQfrUUHJEOO8jdiNhq7/pT46TbH0jx76r0
zEx0i7V2GoG66LVTEk3FymO48cTS0BkIRlZq3pV3NTMZn0HN1tZWDfa2/YbI
JqK6RYpjbiU3qPN67YT7C146CO3RmSjhbrNnbcqmbMqmbMqmbMqmbMqmbMqm
bMqmbMqmbMqmbMqmbMr/x/Jv0rhyngBQAAA=

--0-1103046172-1233573440=:27985--

