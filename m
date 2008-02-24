Date: Sun, 24 Feb 2008 14:42:39 +0100
Message-Id: <606588375@domain.hid>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai and Virtex II Pro (PPC405)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: berlemont.hauw@domain.hid
Cc: xenomai@xenomai.org

>Correct me if am wrong,but for me, a Virtex II Pro contains 1 (maybe 2)
>hardwired PPC405 core(s) inside the FPGA. But compared to common AMCC or
>Freescale PPC micro-controllers, you have to instanciante in VHDL some
>peripherals / controllers or some glue towards them. You have to build yo=
ur
>own micro-controller, haven't you =3F

I don't think you have to add any VHDL Code for the ppc (2 of them on my V=
2)
But I use a Kernel from here
http://git.xilinx.com/cgi-bin/gitweb.cgi=3Fp=3Dlinux-2.6-xlnx.git;a=3Dsummary
because there are already some drivers for my Evaluation Board intergrated=
.

>Consequently, as soon as you make Linux run on it, I can see no reason wh=
y you
>would get trouble with Xenomai. Even if you had to cope with such a
>predicament, the problem(s) would be bound to be located in ipipe, not in=

>Xenomai. Keep in mind that RTAI seems to be based on ipipe too.

I already got some trouble. But this could also be because I don't know=20
what exactly to do. Is there a good Step by Step howto you know=3F I don't
think one of the howtos at the xenomai site explains how to setup xenomai.=

What is this ipipe thing=3F


>Which framework =3F

An application, basing on this framework (written by someone at my college=
,=20
who isn't here anymore), which bases on rtai, was running on linux on a ce=
leron.
This application should be ported to the Virtex 2 Pro by me. So I ask myse=
lf how=20
hard it would be, to use Xenomai (perhaps with this "rtai skin=3F=3F") instead=
 of rtai.=20

Thank you for you answer and help.
Greetings
Joachim
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Unbegrenzter Speicherplatz f=FCr Ihr E-Mail Postfach=3F Jetzt aktivieren!
http://www.digitaledienste.web.de/freemail/club/lp/=3Flp=3D7


