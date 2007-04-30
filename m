Message-ID: <46360605.4020901@domain.hid>
Date: Mon, 30 Apr 2007 17:06:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <17043901.1177943488672.JavaMail.ngmail@domain.hid>
In-Reply-To: <17043901.1177943488672.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEED87B226C005EA695A15D3C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [RTnet-users] Xenomai/rtnet vs. 2.6.21 realtime
	preempt patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEED87B226C005EA695A15D3C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi everybody,
>=20
> I have tried the latest 2.6.21 kernel + Ingo Molnar's realtime preempt =
patch
> (see: http://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO)
>=20
> And I am really amazed about the results.
> On my Pentium 4D (dual core) system, 3.2 GHz, I ran the cyclictest
> application (which is something similar to the "latency" application of=
 Xenomai/RTAI)
> and I get values below 15 microseconds on my PC (for a single task runn=
ing with 200 microseconds).
>=20
> Using kernel 2.6.20.4 + Xenomai 2.3.1 I get similar results for the lat=
ency application.
>=20
> That means, that Ingo Molnar has done a real cool job in moving standar=
d linux in the direction
> of a real time OS.

Yep, -rt is an amazing piece of work when considering the big chunk of
non-RT code it has to deal with through Linux. Still, there are open
design and implementation issues that the cyclictest does not tickle,
mainly futex determinism, the high locking complexity, and OOM-risks due
to preemptible RCU. Also, when your Linux box used to be tuned to
CONFIG_PREEMPT_NONE/VOLUNTARY for its non-RT load, your mileage may vary
with CONFIG_PREEMPT_RT.

If you want to dive deeper into testing, try e.g. irqbench (Wolfgang has
an -rt port via the rtdm-native branch of Xenomai) or benchmarks that
stresses locking (futexes) etc.

>=20
> However, one thing is not as fine as with Xenomai/rtnet:
> I want to do real time UDP communication from a user space application.=

> Unfortunately, I was not  able to do that as fast as with the Xenomai/r=
tnet way.
> My application does a kind of "ping-pong" with an embedded device that =
is connected as only
> device to eth1 (Intel e1000 adapter).
> Using Xenomai/rtnet I get request/response times at about 200 microseco=
nds.

You are then using the plain Linux network stack which has quite a few
pitfalls /wrt latency and determinism.

>=20
> When I run an adapted application on the kernel with the preempt patch =
using the standard
> linux UDP socket functions (sendto, recv), I get request/response times=
 around 1 millisecond.
> I have now the assumption that the TCP/IP stack that uses some internal=
 tasks is not running with
> real time priority. However, I have no idea how to move that code to re=
al time priority or if it makes
> sense to move it as it is probably not possible to handle only communic=
ation via a certain ethernet adapter=20
> with real time priority and all other stuff (house keeping via TCP, dif=
ferent Ethernet adapter)=20
> with standard priority.
> Has anybody an idea about the internal behaviour of this or how to cont=
inue here?

Linux networking (namely: reception) goes through some softirq, and
those are threaded over -rt. You may want to play with the related
priority, but you then push quite a bunch of code up the prio ladder as
well - likely not what you want.

>=20
> Another approach could be to use a modified version of rtnet on base of=
 the preempt patched kernel.
> This could allow to use the preempt patch kernel as base for all thread=
s, and the rtnet is used
> for real time Ethernet communication...
> Is something like this possible or this there a major error in the appr=
oach?

Nope, that's planned for the future. Thanks to Wolfgang's work on RTDM
for -rt, we already have a platform that is just lacking one feature for
RTnet (rtdm_tasks). We then need to extend RTnet's build system to
create RTnet for PREEMPT_RT. This will be at least a mid-term approach,
the long-term is something I'm still meditating on, but it will look
differently.

>=20
> Currently, my application is working quite nice using Xenomai/rtnet how=
ever there are some
> drawbacks like the issue with limited IRQs: Sharing of IRQs between Eth=
ernet-Drivers of rtnet
> and non-realtime drivers is not possible (at least I did not manage tha=
t...).
> A smooth usage of real time features from a "standard" kernel could hel=
p here!

Nope, not really. As I think to have explained earlier, IRQ sharing
between drivers that are designed for real-time and others that are not
will never work deterministically. That has nothing to do with the
design of your RTOS underneath. Actually, the same issue once came up
for -rt over some ARM board that did poor IRQ line sharing as well.

Jan


--------------enigEED87B226C005EA695A15D3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGNgYFniDOoMHTA+kRAk/rAJ9+f07nb/SuKcazux75/R2PqMv22wCdGwGz
UFEqr/PVK9p8u26tKHIic8k=
=2b9B
-----END PGP SIGNATURE-----

--------------enigEED87B226C005EA695A15D3C--

