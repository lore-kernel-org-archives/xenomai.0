Message-ID: <1347634862.78737.YahooMailNeo@web29605.mail.ird.yahoo.com>
Date: Fri, 14 Sep 2012 16:01:02 +0100 (BST)
From: Franz Engel <franz_lambert_engel@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Context Switch with rtnet
Reply-To: Franz Engel <franz_lambert_engel@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=0A=0AI've a little problem. I'm using the rtnet.h-header and the follow=
ing function:=0Aret =3D recvfrom ( ethernetConnection.sock, &recBuffer, siz=
eof ( recBuffer ),0, ( struct sockaddr * ) &ethernetConnection.dest_addr,&d=
estlen );=0A=0A=0AI compiled the program with the xenomai compiling flags a=
nd library.=0A=0AWhen I look to the xenomai state I get something like this=
:=0ACPU =A0PID =A0 =A0MSW =A0 =A0 =A0 =A0CSW =A0 =A0 =A0 =A0PF =A0 =A0STAT =
=A0 =A0 =A0 %CPU =A0NAME=0A=A022 =A00 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A083484=
0 =A0 =A0 0 =A0 =A0 00000082 =A0 =A00.1 =A0rtnet-stack=0A=A022 =A00 =A0 =A0=
 =A00 =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 =A0 =A00 =A0 =A0 00000082 =A0 =A00.0=
 =A0rtnet-rtpc=0A=A0 0 =A06262 =A0 2 =A0 =A0 =A0 =A0 =A02 =A0 =A0 =A0 =A0 =
=A00 =A0 =A0 00300380 =A0 =A00.0 =A0qs_robotpositio=0A=A0 2 =A06265 =A0 2 =
=A0 =A0 =A0 =A0 =A06 =A0 =A0 =A0 =A0 =A00 =A0 =A0 00300380 =A0 =A00.0 =A0qs=
_robotpositio=0A=A0 0 =A06266 =A0 1 =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 =A0 =
=A00 =A0 =A0 00300380 =A0 =A00.0 =A0robotrsiinterfa=0A=A0 1 =A06268 =A0 114=
7 =A0 =A0 =A0 2365 =A0 =A0 =A0 0 =A0 =A0 00300182 =A0 =A00.8 =A0robotrsiint=
erfa=0A=0AYou can see, I get a lote of context and module switches just as =
the rtnet-stack itself. Is that normal?=0A=0AThanks in advanced,=0A=A0 =A0 =
Franz
