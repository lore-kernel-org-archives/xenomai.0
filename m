MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-ID: <18330.16392.961632.366406@domain.hid>
Date: Fri, 25 Jan 2008 21:01:12 +0100
In-Reply-To: <479A38CF.6070209@domain.hid>
References: <4e0b9cb00801240505y77d71956w994e312be382f91b@domain.hid>
	<479A38CF.6070209@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Some beginner technical questions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Remi Lefevre wrote:
 > > Hi, I try to really understand the Xenomai design & behavior and h=
ave
 > > a few technical questions for which I can't find exact answers on
 > > documentations or mailing list :
 > >=20
 > > - What is the overhead of the Adeos/I-Pipe layer on non RT Linux t=
asks
 > > (including linux kernel) =3F
 > > This surely depends on interrupts number, but perhaps some results=
 on
 > > a particular platform exist.
 >=20
 > It also depends on the architecture and CPU speed. I can't provide
 > up-to-date numbers, and the best for you is anyway to evaluate
 > specifically your desired platform. This could mean running typical
 > Linux benchmark (eg. lmbench) on kernels with and without I-pipe +
 > Xenomai. You are always welcome to publish results and discuss them =
with us.

Some number were published a long time ago on the LKML comparing the
overhead of adeos and preempt=5Frt. It starts at:
http://groups.google.com/group/linux.kernel/msg/b59137a4da507a55=3Fhl=3D=
en

=46rom my experience on ARM based Intel IXP465 hardware, the overhead of
Adeos is invisible when observing network throughput or CPU consumption=

induced by this network traffic.

 >=20
 > >=20
 > > - When using RTnet, I understand that non RT Linux tasks uses a
 > > virtual network device linked to the RTnet one, so what performanc=
e
 > > impact does this have on non RT network bandwidth =3F
 >=20
 > That depends. First of all, you only have to use the the virtual NIC=
s
 > when you have to share the RT Ethernet link with non-RT traffic.
 > Otherwise you could simply use standard networking without penalties=
. If
 > VNICs are to be used, the performance Linux sees heavily depends on =
the
 > RTmac discipline and its configuration (e.g. the TDMA slot layout). =
Feel
 > free to continue on this topic on the rtnet-user list.

I have a particular experience with IXP465 on this topic, using the
nomac policy. First RTnet vnic TX suffer from a performance problem
which is due to the fact that sending a packet wakes up a real-time tas=
k
to send the packet. Since the task is real-time, it wakes up
immediately, so there is no way the packets may be batched, and for
every packet sent, we pay the price of a context switch. Once this
bottleneck removed and after a few other minor performance improvements=
,
I could make some measurements:
- on IXP465 running vanilla linux, NATing a 100 Mbits/sec traffic
  consumes 80% of CPU;
- when running through RTnet vnics, it consumes 100% of CPU for a
  traffic around 95 Mbits/sec, so, it does not come for free, but
  remains acceptable.

--=20


=09=09=09=09=09    Gilles Chanteperdrix.

