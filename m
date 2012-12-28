Date: Fri, 28 Dec 2012 16:13:17 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <50ddb70d31c128.40198428@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Xenomai] posix/stdio.h error: ?size_t? does not name a type
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Dnia Pi=B1tek, 28 Grudnia 2012 16:01 Gilles Chanteperdrix <gilles.chanteper=
drix@xenomai.org> napisa=B3(a)=20
> On 12/28/2012 01:26 PM, Mariusz Janiak wrote:
>=20
> > Hi
> >=20
> > After successful Xenomai 2.6.2 installation (with Gilles help), I have =
started building OROCOS 2.6 with xeno support, and once again I went into t=
rouble. This time I am not sure that it is a Xenomai related bug. The probl=
em is following=20
> >=20
> > from /worek/install/orocos-toolchain-xeno/rtt/rtt/transports/mqueue/MQL=
ib.hpp:42,
> >                      from /worek/install/orocos-toolchain-xeno/rtt/rtt/=
transports/mqueue/MQLib.cpp:40:
> >     /usr/xenomai/include/xenomai/posix/stdio.h:30:1: error: ?size_t? do=
es not name a type
> >     make[2]: *** [rtt/transports/mqueue/CMakeFiles/rtt-transport-mqueue=
-xenomai_plugin.dir/MQLib.cpp.o] B=B3=B1d 1
> >=20
> > I have found one thread related to this problem=20
> >=20
> > http://www.xenomai.org/pipermail/xenomai/2012-September/026143.html
> >=20
> > Adding #include <unistd.h> in /usr/xenomai/include/xenomai/posix/stdio.=
h have solved my problem, but I don't know if it is a suitable solution.=20
>=20
>=20
> Hi Mariusz,
>=20
> thanks for the report. Could you tell me which distribution and which
> version you are using? We are certainly not going to include unistd.h in
> stdio.h, the fact that size_t is not defined indicates that something
> else is wrong as there are services supposedly defined in stdio.h which
> use size_t.
=20
I have Ubuntu 12.10 x86_64, gcc version 4.7.2 (Ubuntu/Linaro 4.7.2-2ubuntu1=
).

Mariusz





