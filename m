Message-ID: <OFE8C7C220.001FDB8A-ONC125742D.004982E9-C125742D.004A8124@domain.hid>
From: "G.P.M. Haagh" <g.p.m.haagh@domain.hid>
Date: Wed, 16 Apr 2008 15:35:16 +0200
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFEBEDFDA04798f9e8a93df938690918c4EBBFEBEDFDA0479"
Content-Disposition: inline
Subject: [Xenomai-help] ddd hangs system
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

--0__=4EBBFEBEDFDA04798f9e8a93df938690918c4EBBFEBEDFDA0479
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



When I use ddd to debug a rt user space program, my system hangs
immediately when pressing 'RUN' after setting a breakpoint.
(kernel 2.6.20.1, xenomai 2.3.4, native skin, posix skin)

      ddd  ./program
      open a source file
      set breakpoint
      press run

      everything freezes; power cycle needed.

If I run the progam outside the debugger it operates fine.
If I run the program within the debugger without setting a breakpoint, =
it
runs fine until  setting a breakpoint.

Any ideas what might cause this.

thanx,
Gerard

G.P.M. Haagh
Philips Applied Technologies
Building WDX 2A20, High Tech Campus 7, 5656 AE Eindhoven, The Netherlan=
ds
Tel: +31 40 27 48450


The information contained in this message may be confidential and legal=
ly
privileged. The message is intended solely for the addressee(s). If you=
 are
not the intended recipient, you are hereby notified that any use,
forwarding, dissemination, or reproduction of this message is strictly
prohibited and may be unlawful. If you are not the intended recipient,
please contact the sender by return e-mail and destroy all copies of th=
e
original message.=

--0__=4EBBFEBEDFDA04798f9e8a93df938690918c4EBBFEBEDFDA0479
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p>When I use ddd to debug a rt user space program, my system hangs imm=
ediately when pressing 'RUN' after setting a breakpoint.<br>
(kernel 2.6.20.1, xenomai 2.3.4, native skin, posix skin)<br>
<br>
	ddd  ./program<br>
	open a source file<br>
  	set breakpoint<br>
	press run<br>
<br>
	everything freezes; power cycle needed.<br>
<br>
If I run the progam outside the debugger it operates fine.<br>
If I run the program within the debugger without setting a breakpoint, =
it runs fine until  setting a breakpoint.<br>
<br>
Any ideas what might cause this.<br>
<br>
thanx,<br>
Gerard<br>
<br>
G.P.M. Haagh<br>
Philips Applied Technologies<br>
Building WDX 2A20, High Tech Campus 7, 5656 AE Eindhoven, The Netherlan=
ds<br>
Tel: +31 40 27 48450<br>
<br>
<br>
The information contained in this message may be confidential and legal=
ly privileged. The message is intended solely for the addressee(s). If =
you are not the intended recipient, you are hereby notified that any us=
e, forwarding, dissemination, or reproduction of this message is strict=
ly prohibited and may be unlawful. If you are not the intended recipien=
t, please contact the sender by return e-mail and destroy all copies of=
 the original message.</body></html>=

--0__=4EBBFEBEDFDA04798f9e8a93df938690918c4EBBFEBEDFDA0479--


