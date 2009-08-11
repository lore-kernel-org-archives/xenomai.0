From: "Charlton, John" <john.charlton@domain.hid>
Date: Tue, 11 Aug 2009 15:38:47 -0400
Message-ID: <CF7FB0793253794F9F45991443E5FE20060EFA4BEC@us194mx002.tycoelectronics.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] pthread_setschedparam: Function not implemented
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I have been using xenomai-2.4.6.1 with linux-2.6.27.7 without problems. We =
have changed our open embedded build to build xenomai within open embedded =
and with recent xenomai/kernel builds I am getting the following error outp=
ut from xeno-test:

latency: failed to open benchmark device, code -38
(modprobe xeno_timerbench?)                      =20
Xenomai Posix skin init: pthread_setschedparam: Function not implemented

Any ideas on what the problem is?

--John

Some of the xeno-test output:

running: ./run -- -sh -T 120 -t2 # latency
*                                        =20
*                                        =20
* Type ^C to stop this application.      =20
*                                        =20
*                                        =20
=3D=3D Sampling period: 100 us               =20
=3D=3D Test mode: in-kernel timer handler    =20
=3D=3D All results in microseconds           =20

Tue Aug 11 14:51:31 BST 2009
running: ./run -- -T 120 # switchtest
*                                   =20
*                                   =20
* Type ^C to stop this application. =20
*                                   =20
*                                   =20
Xenomai Posix skin init: pthread_setschedparam: Function not implemented

Tue Aug 11 14:51:32 BST 2009
running: ./run -- -h # switchbench
*                                =20
*                                =20
* Type ^C to stop this application.
*                                 =20
*                                 =20
=3D=3D Sampling period: 100 us        =20
=3D=3D Do not interrupt this program  =20
switch: failed to start worker task, code -4

Tue Aug 11 14:51:33 BST 2009
running: ./run -- -p 10 -n -l 1000 # cyclictest
*                                             =20
*                                             =20
* Type ^C to stop this application.           =20
*                                             =20
*                                             =20
Xenomai Posix skin init: pthread_setschedparam: Function not implemented

