Date: Wed, 02 Jul 2008 15:58:03 +0200
Message-Id: <853674476@domain.hid>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] latency in kernel mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: smolorz@domain.hid
Cc: xenomai@xenomai.org

Hi

You were right, I really used different versions.....I fixed it now, so I =
use only 2.4.2.=20

Latency:
-----------
bash-3.00# ./run -- -t 1
./run: line 1: dirname: command not found
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 100 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat wo=
rst
RTD|       4.270|       6.190|      32.050|       0|       4.270|      32.=
050
RTD|       4.270|       6.238|      50.750|       0|       4.270|      50.=
750
RTD|       4.270|       6.175|      49.760|       0|       4.270|      50.=
750
RTD|       4.270|       6.206|      63.770|       0|       4.270|      63.=
770
RTD|       4.270|       6.210|      48.220|       0|       4.270|      63.=
770
---|------------|------------|------------|--------|----------------------=
---
RTS|       4.270|       6.203|      63.770|       0|    00:00:06/00:00:06
bash-3.00#

Switchbench:
-----------------
bash-3.00# ./run -- -n 5000 -p 200
./run: line 1: dirname: command not found
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 200 us
=3D=3D Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|      49.070|      53.050|      79.350|           1
bash-3.00#


Thank you all.

I think now, that all test work fine I can start programm my RT programms.=
 I you have any recommendations of things I should do in addition to the t=
ests of the testsuite, please feel free to mail.

Thanks all again=20
Greez
Joachim=20

=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
EINE F=DCR ALLE: die kostenlose WEB.DE-Plattform f=FCr Freunde und Deine
Homepage mit eigenem Namen. Jetzt starten! http://unddu.de/=3Fkid=3Dkid@domain.hid


