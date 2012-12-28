Date: Fri, 28 Dec 2012 13:26:15 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <50dd8fe7a2bbd6.25169205@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai] posix/stdio.h error: ?size_t? does not name a type
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi

After successful Xenomai 2.6.2 installation (with Gilles help), I have star=
ted building OROCOS 2.6 with xeno support, and once again I went into troub=
le. This time I am not sure that it is a Xenomai related bug. The problem i=
s following=20

from /worek/install/orocos-toolchain-xeno/rtt/rtt/transports/mqueue/MQLib.h=
pp:42,
                     from /worek/install/orocos-toolchain-xeno/rtt/rtt/tran=
sports/mqueue/MQLib.cpp:40:
    /usr/xenomai/include/xenomai/posix/stdio.h:30:1: error: ?size_t? does n=
ot name a type
    make[2]: *** [rtt/transports/mqueue/CMakeFiles/rtt-transport-mqueue-xen=
omai_plugin.dir/MQLib.cpp.o] B=B3=B1d 1

I have found one thread related to this problem=20

http://www.xenomai.org/pipermail/xenomai/2012-September/026143.html

Adding #include <unistd.h> in /usr/xenomai/include/xenomai/posix/stdio.h ha=
ve solved my problem, but I don't know if it is a suitable solution.=20

Mariusz





