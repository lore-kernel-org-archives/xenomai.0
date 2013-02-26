Message-ID: <512BFD9E.5010501@crubille.lautre.net>
Date: Tue, 26 Feb 2013 01:11:10 +0100
From: Paul <paul@crubille.lautre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Linux port to ARM Allwinner A13
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Here is a first port for OLINUXINO A13 board.

http://www.crubille.lautre.net/xenomai_sun5i/ipipe-linuxsun5i-3.4.24.beta=
.patch

and apply the standart xenomai-2.6.2.1 procedure on a sunxi linux kernel=20
from :
"git clone git://github.com/linux-sunxi/linux-sunxi.git -b sunxi-3.4"

I think that the A10/A13 port in the official linux tree is still too=20
unstable to port on it.


The patch is a basic but functionnal version. I attempt to use priority=20
interrupt, but go in trouble.
If i can have comments about this point?

If somebody is interested in it for A10, it is very easy to adapt, and i=20
can do it and send the patch.

Paul Crubill=E9

-------------------------------------------------------------------------=
--------------------------

Running it, i get


latency -t 2 -p 100
=3D=3D Sampling period: 100 us
=3D=3D Test mode: in-kernel timer handler
=3D=3D All results in microseconds
RTT|  00:00:01  (in-kernel timer handler, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat=20
best|--lat worst
RTD|      5.583|      6.265|     11.167|       0|     0|      5.583|   =20
  11.167
RTD|      6.125|      6.258|     10.917|       0|     0|      5.583|   =20
  11.167
RTD|      5.500|      6.270|     12.000|       0|     0|      5.500|   =20
  12.000


"lat worst" is mostly under 20 us but can go up for 30 ns.

latency  -p 100
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat=20
best|--lat worst
RTD|     11.999|     12.708|     21.333|       0|     0|     11.999|   =20
  21.333
RTD|     12.624|     12.791|     21.541|       0|     0|     11.999|   =20
  21.541
RTD|     12.458|     12.791|     26.458|       0|     0|     11.999|   =20
  26.458

"lat worst" is mostly under 40 us but can go up for 80 ns.



