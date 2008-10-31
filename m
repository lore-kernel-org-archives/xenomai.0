Date: Fri, 31 Oct 2008 16:26:10 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-447088523-1225470370=:30206"
Message-ID: <857546.30206.qm@domain.hid>
Subject: [Xenomai-help] floating point (int 16) exception
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

--0-447088523-1225470370=:30206
Content-Type: multipart/alternative; boundary="0-1955833178-1225470370=:30206"

--0-1955833178-1225470370=:30206
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Scenario:=0AXenomai 2.4.5, kernel 2.6.24-7 (x86)=0AI have successfully trap=
ped and restored int #0 (it is not reported in the example).=0ANow I want t=
o trap fpu exceptions (#16) of a Xenomai user task (ring 3).=0A=0Axfpu_xcpt=
.c -> kernel module used to intercept and manage fpu (#16) exceptions.=0Axf=
pu_user.c -> xenomai user task=0A=0AThe easiest way (it will not be so easy=
 the final fpu exception manager of course!) to do this I knows was to do a=
n fnclex but the example doesn't work (it hangs shortly).=0AI have tried *m=
any* solutions but nothing works. I think the problem is I can't do a simpl=
e fnclex but I can't figure how to solve the problem.=0A=0AThank you=0A=0A=
=0A      Unisciti alla community di Io fotografo e video, il nuovo corso di=
 fotografia di Gazzetta dello sport:=0Ahttp://www.flickr.com/groups/iofotog=
rafoevideo
--0-1955833178-1225470370=:30206
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div>Scenario:<br>Xenomai 2.4.5, kernel 2.6.24-7 (x86)<br>I have success=
fully trapped and restored int #0 (it is not reported in the example).<br>=
=0ANow I want to trap fpu exceptions (#16) of a Xenomai user task (ring 3).=
<br><br>xfpu_xcpt.c -&gt; kernel module used to intercept and manage fpu (#=
16) exceptions.<br>xfpu_user.c -&gt; xenomai user task<br><br>The easiest w=
ay (it will not be so easy the final fpu exception manager of course!) to d=
o this I knows was to do an fnclex but the example doesn't work (it hangs s=
hortly).<br>I have tried *many* solutions but nothing works. I think the pr=
oblem is I can't do a simple fnclex but I can't figure how to solve the pro=
blem.<br><br>Thank you</div></div><br>=0A=0A=0A=0A      <hr size=3D1><font =
face=3D"Arial" size=3D"2">Scopri la community di Io fotografo e video<br>=
=0A<a href=3Dhttp://us.rd.yahoo.com/SIG=3D11ud6kror/**http%3A%2F%2Fwww.flic=
kr.com%2Fgroups%2Fiofotografoevideo%2F>Il nuovo corso</a> di Gazzetta dello=
 sport per diventare veri fotografi!</font></body></html>
--0-1955833178-1225470370=:30206--

--0-447088523-1225470370=:30206
Content-Type: application/x-gzip; name="xfpu.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xfpu.tar.gz"

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

--0-447088523-1225470370=:30206--

