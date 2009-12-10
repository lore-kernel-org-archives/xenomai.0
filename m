Message-ID: <500245.60842.qm@domain.hid>
Date: Thu, 10 Dec 2009 16:48:49 +0000 (GMT)
From: A C <adrien_chiron@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-857040023-1260463729=:60842"
Subject: [Adeos-main] Porting Adeos-Ipipe on AVR32 (NGW 100).
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

--0-857040023-1260463729=:60842
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,=0A=0AWe started to port Adeos for the IRQs part. =0A=0ASimple questi=
on: Why the function raw_irqs_disabled_flags(flags) is the same with or wit=
hout ipipe ? (as we saw in some arch).=0A=0A(in the case with ipipe) =0AWhy=
=0Anot use __ipipe_test_root() -in the same way as the function=0A__raw_loc=
al_save_flags()- to write the new function=0Araw_irqs_disabled_flags(flags)=
?=0A=0ARegards=0A=0AAdrien Chiron & Vincent Vanbesien=0A=0A=0A      
--0-857040023-1260463729=:60842
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:12pt"><div>Hello,<br><br>We started to port Adeos for the IRQs part.=
 <br><br>Simple question: Why the function raw_irqs_disabled_flags(flags) i=
s the same with or without ipipe ? (as we saw in some arch).<br> <br>(in th=
e case with ipipe) <br>Why=0Anot use __ipipe_test_root() -in the same way a=
s the function=0A__raw_local_save_flags()- to write the new function=0Araw_=
irqs_disabled_flags(flags)?<br><br>Regards<br><br>Adrien Chiron &amp; Vince=
nt Vanbesien</div>=0A<!-- cg20.c41.mail.ird.yahoo.com compressed/chunked Th=
u Dec 10 06:37:13 PST 2009 -->=0A</div><br>=0A=0A=0A=0A=0A      </body></ht=
ml>
--0-857040023-1260463729=:60842--

