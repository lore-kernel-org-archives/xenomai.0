From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 10 Jul 2012 12:24:51 -0400
Message-ID: <20120710162451.GD19565@csclub.uwaterloo.ca>
References: <4FFBEA93.5070202@xenomai.org>
	<CAKSrRNxNEU5f3eY93tgL1WQjtPP5500z1pbYFjLnYOf2P4T2Zg@mail.gmail.com>
	<4FFBF197.4050203@xenomai.org>
	<CAKSrRNwnjG1GRogzx5_QaXu_Jwe+HuQWoQVjqe8N_YQO9GT9Sg@mail.gmail.com>
	<4FFBF7A0.7070601@xenomai.org>
	<CAKSrRNxBZ+GYVRwZhjOxX+tb_LvXhJgjF8ydckmtUNU3PoQdzg@mail.gmail.com>
	<4FFC43B8.2030203@xenomai.org>
	<CAKSrRNzwfnznNPFY+fkEY2q28NEa+Y-7g=g9D8ch5oP0U10BgQ@mail.gmail.com>
	<4FFC50FD.7090008@xenomai.org>
	<CAKSrRNz=88H6A_42fM0_vSSA2hpQekj_k25ZAmOH_Sja4m0TiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKSrRNz=88H6A_42fM0_vSSA2hpQekj_k25ZAmOH_Sja4m0TiQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] XDDP and inter-driver API.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sunetra Sashi <snmgmt19@gmail.com>
Cc: xenomai@xenomai.org

On Tue, Jul 10, 2012 at 12:15:24PM -0400, Sunetra Sashi wrote:
> Thanks for clarifying. I should have said =C2=A8not possible using Xeno=
mai
> IPCs=C2=A8. Sorry about that.
>=20
> I am not trying to port legacy code. I am instead trying to establish a
> communication pathway from voice applications in user land to some real
> time xenomai code running within the kernel via a linux driver KM runni=
ng
> native linux. In our instance, it is necessary that the code executes i=
n
> the kernel space.

Nothing is ever necesary.  Sometimes it may be easier.

> On a related note, if I create a simple xenomai kernel module running r=
eal
> time code and signal events to it from linux kernel space (via the rt_e=
vent
> API) and communicate information back via interrupts (assuming we manag=
e
> memory via shared buffers), would that considered to be a true
> Linux-Xenomai switch?

My understanding was that xenomai 3.x won't even allow kernel mode
realtime anymore, only userspace, so unless you have no intension of
ever going to future versions, you probably don't want to design your
code that way.

I must admit I haven't checked the details of that to see how device
drivers for xenomai are supposed to be handled in 3.x.

--=20
Len Sorensen

